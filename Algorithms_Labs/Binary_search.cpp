#include <iostream>
using namespace std;

void mergeArrays(int arr[], int left, int right, int mid)
{
	int i = left, j = mid + 1, k = left;
	int* temp = new int[right + 1];

	while (i <= mid || j <= right)
	{
		if (i > mid)
			temp[k++] = arr[j++];
		else if (j > right)
			temp[k++] = arr[i++];
		else if (arr[i] > arr[j])
			temp[k++] = arr[j++];
		else
			temp[k++] = arr[i++];
	}

	for (int x = left; x <= right; x++)
		arr[x] = temp[x];

	delete[] temp;
}

void mergeSort(int arr[], int left, int right)
{
	if (left < right)
	{
		int mid = (left + right) / 2;
		mergeSort(arr, left, mid);
		mergeSort(arr, mid + 1, right);
		mergeArrays(arr, left, right, mid);
	}
}

int binarySearch(int arr[], int low, int high, int target)
{
	while (low <= high)
	{
		int mid = (low + high) / 2;
		if (target == arr[mid])
			return mid;
		else if (arr[mid] < target)
			low = mid + 1;
		else
			high = mid - 1;
	}
	return -1;
}

int binarySearchRecursive(int arr[], int low, int high, int target)
{
	if (low > high)
		return -1;

	int mid = (low + high) / 2;

	if (arr[mid] == target)
		return mid;
	else if (arr[mid] < target)
		return binarySearchRecursive(arr, mid + 1, high, target);
	else
		return binarySearchRecursive(arr, low, mid - 1, target);
}

int main()
{
	int arr[] = { 5,7,14,3,9,20 };
	int size = sizeof(arr) / sizeof(arr[0]);

	mergeSort(arr, 0, size - 1);

	cout << binarySearch(arr, 0, size - 1, 9);

	return 0;
}