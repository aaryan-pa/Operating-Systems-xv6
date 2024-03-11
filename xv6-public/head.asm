
_head:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc,char* argv[]){
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	57                   	push   %edi
    300e:	56                   	push   %esi
    300f:	53                   	push   %ebx
    3010:	51                   	push   %ecx
    3011:	81 ec 10 08 00 00    	sub    $0x810,%esp
    3017:	8b 31                	mov    (%ecx),%esi
    3019:	8b 41 04             	mov    0x4(%ecx),%eax
    printf(1,"head command getting executed in user mode\n");
    301c:	68 18 40 00 00       	push   $0x4018
    3021:	6a 01                	push   $0x1
int main(int argc,char* argv[]){
    3023:	89 b5 f8 f7 ff ff    	mov    %esi,-0x808(%ebp)
    3029:	89 85 fc f7 ff ff    	mov    %eax,-0x804(%ebp)
    printf(1,"head command getting executed in user mode\n");
    302f:	e8 bc 0c 00 00       	call   3cf0 <printf>
    if(argc == 2){
    3034:	83 c4 10             	add    $0x10,%esp
    3037:	83 fe 02             	cmp    $0x2,%esi
    303a:	0f 84 02 03 00 00    	je     3342 <main+0x342>
}
exit();
}
}
else{   //more than 2 arguments
if(argv[1][0] == '-'){      // -n option to specify length
    3040:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    3046:	8b 40 04             	mov    0x4(%eax),%eax
    3049:	80 38 2d             	cmpb   $0x2d,(%eax)
    304c:	0f 84 94 01 00 00    	je     31e6 <main+0x1e6>
exit();
}
}
else //multiple files 
{
for(int i=1;i<argc;i++)
    3052:	83 bd f8 f7 ff ff 01 	cmpl   $0x1,-0x808(%ebp)
    3059:	c7 85 00 f8 ff ff 01 	movl   $0x1,-0x800(%ebp)
    3060:	00 00 00 
    3063:	0f 8e 93 00 00 00    	jle    30fc <main+0xfc>
{
    char *filename = argv[i];
    3069:	8b 8d 00 f8 ff ff    	mov    -0x800(%ebp),%ecx
    306f:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    int fd = open(filename, O_RDONLY); // Open the file for reading
    3075:	83 ec 08             	sub    $0x8,%esp
    char *filename = argv[i];
    3078:	8b 3c 88             	mov    (%eax,%ecx,4),%edi
    int fd = open(filename, O_RDONLY); // Open the file for reading
    307b:	6a 00                	push   $0x0
    307d:	57                   	push   %edi
    307e:	e8 40 0b 00 00       	call   3bc3 <open>
    int n;
    char buf[1000];
    printf(1,"===> %s <===\n",filename);
    3083:	83 c4 0c             	add    $0xc,%esp
    3086:	57                   	push   %edi
    int fd = open(filename, O_RDONLY); // Open the file for reading
    3087:	89 c3                	mov    %eax,%ebx
    printf(1,"===> %s <===\n",filename);
    3089:	68 62 40 00 00       	push   $0x4062
    308e:	6a 01                	push   $0x1
    3090:	e8 5b 0c 00 00       	call   3cf0 <printf>
if (fd < 0) {
    3095:	83 c4 10             	add    $0x10,%esp
    3098:	85 db                	test   %ebx,%ebx
    309a:	0f 88 33 01 00 00    	js     31d3 <main+0x1d3>
        printf(2, "Failed to open file: %s\n", filename);
        exit();
    }
  int sentences=0;
    30a0:	31 f6                	xor    %esi,%esi
    30a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    30a8:	83 ec 04             	sub    $0x4,%esp
    30ab:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
    30b1:	68 e8 03 00 00       	push   $0x3e8
    30b6:	50                   	push   %eax
    30b7:	53                   	push   %ebx
    30b8:	e8 de 0a 00 00       	call   3b9b <read>
    30bd:	83 c4 10             	add    $0x10,%esp
    30c0:	85 c0                	test   %eax,%eax
    30c2:	7e 3d                	jle    3101 <main+0x101>
    30c4:	8d 95 00 fc ff ff    	lea    -0x400(%ebp),%edx
    30ca:	01 d0                	add    %edx,%eax
    30cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (int i = 0; i < n; i++) {
            // Print the character to stdout
            if (buf[i] == '\n') {
                // Print a newline character to stdout
                sentences++;
    30d0:	31 c9                	xor    %ecx,%ecx
    30d2:	80 3a 0a             	cmpb   $0xa,(%edx)
    30d5:	0f 94 c1             	sete   %cl
        for (int i = 0; i < n; i++) {
    30d8:	83 c2 01             	add    $0x1,%edx
                sentences++;
    30db:	01 ce                	add    %ecx,%esi
        for (int i = 0; i < n; i++) {
    30dd:	39 c2                	cmp    %eax,%edx
    30df:	75 ef                	jne    30d0 <main+0xd0>
    30e1:	eb c5                	jmp    30a8 <main+0xa8>
for(int i=1;i<argc;i++)
    30e3:	83 85 00 f8 ff ff 01 	addl   $0x1,-0x800(%ebp)
    30ea:	8b 85 00 f8 ff ff    	mov    -0x800(%ebp),%eax
    30f0:	39 85 f8 f7 ff ff    	cmp    %eax,-0x808(%ebp)
    30f6:	0f 85 6d ff ff ff    	jne    3069 <main+0x69>
    exit();
    30fc:	e8 82 0a 00 00       	call   3b83 <exit>
            }
        }
    }
    if (sentences <= 14){
    3101:	83 fe 0e             	cmp    $0xe,%esi
    3104:	7f 5b                	jg     3161 <main+0x161>
    fd = open(filename, O_RDONLY);
    3106:	83 ec 08             	sub    $0x8,%esp
    3109:	6a 00                	push   $0x0
    310b:	57                   	push   %edi
    310c:	e8 b2 0a 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3111:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    3114:	89 c6                	mov    %eax,%esi
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    311d:	8d 76 00             	lea    0x0(%esi),%esi
    3120:	83 ec 04             	sub    $0x4,%esp
    3123:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
    3129:	68 e8 03 00 00       	push   $0x3e8
    312e:	50                   	push   %eax
    312f:	56                   	push   %esi
    3130:	e8 66 0a 00 00       	call   3b9b <read>
    3135:	83 c4 10             	add    $0x10,%esp
    3138:	85 c0                	test   %eax,%eax
    313a:	7e a7                	jle    30e3 <main+0xe3>
    313c:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
    3142:	8d 3c 03             	lea    (%ebx,%eax,1),%edi
    3145:	8d 76 00             	lea    0x0(%esi),%esi
        for (int i = 0; i < n; i++) {
            write(1, &buf[i], 1);// Print the character to stdout
    3148:	83 ec 04             	sub    $0x4,%esp
    314b:	6a 01                	push   $0x1
    314d:	53                   	push   %ebx
        for (int i = 0; i < n; i++) {
    314e:	83 c3 01             	add    $0x1,%ebx
            write(1, &buf[i], 1);// Print the character to stdout
    3151:	6a 01                	push   $0x1
    3153:	e8 4b 0a 00 00       	call   3ba3 <write>
        for (int i = 0; i < n; i++) {
    3158:	83 c4 10             	add    $0x10,%esp
    315b:	39 fb                	cmp    %edi,%ebx
    315d:	75 e9                	jne    3148 <main+0x148>
    315f:	eb bf                	jmp    3120 <main+0x120>
        }
    }
    continue;
    }
    else{
    fd = open(filename, O_RDONLY);
    3161:	83 ec 08             	sub    $0x8,%esp
    int lines=14;
    3164:	be 0e 00 00 00       	mov    $0xe,%esi
    fd = open(filename, O_RDONLY);
    3169:	6a 00                	push   $0x0
    316b:	57                   	push   %edi
    316c:	e8 52 0a 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3171:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    3174:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    317a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3180:	83 ec 04             	sub    $0x4,%esp
    3183:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
    3189:	68 e8 03 00 00       	push   $0x3e8
    318e:	50                   	push   %eax
    318f:	ff b5 04 f8 ff ff    	push   -0x7fc(%ebp)
    3195:	e8 01 0a 00 00       	call   3b9b <read>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	85 c0                	test   %eax,%eax
    319f:	0f 8e 3e ff ff ff    	jle    30e3 <main+0xe3>
    31a5:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
    31ab:	8d 3c 03             	lea    (%ebx,%eax,1),%edi
    31ae:	eb 07                	jmp    31b7 <main+0x1b7>
        for (int i = 0; i < n; i++) {
    31b0:	83 c3 01             	add    $0x1,%ebx
    31b3:	39 fb                	cmp    %edi,%ebx
    31b5:	74 c9                	je     3180 <main+0x180>
            write(1, &buf[i], 1);// Print the character to stdout
    31b7:	83 ec 04             	sub    $0x4,%esp
    31ba:	6a 01                	push   $0x1
    31bc:	53                   	push   %ebx
    31bd:	6a 01                	push   $0x1
    31bf:	e8 df 09 00 00       	call   3ba3 <write>
            if (buf[i] == '\n') {
    31c4:	83 c4 10             	add    $0x10,%esp
    31c7:	80 3b 0a             	cmpb   $0xa,(%ebx)
    31ca:	75 e4                	jne    31b0 <main+0x1b0>
                // Print a newline character to stdout
                lines--;
                if(lines==0)
    31cc:	83 ee 01             	sub    $0x1,%esi
    31cf:	75 df                	jne    31b0 <main+0x1b0>
    31d1:	eb ad                	jmp    3180 <main+0x180>
        printf(2, "Failed to open file: %s\n", filename);
    31d3:	50                   	push   %eax
    31d4:	57                   	push   %edi
    31d5:	68 49 40 00 00       	push   $0x4049
    31da:	6a 02                	push   $0x2
    31dc:	e8 0f 0b 00 00       	call   3cf0 <printf>
        exit();
    31e1:	e8 9d 09 00 00       	call   3b83 <exit>
for(int i=0;i<strlen(argv[2]);i++){
    31e6:	8b bd fc f7 ff ff    	mov    -0x804(%ebp),%edi
    31ec:	31 db                	xor    %ebx,%ebx
int nlen=0;
    31ee:	31 f6                	xor    %esi,%esi
if (argc==4){
    31f0:	83 bd f8 f7 ff ff 04 	cmpl   $0x4,-0x808(%ebp)
for(int i=0;i<strlen(argv[2]);i++){
    31f7:	8b 47 08             	mov    0x8(%edi),%eax
if (argc==4){
    31fa:	75 1d                	jne    3219 <main+0x219>
    31fc:	e9 d9 00 00 00       	jmp    32da <main+0x2da>
    3201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 nlen = nlen*10+argv[2][i]-'0';
    3208:	8b 47 08             	mov    0x8(%edi),%eax
    320b:	8d 0c b6             	lea    (%esi,%esi,4),%ecx
    320e:	0f be 14 18          	movsbl (%eax,%ebx,1),%edx
for(int i=0;i<strlen(argv[2]);i++)
    3212:	83 c3 01             	add    $0x1,%ebx
 nlen = nlen*10+argv[2][i]-'0';
    3215:	8d 74 4a d0          	lea    -0x30(%edx,%ecx,2),%esi
for(int i=0;i<strlen(argv[2]);i++)
    3219:	83 ec 0c             	sub    $0xc,%esp
    321c:	50                   	push   %eax
    321d:	e8 9e 07 00 00       	call   39c0 <strlen>
    3222:	83 c4 10             	add    $0x10,%esp
    3225:	39 d8                	cmp    %ebx,%eax
    3227:	77 df                	ja     3208 <main+0x208>
for(int i=3;i<argc;i++)
    3229:	83 bd f8 f7 ff ff 03 	cmpl   $0x3,-0x808(%ebp)
    3230:	89 b5 f4 f7 ff ff    	mov    %esi,-0x80c(%ebp)
    3236:	0f 8e c0 fe ff ff    	jle    30fc <main+0xfc>
    323c:	c7 85 00 f8 ff ff 03 	movl   $0x3,-0x800(%ebp)
    3243:	00 00 00 
    char *filename = argv[i];
    3246:	8b 8d 00 f8 ff ff    	mov    -0x800(%ebp),%ecx
    324c:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    int fd = open(filename, O_RDONLY); // Open the file for reading
    3252:	83 ec 08             	sub    $0x8,%esp
    char *filename = argv[i];
    3255:	8b 3c 88             	mov    (%eax,%ecx,4),%edi
    int fd = open(filename, O_RDONLY); // Open the file for reading
    3258:	6a 00                	push   $0x0
    325a:	57                   	push   %edi
    325b:	e8 63 09 00 00       	call   3bc3 <open>
    printf(1,"===> %s <===\n",filename);    
    3260:	83 c4 0c             	add    $0xc,%esp
    3263:	57                   	push   %edi
    int fd = open(filename, O_RDONLY); // Open the file for reading
    3264:	89 c3                	mov    %eax,%ebx
    printf(1,"===> %s <===\n",filename);    
    3266:	68 62 40 00 00       	push   $0x4062
    326b:	6a 01                	push   $0x1
    326d:	e8 7e 0a 00 00       	call   3cf0 <printf>
    if (fd < 0) {
    3272:	83 c4 10             	add    $0x10,%esp
    3275:	85 db                	test   %ebx,%ebx
    3277:	0f 88 56 ff ff ff    	js     31d3 <main+0x1d3>
  int sentences=0;
    327d:	31 f6                	xor    %esi,%esi
    327f:	90                   	nop
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3280:	83 ec 04             	sub    $0x4,%esp
    3283:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
    3289:	68 e8 03 00 00       	push   $0x3e8
    328e:	50                   	push   %eax
    328f:	53                   	push   %ebx
    3290:	e8 06 09 00 00       	call   3b9b <read>
    3295:	83 c4 10             	add    $0x10,%esp
    3298:	85 c0                	test   %eax,%eax
    329a:	0f 8e c0 01 00 00    	jle    3460 <main+0x460>
    32a0:	8d 95 00 fc ff ff    	lea    -0x400(%ebp),%edx
    32a6:	89 d1                	mov    %edx,%ecx
    32a8:	01 c1                	add    %eax,%ecx
    32aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                sentences++;
    32b0:	31 c0                	xor    %eax,%eax
    32b2:	80 3a 0a             	cmpb   $0xa,(%edx)
    32b5:	0f 94 c0             	sete   %al
        for (int i = 0; i < n; i++) {
    32b8:	83 c2 01             	add    $0x1,%edx
                sentences++;
    32bb:	01 c6                	add    %eax,%esi
        for (int i = 0; i < n; i++) {
    32bd:	39 d1                	cmp    %edx,%ecx
    32bf:	75 ef                	jne    32b0 <main+0x2b0>
    32c1:	eb bd                	jmp    3280 <main+0x280>
 nlen = nlen*10+argv[2][i]-'0';
    32c3:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    32c9:	8d 0c b6             	lea    (%esi,%esi,4),%ecx
    32cc:	8b 40 08             	mov    0x8(%eax),%eax
    32cf:	0f be 14 18          	movsbl (%eax,%ebx,1),%edx
for(int i=0;i<strlen(argv[2]);i++){
    32d3:	83 c3 01             	add    $0x1,%ebx
 nlen = nlen*10+argv[2][i]-'0';
    32d6:	8d 74 4a d0          	lea    -0x30(%edx,%ecx,2),%esi
for(int i=0;i<strlen(argv[2]);i++){
    32da:	83 ec 0c             	sub    $0xc,%esp
    32dd:	50                   	push   %eax
    32de:	e8 dd 06 00 00       	call   39c0 <strlen>
    32e3:	83 c4 10             	add    $0x10,%esp
    32e6:	39 d8                	cmp    %ebx,%eax
    32e8:	77 d9                	ja     32c3 <main+0x2c3>
  for(int i=strlen(argv[3])-4;i<strlen(argv[3]);i++){
    32ea:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    32f0:	83 ec 0c             	sub    $0xc,%esp
    32f3:	89 b5 04 f8 ff ff    	mov    %esi,-0x7fc(%ebp)
    32f9:	8d bd 14 f8 ff ff    	lea    -0x7ec(%ebp),%edi
    32ff:	89 fe                	mov    %edi,%esi
    3301:	ff 70 0c             	push   0xc(%eax)
    3304:	e8 b7 06 00 00       	call   39c0 <strlen>
    3309:	83 c4 10             	add    $0x10,%esp
    330c:	8d 58 fc             	lea    -0x4(%eax),%ebx
    330f:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    3315:	83 ec 0c             	sub    $0xc,%esp
    3318:	ff 70 0c             	push   0xc(%eax)
    331b:	e8 a0 06 00 00       	call   39c0 <strlen>
    3320:	83 c4 10             	add    $0x10,%esp
    3323:	39 d8                	cmp    %ebx,%eax
    3325:	0f 86 28 02 00 00    	jbe    3553 <main+0x553>
   istext[j]+=argv[3][i];
    332b:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    3331:	8b 40 0c             	mov    0xc(%eax),%eax
    3334:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
  for(int i=strlen(argv[3])-4;i<strlen(argv[3]);i++){
    3338:	83 c3 01             	add    $0x1,%ebx
   istext[j]+=argv[3][i];
    333b:	00 06                	add    %al,(%esi)
  for(int i=strlen(argv[3])-4;i<strlen(argv[3]);i++){
    333d:	83 c6 01             	add    $0x1,%esi
    3340:	eb cd                	jmp    330f <main+0x30f>
  for(int i=strlen(argv[1])-4;i<strlen(argv[1]);i++){
    3342:	8b b5 fc f7 ff ff    	mov    -0x804(%ebp),%esi
    3348:	83 ec 0c             	sub    $0xc,%esp
    334b:	ff 76 04             	push   0x4(%esi)
    334e:	e8 6d 06 00 00       	call   39c0 <strlen>
    3353:	8b 56 04             	mov    0x4(%esi),%edx
    3356:	83 c4 10             	add    $0x10,%esp
    3359:	8d b5 10 f8 ff ff    	lea    -0x7f0(%ebp),%esi
    335f:	83 ec 0c             	sub    $0xc,%esp
    3362:	89 f7                	mov    %esi,%edi
    3364:	8d 58 fc             	lea    -0x4(%eax),%ebx
    3367:	52                   	push   %edx
    3368:	29 c7                	sub    %eax,%edi
    336a:	e8 51 06 00 00       	call   39c0 <strlen>
    336f:	83 c4 10             	add    $0x10,%esp
    3372:	39 d8                	cmp    %ebx,%eax
    3374:	76 24                	jbe    339a <main+0x39a>
   istext[j]+=argv[1][i];
    3376:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
  for(int i=strlen(argv[1])-4;i<strlen(argv[1]);i++){
    337c:	83 ec 0c             	sub    $0xc,%esp
   istext[j]+=argv[1][i];
    337f:	8b 50 04             	mov    0x4(%eax),%edx
    3382:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
    3386:	00 44 1f 04          	add    %al,0x4(%edi,%ebx,1)
  for(int i=strlen(argv[1])-4;i<strlen(argv[1]);i++){
    338a:	83 c3 01             	add    $0x1,%ebx
    338d:	52                   	push   %edx
    338e:	e8 2d 06 00 00       	call   39c0 <strlen>
    3393:	83 c4 10             	add    $0x10,%esp
    3396:	39 d8                	cmp    %ebx,%eax
    3398:	77 dc                	ja     3376 <main+0x376>
  if(strcmp(istext,".txt") == 0) // is a text file
    339a:	51                   	push   %ecx
    339b:	51                   	push   %ecx
    339c:	68 44 40 00 00       	push   $0x4044
    33a1:	56                   	push   %esi
    33a2:	e8 b9 05 00 00       	call   3960 <strcmp>
    33a7:	83 c4 10             	add    $0x10,%esp
    33aa:	89 c6                	mov    %eax,%esi
    33ac:	85 c0                	test   %eax,%eax
    33ae:	75 6c                	jne    341c <main+0x41c>
    const char *filename = argv[1];
    33b0:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    33b6:	8d 9d 18 f8 ff ff    	lea    -0x7e8(%ebp),%ebx
    33bc:	8b 78 04             	mov    0x4(%eax),%edi
    int fd = open(filename, O_RDONLY); // Open the file for reading
    33bf:	50                   	push   %eax
    33c0:	50                   	push   %eax
    33c1:	6a 00                	push   $0x0
    33c3:	57                   	push   %edi
    33c4:	e8 fa 07 00 00       	call   3bc3 <open>
fd = open(filename, O_RDONLY);
    33c9:	58                   	pop    %eax
    33ca:	5a                   	pop    %edx
    33cb:	6a 00                	push   $0x0
    33cd:	57                   	push   %edi
    33ce:	e8 f0 07 00 00       	call   3bc3 <open>
if (fd < 0) {
    33d3:	83 c4 10             	add    $0x10,%esp
fd = open(filename, O_RDONLY);
    33d6:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
if (fd < 0) {
    33dc:	85 c0                	test   %eax,%eax
    33de:	0f 88 ef fd ff ff    	js     31d3 <main+0x1d3>
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    33e4:	83 ec 04             	sub    $0x4,%esp
    33e7:	68 e8 03 00 00       	push   $0x3e8
    33ec:	53                   	push   %ebx
    33ed:	ff b5 04 f8 ff ff    	push   -0x7fc(%ebp)
    33f3:	e8 a3 07 00 00       	call   3b9b <read>
    33f8:	83 c4 10             	add    $0x10,%esp
    33fb:	89 c1                	mov    %eax,%ecx
    33fd:	85 c0                	test   %eax,%eax
    33ff:	0f 8e d2 01 00 00    	jle    35d7 <main+0x5d7>
    3405:	89 d8                	mov    %ebx,%eax
    3407:	01 d9                	add    %ebx,%ecx
                sentences++;
    3409:	31 d2                	xor    %edx,%edx
    340b:	80 38 0a             	cmpb   $0xa,(%eax)
    340e:	0f 94 c2             	sete   %dl
        for (int i = 0; i < n; i++) {
    3411:	83 c0 01             	add    $0x1,%eax
                sentences++;
    3414:	01 d6                	add    %edx,%esi
        for (int i = 0; i < n; i++) {
    3416:	39 c1                	cmp    %eax,%ecx
    3418:	75 ef                	jne    3409 <main+0x409>
    341a:	eb c8                	jmp    33e4 <main+0x3e4>
int len = strlen(argv[1]);
    341c:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    3422:	83 ec 0c             	sub    $0xc,%esp
    3425:	ff 70 04             	push   0x4(%eax)
    3428:	e8 93 05 00 00       	call   39c0 <strlen>
char input[len];
    342d:	83 c4 10             	add    $0x10,%esp
    3430:	8d 48 0f             	lea    0xf(%eax),%ecx
    3433:	89 e3                	mov    %esp,%ebx
    3435:	89 ca                	mov    %ecx,%edx
    3437:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
    343d:	83 e2 f0             	and    $0xfffffff0,%edx
    3440:	29 cb                	sub    %ecx,%ebx
    3442:	39 dc                	cmp    %ebx,%esp
    3444:	0f 84 c4 02 00 00    	je     370e <main+0x70e>
    344a:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3450:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    3457:	00 
    3458:	eb e8                	jmp    3442 <main+0x442>
    345a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (sentences <= nlen){
    3460:	39 b5 f4 f7 ff ff    	cmp    %esi,-0x80c(%ebp)
    3466:	7c 77                	jl     34df <main+0x4df>
    fd = open(filename, O_RDONLY);
    3468:	83 ec 08             	sub    $0x8,%esp
    346b:	6a 00                	push   $0x0
    346d:	57                   	push   %edi
    346e:	e8 50 07 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3473:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    3476:	89 c6                	mov    %eax,%esi
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    347f:	90                   	nop
    3480:	83 ec 04             	sub    $0x4,%esp
    3483:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
    3489:	68 e8 03 00 00       	push   $0x3e8
    348e:	50                   	push   %eax
    348f:	56                   	push   %esi
    3490:	e8 06 07 00 00       	call   3b9b <read>
    3495:	83 c4 10             	add    $0x10,%esp
    3498:	85 c0                	test   %eax,%eax
    349a:	7e 25                	jle    34c1 <main+0x4c1>
    349c:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
    34a2:	8d 3c 03             	lea    (%ebx,%eax,1),%edi
    34a5:	8d 76 00             	lea    0x0(%esi),%esi
            write(1, &buf[i], 1);// Print the character to stdout
    34a8:	83 ec 04             	sub    $0x4,%esp
    34ab:	6a 01                	push   $0x1
    34ad:	53                   	push   %ebx
        for (int i = 0; i < n; i++) {
    34ae:	83 c3 01             	add    $0x1,%ebx
            write(1, &buf[i], 1);// Print the character to stdout
    34b1:	6a 01                	push   $0x1
    34b3:	e8 eb 06 00 00       	call   3ba3 <write>
        for (int i = 0; i < n; i++) {
    34b8:	83 c4 10             	add    $0x10,%esp
    34bb:	39 df                	cmp    %ebx,%edi
    34bd:	75 e9                	jne    34a8 <main+0x4a8>
    34bf:	eb bf                	jmp    3480 <main+0x480>
for(int i=3;i<argc;i++)
    34c1:	83 85 00 f8 ff ff 01 	addl   $0x1,-0x800(%ebp)
    34c8:	8b 85 00 f8 ff ff    	mov    -0x800(%ebp),%eax
    34ce:	39 85 f8 f7 ff ff    	cmp    %eax,-0x808(%ebp)
    34d4:	0f 85 6c fd ff ff    	jne    3246 <main+0x246>
    34da:	e9 1d fc ff ff       	jmp    30fc <main+0xfc>
    fd = open(filename, O_RDONLY);
    34df:	83 ec 08             	sub    $0x8,%esp
    34e2:	6a 00                	push   $0x0
    34e4:	57                   	push   %edi
    34e5:	e8 d9 06 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    34ea:	8b b5 f4 f7 ff ff    	mov    -0x80c(%ebp),%esi
    34f0:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    34f3:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    34f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3500:	83 ec 04             	sub    $0x4,%esp
    3503:	8d 85 00 fc ff ff    	lea    -0x400(%ebp),%eax
    3509:	68 e8 03 00 00       	push   $0x3e8
    350e:	50                   	push   %eax
    350f:	ff b5 04 f8 ff ff    	push   -0x7fc(%ebp)
    3515:	e8 81 06 00 00       	call   3b9b <read>
    351a:	83 c4 10             	add    $0x10,%esp
    351d:	85 c0                	test   %eax,%eax
    351f:	7e a0                	jle    34c1 <main+0x4c1>
    3521:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
    3527:	8d 3c 03             	lea    (%ebx,%eax,1),%edi
    352a:	eb 0b                	jmp    3537 <main+0x537>
    352c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (int i = 0; i < n; i++) {
    3530:	83 c3 01             	add    $0x1,%ebx
    3533:	39 df                	cmp    %ebx,%edi
    3535:	74 c9                	je     3500 <main+0x500>
            write(1, &buf[i], 1);// Print the character to stdout
    3537:	83 ec 04             	sub    $0x4,%esp
    353a:	6a 01                	push   $0x1
    353c:	53                   	push   %ebx
    353d:	6a 01                	push   $0x1
    353f:	e8 5f 06 00 00       	call   3ba3 <write>
            if (buf[i] == '\n') {
    3544:	83 c4 10             	add    $0x10,%esp
    3547:	80 3b 0a             	cmpb   $0xa,(%ebx)
    354a:	75 e4                	jne    3530 <main+0x530>
                if(lines==0)
    354c:	83 ee 01             	sub    $0x1,%esi
    354f:	75 df                	jne    3530 <main+0x530>
    3551:	eb ad                	jmp    3500 <main+0x500>
  if(strcmp(istext,".txt") == 0) // is a text file
    3553:	51                   	push   %ecx
    3554:	51                   	push   %ecx
    3555:	68 44 40 00 00       	push   $0x4044
    355a:	57                   	push   %edi
    355b:	e8 00 04 00 00       	call   3960 <strcmp>
    3560:	83 c4 10             	add    $0x10,%esp
    3563:	89 c6                	mov    %eax,%esi
    3565:	85 c0                	test   %eax,%eax
    3567:	0f 85 2c 01 00 00    	jne    3699 <main+0x699>
    const char *filename = argv[3];
    356d:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    3573:	8d 9d 00 fc ff ff    	lea    -0x400(%ebp),%ebx
    3579:	8b 78 0c             	mov    0xc(%eax),%edi
    int fd = open(filename, O_RDONLY); // Open the file for reading
    357c:	50                   	push   %eax
    357d:	50                   	push   %eax
    357e:	6a 00                	push   $0x0
    3580:	57                   	push   %edi
    3581:	e8 3d 06 00 00       	call   3bc3 <open>
fd = open(filename, O_RDONLY);
    3586:	58                   	pop    %eax
    3587:	5a                   	pop    %edx
    3588:	6a 00                	push   $0x0
    358a:	57                   	push   %edi
    358b:	e8 33 06 00 00       	call   3bc3 <open>
if (fd < 0) {
    3590:	83 c4 10             	add    $0x10,%esp
fd = open(filename, O_RDONLY);
    3593:	89 85 00 f8 ff ff    	mov    %eax,-0x800(%ebp)
if (fd < 0) {
    3599:	85 c0                	test   %eax,%eax
    359b:	0f 88 32 fc ff ff    	js     31d3 <main+0x1d3>
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    35a1:	50                   	push   %eax
    35a2:	68 e8 03 00 00       	push   $0x3e8
    35a7:	53                   	push   %ebx
    35a8:	ff b5 00 f8 ff ff    	push   -0x800(%ebp)
    35ae:	e8 e8 05 00 00       	call   3b9b <read>
    35b3:	83 c4 10             	add    $0x10,%esp
    35b6:	89 c2                	mov    %eax,%edx
    35b8:	85 c0                	test   %eax,%eax
    35ba:	0f 8e 0c 02 00 00    	jle    37cc <main+0x7cc>
    35c0:	89 d8                	mov    %ebx,%eax
    35c2:	01 da                	add    %ebx,%edx
                sentences++;
    35c4:	31 c9                	xor    %ecx,%ecx
    35c6:	80 38 0a             	cmpb   $0xa,(%eax)
    35c9:	0f 94 c1             	sete   %cl
        for (int i = 0; i < n; i++) {
    35cc:	83 c0 01             	add    $0x1,%eax
                sentences++;
    35cf:	01 ce                	add    %ecx,%esi
        for (int i = 0; i < n; i++) {
    35d1:	39 d0                	cmp    %edx,%eax
    35d3:	75 ef                	jne    35c4 <main+0x5c4>
    35d5:	eb ca                	jmp    35a1 <main+0x5a1>
    if (sentences <= 14){
    35d7:	83 fe 0e             	cmp    $0xe,%esi
    35da:	7e 6e                	jle    364a <main+0x64a>
    fd = open(filename, O_RDONLY);
    35dc:	50                   	push   %eax
    35dd:	50                   	push   %eax
    35de:	6a 00                	push   $0x0
    35e0:	57                   	push   %edi
    35e1:	e8 dd 05 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    35e6:	83 c4 10             	add    $0x10,%esp
    int lines=14;
    35e9:	c7 85 04 f8 ff ff 0e 	movl   $0xe,-0x7fc(%ebp)
    35f0:	00 00 00 
    fd = open(filename, O_RDONLY);
    35f3:	89 85 00 f8 ff ff    	mov    %eax,-0x800(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    35f9:	56                   	push   %esi
    35fa:	68 e8 03 00 00       	push   $0x3e8
    35ff:	53                   	push   %ebx
    3600:	ff b5 00 f8 ff ff    	push   -0x800(%ebp)
    3606:	e8 90 05 00 00       	call   3b9b <read>
    360b:	83 c4 10             	add    $0x10,%esp
    360e:	89 c7                	mov    %eax,%edi
    3610:	85 c0                	test   %eax,%eax
    3612:	0f 8e e4 fa ff ff    	jle    30fc <main+0xfc>
    3618:	89 de                	mov    %ebx,%esi
    361a:	01 df                	add    %ebx,%edi
    361c:	eb 09                	jmp    3627 <main+0x627>
    361e:	66 90                	xchg   %ax,%ax
        for (int i = 0; i < n; i++) {
    3620:	83 c6 01             	add    $0x1,%esi
    3623:	39 fe                	cmp    %edi,%esi
    3625:	74 d2                	je     35f9 <main+0x5f9>
            write(1, &buf[i], 1);// Print the character to stdout
    3627:	83 ec 04             	sub    $0x4,%esp
    362a:	6a 01                	push   $0x1
    362c:	56                   	push   %esi
    362d:	6a 01                	push   $0x1
    362f:	e8 6f 05 00 00       	call   3ba3 <write>
            if (buf[i] == '\n') {
    3634:	83 c4 10             	add    $0x10,%esp
    3637:	80 3e 0a             	cmpb   $0xa,(%esi)
    363a:	75 e4                	jne    3620 <main+0x620>
                if(lines==0)
    363c:	83 ad 04 f8 ff ff 01 	subl   $0x1,-0x7fc(%ebp)
    3643:	75 db                	jne    3620 <main+0x620>
    3645:	e9 b2 fa ff ff       	jmp    30fc <main+0xfc>
    fd = open(filename, O_RDONLY);
    364a:	50                   	push   %eax
    364b:	50                   	push   %eax
    364c:	6a 00                	push   $0x0
    364e:	57                   	push   %edi
    364f:	e8 6f 05 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3654:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    3657:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    365d:	50                   	push   %eax
    365e:	68 e8 03 00 00       	push   $0x3e8
    3663:	53                   	push   %ebx
    3664:	ff b5 04 f8 ff ff    	push   -0x7fc(%ebp)
    366a:	e8 2c 05 00 00       	call   3b9b <read>
    366f:	83 c4 10             	add    $0x10,%esp
    3672:	89 c7                	mov    %eax,%edi
    3674:	85 c0                	test   %eax,%eax
    3676:	0f 8e 80 fa ff ff    	jle    30fc <main+0xfc>
    367c:	89 de                	mov    %ebx,%esi
    367e:	01 df                	add    %ebx,%edi
            write(1, &buf[i], 1);// Print the character to stdout
    3680:	83 ec 04             	sub    $0x4,%esp
    3683:	6a 01                	push   $0x1
    3685:	56                   	push   %esi
        for (int i = 0; i < n; i++) {
    3686:	83 c6 01             	add    $0x1,%esi
            write(1, &buf[i], 1);// Print the character to stdout
    3689:	6a 01                	push   $0x1
    368b:	e8 13 05 00 00       	call   3ba3 <write>
        for (int i = 0; i < n; i++) {
    3690:	83 c4 10             	add    $0x10,%esp
    3693:	39 fe                	cmp    %edi,%esi
    3695:	75 e9                	jne    3680 <main+0x680>
    3697:	eb c4                	jmp    365d <main+0x65d>
int len = strlen(argv[3]);
    3699:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    369f:	83 ec 0c             	sub    $0xc,%esp
for(int i=0;i<strlen(argv[3]);i++){
    36a2:	31 db                	xor    %ebx,%ebx
int nlen=0;
    36a4:	31 f6                	xor    %esi,%esi
int len = strlen(argv[3]);
    36a6:	ff 70 0c             	push   0xc(%eax)
    36a9:	e8 12 03 00 00       	call   39c0 <strlen>
for(int i=0;i<strlen(argv[3]);i++){
    36ae:	83 c4 10             	add    $0x10,%esp
int len = strlen(argv[3]);
    36b1:	89 c7                	mov    %eax,%edi
for(int i=0;i<strlen(argv[3]);i++){
    36b3:	eb 17                	jmp    36cc <main+0x6cc>
 nlen = nlen*10+argv[2][i]-'0';
    36b5:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    36bb:	6b f6 0a             	imul   $0xa,%esi,%esi
    36be:	8b 40 08             	mov    0x8(%eax),%eax
    36c1:	0f be 04 18          	movsbl (%eax,%ebx,1),%eax
for(int i=0;i<strlen(argv[3]);i++){
    36c5:	83 c3 01             	add    $0x1,%ebx
 nlen = nlen*10+argv[2][i]-'0';
    36c8:	8d 74 30 d0          	lea    -0x30(%eax,%esi,1),%esi
for(int i=0;i<strlen(argv[3]);i++){
    36cc:	8b 85 fc f7 ff ff    	mov    -0x804(%ebp),%eax
    36d2:	83 ec 0c             	sub    $0xc,%esp
    36d5:	ff 70 0c             	push   0xc(%eax)
    36d8:	e8 e3 02 00 00       	call   39c0 <strlen>
    36dd:	83 c4 10             	add    $0x10,%esp
    36e0:	39 d8                	cmp    %ebx,%eax
    36e2:	77 d1                	ja     36b5 <main+0x6b5>
char input[len];
    36e4:	8d 57 0f             	lea    0xf(%edi),%edx
    36e7:	89 e1                	mov    %esp,%ecx
    36e9:	89 d0                	mov    %edx,%eax
    36eb:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    36f1:	83 e0 f0             	and    $0xfffffff0,%eax
    36f4:	29 d1                	sub    %edx,%ecx
    36f6:	39 cc                	cmp    %ecx,%esp
    36f8:	0f 84 29 01 00 00    	je     3827 <main+0x827>
    36fe:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3704:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    370b:	00 
    370c:	eb e8                	jmp    36f6 <main+0x6f6>
char input[len];
    370e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    3714:	29 d4                	sub    %edx,%esp
    3716:	85 d2                	test   %edx,%edx
    3718:	74 05                	je     371f <main+0x71f>
    371a:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
    371f:	89 e3                	mov    %esp,%ebx
for(int i=0;i<len;i++){input[i] = argv[1][i];}
    3721:	85 c0                	test   %eax,%eax
    3723:	7e 1d                	jle    3742 <main+0x742>
    3725:	8b 8d fc f7 ff ff    	mov    -0x804(%ebp),%ecx
    372b:	89 e6                	mov    %esp,%esi
    372d:	8b 51 04             	mov    0x4(%ecx),%edx
    3730:	01 d0                	add    %edx,%eax
    3732:	0f b6 0a             	movzbl (%edx),%ecx
    3735:	83 c2 01             	add    $0x1,%edx
    3738:	83 c6 01             	add    $0x1,%esi
    373b:	88 4e ff             	mov    %cl,-0x1(%esi)
    373e:	39 c2                	cmp    %eax,%edx
    3740:	75 f0                	jne    3732 <main+0x732>
for(int i=0;i<strlen(input);i++){
    3742:	31 f6                	xor    %esi,%esi
int sentences=0;
    3744:	31 ff                	xor    %edi,%edi
    3746:	eb 0e                	jmp    3756 <main+0x756>
sentences++;
    3748:	31 c0                	xor    %eax,%eax
    374a:	80 3c 33 0a          	cmpb   $0xa,(%ebx,%esi,1)
    374e:	0f 94 c0             	sete   %al
for(int i=0;i<strlen(input);i++){
    3751:	83 c6 01             	add    $0x1,%esi
sentences++;
    3754:	01 c7                	add    %eax,%edi
for(int i=0;i<strlen(input);i++){
    3756:	83 ec 0c             	sub    $0xc,%esp
    3759:	53                   	push   %ebx
    375a:	e8 61 02 00 00       	call   39c0 <strlen>
    375f:	83 c4 10             	add    $0x10,%esp
    3762:	39 f0                	cmp    %esi,%eax
    3764:	77 e2                	ja     3748 <main+0x748>
if (sentences <= 14){
    3766:	83 ff 0e             	cmp    $0xe,%edi
    3769:	7e 47                	jle    37b2 <main+0x7b2>
        for (int i = 0; i < strlen(input); i++) {
    376b:	31 f6                	xor    %esi,%esi
    int lines=14;
    376d:	bf 0e 00 00 00       	mov    $0xe,%edi
    3772:	eb 07                	jmp    377b <main+0x77b>
    3774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (int i = 0; i < strlen(input); i++) {
    3778:	83 c6 01             	add    $0x1,%esi
    377b:	83 ec 0c             	sub    $0xc,%esp
    377e:	53                   	push   %ebx
    377f:	e8 3c 02 00 00       	call   39c0 <strlen>
    3784:	83 c4 10             	add    $0x10,%esp
    3787:	39 c6                	cmp    %eax,%esi
    3789:	0f 83 6d f9 ff ff    	jae    30fc <main+0xfc>
            write(1, &input[i], 1);// Print the character to stdout
    378f:	83 ec 04             	sub    $0x4,%esp
    3792:	8d 04 33             	lea    (%ebx,%esi,1),%eax
    3795:	6a 01                	push   $0x1
    3797:	50                   	push   %eax
    3798:	6a 01                	push   $0x1
    379a:	e8 04 04 00 00       	call   3ba3 <write>
            if (input[i] == '\n') {
    379f:	83 c4 10             	add    $0x10,%esp
    37a2:	80 3c 33 0a          	cmpb   $0xa,(%ebx,%esi,1)
    37a6:	75 d0                	jne    3778 <main+0x778>
                if(lines==0)
    37a8:	83 ef 01             	sub    $0x1,%edi
    37ab:	75 cb                	jne    3778 <main+0x778>
    37ad:	e9 4a f9 ff ff       	jmp    30fc <main+0xfc>
        write(1,input,strlen(input));
    37b2:	83 ec 0c             	sub    $0xc,%esp
    37b5:	53                   	push   %ebx
    37b6:	e8 05 02 00 00       	call   39c0 <strlen>
    37bb:	83 c4 0c             	add    $0xc,%esp
    37be:	50                   	push   %eax
    37bf:	53                   	push   %ebx
    37c0:	6a 01                	push   $0x1
    37c2:	e8 dc 03 00 00       	call   3ba3 <write>
    exit();
    37c7:	e8 b7 03 00 00       	call   3b83 <exit>
    if (sentences <= nlen){
    37cc:	39 b5 04 f8 ff ff    	cmp    %esi,-0x7fc(%ebp)
    37d2:	0f 8c f5 00 00 00    	jl     38cd <main+0x8cd>
    fd = open(filename, O_RDONLY);
    37d8:	50                   	push   %eax
    37d9:	50                   	push   %eax
    37da:	6a 00                	push   $0x0
    37dc:	57                   	push   %edi
    37dd:	e8 e1 03 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    37e2:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    37e5:	89 85 04 f8 ff ff    	mov    %eax,-0x7fc(%ebp)
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    37eb:	57                   	push   %edi
    37ec:	68 e8 03 00 00       	push   $0x3e8
    37f1:	53                   	push   %ebx
    37f2:	ff b5 04 f8 ff ff    	push   -0x7fc(%ebp)
    37f8:	e8 9e 03 00 00       	call   3b9b <read>
    37fd:	83 c4 10             	add    $0x10,%esp
    3800:	89 c7                	mov    %eax,%edi
    3802:	85 c0                	test   %eax,%eax
    3804:	0f 8e f2 f8 ff ff    	jle    30fc <main+0xfc>
    380a:	89 de                	mov    %ebx,%esi
    380c:	01 df                	add    %ebx,%edi
            write(1, &buf[i], 1);// Print the character to stdout
    380e:	83 ec 04             	sub    $0x4,%esp
    3811:	6a 01                	push   $0x1
    3813:	56                   	push   %esi
        for (int i = 0; i < n; i++) {
    3814:	83 c6 01             	add    $0x1,%esi
            write(1, &buf[i], 1);// Print the character to stdout
    3817:	6a 01                	push   $0x1
    3819:	e8 85 03 00 00       	call   3ba3 <write>
        for (int i = 0; i < n; i++) {
    381e:	83 c4 10             	add    $0x10,%esp
    3821:	39 f7                	cmp    %esi,%edi
    3823:	75 e9                	jne    380e <main+0x80e>
    3825:	eb c4                	jmp    37eb <main+0x7eb>
char input[len];
    3827:	25 ff 0f 00 00       	and    $0xfff,%eax
    382c:	29 c4                	sub    %eax,%esp
    382e:	85 c0                	test   %eax,%eax
    3830:	74 05                	je     3837 <main+0x837>
    3832:	83 4c 04 fc 00       	orl    $0x0,-0x4(%esp,%eax,1)
    3837:	8b 8d fc f7 ff ff    	mov    -0x804(%ebp),%ecx
    383d:	89 e3                	mov    %esp,%ebx
for(int i=0;i<len;i++){input[i] = argv[3][i];}
    383f:	31 d2                	xor    %edx,%edx
    3841:	eb 0d                	jmp    3850 <main+0x850>
    3843:	8b 41 0c             	mov    0xc(%ecx),%eax
    3846:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
    384a:	88 04 13             	mov    %al,(%ebx,%edx,1)
    384d:	83 c2 01             	add    $0x1,%edx
    3850:	39 fa                	cmp    %edi,%edx
    3852:	7c ef                	jl     3843 <main+0x843>
int sentences=0;
    3854:	31 d2                	xor    %edx,%edx
    3856:	89 b5 04 f8 ff ff    	mov    %esi,-0x7fc(%ebp)
for(int i=0;i<strlen(input);i++){
    385c:	31 ff                	xor    %edi,%edi
    385e:	89 de                	mov    %ebx,%esi
    3860:	89 d3                	mov    %edx,%ebx
    3862:	eb 0c                	jmp    3870 <main+0x870>
if(input[i] == '\n')
    3864:	80 3c 3e 0a          	cmpb   $0xa,(%esi,%edi,1)
    3868:	75 03                	jne    386d <main+0x86d>
sentences++;
    386a:	83 c3 01             	add    $0x1,%ebx
for(int i=0;i<strlen(input);i++){
    386d:	83 c7 01             	add    $0x1,%edi
    3870:	83 ec 0c             	sub    $0xc,%esp
    3873:	56                   	push   %esi
    3874:	e8 47 01 00 00       	call   39c0 <strlen>
    3879:	83 c4 10             	add    $0x10,%esp
    387c:	39 f8                	cmp    %edi,%eax
    387e:	77 e4                	ja     3864 <main+0x864>
        for (int i = 0; i < strlen(input); i++) {
    3880:	89 da                	mov    %ebx,%edx
    3882:	89 f3                	mov    %esi,%ebx
    3884:	8b b5 04 f8 ff ff    	mov    -0x7fc(%ebp),%esi
    388a:	31 ff                	xor    %edi,%edi
if (sentences <= nlen){
    388c:	39 d6                	cmp    %edx,%esi
    388e:	7c 08                	jl     3898 <main+0x898>
    3890:	e9 1d ff ff ff       	jmp    37b2 <main+0x7b2>
        for (int i = 0; i < strlen(input); i++) {
    3895:	83 c7 01             	add    $0x1,%edi
    3898:	83 ec 0c             	sub    $0xc,%esp
    389b:	53                   	push   %ebx
    389c:	e8 1f 01 00 00       	call   39c0 <strlen>
    38a1:	83 c4 10             	add    $0x10,%esp
    38a4:	39 f8                	cmp    %edi,%eax
    38a6:	0f 86 50 f8 ff ff    	jbe    30fc <main+0xfc>
            write(1, &input[i], 1);// Print the character to stdout
    38ac:	8d 04 3b             	lea    (%ebx,%edi,1),%eax
    38af:	52                   	push   %edx
    38b0:	6a 01                	push   $0x1
    38b2:	50                   	push   %eax
    38b3:	6a 01                	push   $0x1
    38b5:	e8 e9 02 00 00       	call   3ba3 <write>
            if (input[i] == '\n') {
    38ba:	83 c4 10             	add    $0x10,%esp
    38bd:	80 3c 3b 0a          	cmpb   $0xa,(%ebx,%edi,1)
    38c1:	75 d2                	jne    3895 <main+0x895>
                if(nlen==0)
    38c3:	83 ee 01             	sub    $0x1,%esi
    38c6:	75 cd                	jne    3895 <main+0x895>
    38c8:	e9 2f f8 ff ff       	jmp    30fc <main+0xfc>
    fd = open(filename, O_RDONLY);
    38cd:	56                   	push   %esi
    38ce:	56                   	push   %esi
    38cf:	6a 00                	push   $0x0
    38d1:	57                   	push   %edi
    38d2:	e8 ec 02 00 00       	call   3bc3 <open>
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    38d7:	83 c4 10             	add    $0x10,%esp
    fd = open(filename, O_RDONLY);
    38da:	89 c7                	mov    %eax,%edi
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    38dc:	51                   	push   %ecx
    38dd:	68 e8 03 00 00       	push   $0x3e8
    38e2:	53                   	push   %ebx
    38e3:	57                   	push   %edi
    38e4:	e8 b2 02 00 00       	call   3b9b <read>
    38e9:	83 c4 10             	add    $0x10,%esp
    38ec:	85 c0                	test   %eax,%eax
    38ee:	0f 8e 08 f8 ff ff    	jle    30fc <main+0xfc>
    38f4:	01 d8                	add    %ebx,%eax
    38f6:	89 de                	mov    %ebx,%esi
    38f8:	89 85 00 f8 ff ff    	mov    %eax,-0x800(%ebp)
    38fe:	eb 0b                	jmp    390b <main+0x90b>
        for (int i = 0; i < n; i++) {
    3900:	83 c6 01             	add    $0x1,%esi
    3903:	3b b5 00 f8 ff ff    	cmp    -0x800(%ebp),%esi
    3909:	74 d1                	je     38dc <main+0x8dc>
            write(1, &buf[i], 1);// Print the character to stdout
    390b:	83 ec 04             	sub    $0x4,%esp
    390e:	6a 01                	push   $0x1
    3910:	56                   	push   %esi
    3911:	6a 01                	push   $0x1
    3913:	e8 8b 02 00 00       	call   3ba3 <write>
            if (buf[i] == '\n') {
    3918:	83 c4 10             	add    $0x10,%esp
    391b:	80 3e 0a             	cmpb   $0xa,(%esi)
    391e:	75 e0                	jne    3900 <main+0x900>
                if(nlen==0)
    3920:	83 ad 04 f8 ff ff 01 	subl   $0x1,-0x7fc(%ebp)
    3927:	75 d7                	jne    3900 <main+0x900>
    3929:	e9 ce f7 ff ff       	jmp    30fc <main+0xfc>
    392e:	66 90                	xchg   %ax,%ax

00003930 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3930:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3931:	31 c0                	xor    %eax,%eax
{
    3933:	89 e5                	mov    %esp,%ebp
    3935:	53                   	push   %ebx
    3936:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3939:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3940:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3944:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3947:	83 c0 01             	add    $0x1,%eax
    394a:	84 d2                	test   %dl,%dl
    394c:	75 f2                	jne    3940 <strcpy+0x10>
    ;
  return os;
}
    394e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3951:	89 c8                	mov    %ecx,%eax
    3953:	c9                   	leave  
    3954:	c3                   	ret    
    3955:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    395c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003960 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3960:	55                   	push   %ebp
    3961:	89 e5                	mov    %esp,%ebp
    3963:	53                   	push   %ebx
    3964:	8b 55 08             	mov    0x8(%ebp),%edx
    3967:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    396a:	0f b6 02             	movzbl (%edx),%eax
    396d:	84 c0                	test   %al,%al
    396f:	75 17                	jne    3988 <strcmp+0x28>
    3971:	eb 3a                	jmp    39ad <strcmp+0x4d>
    3973:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3977:	90                   	nop
    3978:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    397c:	83 c2 01             	add    $0x1,%edx
    397f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3982:	84 c0                	test   %al,%al
    3984:	74 1a                	je     39a0 <strcmp+0x40>
    p++, q++;
    3986:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3988:	0f b6 19             	movzbl (%ecx),%ebx
    398b:	38 c3                	cmp    %al,%bl
    398d:	74 e9                	je     3978 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    398f:	29 d8                	sub    %ebx,%eax
}
    3991:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3994:	c9                   	leave  
    3995:	c3                   	ret    
    3996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    399d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    39a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    39a4:	31 c0                	xor    %eax,%eax
    39a6:	29 d8                	sub    %ebx,%eax
}
    39a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    39ab:	c9                   	leave  
    39ac:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    39ad:	0f b6 19             	movzbl (%ecx),%ebx
    39b0:	31 c0                	xor    %eax,%eax
    39b2:	eb db                	jmp    398f <strcmp+0x2f>
    39b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    39bf:	90                   	nop

000039c0 <strlen>:

uint
strlen(const char *s)
{
    39c0:	55                   	push   %ebp
    39c1:	89 e5                	mov    %esp,%ebp
    39c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    39c6:	80 3a 00             	cmpb   $0x0,(%edx)
    39c9:	74 15                	je     39e0 <strlen+0x20>
    39cb:	31 c0                	xor    %eax,%eax
    39cd:	8d 76 00             	lea    0x0(%esi),%esi
    39d0:	83 c0 01             	add    $0x1,%eax
    39d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    39d7:	89 c1                	mov    %eax,%ecx
    39d9:	75 f5                	jne    39d0 <strlen+0x10>
    ;
  return n;
}
    39db:	89 c8                	mov    %ecx,%eax
    39dd:	5d                   	pop    %ebp
    39de:	c3                   	ret    
    39df:	90                   	nop
  for(n = 0; s[n]; n++)
    39e0:	31 c9                	xor    %ecx,%ecx
}
    39e2:	5d                   	pop    %ebp
    39e3:	89 c8                	mov    %ecx,%eax
    39e5:	c3                   	ret    
    39e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39ed:	8d 76 00             	lea    0x0(%esi),%esi

000039f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    39f0:	55                   	push   %ebp
    39f1:	89 e5                	mov    %esp,%ebp
    39f3:	57                   	push   %edi
    39f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    39f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    39fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    39fd:	89 d7                	mov    %edx,%edi
    39ff:	fc                   	cld    
    3a00:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3a02:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3a05:	89 d0                	mov    %edx,%eax
    3a07:	c9                   	leave  
    3a08:	c3                   	ret    
    3a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003a10 <strchr>:

char*
strchr(const char *s, char c)
{
    3a10:	55                   	push   %ebp
    3a11:	89 e5                	mov    %esp,%ebp
    3a13:	8b 45 08             	mov    0x8(%ebp),%eax
    3a16:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    3a1a:	0f b6 10             	movzbl (%eax),%edx
    3a1d:	84 d2                	test   %dl,%dl
    3a1f:	75 12                	jne    3a33 <strchr+0x23>
    3a21:	eb 1d                	jmp    3a40 <strchr+0x30>
    3a23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3a27:	90                   	nop
    3a28:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    3a2c:	83 c0 01             	add    $0x1,%eax
    3a2f:	84 d2                	test   %dl,%dl
    3a31:	74 0d                	je     3a40 <strchr+0x30>
    if(*s == c)
    3a33:	38 d1                	cmp    %dl,%cl
    3a35:	75 f1                	jne    3a28 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3a37:	5d                   	pop    %ebp
    3a38:	c3                   	ret    
    3a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3a40:	31 c0                	xor    %eax,%eax
}
    3a42:	5d                   	pop    %ebp
    3a43:	c3                   	ret    
    3a44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3a4f:	90                   	nop

00003a50 <gets>:

char*
gets(char *buf, int max)
{
    3a50:	55                   	push   %ebp
    3a51:	89 e5                	mov    %esp,%ebp
    3a53:	57                   	push   %edi
    3a54:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3a55:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3a58:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3a59:	31 db                	xor    %ebx,%ebx
{
    3a5b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    3a5e:	eb 27                	jmp    3a87 <gets+0x37>
    cc = read(0, &c, 1);
    3a60:	83 ec 04             	sub    $0x4,%esp
    3a63:	6a 01                	push   $0x1
    3a65:	57                   	push   %edi
    3a66:	6a 00                	push   $0x0
    3a68:	e8 2e 01 00 00       	call   3b9b <read>
    if(cc < 1)
    3a6d:	83 c4 10             	add    $0x10,%esp
    3a70:	85 c0                	test   %eax,%eax
    3a72:	7e 1d                	jle    3a91 <gets+0x41>
      break;
    buf[i++] = c;
    3a74:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3a78:	8b 55 08             	mov    0x8(%ebp),%edx
    3a7b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    3a7f:	3c 0a                	cmp    $0xa,%al
    3a81:	74 1d                	je     3aa0 <gets+0x50>
    3a83:	3c 0d                	cmp    $0xd,%al
    3a85:	74 19                	je     3aa0 <gets+0x50>
  for(i=0; i+1 < max; ){
    3a87:	89 de                	mov    %ebx,%esi
    3a89:	83 c3 01             	add    $0x1,%ebx
    3a8c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3a8f:	7c cf                	jl     3a60 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3a91:	8b 45 08             	mov    0x8(%ebp),%eax
    3a94:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3a98:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a9b:	5b                   	pop    %ebx
    3a9c:	5e                   	pop    %esi
    3a9d:	5f                   	pop    %edi
    3a9e:	5d                   	pop    %ebp
    3a9f:	c3                   	ret    
  buf[i] = '\0';
    3aa0:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa3:	89 de                	mov    %ebx,%esi
    3aa5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3aa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3aac:	5b                   	pop    %ebx
    3aad:	5e                   	pop    %esi
    3aae:	5f                   	pop    %edi
    3aaf:	5d                   	pop    %ebp
    3ab0:	c3                   	ret    
    3ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3abf:	90                   	nop

00003ac0 <stat>:

int
stat(const char *n, struct stat *st)
{
    3ac0:	55                   	push   %ebp
    3ac1:	89 e5                	mov    %esp,%ebp
    3ac3:	56                   	push   %esi
    3ac4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3ac5:	83 ec 08             	sub    $0x8,%esp
    3ac8:	6a 00                	push   $0x0
    3aca:	ff 75 08             	push   0x8(%ebp)
    3acd:	e8 f1 00 00 00       	call   3bc3 <open>
  if(fd < 0)
    3ad2:	83 c4 10             	add    $0x10,%esp
    3ad5:	85 c0                	test   %eax,%eax
    3ad7:	78 27                	js     3b00 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3ad9:	83 ec 08             	sub    $0x8,%esp
    3adc:	ff 75 0c             	push   0xc(%ebp)
    3adf:	89 c3                	mov    %eax,%ebx
    3ae1:	50                   	push   %eax
    3ae2:	e8 f4 00 00 00       	call   3bdb <fstat>
  close(fd);
    3ae7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    3aea:	89 c6                	mov    %eax,%esi
  close(fd);
    3aec:	e8 ba 00 00 00       	call   3bab <close>
  return r;
    3af1:	83 c4 10             	add    $0x10,%esp
}
    3af4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3af7:	89 f0                	mov    %esi,%eax
    3af9:	5b                   	pop    %ebx
    3afa:	5e                   	pop    %esi
    3afb:	5d                   	pop    %ebp
    3afc:	c3                   	ret    
    3afd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3b00:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3b05:	eb ed                	jmp    3af4 <stat+0x34>
    3b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b0e:	66 90                	xchg   %ax,%ax

00003b10 <atoi>:

int
atoi(const char *s)
{
    3b10:	55                   	push   %ebp
    3b11:	89 e5                	mov    %esp,%ebp
    3b13:	53                   	push   %ebx
    3b14:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3b17:	0f be 02             	movsbl (%edx),%eax
    3b1a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    3b1d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3b20:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3b25:	77 1e                	ja     3b45 <atoi+0x35>
    3b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b2e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3b30:	83 c2 01             	add    $0x1,%edx
    3b33:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3b36:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    3b3a:	0f be 02             	movsbl (%edx),%eax
    3b3d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3b40:	80 fb 09             	cmp    $0x9,%bl
    3b43:	76 eb                	jbe    3b30 <atoi+0x20>
  return n;
}
    3b45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b48:	89 c8                	mov    %ecx,%eax
    3b4a:	c9                   	leave  
    3b4b:	c3                   	ret    
    3b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003b50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3b50:	55                   	push   %ebp
    3b51:	89 e5                	mov    %esp,%ebp
    3b53:	57                   	push   %edi
    3b54:	8b 45 10             	mov    0x10(%ebp),%eax
    3b57:	8b 55 08             	mov    0x8(%ebp),%edx
    3b5a:	56                   	push   %esi
    3b5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3b5e:	85 c0                	test   %eax,%eax
    3b60:	7e 13                	jle    3b75 <memmove+0x25>
    3b62:	01 d0                	add    %edx,%eax
  dst = vdst;
    3b64:	89 d7                	mov    %edx,%edi
    3b66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b6d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3b70:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3b71:	39 f8                	cmp    %edi,%eax
    3b73:	75 fb                	jne    3b70 <memmove+0x20>
  return vdst;
}
    3b75:	5e                   	pop    %esi
    3b76:	89 d0                	mov    %edx,%eax
    3b78:	5f                   	pop    %edi
    3b79:	5d                   	pop    %ebp
    3b7a:	c3                   	ret    

00003b7b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3b7b:	b8 01 00 00 00       	mov    $0x1,%eax
    3b80:	cd 40                	int    $0x40
    3b82:	c3                   	ret    

00003b83 <exit>:
SYSCALL(exit)
    3b83:	b8 02 00 00 00       	mov    $0x2,%eax
    3b88:	cd 40                	int    $0x40
    3b8a:	c3                   	ret    

00003b8b <wait>:
SYSCALL(wait)
    3b8b:	b8 03 00 00 00       	mov    $0x3,%eax
    3b90:	cd 40                	int    $0x40
    3b92:	c3                   	ret    

00003b93 <pipe>:
SYSCALL(pipe)
    3b93:	b8 04 00 00 00       	mov    $0x4,%eax
    3b98:	cd 40                	int    $0x40
    3b9a:	c3                   	ret    

00003b9b <read>:
SYSCALL(read)
    3b9b:	b8 05 00 00 00       	mov    $0x5,%eax
    3ba0:	cd 40                	int    $0x40
    3ba2:	c3                   	ret    

00003ba3 <write>:
SYSCALL(write)
    3ba3:	b8 10 00 00 00       	mov    $0x10,%eax
    3ba8:	cd 40                	int    $0x40
    3baa:	c3                   	ret    

00003bab <close>:
SYSCALL(close)
    3bab:	b8 15 00 00 00       	mov    $0x15,%eax
    3bb0:	cd 40                	int    $0x40
    3bb2:	c3                   	ret    

00003bb3 <kill>:
SYSCALL(kill)
    3bb3:	b8 06 00 00 00       	mov    $0x6,%eax
    3bb8:	cd 40                	int    $0x40
    3bba:	c3                   	ret    

00003bbb <exec>:
SYSCALL(exec)
    3bbb:	b8 07 00 00 00       	mov    $0x7,%eax
    3bc0:	cd 40                	int    $0x40
    3bc2:	c3                   	ret    

00003bc3 <open>:
SYSCALL(open)
    3bc3:	b8 0f 00 00 00       	mov    $0xf,%eax
    3bc8:	cd 40                	int    $0x40
    3bca:	c3                   	ret    

00003bcb <mknod>:
SYSCALL(mknod)
    3bcb:	b8 11 00 00 00       	mov    $0x11,%eax
    3bd0:	cd 40                	int    $0x40
    3bd2:	c3                   	ret    

00003bd3 <unlink>:
SYSCALL(unlink)
    3bd3:	b8 12 00 00 00       	mov    $0x12,%eax
    3bd8:	cd 40                	int    $0x40
    3bda:	c3                   	ret    

00003bdb <fstat>:
SYSCALL(fstat)
    3bdb:	b8 08 00 00 00       	mov    $0x8,%eax
    3be0:	cd 40                	int    $0x40
    3be2:	c3                   	ret    

00003be3 <link>:
SYSCALL(link)
    3be3:	b8 13 00 00 00       	mov    $0x13,%eax
    3be8:	cd 40                	int    $0x40
    3bea:	c3                   	ret    

00003beb <mkdir>:
SYSCALL(mkdir)
    3beb:	b8 14 00 00 00       	mov    $0x14,%eax
    3bf0:	cd 40                	int    $0x40
    3bf2:	c3                   	ret    

00003bf3 <chdir>:
SYSCALL(chdir)
    3bf3:	b8 09 00 00 00       	mov    $0x9,%eax
    3bf8:	cd 40                	int    $0x40
    3bfa:	c3                   	ret    

00003bfb <dup>:
SYSCALL(dup)
    3bfb:	b8 0a 00 00 00       	mov    $0xa,%eax
    3c00:	cd 40                	int    $0x40
    3c02:	c3                   	ret    

00003c03 <getpid>:
SYSCALL(getpid)
    3c03:	b8 0b 00 00 00       	mov    $0xb,%eax
    3c08:	cd 40                	int    $0x40
    3c0a:	c3                   	ret    

00003c0b <sbrk>:
SYSCALL(sbrk)
    3c0b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3c10:	cd 40                	int    $0x40
    3c12:	c3                   	ret    

00003c13 <sleep>:
SYSCALL(sleep)
    3c13:	b8 0d 00 00 00       	mov    $0xd,%eax
    3c18:	cd 40                	int    $0x40
    3c1a:	c3                   	ret    

00003c1b <uptime>:
SYSCALL(uptime)
    3c1b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3c20:	cd 40                	int    $0x40
    3c22:	c3                   	ret    

00003c23 <uniq>:
SYSCALL(uniq)
    3c23:	b8 16 00 00 00       	mov    $0x16,%eax
    3c28:	cd 40                	int    $0x40
    3c2a:	c3                   	ret    

00003c2b <head>:
SYSCALL(head)
    3c2b:	b8 17 00 00 00       	mov    $0x17,%eax
    3c30:	cd 40                	int    $0x40
    3c32:	c3                   	ret    

00003c33 <ps>:
    3c33:	b8 18 00 00 00       	mov    $0x18,%eax
    3c38:	cd 40                	int    $0x40
    3c3a:	c3                   	ret    
    3c3b:	66 90                	xchg   %ax,%ax
    3c3d:	66 90                	xchg   %ax,%ax
    3c3f:	90                   	nop

00003c40 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3c40:	55                   	push   %ebp
    3c41:	89 e5                	mov    %esp,%ebp
    3c43:	57                   	push   %edi
    3c44:	56                   	push   %esi
    3c45:	53                   	push   %ebx
    3c46:	83 ec 3c             	sub    $0x3c,%esp
    3c49:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3c4c:	89 d1                	mov    %edx,%ecx
{
    3c4e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3c51:	85 d2                	test   %edx,%edx
    3c53:	0f 89 7f 00 00 00    	jns    3cd8 <printint+0x98>
    3c59:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3c5d:	74 79                	je     3cd8 <printint+0x98>
    neg = 1;
    3c5f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3c66:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3c68:	31 db                	xor    %ebx,%ebx
    3c6a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    3c6d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3c70:	89 c8                	mov    %ecx,%eax
    3c72:	31 d2                	xor    %edx,%edx
    3c74:	89 cf                	mov    %ecx,%edi
    3c76:	f7 75 c4             	divl   -0x3c(%ebp)
    3c79:	0f b6 92 d0 40 00 00 	movzbl 0x40d0(%edx),%edx
    3c80:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3c83:	89 d8                	mov    %ebx,%eax
    3c85:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3c88:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    3c8b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    3c8e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3c91:	76 dd                	jbe    3c70 <printint+0x30>
  if(neg)
    3c93:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3c96:	85 c9                	test   %ecx,%ecx
    3c98:	74 0c                	je     3ca6 <printint+0x66>
    buf[i++] = '-';
    3c9a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    3c9f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3ca1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3ca6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3ca9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3cad:	eb 07                	jmp    3cb6 <printint+0x76>
    3caf:	90                   	nop
    putc(fd, buf[i]);
    3cb0:	0f b6 13             	movzbl (%ebx),%edx
    3cb3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3cb6:	83 ec 04             	sub    $0x4,%esp
    3cb9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3cbc:	6a 01                	push   $0x1
    3cbe:	56                   	push   %esi
    3cbf:	57                   	push   %edi
    3cc0:	e8 de fe ff ff       	call   3ba3 <write>
  while(--i >= 0)
    3cc5:	83 c4 10             	add    $0x10,%esp
    3cc8:	39 de                	cmp    %ebx,%esi
    3cca:	75 e4                	jne    3cb0 <printint+0x70>
}
    3ccc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3ccf:	5b                   	pop    %ebx
    3cd0:	5e                   	pop    %esi
    3cd1:	5f                   	pop    %edi
    3cd2:	5d                   	pop    %ebp
    3cd3:	c3                   	ret    
    3cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3cd8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3cdf:	eb 87                	jmp    3c68 <printint+0x28>
    3ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3cef:	90                   	nop

00003cf0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3cf0:	55                   	push   %ebp
    3cf1:	89 e5                	mov    %esp,%ebp
    3cf3:	57                   	push   %edi
    3cf4:	56                   	push   %esi
    3cf5:	53                   	push   %ebx
    3cf6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3cf9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    3cfc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    3cff:	0f b6 13             	movzbl (%ebx),%edx
    3d02:	84 d2                	test   %dl,%dl
    3d04:	74 6a                	je     3d70 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3d06:	8d 45 10             	lea    0x10(%ebp),%eax
    3d09:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    3d0c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3d0f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3d11:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3d14:	eb 36                	jmp    3d4c <printf+0x5c>
    3d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d1d:	8d 76 00             	lea    0x0(%esi),%esi
    3d20:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3d23:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3d28:	83 f8 25             	cmp    $0x25,%eax
    3d2b:	74 15                	je     3d42 <printf+0x52>
  write(fd, &c, 1);
    3d2d:	83 ec 04             	sub    $0x4,%esp
    3d30:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3d33:	6a 01                	push   $0x1
    3d35:	57                   	push   %edi
    3d36:	56                   	push   %esi
    3d37:	e8 67 fe ff ff       	call   3ba3 <write>
    3d3c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    3d3f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3d42:	0f b6 13             	movzbl (%ebx),%edx
    3d45:	83 c3 01             	add    $0x1,%ebx
    3d48:	84 d2                	test   %dl,%dl
    3d4a:	74 24                	je     3d70 <printf+0x80>
    c = fmt[i] & 0xff;
    3d4c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3d4f:	85 c9                	test   %ecx,%ecx
    3d51:	74 cd                	je     3d20 <printf+0x30>
      }
    } else if(state == '%'){
    3d53:	83 f9 25             	cmp    $0x25,%ecx
    3d56:	75 ea                	jne    3d42 <printf+0x52>
      if(c == 'd'){
    3d58:	83 f8 25             	cmp    $0x25,%eax
    3d5b:	0f 84 07 01 00 00    	je     3e68 <printf+0x178>
    3d61:	83 e8 63             	sub    $0x63,%eax
    3d64:	83 f8 15             	cmp    $0x15,%eax
    3d67:	77 17                	ja     3d80 <printf+0x90>
    3d69:	ff 24 85 78 40 00 00 	jmp    *0x4078(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d73:	5b                   	pop    %ebx
    3d74:	5e                   	pop    %esi
    3d75:	5f                   	pop    %edi
    3d76:	5d                   	pop    %ebp
    3d77:	c3                   	ret    
    3d78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d7f:	90                   	nop
  write(fd, &c, 1);
    3d80:	83 ec 04             	sub    $0x4,%esp
    3d83:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3d86:	6a 01                	push   $0x1
    3d88:	57                   	push   %edi
    3d89:	56                   	push   %esi
    3d8a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3d8e:	e8 10 fe ff ff       	call   3ba3 <write>
        putc(fd, c);
    3d93:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3d97:	83 c4 0c             	add    $0xc,%esp
    3d9a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3d9d:	6a 01                	push   $0x1
    3d9f:	57                   	push   %edi
    3da0:	56                   	push   %esi
    3da1:	e8 fd fd ff ff       	call   3ba3 <write>
        putc(fd, c);
    3da6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3da9:	31 c9                	xor    %ecx,%ecx
    3dab:	eb 95                	jmp    3d42 <printf+0x52>
    3dad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3db0:	83 ec 0c             	sub    $0xc,%esp
    3db3:	b9 10 00 00 00       	mov    $0x10,%ecx
    3db8:	6a 00                	push   $0x0
    3dba:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3dbd:	8b 10                	mov    (%eax),%edx
    3dbf:	89 f0                	mov    %esi,%eax
    3dc1:	e8 7a fe ff ff       	call   3c40 <printint>
        ap++;
    3dc6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3dca:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3dcd:	31 c9                	xor    %ecx,%ecx
    3dcf:	e9 6e ff ff ff       	jmp    3d42 <printf+0x52>
    3dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3dd8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3ddb:	8b 10                	mov    (%eax),%edx
        ap++;
    3ddd:	83 c0 04             	add    $0x4,%eax
    3de0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3de3:	85 d2                	test   %edx,%edx
    3de5:	0f 84 8d 00 00 00    	je     3e78 <printf+0x188>
        while(*s != 0){
    3deb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    3dee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3df0:	84 c0                	test   %al,%al
    3df2:	0f 84 4a ff ff ff    	je     3d42 <printf+0x52>
    3df8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3dfb:	89 d3                	mov    %edx,%ebx
    3dfd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3e00:	83 ec 04             	sub    $0x4,%esp
          s++;
    3e03:	83 c3 01             	add    $0x1,%ebx
    3e06:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3e09:	6a 01                	push   $0x1
    3e0b:	57                   	push   %edi
    3e0c:	56                   	push   %esi
    3e0d:	e8 91 fd ff ff       	call   3ba3 <write>
        while(*s != 0){
    3e12:	0f b6 03             	movzbl (%ebx),%eax
    3e15:	83 c4 10             	add    $0x10,%esp
    3e18:	84 c0                	test   %al,%al
    3e1a:	75 e4                	jne    3e00 <printf+0x110>
      state = 0;
    3e1c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    3e1f:	31 c9                	xor    %ecx,%ecx
    3e21:	e9 1c ff ff ff       	jmp    3d42 <printf+0x52>
    3e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3e2d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3e30:	83 ec 0c             	sub    $0xc,%esp
    3e33:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3e38:	6a 01                	push   $0x1
    3e3a:	e9 7b ff ff ff       	jmp    3dba <printf+0xca>
    3e3f:	90                   	nop
        putc(fd, *ap);
    3e40:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3e43:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3e46:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3e48:	6a 01                	push   $0x1
    3e4a:	57                   	push   %edi
    3e4b:	56                   	push   %esi
        putc(fd, *ap);
    3e4c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3e4f:	e8 4f fd ff ff       	call   3ba3 <write>
        ap++;
    3e54:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3e58:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3e5b:	31 c9                	xor    %ecx,%ecx
    3e5d:	e9 e0 fe ff ff       	jmp    3d42 <printf+0x52>
    3e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3e68:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3e6b:	83 ec 04             	sub    $0x4,%esp
    3e6e:	e9 2a ff ff ff       	jmp    3d9d <printf+0xad>
    3e73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3e77:	90                   	nop
          s = "(null)";
    3e78:	ba 70 40 00 00       	mov    $0x4070,%edx
        while(*s != 0){
    3e7d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3e80:	b8 28 00 00 00       	mov    $0x28,%eax
    3e85:	89 d3                	mov    %edx,%ebx
    3e87:	e9 74 ff ff ff       	jmp    3e00 <printf+0x110>
    3e8c:	66 90                	xchg   %ax,%ax
    3e8e:	66 90                	xchg   %ax,%ax

00003e90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3e90:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3e91:	a1 84 43 00 00       	mov    0x4384,%eax
{
    3e96:	89 e5                	mov    %esp,%ebp
    3e98:	57                   	push   %edi
    3e99:	56                   	push   %esi
    3e9a:	53                   	push   %ebx
    3e9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3e9e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3ea8:	89 c2                	mov    %eax,%edx
    3eaa:	8b 00                	mov    (%eax),%eax
    3eac:	39 ca                	cmp    %ecx,%edx
    3eae:	73 30                	jae    3ee0 <free+0x50>
    3eb0:	39 c1                	cmp    %eax,%ecx
    3eb2:	72 04                	jb     3eb8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3eb4:	39 c2                	cmp    %eax,%edx
    3eb6:	72 f0                	jb     3ea8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3eb8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3ebb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3ebe:	39 f8                	cmp    %edi,%eax
    3ec0:	74 30                	je     3ef2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3ec2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3ec5:	8b 42 04             	mov    0x4(%edx),%eax
    3ec8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3ecb:	39 f1                	cmp    %esi,%ecx
    3ecd:	74 3a                	je     3f09 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3ecf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3ed1:	5b                   	pop    %ebx
  freep = p;
    3ed2:	89 15 84 43 00 00    	mov    %edx,0x4384
}
    3ed8:	5e                   	pop    %esi
    3ed9:	5f                   	pop    %edi
    3eda:	5d                   	pop    %ebp
    3edb:	c3                   	ret    
    3edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3ee0:	39 c2                	cmp    %eax,%edx
    3ee2:	72 c4                	jb     3ea8 <free+0x18>
    3ee4:	39 c1                	cmp    %eax,%ecx
    3ee6:	73 c0                	jae    3ea8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3ee8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3eeb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3eee:	39 f8                	cmp    %edi,%eax
    3ef0:	75 d0                	jne    3ec2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3ef2:	03 70 04             	add    0x4(%eax),%esi
    3ef5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3ef8:	8b 02                	mov    (%edx),%eax
    3efa:	8b 00                	mov    (%eax),%eax
    3efc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3eff:	8b 42 04             	mov    0x4(%edx),%eax
    3f02:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3f05:	39 f1                	cmp    %esi,%ecx
    3f07:	75 c6                	jne    3ecf <free+0x3f>
    p->s.size += bp->s.size;
    3f09:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    3f0c:	89 15 84 43 00 00    	mov    %edx,0x4384
    p->s.size += bp->s.size;
    3f12:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3f15:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3f18:	89 0a                	mov    %ecx,(%edx)
}
    3f1a:	5b                   	pop    %ebx
    3f1b:	5e                   	pop    %esi
    3f1c:	5f                   	pop    %edi
    3f1d:	5d                   	pop    %ebp
    3f1e:	c3                   	ret    
    3f1f:	90                   	nop

00003f20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3f20:	55                   	push   %ebp
    3f21:	89 e5                	mov    %esp,%ebp
    3f23:	57                   	push   %edi
    3f24:	56                   	push   %esi
    3f25:	53                   	push   %ebx
    3f26:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3f29:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3f2c:	8b 3d 84 43 00 00    	mov    0x4384,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3f32:	8d 70 07             	lea    0x7(%eax),%esi
    3f35:	c1 ee 03             	shr    $0x3,%esi
    3f38:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3f3b:	85 ff                	test   %edi,%edi
    3f3d:	0f 84 9d 00 00 00    	je     3fe0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3f43:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3f45:	8b 4a 04             	mov    0x4(%edx),%ecx
    3f48:	39 f1                	cmp    %esi,%ecx
    3f4a:	73 6a                	jae    3fb6 <malloc+0x96>
    3f4c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3f51:	39 de                	cmp    %ebx,%esi
    3f53:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3f56:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3f5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3f60:	eb 17                	jmp    3f79 <malloc+0x59>
    3f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3f68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3f6a:	8b 48 04             	mov    0x4(%eax),%ecx
    3f6d:	39 f1                	cmp    %esi,%ecx
    3f6f:	73 4f                	jae    3fc0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3f71:	8b 3d 84 43 00 00    	mov    0x4384,%edi
    3f77:	89 c2                	mov    %eax,%edx
    3f79:	39 d7                	cmp    %edx,%edi
    3f7b:	75 eb                	jne    3f68 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3f7d:	83 ec 0c             	sub    $0xc,%esp
    3f80:	ff 75 e4             	push   -0x1c(%ebp)
    3f83:	e8 83 fc ff ff       	call   3c0b <sbrk>
  if(p == (char*)-1)
    3f88:	83 c4 10             	add    $0x10,%esp
    3f8b:	83 f8 ff             	cmp    $0xffffffff,%eax
    3f8e:	74 1c                	je     3fac <malloc+0x8c>
  hp->s.size = nu;
    3f90:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3f93:	83 ec 0c             	sub    $0xc,%esp
    3f96:	83 c0 08             	add    $0x8,%eax
    3f99:	50                   	push   %eax
    3f9a:	e8 f1 fe ff ff       	call   3e90 <free>
  return freep;
    3f9f:	8b 15 84 43 00 00    	mov    0x4384,%edx
      if((p = morecore(nunits)) == 0)
    3fa5:	83 c4 10             	add    $0x10,%esp
    3fa8:	85 d2                	test   %edx,%edx
    3faa:	75 bc                	jne    3f68 <malloc+0x48>
        return 0;
  }
}
    3fac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3faf:	31 c0                	xor    %eax,%eax
}
    3fb1:	5b                   	pop    %ebx
    3fb2:	5e                   	pop    %esi
    3fb3:	5f                   	pop    %edi
    3fb4:	5d                   	pop    %ebp
    3fb5:	c3                   	ret    
    if(p->s.size >= nunits){
    3fb6:	89 d0                	mov    %edx,%eax
    3fb8:	89 fa                	mov    %edi,%edx
    3fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3fc0:	39 ce                	cmp    %ecx,%esi
    3fc2:	74 4c                	je     4010 <malloc+0xf0>
        p->s.size -= nunits;
    3fc4:	29 f1                	sub    %esi,%ecx
    3fc6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3fc9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3fcc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    3fcf:	89 15 84 43 00 00    	mov    %edx,0x4384
}
    3fd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3fd8:	83 c0 08             	add    $0x8,%eax
}
    3fdb:	5b                   	pop    %ebx
    3fdc:	5e                   	pop    %esi
    3fdd:	5f                   	pop    %edi
    3fde:	5d                   	pop    %ebp
    3fdf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3fe0:	c7 05 84 43 00 00 88 	movl   $0x4388,0x4384
    3fe7:	43 00 00 
    base.s.size = 0;
    3fea:	bf 88 43 00 00       	mov    $0x4388,%edi
    base.s.ptr = freep = prevp = &base;
    3fef:	c7 05 88 43 00 00 88 	movl   $0x4388,0x4388
    3ff6:	43 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ff9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    3ffb:	c7 05 8c 43 00 00 00 	movl   $0x0,0x438c
    4002:	00 00 00 
    if(p->s.size >= nunits){
    4005:	e9 42 ff ff ff       	jmp    3f4c <malloc+0x2c>
    400a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    4010:	8b 08                	mov    (%eax),%ecx
    4012:	89 0a                	mov    %ecx,(%edx)
    4014:	eb b9                	jmp    3fcf <malloc+0xaf>
