#include <iostream>
using namespace std;

int getMinIndex(int arr[], int size, int start = 0)
{
	if (start == size - 1)
		return start;

	int minPos = getMinIndex(arr, size, start + 1);

	if (arr[minPos] < arr[start])
		return minPos;
	else
		return start;
}

void recursiveSelectionSort(int arr[], int size, int start = 0)
{
	if (start == size - 1)
		return;

	int minPos = getMinIndex(arr, size, start);

	swap(arr[start], arr[minPos]);

	recursiveSelectionSort(arr, size, start + 1);
}

int main()
{
	int numbers[] = { 9,5,1,4,3 };
	int size = sizeof(numbers) / sizeof(numbers[0]);

	recursiveSelectionSort(numbers, size);

	for (int i = 0; i < size; i++)
	{
		cout << numbers[i] << " ";
	}

	return 0;
}