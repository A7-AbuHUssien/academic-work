from mpi4py import MPI
import sys

comm = MPI.COMM_WORLD
rank = comm.Get_rank()  
size = comm.Get_size()

vector = []
for i in range(1, len(sys.argv)):
    vector.append(float(sys.argv[i]))

file_name = "c" + str(rank + 1) + ".txt"
f = open(file_name, "r")
column = []
for line in f:
    column.append(float(line.strip()))
f.close()

total_sum = 0
for i in range(len(vector)):
    total_sum = total_sum + (vector[i] * column[i])

print("Process Rank:", rank, " - The Result Sum:", total_sum)
