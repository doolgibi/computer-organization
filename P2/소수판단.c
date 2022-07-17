#include <stdio.h>
#include <stdlib.h>

int main(){
	int n;
	int cnt;
	
	scanf("%d", &n);
	
	for(int i = 2; i <n; i++){
		if(n % n == 0){
			cnt++;
		}
	}
	
	if(cnt==0){
		printf("소수\n");
	}
	else{
		printf("소수 아님\n");
	}
} 
