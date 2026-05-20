#include<iostream>
using namespace std;

void merge(int arr[], int s, int e, int mid)
{
	int i = s, j = mid + 1, k = s;
	int* R = new int[e + 1];
	while (i <= mid  || j <= e)
	{
		if (i > mid) {
			R[k] = arr[j];
			j++;
		}
		else if (j > e)
		{
			R[k] = arr[i];
			i++;
		}
		else
		{
			if (arr[i] > arr[j])
			{
				R[k] = arr[j];
				j++;
			}
			else
			{
				R[k] = arr[i];
				i++;
			}
			
		}
		k++;
	}
	for (int i = s; i <= e; i++)
	{
		arr[i] = R[i];
	}
}

void merge_sort(int arr[], int s, int e)
{
	if (s < e)
	{
		int mid = (s + e) / 2;
		merge_sort(arr, s, mid);
		merge_sort(arr, mid + 1, e);
		merge(arr, s, e, mid);
	}
	
}




//
//void merge(int arr[], int s, int e,int mid)
//{
//	int i = s, j = mid+1, k = s;
//	int* R = new int[e + 1];
//	while (i<=mid || j<=e)
//	{
//		if (i > mid) {
//			R[k] = arr[j];
//			j++;
//		}
//		else if (j > e)
//		{
//			R[k] = arr[i];
//			i++;
//		}
//		else
//		{
//			if (arr[i] > arr[j])
//			{
//				R[k] = arr[j];
//				j++;
//			}
//			else {
//				R[k] = arr[i];
//				i++;
//			}
//		}
//		k++;
//	}
//	for (int i = s; i <= e; i++)
//	{
//		arr[i] = R[i];
//	}
//
//}
//void merge_sort(int arr[], int s, int e)
//{
//	/*for (int i = s; i <= e; i++)
//	{
//		cout << arr[i] << " ";
//	}*/
//	//cout << endl;
//	if (s < e)
//	{
//		int mid = (s + e) / 2;
//		merge_sort(arr, s, mid);
//		merge_sort(arr, mid + 1, e);
//		merge(arr, s, e, mid);
//	}
//
//	
//}
int main()
{
	int arr[] = { 6,9,5,3,1 ,4};
	int s = sizeof(arr) / sizeof(arr[0]);
	merge_sort(arr, 0, s - 1);
	for (size_t i = 0; i < s; i++)
	{
		cout << arr[i] << " ";
	}
	cout << endl;

	return 0;
}