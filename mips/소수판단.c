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
		printf("�Ҽ�\n");
	}
	else{
		printf("�Ҽ� �ƴ�\n");
	}
} 
