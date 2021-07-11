#include "mpi.h"
#include <iostream>
using namespace std;

double f(double x){
	return 4.0/(1.0 + x * x);
}

int say_hello( int argc, char ** argv );
int calc_pi( int argc, char ** argv );

int calc_pi( int argc, char ** argv )
{
	int myid, numprocs;

	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &myid);
	MPI_Comm_size(MPI_COMM_WORLD, &numprocs);

	MPI_Status status;
	double startTime = 0;
	double endTime = 0;
	startTime = MPI_Wtime();

	int n;
	double ans = 0;
	if(myid == 0){
		cout << "Please input n: ";
		cin >> n;
	}
	MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
	double h = 1.0 / n;
	double x;
	for(int i = myid + 1; i <= n; i+=numprocs){
		x = h * (i - 0.5);
		ans += f(x);
	}
	double mypi = h * ans;

	MPI_Reduce(&mypi, &ans, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	if(myid == 0){
		cout << "Pi is: " << ans << endl;
	}


	MPI_Barrier(MPI_COMM_WORLD);
	endTime = MPI_Wtime();
	if(myid == 0){
		cout << "Tasks over" << endl;
		cout << "Cost time: " << endTime - startTime << " s." << endl;
	}
	MPI_Finalize();
	return 0;
}

int say_hello( int argc, char ** argv )
{
	int myid, numprocs;
    int namelen;
    char processor_name[ MPI_MAX_PROCESSOR_NAME ];
    MPI_Init( &argc, &argv );
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Get_processor_name( processor_name, & namelen );
	cout << "Hello World! Process " << myid << " of " << numprocs << " on " << processor_name << "\n";
    MPI_Finalize();
	
    return 0;
}

int main( int argc, char ** argv )
{
	calc_pi( argc, argv );

    return 0;
}
