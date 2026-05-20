#include <iostream>
using namespace std;

void heapifyDown(int arr[], int size, int index)
{
	int leftChild = (index * 2) + 1;
	int rightChild = (index * 2) + 2;
	int largest = index;

	if (leftChild < size && arr[leftChild] > arr[largest])
		largest = leftChild;

	if (rightChild < size && arr[rightChild] > arr[largest])
		largest = rightChild;

	if (largest != index)
	{
		swap(arr[index], arr[largest]);
		heapifyDown(arr, size, largest);
	}
}

void buildMaxHeap(int arr[], int size)
{
	for (int i = (size / 2) - 1; i >= 0; i--)
	{
		heapifyDown(arr, size, i);
	}
}

void heapSort(int arr[], int size)
{
	buildMaxHeap(arr, size);

	for (int i = size - 1; i >= 0; i--)
	{
		swap(arr[0], arr[i]);
		heapifyDown(arr, i, 0);
	}
}

int main()
{
	int arr[] = { 20,80,50,30,90,10 };
	int size = sizeof(arr) / sizeof(arr[0]);

	heapSort(arr, size);

	for (int i = 0; i < size; i++)
	{
		cout << arr[i] << " ";
	}

	return 0;
}