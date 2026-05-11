from mpi4py import MPI
import random

world = MPI.COMM_WORLD

rank = world.Get_rank()
size = world.Get_size()

group_id = rank % 3

sub_comm = world.Split(group_id, rank)

sub_rank = sub_comm.Get_rank()

value = random.randint(10, 99)

print(f"Global Rank {rank} | Group {group_id} | Local Rank {sub_rank} | Number {value}")

numbers = sub_comm.gather(value, root=0)

sorted_numbers = None

if sub_rank == 0:
    numbers.sort()
    sorted_numbers = numbers
    print(f"Leader of Group {group_id} sorted: {sorted_numbers}")

all_data = world.gather(sorted_numbers, root=0)

if rank == 0:
    merged = []

    for item in all_data:
        if item is not None:
            merged.extend(item)

    merged.sort()

    print("\nFinal Sorted List:")
    print(merged)