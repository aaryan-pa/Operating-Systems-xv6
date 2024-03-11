#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
  return fork();
}

int sys_exit(void)
{
  exit();
  return 0; // not reached
}

int sys_wait(void)
{
  return wait();
}

int sys_kill(void)
{
  int pid;

  if (argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int sys_getpid(void)
{
  return myproc()->pid;
}

int sys_sbrk(void)
{
  int addr;
  int n;

  if (argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if (growproc(n) < 0)
    return -1;
  return addr;
}

int sys_sleep(void)
{
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while (ticks - ticks0 < n)
  {
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
int sys_uniq(void)
{
  // int sentences;
  cprintf("Uniq command is getting executed in kernel mode\n");
  char *string;
  // argptr(0,&string,1);
  int option;
  argint(0, &option);
  argstr(1, &string);
  // argint(1,&sentences);
  // cprintf("in kernel = %s", string);
  int sentences = 0;
  int j = 0, k = 0;
  char curr_line[15][100]; // prev_line[] = "";
  if (strlen(curr_line[0]) > 0)
  {
  }
  for (int i = 0; i < strlen(string); i++)
  {
    // printf(1, "i= %d j= %d k= %d\n", i, j, k);
    if (string[i] != '\n')
    {
      curr_line[j][k++] = string[i];
    }
    else
    {
      curr_line[j][k] = '\0';
      j++;
      k = 0;
      sentences++;
    }
  }
  if (sentences > 0)
  {
    ;
  }
  if (option == 0)
  {
    cprintf("%s", curr_line[0]);
    // write(1, curr_line[0], strlen(curr_line[0]));
    cprintf("\n");
    //cprintf("inside option 0 - sentences=%d\n", sentences);
    int max;
    for (int i = 1; i < sentences; i++)
    {
      max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
      if (strncmp(curr_line[i], curr_line[i - 1], max) != 0)
      {
        cprintf("%s", curr_line[i]);
        cprintf("\n");
      }
    }
    // curr_line[0][0]='a';
    // for (int i = 0; i <strlen(string) ; i++)
    //             {
    //               //printf(1, "i= %d j= %d k= %d\n", i, j, k);
    //               if (string[i] != '\n')
    //               {
    //                   current_line[j++] = string[i];
    //                   continue;
    //               }
    //               else  //string[i]=='\n'
    //               {
    //                   if(strncmp(prev_line,"") == 0)
    //                   {
    //                     cprintf("%s\n",curr_line);
    //                   }
    //                   else if(strncmp(prev_line,current_line) == 0)
    //                   {

    //                   }
    //                   curr_line[j] = '\0';
    //                   j++;
    //                   k = 0;
    //                   sentences++;
    //               }
    //           }
    //cprintf("before options = %d", sentences);
    return 0;
  }
  else if (option == 1)
  {
    // cprintf("inside option 1 - sentences=%d\n", sentences);
    int is_duplicate[sentences];
    is_duplicate[0] = 0;
    int counter = 0, max = -1;
    for (int i = 1; i < sentences; i++)
    {
      max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
      if (strncmp(curr_line[i], curr_line[i - 1], max) == 0)
      {
        // cprintf("same %s %s i=%d counter=%d\n", curr_line[i], curr_line[i - 1], i, counter);
        is_duplicate[i] = counter;
        continue;
      }
      else
      {
        // cprintf("different %s %s %d counter=%d\n", curr_line[i], curr_line[i - 1], i, counter);
        counter++;
        is_duplicate[i] = counter;
      }
    }
    // cprintf("is_dup array\n");
    // for (int i = 0; i < sentences; i++)
      // cprintf("i= %d a[i]= %d\n", i, is_duplicate[i]);
    int var = -1, i = 0;
    while (i < sentences)
    {
      if (var == is_duplicate[i])
      {
        cprintf("%s\n", curr_line[i]);
        while (i < sentences && is_duplicate[i] == var)
          i++;
      }
      else
      {
        var = is_duplicate[i];
        i++;
      }
    }
    // cprintf("outside while\n");
    return 0;
  }
  else if(option == 2){
    int is_duplicate[sentences];
            is_duplicate[0] = 1;
            int max;
            for (int i = 1; i < sentences; i++)
            {    
              max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
                if (strncmp(curr_line[i], curr_line[i - 1],max) == 0)
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
                    cprintf("%d %s\n", is_duplicate[i], curr_line[i]);
                }
            }
            cprintf("%d %s\n", is_duplicate[sentences - 1], curr_line[sentences - 1]);
    return 0;
  }
  else{
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
            cprintf(curr_line[1]);
            cprintf("\n");
            int max=-1;
            for (int i = 1; i < sentences; i++)
            {  
              max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
                if (strncmp(small_case[i], small_case[i - 1],max) != 0)
                {
                    cprintf(curr_line[i]);
                    cprintf("\n");
                }
            }
  return 0;
  }
  return 0;
}
// return how many clock tick interrupts have occurred
// since start.
int sys_head(void)
{
  cprintf("head command is getting executed in kernel mode\n");
  int max_len;
  char *string;
  argint(0, &max_len);
  argstr(1, &string);

  int sentences = 0;
  int j = 0, k = 0;
  char curr_line[15][100]; // prev_line[] = "";
  if (strlen(curr_line[0]) > 0)
  {
  }
  for (int i = 0; i < strlen(string); i++)
  {
    // printf(1, "i= %d j= %d k= %d\n", i, j, k);

    if (string[i] != '\n')
    {
      curr_line[j][k++] = string[i];
    }
    else
    {
      curr_line[j][k] = '\0';
      j++;
      k = 0;
      sentences++;
    }
  }
  if (sentences < max_len)
  {
    for (int i = 0; i < sentences; i++)
      cprintf("%s\n", curr_line[i]);
  }
  else
  {
    int i = 0;
    while (max_len > 0)
    {
      cprintf("%s\n", curr_line[i]);
      i++;
      max_len--;
    }
  }
  return 0;
}
int sys_ps(void){
  char *string;
  argstr(0, &string);
  return ps(string);
}
int sys_change_priority(void){
  int pid;
  int priority;
  argint(0,&pid);
  argint(1,&priority);
  return change_priority(pid,priority);
}
int sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
