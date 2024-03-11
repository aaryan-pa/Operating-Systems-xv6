#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    printf(1,"Uniq command is getting executed in user mode\n");
    if (argc == 1)
    {
        int n;
        int j = 0, k = 0;
        char buf[100];
        int sentences = 0;
        char curr_line[15][100]; // prev_line[] = "";
        while ((n = read(0, buf, sizeof(buf))) > 0)
        {
            for (int i = 0; i < n; i++)
            {
                //printf(1, "i= %d j= %d k= %d\n", i, j, k);

                if (buf[i] != '\n')
                {
                    curr_line[j][k++] = buf[i];
                }
                else
                {
                    curr_line[j][k] = '\0';
                    j++;
                    k = 0;
                    sentences++;
                }
            }
        }
        write(1, curr_line[0], strlen(curr_line[0]));
        printf(1,"\n");
        for (int i = 1; i < sentences ; i++)
        {
            if (strcmp(curr_line[i], curr_line[i - 1]) != 0)
            {
                write(1, curr_line[i], strlen(curr_line[i]));
                printf(1, "\n");
            }
        }
        exit();
    }

    else if (argc == 2)
    { // no options given
        const char *filename = argv[1];
        int fd = open(filename, O_RDONLY); // Open the file for reading
        //printf(1, "file = %s", filename);
        int n,sentences=0;
        char buf[100];
        if (fd < 0)
        {
            printf(2, "Failed to open file: %s\n", filename);
            exit();
        }
        while ((n = read(fd, buf, sizeof(buf))) > 0)
        {
            for (int i = 0; i < n; i++)
            {
                if (buf[i] == '\n' || buf[i] == '\0')
                {
                    sentences++;
                }
            }
        }
        // more than 1 sentence
        fd = open(filename, O_RDONLY);
        char curr_line[sentences][100]; // prev_line[] = "";
        int j = 0, k = 0;
        if(strlen(curr_line[0]) > 0 ){}
        while ((n = read(fd, buf, sizeof(buf))) > 0)
        {
            for (int i = 0; i < n; i++)
            {
                if (buf[i] != '\n')
                    curr_line[j][k++] = buf[i];
                else
                {
                    curr_line[j][k] = '\0';
                    j++;
                    k = 0;
                } // Print the character to stdout until whole sentence is printed
            }
        }
        write(1, curr_line[0], strlen(curr_line[0]));
        printf(1,"\n");
        for (int i = 1; i < sentences; i++)
        {
            if (strcmp(curr_line[i], curr_line[i - 1]) != 0)
            {
                write(1, curr_line[i], strlen(curr_line[i]));
                printf(1, "\n");
            }
        }

        // for (int i = 0; i < n; i++)
        // {
        //     // printf(1,"%d %d %s\n",i,j,buf[i]);
        //     printf(1, "i = %d\nchar = %c\n", i, buf[i]);
        //     if (buf[i] != '\n' || buf[i] != '\0')

        //     else
        //     {
        //         //j = 0;
        //         if ((strcmp(prev_line, "") == 0) || (strcmp(curr_line, prev_line) != 0))
        //         {
        //             write(1, curr_line, strlen(curr_line));
        //         }
        //         strcpy(prev_line, curr_line);
        //         memset(curr_line, 0, strlen(curr_line));
        //     }
        //     printf(1, "curr=%s prev=%s\n", curr_line, prev_line);
        // }
        // j holds the position of first \n

        exit();
    }
    else
    { // options
        if (argv[1][1] == 'd')
        {
            const char *filename = argv[2];
            int fd = open(filename, O_RDONLY); // Open the file for reading
            int n;
            char buf[100];
            if (fd < 0)
            {
                printf(2, "Failed to open file: %s\n", filename);
                exit();
            }
            int sentences = 0;
            while ((n = read(fd, buf, sizeof(buf))) > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] == '\n' || buf[i] == '\0')
                    {
                        sentences++;
                    }
                }
            }
            // more than 1 sentence
            fd = open(filename, O_RDONLY);
            char curr_line[sentences][100]; // prev_line[] = "";
            int j = 0, k = 0;

            while ((n = read(fd, buf, sizeof(buf))) > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] != '\n')
                        curr_line[j][k++] = buf[i];
                    else
                    {
                        curr_line[j][k] = '\0';
                        j++;
                        k = 0;
                    } // Print the character to stdout until whole sentence is printed
                }
            }
            // write(1,curr_line[0],strlen(curr_line[0]));
            int is_duplicate[sentences];
            is_duplicate[0] = 0;
            int counter = 0;
            for (int i = 1; i < sentences; i++)
            {
                if (strcmp(curr_line[i], curr_line[i - 1]) == 0)
                {
                    is_duplicate[i] = counter;
                    continue;
                }
                else
                {
                    counter++;
                    is_duplicate[i] = counter;
                }
            }
            
            int var = -1, i = 0;
            while (i < sentences)
            {
                if (var == is_duplicate[i])
                {
                    printf(1, "%s\n", curr_line[i]);
                    while (i < sentences && is_duplicate[i] == var)
                        i++;
                }
                else
                {
                    var = is_duplicate[i];
                    i++;
                }
            }
            exit();
        }
        else if (argv[1][1] == 'c')
        { // options
            const char *filename = argv[2];
            int fd = open(filename, O_RDONLY); // Open the file for reading
            int n;
            char buf[100];
            if (fd < 0)
            {
                printf(2, "Failed to open file: %s\n", filename);
                exit();
            }
            int sentences = 0;
            while ((n = read(fd, buf, sizeof(buf))) > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] == '\n' || buf[i] == '\0')
                    {
                        sentences++;
                    }
                }
            }
            // more than 1 sentence
            fd = open(filename, O_RDONLY);
            char curr_line[sentences][100]; // prev_line[] = "";
            int j = 0, k = 0;

            while ((n = read(fd, buf, sizeof(buf))) > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] != '\n')
                        curr_line[j][k++] = buf[i];
                    else
                    {
                        curr_line[j][k] = '\0';
                        j++;
                        k = 0;
                    } // Print the character to stdout until whole sentence is printed
                }
            }
            // write(1,curr_line[0],strlen(curr_line[0]));
            int is_duplicate[sentences];
            is_duplicate[0] = 1;
            for (int i = 1; i < sentences; i++)
            {
                if (strcmp(curr_line[i], curr_line[i - 1]) == 0)
                { // printf(1,"same %s %s i=%d counter=%d\n",curr_line[i],curr_line[i-1],i,is_duplicate[i]);
                    is_duplicate[i] = is_duplicate[i - 1] + 1;
                    continue;
                }
                else
                { // printf(1,"different %s %s %d counter=%d\n",curr_line[i],curr_line[i-1],i,is_duplicate[i]);
                    is_duplicate[i] = 1;
                }
            }
            for (int i = 0; i < sentences - 1; i++)
            {
                if (is_duplicate[i] < is_duplicate[i + 1])
                    continue;
                else
                {
                    printf(1, "%d %s\n", is_duplicate[i], curr_line[i]);
                }
            }
            printf(1, "%d %s\n", is_duplicate[sentences - 1], curr_line[sentences - 1]);
            exit();
        }
        else
        { //-i ignore case
            const char *filename = argv[2];
            int fd = open(filename, O_RDONLY); // Open the file for reading
            int n;
            char buf[100];
            if (fd < 0)
            {
                printf(2, "Failed to open file: %s\n", filename);
                exit();
            }
            int sentences = 0;
            while ((n = read(fd, buf, sizeof(buf))) > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] == '\n' || buf[i] == '\0')
                    {
                        sentences++;
                    }
                }
            }
            // more than 1 sentence
            fd = open(filename, O_RDONLY);
            char curr_line[sentences][100]; // prev_line[] = "";
            int j = 0, k = 0;

            while ((n = read(fd, buf, sizeof(buf))) > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] != '\n')
                        curr_line[j][k++] = buf[i];
                    else
                    {
                        curr_line[j][k] = '\0';
                        j++;
                        k = 0;
                    } // Print the character to stdout until whole sentence is printed
                }
            }
            char small_case[sentences][100];
            for (int i = 0; i < sentences; i++)
            {
                for (int j = 0; j < strlen(curr_line[i]); j++)
                {
                    if (curr_line[i][j] >= 'A' && curr_line[i][j] <= 'Z')
                        small_case[i][j] = curr_line[i][j] + 32;
                    else
                        small_case[i][j] = curr_line[i][j];
                }
            }
            write(1, curr_line[1], strlen(curr_line[1]));
            printf(1, "\n");
            for (int i = 1; i < sentences; i++)
            {
                if (strcmp(small_case[i], small_case[i - 1]) != 0)
                {
                    write(1, curr_line[i], strlen(curr_line[i]));
                    printf(1, "\n");
                }
            }

            // for (int i = 0; i < n; i++)
            // {
            //     // printf(1,"%d %d %s\n",i,j,buf[i]);
            //     printf(1, "i = %d\nchar = %c\n", i, buf[i]);
            //     if (buf[i] != '\n' || buf[i] != '\0')

            //     else
            //     {
            //         //j = 0;
            //         if ((strcmp(prev_line, "") == 0) || (strcmp(curr_line, prev_line) != 0))
            //         {
            //             write(1, curr_line, strlen(curr_line));
            //         }
            //         strcpy(prev_line, curr_line);
            //         memset(curr_line, 0, strlen(curr_line));
            //     }
            //     printf(1, "curr=%s prev=%s\n", curr_line, prev_line);
            // }
            // j holds the position of first \n
            exit();
        }
    }
}
