from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

A = [10, 20, 30, 40]
B = [1, 2, 3, 4]

first = A[rank]
second = B[rank]

sum = first + second

final_C = comm.gather(sum, root=0)

if rank == 0:
    print("Vector A:", A)
    print("Vector B:", B)
    print("Final Result Vector C:", final_C)
