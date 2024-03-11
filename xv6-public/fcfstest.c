#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc,char* argv[]){
// char arg_vector[][] = {"a","b"};
// arg_vector[][10]--;

// int waits[argc-1];
// int turnarounds[argc-1];

for(int i=1;i<argc;i++){
    int pid = fork();
    if(pid == 0){
    char *function = argv[i];
    char *args[] = { function, "input.txt", 0};    
    exec(function, args);  
    }
    else{
        wait();
    }
}

exit();
}