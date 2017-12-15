#include <stdio.h>

void swap(int* a, int* b) {
	int temp = *a;
	*a = *b;
	*b = temp;
}

void quicksort(int* a, int l, int r) { /* a[l..r] */
	if (l >= r) 
		return;
	int q = r;
	int x = a[q];
	int i = l - 1;
	for (int j = l; j <= r; j++) {
		if (j == q)
			continue;
		if (a[j] < x) {
			i++;
			swap(&a[i], &a[j]); 
		}
	}
	i++;
	swap(&a[i], &a[r]);
	quicksort(a, l, i - 1);
	quicksort(a, i + 1, r);
}

int main() {
	int a[] = {4, 3, 2, 5, 7, 1, 4};
	quicksort(a, 0, 6);
	for (int i = 0; i < 7; i++)
		printf("%d ", a[i]);
	printf("\n");
	return 0;
}