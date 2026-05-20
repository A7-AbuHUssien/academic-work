#include <iostream>
using namespace std;

int main()
{
	int numbers[] = { 9,5,1,4,3 };
	int size = sizeof(numbers) / sizeof(numbers[0]);

	for (int i = 0; i < size; i++)
	{
		int minPos = i;

		for (int j = i + 1; j < size; j++)
		{
			if (numbers[j] < numbers[minPos])
				minPos = j;
		}

		swap(numbers[i], numbers[minPos]);
	}

	for (int i = 0; i < size; i++)
	{
		cout << numbers[i] << " ";
	}

	return 0;
}