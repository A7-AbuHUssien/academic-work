#include <iostream>
using namespace std;

int main()
{
	string text = "BFCAI";

	for (int i = 1; i < text.length(); i++)
	{
		char currentChar = text[i];
		int j = i - 1;

		while (j >= 0 && text[j] > currentChar)
		{
			text[j + 1] = text[j];
			j--;
		}

		text[j + 1] = currentChar;
	}
	for (int i = 0; i < text.length(); i++)
	{
		cout << text[i] << " ";
	}

	return 0;
}