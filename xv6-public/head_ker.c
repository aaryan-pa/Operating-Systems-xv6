#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
char buf[1024];
        //int sentences = 0;
        //char curr_line[15][100]; // prev_line[] = "";
        
       if(argv[1][0] == '-'){
        int len=0;
        for(int i=0;i<strlen(argv[2]);i++)
        len = len*10+argv[2][i]-'0';
    
       const char *filename = argv[3];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        head(len,buf);
       }
       else{
        const char *filename = argv[1];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        head(14,buf);
       }
    
    
    // open()
    // close()
    exit();
}