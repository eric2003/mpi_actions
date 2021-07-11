#. output message:
message(STATUS "") 
message(STATUS "--- Enter subdirectory, Start to call ${CMAKE_CURRENT_LIST_FILE} ---") 
message(STATUS "This current binary directory is ${CMAKE_CURRENT_BINARY_DIR}.")
message(STATUS "This current source directory is ${CMAKE_CURRENT_SOURCE_DIR}.")

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
    message(STATUS "WIN_COMPILER is ${WIN_COMPILER}")
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)  #取消c语言中fopen等函数的警告
endif()

message(STATUS "The CMAKE_C_COMPILER is ${CMAKE_C_COMPILER}")
message(STATUS "The CMAKE_CXX_COMPILER is ${CMAKE_CXX_COMPILER}")
message(STATUS "The CMAKE_C_FLAGS is ${CMAKE_C_FLAGS}")
message(STATUS "The CMAKE_CXX_FLAGS is ${CMAKE_CXX_FLAGS}")

message(STATUS "The CFLAGS is ${CFLAGS}")
message(STATUS "The CXXFLAGS is ${CXXFLAGS}")
message(STATUS "The LDFLAGS is ${LDFLAGS}")

message(STATUS "The CMAKE_C_FLAGS is ${CMAKE_C_FLAGS}")
message(STATUS "The CMAKE_CXX_FLAGS is ${CMAKE_CXX_FLAGS}")
message(STATUS "The CMAKE_EXE_LINKER_FLAGS is ${CMAKE_EXE_LINKER_FLAGS}")

if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    if ( CMAKE_COMPILER_IS_GNUCXX )
        Set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic, -Wl,-Bdynamic")
    else()
        Set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl")
    endif()
else()
    Set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--no-as-needed -ldl")
endif()
message(STATUS "The CMAKE_EXE_LINKER_FLAGS is ${CMAKE_EXE_LINKER_FLAGS}")

set(ARCH "x64")
set(MPI_DIR "C:/Program Files (x86)/Microsoft SDKs/MPI" )
set(MPI_LIBRARY_NAME "msmpi" CACHE STRING "name of mpi library")
set(MPI_HEADER_DIR "${MPI_DIR}/include" CACHE PATH "path to mpi headers")
set(MPI_LIBRARY_DIR "${MPI_DIR}/lib/${ARCH}" CACHE PATH "path to mpi library")

include_directories(${MPI_HEADER_DIR})  #头文件目录
link_directories(${MPI_LIBRARY_DIR})    #库目录
link_libraries(${MPI_LIBRARY_NAME})     #库名称

message(STATUS "MPI_HEADER_DIR is ${MPI_HEADER_DIR}")
message(STATUS "MPI_LIBRARY_DIR is ${MPI_LIBRARY_DIR}")
message(STATUS "MPI_LIBRARY_NAME is ${MPI_LIBRARY_NAME}")

GetAllSubDir( dirList ${CMAKE_CURRENT_SOURCE_DIR})

message( STATUS "The dirList is ${dirList}" )

set_source_group( HEAD_LIST SRC_LIST )

#. set executable name:
set(EXECUTABLE_TARGET_NAME "${CMAKE_PROJECT_NAME}")
message(STATUS "The executable name is ${EXECUTABLE_TARGET_NAME}.")

#. add an executable to the project using the specified source files and header files:
add_executable( ${EXECUTABLE_TARGET_NAME} ${SRC_LIST} ${HEAD_LIST} ) 

install(TARGETS ${EXECUTABLE_TARGET_NAME} RUNTIME DESTINATION bin)

message(STATUS "The CMAKE_INSTALL_PREFIX is ${CMAKE_INSTALL_PREFIX}.")