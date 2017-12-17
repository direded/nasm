#include <stdio.h>
#include <float.h>

int main() {
	double n = 0;
	scanf("%lf", &n);
	double eps = 0.001;
	scanf("%lf", &eps);

	double l = 0;
	double r = DBL_MAX;
	double m = 0;
	while (r - l > eps) {
		m = l + (r - l) / 2;
		if (m*m > n) 
			r = m;
		else
			l = m;
	}

	printf("%.20f\n%.20f\n%.20f", l, m, r);


}