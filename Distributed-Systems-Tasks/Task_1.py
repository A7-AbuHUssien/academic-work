from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

x = 5
y = x ** (rank + 2)

print(f"Rank {rank}: x = {x}, y = {y}")

