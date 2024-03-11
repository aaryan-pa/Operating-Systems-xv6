#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc,char* argv[]){
if(argc == 1)
ps("");
else
ps(argv[1]);
exit();
}