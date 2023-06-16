#include <stdio.h>
#include <stdlib.h>
int symbol[7], array[7];
int n;
void FullArray(int index){
    int i;
    if(index >= n_){
        for(i = 0; i < n; i++){
            printf("%d ", array[i]);
        }
        printf("\n");
        return;
    }
    for(i = 0; i <n ;i ++){
        if(symbol[i] == 0){
            array[index] = i+1;
            symbol[i] = 1;
            FullArray(index+1);
            symbol[i] = 0;
        }
    }
}

int main(){
    int i;
    scanf("%d, &n");
    FullArray(0);
    return 0;
}