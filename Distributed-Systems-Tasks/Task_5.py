from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

texts = [
    "this movie is good",
    "bad service and horrible support",
    "excellent work and amazing result",
    "poor quality product",
    "good people with great attitude",
    "terrible experience overall"
]

positive_words = ["good", "great", "excellent", "amazing"]
negative_words = ["bad", "poor", "terrible", "horrible"]

assigned_texts = []

for i in range(len(texts)):
    if i % size == rank:
        assigned_texts.append(texts[i])

positive_count = 0
negative_count = 0

for sentence in assigned_texts:

    words = sentence.split()

    for word in words:

        if word in positive_words:
            positive_count += 1

        if word in negative_words:
            negative_count += 1

final_positive = comm.reduce(positive_count, op=MPI.SUM, root=0)
final_negative = comm.reduce(negative_count, op=MPI.SUM, root=0)

if rank == 0:

    print("Positive Words:", final_positive)
    print("Negative Words:", final_negative)

    if final_positive > final_negative:
        print("Overall Sentiment = Positive")

    elif final_negative > final_positive:
        print("Overall Sentiment = Negative")

    else:
        print("Overall Sentiment = Neutral")