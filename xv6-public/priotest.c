#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{

    // for(int i=1;i<argc;i++){
    // int pid = fork();
    // wait();
    // if(pid == 0){
    // if(atoi(argv[i]) == 0)
    // {    // printf(1,"i= %d",i);
    //     // printf(1,"\n");
    // if(i == argc-1)   //last argument can only be a function
    // {
    //     char *function = argv[i];
    //     char *args[] = { function, "input.txt", 0};

    //     // printf(1,"args = ",args[0]);
    //     // printf(1,"\n");
    //     exec(function, args);
    //     continue;
    // }
    // else{
    // if(atoi(argv[i+1]) != 0){
    //     char *function = argv[i];
    //     char *args[] = { function, "input.txt", 0};
    //     int curr_priority = atoi(argv[i+1]);
    //     //change_priority(pid,curr_priority);
    //     // printf(1,"args = ",args[1]);
    //     // printf(1,"\n");
    //     printf(1,"priority = %d\n",curr_priority);
    //     exec(function, args);
    //     continue;
    //     //exec(function, args);
    // }
    // else{
    //     char *function = argv[i];
    //     char *args[] = { function, "input.txt", 0};
    //     exec(function, args);
    //     continue;
    // }
    // }
    // }
    // else
    // continue;
    // }
    // }
    int priorities[argc];
    memset(priorities, 0, argc);

    for (int i = 0; i < argc; i++)
    {
        priorities[i] = atoi(argv[i]);
    }
    for (int i = 1; i < argc - 1; i++)
    {
        if (priorities[i + 1] != 0)
            priorities[i] = priorities[i + 1];
        else
        {
            if (strcmp(argv[i], "uniq_ker") == 0)
                priorities[i] = 9;
            if (strcmp(argv[i], "head_ker") == 0)
                priorities[i] = 9;
            if (strcmp(argv[i], "head") == 0)
                priorities[i] = 10;
            if (strcmp(argv[i], "uniq") == 0)
                priorities[i] = 10;
        }
    }
    if (strcmp(argv[argc - 1], "uniq_ker") == 0)
        priorities[argc - 1] = 9;
    if (strcmp(argv[argc - 1], "head_ker") == 0)
        priorities[argc - 1] = 9;
    if (strcmp(argv[argc - 1], "head") == 0)
        priorities[argc - 1] = 10;
    if (strcmp(argv[argc - 1], "uniq") == 0)
        priorities[argc - 1] = 10;
    // for (int i = 0; i < argc; i++)
    //     printf(1, "%d %d\n", i, priorities[i]);
    for (int p = 1; p <= 10; p++)
    {
            for (int i = 1; i < argc; i++)
            {
                if (atoi(argv[i]) == 0)
                {
                    if (priorities[i] == p)
                    {
                        int pid = fork();
                        if (pid == 0)
                        {
                        char *function = argv[i];
                        char *args[] = {function, "input.txt", 0};
                        exec(function, args);
                        }
                        else
                        wait();
                    }
                    else
                        continue;
                }
            }
        
        
    }
    exit();
}