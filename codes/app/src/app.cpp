#include "mpi.h"
#include <iostream>
using namespace std;

int main( int argc, char ** argv )
{
	int myid, numprocs;
    int namelen;
    char processor_name[ MPI_MAX_PROCESSOR_NAME ];
    MPI_Init( &argc, &argv );
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Get_processor_name( processor_name, & namelen );
    //printf("Hello World! Process %d of %d on %s\n", myid,numprocs,processor_name);
	cout << "Hello World! Process " << myid << " of " << numprocs << on << processor_name << "\n";
    MPI_Finalize();
	
    return 0;
}
