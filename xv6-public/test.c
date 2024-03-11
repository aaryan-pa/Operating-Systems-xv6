#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc,char* argv[]){
        int ptr=1;               //for traversing argv
        while(ptr < argc){       //looping over argv
        if(strcmp("head",argv[ptr]) == 0){
        char buf[1024];
        //int sentences = 0;
        //char curr_line[15][100]; // prev_line[] = "";
       if(argv[ptr+1][0] == '-'){    //option enabled
        int len=0;
        for(int i=0;i<strlen(argv[ptr+2]);i++)
        len = len*10+argv[ptr+2][i]-'0';
       const char *filename = argv[ptr+3];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        head(len,buf);
        ptr+=4;
       }
       else{
        const char *filename = argv[ptr+1];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        head(14,buf);                      //no options
        ptr+=2;
       }
    //printf(1,"ptr = %d\n",ptr);
    }
    if(ptr >= argc)
    exit();
    if(strcmp("uniq",argv[ptr]) == 0){
        char buf[1024];
    if(argv[ptr+1][0] != '-'){
        char *filename = argv[ptr+1];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        int option=-1;
        uniq(option,buf);
        ptr+=2;
    }
    else{
        char *filename = argv[ptr+2];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        int option=-1;
        if(argv[ptr+1][1] == 'd')
            option=1;
        else if (argv[ptr+1][1] == 'c')
            option=2;
        else
            option=3;
        uniq(option,buf);
        ptr+=3;
    }
    }
    // open()
    // close()   
}
exit();
}