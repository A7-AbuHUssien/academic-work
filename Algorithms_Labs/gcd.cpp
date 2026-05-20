#include <iostream>
using namespace std;

int main()
{
	int a = 60, b = 24, remainder;

	while (b > 0)
	{
		remainder = a;
		while (remainder - b >= 0)
		{
			remainder -= b;
		}
		a = b;
		b = remainder;
	}

	cout << a << endl;

	return 0;
}