#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{

        char buf[1024];
        //int sentences = 0;
        //char curr_line[15][100]; // prev_line[] = "";
        char *filename = argv[1];
        if(argc > 2)
        { filename = argv[2]; }
        int fd = open(filename, O_RDONLY); // Open the file for reading
        read(fd,buf,sizeof(buf));
        // while ((n = read(0, buf, sizeof(buf))) > 0)
        // {
        //     for (int i = 0; i < n; i++)
        //     {
        //         //printf(1, "i= %d j= %d k= %d\n", i, j, k);

        //         if (buf[i] != '\n')
        //         {
        //             curr_line[j][k++] = buf[i];
        //         }
        //         else
        //         {
        //             curr_line[j][k] = '\0';
        //             j++;
        //             k = 0;
        //             sentences++;
        //         }
        //     }
        // }
        int option=-1;
        if(argc == 2)
        option=0;
        else{
            if(argv[1][1] == 'd')
            option=1;
            else if (argv[1][1] == 'c')
            option=2;
            else
            option=3;
        }
        //printf(1,"option = %d\n",option);
        
        uniq(option,buf);
        
        // write(1, curr_line[0], strlen(curr_line[0]));
        // printf(1,"\n");
        // for (int i = 1; i < sentences ; i++)
        // {
        //     if (strcmp(curr_line[i], curr_line[i - 1]) != 0)
        //     {
        //         write(1, curr_line[i], strlen(curr_line[i]));
        //         printf(1, "\n");
        //     }
        // }
        // exit();
    
    
    // open()
    // close()
    exit();
}