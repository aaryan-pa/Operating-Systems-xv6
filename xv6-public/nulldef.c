#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#define NULL ((void *)0)

int main(int argc,char* argv[]){
int *ptr;
ptr=NULL;
printf(1,"Null pointer deference %p\n",*ptr);
exit();
}