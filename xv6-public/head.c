#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc,char* argv[]){
    printf(1,"head command getting executed in user mode\n");
    if(argc == 2){
  char istext[4];
  int j=0;
  for(int i=strlen(argv[1])-4;i<strlen(argv[1]);i++){
   istext[j]+=argv[1][i];
   j++;
  }
  if(strcmp(istext,".txt") == 0) // is a text file
  {
    const char *filename = argv[1];
    int fd = open(filename, O_RDONLY); // Open the file for reading
int n;
 char buf[1000];
fd = open(filename, O_RDONLY);
if (fd < 0) {
        printf(2, "Failed to open file: %s\n", filename);
        exit();
    }
  int sentences=0;
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                sentences++;
            }
        }
    }
    if (sentences <= 14){
    fd = open(filename, O_RDONLY);
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
        }
    }
    exit();
    }
    else{
    fd = open(filename, O_RDONLY);
    int lines=14;
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                lines--;
                if(lines==0)
               { 
               exit(); 
               }
            }
        }
    }
    }
exit();
}
else  //not a text file
{
int len = strlen(argv[1]);
char input[len];
for(int i=0;i<len;i++){input[i] = argv[1][i];}

int sentences=0;
for(int i=0;i<strlen(input);i++){
if(input[i] == '\n')
sentences++;
}
if (sentences <= 14){
        write(1,input,strlen(input));
    exit();
    }
else{
 
    int lines=14;
    
        for (int i = 0; i < strlen(input); i++) {
            write(1, &input[i], 1);// Print the character to stdout
            if (input[i] == '\n') {
                // Print a newline character to stdout
                lines--;
                if(lines==0)
               { 
               exit(); 
               }
            }
        }
}
exit();
}
}
else{   //more than 2 arguments
if(argv[1][0] == '-'){      // -n option to specify length
if (argc==4){
int nlen=0;
for(int i=0;i<strlen(argv[2]);i++){
 nlen = nlen*10+argv[2][i]-'0';
}
char istext[4];
  int j=0;
  for(int i=strlen(argv[3])-4;i<strlen(argv[3]);i++){
   istext[j]+=argv[3][i];
   j++;
  }
  
  if(strcmp(istext,".txt") == 0) // is a text file
  {
    const char *filename = argv[3];
    int fd = open(filename, O_RDONLY); // Open the file for reading
int n;
 char buf[1000];
fd = open(filename, O_RDONLY);
if (fd < 0) {
        printf(2, "Failed to open file: %s\n", filename);
        exit();
    }
  int sentences=0;
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            // Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                sentences++;
                
            }
        }
    }
    if (sentences <= nlen){
    fd = open(filename, O_RDONLY);
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
        }
    }
    exit();
    }
    else{
    fd = open(filename, O_RDONLY);
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                nlen--;
                if(nlen==0)
               { 
               exit(); 
               }
            }
        }
    }
    }
exit();
}
 else //not a text file
 {
int len = strlen(argv[3]);
int nlen=0;
for(int i=0;i<strlen(argv[3]);i++){
 nlen = nlen*10+argv[2][i]-'0';
}
char input[len];
for(int i=0;i<len;i++){input[i] = argv[3][i];}

int sentences=0;
for(int i=0;i<strlen(input);i++){
if(input[i] == '\n')
sentences++;
}
if (sentences <= nlen){
        write(1,input,strlen(input));
    exit();
    }
else{
        for (int i = 0; i < strlen(input); i++) {
            write(1, &input[i], 1);// Print the character to stdout
            if (input[i] == '\n') {
                // Print a newline character to stdout
                nlen--;
                if(nlen==0)
               { 
               exit(); 
               }
            }
        }
exit();
}
exit();
}
} 
else{    //multiple files with -n
int nlen=0;
for(int i=0;i<strlen(argv[2]);i++)
 nlen = nlen*10+argv[2][i]-'0';
for(int i=3;i<argc;i++)
{

    char *filename = argv[i];
    int fd = open(filename, O_RDONLY); // Open the file for reading
    int n;
    char buf[1000];
    printf(1,"===> %s <===\n",filename);    
    if (fd < 0) {
        printf(2, "Failed to open file: %s\n", filename);
        exit();
    }
  int sentences=0;
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            // Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                sentences++;
            }
        }
    }
    if (sentences <= nlen){
    fd = open(filename, O_RDONLY);
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
        }
    }
    continue;
    }
    else{
    fd = open(filename, O_RDONLY);
    int lines=nlen;
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                lines--;
                if(lines==0)
               { 
               break; 
               }
            }
        }
    }
continue;
    }
//end for
exit();
}
exit();
}
}
else //multiple files 
{
for(int i=1;i<argc;i++)
{
    char *filename = argv[i];
    int fd = open(filename, O_RDONLY); // Open the file for reading
    int n;
    char buf[1000];
    printf(1,"===> %s <===\n",filename);
if (fd < 0) {
        printf(2, "Failed to open file: %s\n", filename);
        exit();
    }
  int sentences=0;
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            // Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                sentences++;
            }
        }
    }
    if (sentences <= 14){
    fd = open(filename, O_RDONLY);
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
        }
    }
    continue;
    }
    else{
    fd = open(filename, O_RDONLY);
    int lines=14;
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                lines--;
                if(lines==0)
               { 
               break; 
               }
            }
        }
    }
    }
continue;
//end for
}
exit();
}
exit();
}
}
