#include <iostream>
using namespace std;

int main()
{
	int firstArr[] = { 2,5,5,5 };
	int secondArr[] = { 2,2,3,5,5,7 };

	int size1 = 4;
	int size2 = 6;

	int pointer1 = 0;
	int pointer2 = 0;

	while (pointer1 < size1 && pointer2 < size2)
	{
		if (firstArr[pointer1] == secondArr[pointer2])
		{
			cout << firstArr[pointer1] << " ";
			pointer1++;
			pointer2++;
		}
		else if (firstArr[pointer1] < secondArr[pointer2])
			pointer1++;
		else
			pointer2++;
	}

	return 0;
}