#include <stdio.h>

void main(){
  
   int cant,y,chrs;

     printf("Mete los necesarios? : ");
    

     scanf(" %d",   &cant);
     printf("Long aprox de los usaados? ");
     

     scanf(" %d", &chrs);

     char nombre[cant][chrs]; 

    for(y=0; y<cant;y++) 
    {
	     printf("\nPersona  %d : ",y+1);
	     scanf(" %[^\n]", &nombre[y]);
     }
    for(y=0;y<cant;y++)
    {
      printf(" %d nombre es %s \n ",y+1, nombre[i]);
    }
}
