#include <stdio.h>
#include <conio.h>

int main(int rgi, char** argc){
    
    int n;
    
    printf("Dame el numero con el que deseas iniciar la serie: ");
    scanf("%d", &n);
    printf("%d ", n);
    
    while(n > 1){
            if(n % 2 == 0){
                 n /= 2;
            }
            else{
                 n = (n * 3) + 1;
            }
            printf("%d ", n);
    }
    
    getch();
    return 0;
}
