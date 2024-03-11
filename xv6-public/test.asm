
_test:     file format elf32-i386


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
        int ptr=1;               //for traversing argv
    300f:	be 01 00 00 00       	mov    $0x1,%esi
int main(int argc,char* argv[]){
    3014:	53                   	push   %ebx
    3015:	51                   	push   %ecx
    3016:	81 ec 18 04 00 00    	sub    $0x418,%esp
    301c:	8b 01                	mov    (%ecx),%eax
    301e:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
    3024:	8b 41 04             	mov    0x4(%ecx),%eax
    3027:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
        while(ptr < argc){       //looping over argv
    302d:	eb 66                	jmp    3095 <main+0x95>
    302f:	90                   	nop
        head(len,buf);
        ptr+=4;
       }
       else{
        const char *filename = argv[ptr+1];
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3030:	83 ec 08             	sub    $0x8,%esp
        read(fd,buf,sizeof(buf));
        head(14,buf);                      //no options
        ptr+=2;
    3033:	83 c6 02             	add    $0x2,%esi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3036:	6a 00                	push   $0x0
    3038:	50                   	push   %eax
    3039:	e8 a5 04 00 00       	call   34e3 <open>
        read(fd,buf,sizeof(buf));
    303e:	83 c4 0c             	add    $0xc,%esp
    3041:	8d 8d e8 fb ff ff    	lea    -0x418(%ebp),%ecx
    3047:	68 00 04 00 00       	push   $0x400
    304c:	51                   	push   %ecx
    304d:	50                   	push   %eax
    304e:	e8 68 04 00 00       	call   34bb <read>
        head(14,buf);                      //no options
    3053:	58                   	pop    %eax
    3054:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    305a:	5a                   	pop    %edx
    305b:	50                   	push   %eax
    305c:	6a 0e                	push   $0xe
    305e:	e8 e8 04 00 00       	call   354b <head>
        ptr+=2;
    3063:	83 c4 10             	add    $0x10,%esp
       }
    //printf(1,"ptr = %d\n",ptr);
    }
    if(ptr >= argc)
    3066:	3b b5 dc fb ff ff    	cmp    -0x424(%ebp),%esi
    306c:	0f 8d 1e 01 00 00    	jge    3190 <main+0x190>
    exit();
    if(strcmp("uniq",argv[ptr]) == 0){
    3072:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    3078:	8d 14 b0             	lea    (%eax,%esi,4),%edx
    307b:	83 ec 08             	sub    $0x8,%esp
    307e:	ff 32                	push   (%edx)
    3080:	68 3d 39 00 00       	push   $0x393d
    3085:	e8 f6 01 00 00       	call   3280 <strcmp>
    308a:	83 c4 10             	add    $0x10,%esp
    308d:	85 c0                	test   %eax,%eax
    308f:	0f 84 00 01 00 00    	je     3195 <main+0x195>
        while(ptr < argc){       //looping over argv
    3095:	3b b5 dc fb ff ff    	cmp    -0x424(%ebp),%esi
    309b:	0f 8d ef 00 00 00    	jge    3190 <main+0x190>
        if(strcmp("head",argv[ptr]) == 0){
    30a1:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    30a7:	8d 3c b5 00 00 00 00 	lea    0x0(,%esi,4),%edi
    30ae:	83 ec 08             	sub    $0x8,%esp
    30b1:	8d 14 38             	lea    (%eax,%edi,1),%edx
    30b4:	ff 32                	push   (%edx)
    30b6:	68 38 39 00 00       	push   $0x3938
    30bb:	89 95 e0 fb ff ff    	mov    %edx,-0x420(%ebp)
    30c1:	e8 ba 01 00 00       	call   3280 <strcmp>
    30c6:	83 c4 10             	add    $0x10,%esp
    30c9:	8b 95 e0 fb ff ff    	mov    -0x420(%ebp),%edx
    30cf:	85 c0                	test   %eax,%eax
    30d1:	89 c3                	mov    %eax,%ebx
    30d3:	75 a6                	jne    307b <main+0x7b>
       if(argv[ptr+1][0] == '-'){    //option enabled
    30d5:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    30db:	8b 44 38 04          	mov    0x4(%eax,%edi,1),%eax
    30df:	80 38 2d             	cmpb   $0x2d,(%eax)
    30e2:	0f 85 48 ff ff ff    	jne    3030 <main+0x30>
        for(int i=0;i<strlen(argv[ptr+2]);i++)
    30e8:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    30ee:	31 d2                	xor    %edx,%edx
    30f0:	89 bd e0 fb ff ff    	mov    %edi,-0x420(%ebp)
    30f6:	89 b5 d8 fb ff ff    	mov    %esi,-0x428(%ebp)
    30fc:	89 de                	mov    %ebx,%esi
    30fe:	8d 4c 38 08          	lea    0x8(%eax,%edi,1),%ecx
    3102:	89 d7                	mov    %edx,%edi
    3104:	8b 01                	mov    (%ecx),%eax
    3106:	89 cb                	mov    %ecx,%ebx
    3108:	eb 16                	jmp    3120 <main+0x120>
    310a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        len = len*10+argv[ptr+2][i]-'0';
    3110:	8b 03                	mov    (%ebx),%eax
    3112:	8d 14 b6             	lea    (%esi,%esi,4),%edx
    3115:	0f be 0c 38          	movsbl (%eax,%edi,1),%ecx
        for(int i=0;i<strlen(argv[ptr+2]);i++)
    3119:	83 c7 01             	add    $0x1,%edi
        len = len*10+argv[ptr+2][i]-'0';
    311c:	8d 74 51 d0          	lea    -0x30(%ecx,%edx,2),%esi
        for(int i=0;i<strlen(argv[ptr+2]);i++)
    3120:	83 ec 0c             	sub    $0xc,%esp
    3123:	50                   	push   %eax
    3124:	e8 b7 01 00 00       	call   32e0 <strlen>
    3129:	83 c4 10             	add    $0x10,%esp
    312c:	39 f8                	cmp    %edi,%eax
    312e:	77 e0                	ja     3110 <main+0x110>
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3130:	8b bd e0 fb ff ff    	mov    -0x420(%ebp),%edi
    3136:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    313c:	83 ec 08             	sub    $0x8,%esp
    313f:	89 f3                	mov    %esi,%ebx
    3141:	6a 00                	push   $0x0
    3143:	8b b5 d8 fb ff ff    	mov    -0x428(%ebp),%esi
    3149:	ff 74 38 0c          	push   0xc(%eax,%edi,1)
        ptr+=4;
    314d:	83 c6 04             	add    $0x4,%esi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3150:	e8 8e 03 00 00       	call   34e3 <open>
        read(fd,buf,sizeof(buf));
    3155:	83 c4 0c             	add    $0xc,%esp
    3158:	8d 8d e8 fb ff ff    	lea    -0x418(%ebp),%ecx
    315e:	68 00 04 00 00       	push   $0x400
    3163:	51                   	push   %ecx
    3164:	50                   	push   %eax
    3165:	e8 51 03 00 00       	call   34bb <read>
        head(len,buf);
    316a:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
    3170:	59                   	pop    %ecx
    3171:	5f                   	pop    %edi
    3172:	50                   	push   %eax
    3173:	53                   	push   %ebx
    3174:	e8 d2 03 00 00       	call   354b <head>
        ptr+=4;
    3179:	83 c4 10             	add    $0x10,%esp
    if(ptr >= argc)
    317c:	3b b5 dc fb ff ff    	cmp    -0x424(%ebp),%esi
    3182:	0f 8c ea fe ff ff    	jl     3072 <main+0x72>
    3188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    318f:	90                   	nop
    exit();
    3190:	e8 0e 03 00 00       	call   34a3 <exit>
        char buf[1024];
    if(argv[ptr+1][0] != '-'){
    3195:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    319b:	8d 14 b5 04 00 00 00 	lea    0x4(,%esi,4),%edx
    31a2:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
    31a5:	8b 03                	mov    (%ebx),%eax
    31a7:	80 38 2d             	cmpb   $0x2d,(%eax)
    31aa:	74 34                	je     31e0 <main+0x1e0>
        char *filename = argv[ptr+1];
        int fd = open(filename, O_RDONLY); // Open the file for reading
    31ac:	53                   	push   %ebx
        read(fd,buf,sizeof(buf));
        int option=-1;
        uniq(option,buf);
        ptr+=2;
    31ad:	83 c6 02             	add    $0x2,%esi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    31b0:	53                   	push   %ebx
        read(fd,buf,sizeof(buf));
    31b1:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
        int fd = open(filename, O_RDONLY); // Open the file for reading
    31b7:	6a 00                	push   $0x0
    31b9:	50                   	push   %eax
    31ba:	e8 24 03 00 00       	call   34e3 <open>
        read(fd,buf,sizeof(buf));
    31bf:	83 c4 0c             	add    $0xc,%esp
    31c2:	68 00 04 00 00       	push   $0x400
    31c7:	53                   	push   %ebx
    31c8:	50                   	push   %eax
    31c9:	e8 ed 02 00 00       	call   34bb <read>
        uniq(option,buf);
    31ce:	5f                   	pop    %edi
    31cf:	58                   	pop    %eax
    31d0:	53                   	push   %ebx
    31d1:	6a ff                	push   $0xffffffff
    31d3:	e8 6b 03 00 00       	call   3543 <uniq>
        ptr+=2;
    31d8:	83 c4 10             	add    $0x10,%esp
    31db:	e9 b5 fe ff ff       	jmp    3095 <main+0x95>
    }
    else{
        char *filename = argv[ptr+2];
        int fd = open(filename, O_RDONLY); // Open the file for reading
    31e0:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
    31e6:	51                   	push   %ecx
    31e7:	51                   	push   %ecx
    31e8:	6a 00                	push   $0x0
    31ea:	ff 74 10 04          	push   0x4(%eax,%edx,1)
    31ee:	e8 f0 02 00 00       	call   34e3 <open>
        read(fd,buf,sizeof(buf));
    31f3:	83 c4 0c             	add    $0xc,%esp
    31f6:	8d 8d e8 fb ff ff    	lea    -0x418(%ebp),%ecx
    31fc:	68 00 04 00 00       	push   $0x400
    3201:	51                   	push   %ecx
    3202:	50                   	push   %eax
    3203:	e8 b3 02 00 00       	call   34bb <read>
        int option=-1;
        if(argv[ptr+1][1] == 'd')
    3208:	8b 03                	mov    (%ebx),%eax
    320a:	83 c4 10             	add    $0x10,%esp
    320d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    3211:	3c 64                	cmp    $0x64,%al
    3213:	74 25                	je     323a <main+0x23a>
            option=1;
        else if (argv[ptr+1][1] == 'c')
            option=2;
        else
            option=3;
    3215:	3c 63                	cmp    $0x63,%al
    3217:	0f 95 c0             	setne  %al
    321a:	0f b6 c0             	movzbl %al,%eax
    321d:	83 c0 02             	add    $0x2,%eax
        uniq(option,buf);
    3220:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
    3226:	52                   	push   %edx
        ptr+=3;
    3227:	83 c6 03             	add    $0x3,%esi
        uniq(option,buf);
    322a:	52                   	push   %edx
    322b:	53                   	push   %ebx
    322c:	50                   	push   %eax
    322d:	e8 11 03 00 00       	call   3543 <uniq>
        ptr+=3;
    3232:	83 c4 10             	add    $0x10,%esp
    3235:	e9 5b fe ff ff       	jmp    3095 <main+0x95>
            option=1;
    323a:	b8 01 00 00 00       	mov    $0x1,%eax
    323f:	eb df                	jmp    3220 <main+0x220>
    3241:	66 90                	xchg   %ax,%ax
    3243:	66 90                	xchg   %ax,%ax
    3245:	66 90                	xchg   %ax,%ax
    3247:	66 90                	xchg   %ax,%ax
    3249:	66 90                	xchg   %ax,%ax
    324b:	66 90                	xchg   %ax,%ax
    324d:	66 90                	xchg   %ax,%ax
    324f:	90                   	nop

00003250 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3250:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3251:	31 c0                	xor    %eax,%eax
{
    3253:	89 e5                	mov    %esp,%ebp
    3255:	53                   	push   %ebx
    3256:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3259:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3260:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3264:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3267:	83 c0 01             	add    $0x1,%eax
    326a:	84 d2                	test   %dl,%dl
    326c:	75 f2                	jne    3260 <strcpy+0x10>
    ;
  return os;
}
    326e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3271:	89 c8                	mov    %ecx,%eax
    3273:	c9                   	leave  
    3274:	c3                   	ret    
    3275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    327c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003280 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	53                   	push   %ebx
    3284:	8b 55 08             	mov    0x8(%ebp),%edx
    3287:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    328a:	0f b6 02             	movzbl (%edx),%eax
    328d:	84 c0                	test   %al,%al
    328f:	75 17                	jne    32a8 <strcmp+0x28>
    3291:	eb 3a                	jmp    32cd <strcmp+0x4d>
    3293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3297:	90                   	nop
    3298:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    329c:	83 c2 01             	add    $0x1,%edx
    329f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    32a2:	84 c0                	test   %al,%al
    32a4:	74 1a                	je     32c0 <strcmp+0x40>
    p++, q++;
    32a6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    32a8:	0f b6 19             	movzbl (%ecx),%ebx
    32ab:	38 c3                	cmp    %al,%bl
    32ad:	74 e9                	je     3298 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    32af:	29 d8                	sub    %ebx,%eax
}
    32b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    32b4:	c9                   	leave  
    32b5:	c3                   	ret    
    32b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32bd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    32c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    32c4:	31 c0                	xor    %eax,%eax
    32c6:	29 d8                	sub    %ebx,%eax
}
    32c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    32cb:	c9                   	leave  
    32cc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    32cd:	0f b6 19             	movzbl (%ecx),%ebx
    32d0:	31 c0                	xor    %eax,%eax
    32d2:	eb db                	jmp    32af <strcmp+0x2f>
    32d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    32df:	90                   	nop

000032e0 <strlen>:

uint
strlen(const char *s)
{
    32e0:	55                   	push   %ebp
    32e1:	89 e5                	mov    %esp,%ebp
    32e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    32e6:	80 3a 00             	cmpb   $0x0,(%edx)
    32e9:	74 15                	je     3300 <strlen+0x20>
    32eb:	31 c0                	xor    %eax,%eax
    32ed:	8d 76 00             	lea    0x0(%esi),%esi
    32f0:	83 c0 01             	add    $0x1,%eax
    32f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    32f7:	89 c1                	mov    %eax,%ecx
    32f9:	75 f5                	jne    32f0 <strlen+0x10>
    ;
  return n;
}
    32fb:	89 c8                	mov    %ecx,%eax
    32fd:	5d                   	pop    %ebp
    32fe:	c3                   	ret    
    32ff:	90                   	nop
  for(n = 0; s[n]; n++)
    3300:	31 c9                	xor    %ecx,%ecx
}
    3302:	5d                   	pop    %ebp
    3303:	89 c8                	mov    %ecx,%eax
    3305:	c3                   	ret    
    3306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    330d:	8d 76 00             	lea    0x0(%esi),%esi

00003310 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3310:	55                   	push   %ebp
    3311:	89 e5                	mov    %esp,%ebp
    3313:	57                   	push   %edi
    3314:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3317:	8b 4d 10             	mov    0x10(%ebp),%ecx
    331a:	8b 45 0c             	mov    0xc(%ebp),%eax
    331d:	89 d7                	mov    %edx,%edi
    331f:	fc                   	cld    
    3320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3322:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3325:	89 d0                	mov    %edx,%eax
    3327:	c9                   	leave  
    3328:	c3                   	ret    
    3329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003330 <strchr>:

char*
strchr(const char *s, char c)
{
    3330:	55                   	push   %ebp
    3331:	89 e5                	mov    %esp,%ebp
    3333:	8b 45 08             	mov    0x8(%ebp),%eax
    3336:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    333a:	0f b6 10             	movzbl (%eax),%edx
    333d:	84 d2                	test   %dl,%dl
    333f:	75 12                	jne    3353 <strchr+0x23>
    3341:	eb 1d                	jmp    3360 <strchr+0x30>
    3343:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3347:	90                   	nop
    3348:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    334c:	83 c0 01             	add    $0x1,%eax
    334f:	84 d2                	test   %dl,%dl
    3351:	74 0d                	je     3360 <strchr+0x30>
    if(*s == c)
    3353:	38 d1                	cmp    %dl,%cl
    3355:	75 f1                	jne    3348 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3357:	5d                   	pop    %ebp
    3358:	c3                   	ret    
    3359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3360:	31 c0                	xor    %eax,%eax
}
    3362:	5d                   	pop    %ebp
    3363:	c3                   	ret    
    3364:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    336b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    336f:	90                   	nop

00003370 <gets>:

char*
gets(char *buf, int max)
{
    3370:	55                   	push   %ebp
    3371:	89 e5                	mov    %esp,%ebp
    3373:	57                   	push   %edi
    3374:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3375:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3378:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3379:	31 db                	xor    %ebx,%ebx
{
    337b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    337e:	eb 27                	jmp    33a7 <gets+0x37>
    cc = read(0, &c, 1);
    3380:	83 ec 04             	sub    $0x4,%esp
    3383:	6a 01                	push   $0x1
    3385:	57                   	push   %edi
    3386:	6a 00                	push   $0x0
    3388:	e8 2e 01 00 00       	call   34bb <read>
    if(cc < 1)
    338d:	83 c4 10             	add    $0x10,%esp
    3390:	85 c0                	test   %eax,%eax
    3392:	7e 1d                	jle    33b1 <gets+0x41>
      break;
    buf[i++] = c;
    3394:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3398:	8b 55 08             	mov    0x8(%ebp),%edx
    339b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    339f:	3c 0a                	cmp    $0xa,%al
    33a1:	74 1d                	je     33c0 <gets+0x50>
    33a3:	3c 0d                	cmp    $0xd,%al
    33a5:	74 19                	je     33c0 <gets+0x50>
  for(i=0; i+1 < max; ){
    33a7:	89 de                	mov    %ebx,%esi
    33a9:	83 c3 01             	add    $0x1,%ebx
    33ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    33af:	7c cf                	jl     3380 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    33b1:	8b 45 08             	mov    0x8(%ebp),%eax
    33b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    33b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    33bb:	5b                   	pop    %ebx
    33bc:	5e                   	pop    %esi
    33bd:	5f                   	pop    %edi
    33be:	5d                   	pop    %ebp
    33bf:	c3                   	ret    
  buf[i] = '\0';
    33c0:	8b 45 08             	mov    0x8(%ebp),%eax
    33c3:	89 de                	mov    %ebx,%esi
    33c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    33c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    33cc:	5b                   	pop    %ebx
    33cd:	5e                   	pop    %esi
    33ce:	5f                   	pop    %edi
    33cf:	5d                   	pop    %ebp
    33d0:	c3                   	ret    
    33d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33df:	90                   	nop

000033e0 <stat>:

int
stat(const char *n, struct stat *st)
{
    33e0:	55                   	push   %ebp
    33e1:	89 e5                	mov    %esp,%ebp
    33e3:	56                   	push   %esi
    33e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    33e5:	83 ec 08             	sub    $0x8,%esp
    33e8:	6a 00                	push   $0x0
    33ea:	ff 75 08             	push   0x8(%ebp)
    33ed:	e8 f1 00 00 00       	call   34e3 <open>
  if(fd < 0)
    33f2:	83 c4 10             	add    $0x10,%esp
    33f5:	85 c0                	test   %eax,%eax
    33f7:	78 27                	js     3420 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    33f9:	83 ec 08             	sub    $0x8,%esp
    33fc:	ff 75 0c             	push   0xc(%ebp)
    33ff:	89 c3                	mov    %eax,%ebx
    3401:	50                   	push   %eax
    3402:	e8 f4 00 00 00       	call   34fb <fstat>
  close(fd);
    3407:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    340a:	89 c6                	mov    %eax,%esi
  close(fd);
    340c:	e8 ba 00 00 00       	call   34cb <close>
  return r;
    3411:	83 c4 10             	add    $0x10,%esp
}
    3414:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3417:	89 f0                	mov    %esi,%eax
    3419:	5b                   	pop    %ebx
    341a:	5e                   	pop    %esi
    341b:	5d                   	pop    %ebp
    341c:	c3                   	ret    
    341d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3420:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3425:	eb ed                	jmp    3414 <stat+0x34>
    3427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    342e:	66 90                	xchg   %ax,%ax

00003430 <atoi>:

int
atoi(const char *s)
{
    3430:	55                   	push   %ebp
    3431:	89 e5                	mov    %esp,%ebp
    3433:	53                   	push   %ebx
    3434:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3437:	0f be 02             	movsbl (%edx),%eax
    343a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    343d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3440:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3445:	77 1e                	ja     3465 <atoi+0x35>
    3447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    344e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3450:	83 c2 01             	add    $0x1,%edx
    3453:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3456:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    345a:	0f be 02             	movsbl (%edx),%eax
    345d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3460:	80 fb 09             	cmp    $0x9,%bl
    3463:	76 eb                	jbe    3450 <atoi+0x20>
  return n;
}
    3465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3468:	89 c8                	mov    %ecx,%eax
    346a:	c9                   	leave  
    346b:	c3                   	ret    
    346c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003470 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3470:	55                   	push   %ebp
    3471:	89 e5                	mov    %esp,%ebp
    3473:	57                   	push   %edi
    3474:	8b 45 10             	mov    0x10(%ebp),%eax
    3477:	8b 55 08             	mov    0x8(%ebp),%edx
    347a:	56                   	push   %esi
    347b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    347e:	85 c0                	test   %eax,%eax
    3480:	7e 13                	jle    3495 <memmove+0x25>
    3482:	01 d0                	add    %edx,%eax
  dst = vdst;
    3484:	89 d7                	mov    %edx,%edi
    3486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    348d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3490:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3491:	39 f8                	cmp    %edi,%eax
    3493:	75 fb                	jne    3490 <memmove+0x20>
  return vdst;
}
    3495:	5e                   	pop    %esi
    3496:	89 d0                	mov    %edx,%eax
    3498:	5f                   	pop    %edi
    3499:	5d                   	pop    %ebp
    349a:	c3                   	ret    

0000349b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    349b:	b8 01 00 00 00       	mov    $0x1,%eax
    34a0:	cd 40                	int    $0x40
    34a2:	c3                   	ret    

000034a3 <exit>:
SYSCALL(exit)
    34a3:	b8 02 00 00 00       	mov    $0x2,%eax
    34a8:	cd 40                	int    $0x40
    34aa:	c3                   	ret    

000034ab <wait>:
SYSCALL(wait)
    34ab:	b8 03 00 00 00       	mov    $0x3,%eax
    34b0:	cd 40                	int    $0x40
    34b2:	c3                   	ret    

000034b3 <pipe>:
SYSCALL(pipe)
    34b3:	b8 04 00 00 00       	mov    $0x4,%eax
    34b8:	cd 40                	int    $0x40
    34ba:	c3                   	ret    

000034bb <read>:
SYSCALL(read)
    34bb:	b8 05 00 00 00       	mov    $0x5,%eax
    34c0:	cd 40                	int    $0x40
    34c2:	c3                   	ret    

000034c3 <write>:
SYSCALL(write)
    34c3:	b8 10 00 00 00       	mov    $0x10,%eax
    34c8:	cd 40                	int    $0x40
    34ca:	c3                   	ret    

000034cb <close>:
SYSCALL(close)
    34cb:	b8 15 00 00 00       	mov    $0x15,%eax
    34d0:	cd 40                	int    $0x40
    34d2:	c3                   	ret    

000034d3 <kill>:
SYSCALL(kill)
    34d3:	b8 06 00 00 00       	mov    $0x6,%eax
    34d8:	cd 40                	int    $0x40
    34da:	c3                   	ret    

000034db <exec>:
SYSCALL(exec)
    34db:	b8 07 00 00 00       	mov    $0x7,%eax
    34e0:	cd 40                	int    $0x40
    34e2:	c3                   	ret    

000034e3 <open>:
SYSCALL(open)
    34e3:	b8 0f 00 00 00       	mov    $0xf,%eax
    34e8:	cd 40                	int    $0x40
    34ea:	c3                   	ret    

000034eb <mknod>:
SYSCALL(mknod)
    34eb:	b8 11 00 00 00       	mov    $0x11,%eax
    34f0:	cd 40                	int    $0x40
    34f2:	c3                   	ret    

000034f3 <unlink>:
SYSCALL(unlink)
    34f3:	b8 12 00 00 00       	mov    $0x12,%eax
    34f8:	cd 40                	int    $0x40
    34fa:	c3                   	ret    

000034fb <fstat>:
SYSCALL(fstat)
    34fb:	b8 08 00 00 00       	mov    $0x8,%eax
    3500:	cd 40                	int    $0x40
    3502:	c3                   	ret    

00003503 <link>:
SYSCALL(link)
    3503:	b8 13 00 00 00       	mov    $0x13,%eax
    3508:	cd 40                	int    $0x40
    350a:	c3                   	ret    

0000350b <mkdir>:
SYSCALL(mkdir)
    350b:	b8 14 00 00 00       	mov    $0x14,%eax
    3510:	cd 40                	int    $0x40
    3512:	c3                   	ret    

00003513 <chdir>:
SYSCALL(chdir)
    3513:	b8 09 00 00 00       	mov    $0x9,%eax
    3518:	cd 40                	int    $0x40
    351a:	c3                   	ret    

0000351b <dup>:
SYSCALL(dup)
    351b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3520:	cd 40                	int    $0x40
    3522:	c3                   	ret    

00003523 <getpid>:
SYSCALL(getpid)
    3523:	b8 0b 00 00 00       	mov    $0xb,%eax
    3528:	cd 40                	int    $0x40
    352a:	c3                   	ret    

0000352b <sbrk>:
SYSCALL(sbrk)
    352b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3530:	cd 40                	int    $0x40
    3532:	c3                   	ret    

00003533 <sleep>:
SYSCALL(sleep)
    3533:	b8 0d 00 00 00       	mov    $0xd,%eax
    3538:	cd 40                	int    $0x40
    353a:	c3                   	ret    

0000353b <uptime>:
SYSCALL(uptime)
    353b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3540:	cd 40                	int    $0x40
    3542:	c3                   	ret    

00003543 <uniq>:
SYSCALL(uniq)
    3543:	b8 16 00 00 00       	mov    $0x16,%eax
    3548:	cd 40                	int    $0x40
    354a:	c3                   	ret    

0000354b <head>:
SYSCALL(head)
    354b:	b8 17 00 00 00       	mov    $0x17,%eax
    3550:	cd 40                	int    $0x40
    3552:	c3                   	ret    

00003553 <ps>:
    3553:	b8 18 00 00 00       	mov    $0x18,%eax
    3558:	cd 40                	int    $0x40
    355a:	c3                   	ret    
    355b:	66 90                	xchg   %ax,%ax
    355d:	66 90                	xchg   %ax,%ax
    355f:	90                   	nop

00003560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3560:	55                   	push   %ebp
    3561:	89 e5                	mov    %esp,%ebp
    3563:	57                   	push   %edi
    3564:	56                   	push   %esi
    3565:	53                   	push   %ebx
    3566:	83 ec 3c             	sub    $0x3c,%esp
    3569:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    356c:	89 d1                	mov    %edx,%ecx
{
    356e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3571:	85 d2                	test   %edx,%edx
    3573:	0f 89 7f 00 00 00    	jns    35f8 <printint+0x98>
    3579:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    357d:	74 79                	je     35f8 <printint+0x98>
    neg = 1;
    357f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3586:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3588:	31 db                	xor    %ebx,%ebx
    358a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    358d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3590:	89 c8                	mov    %ecx,%eax
    3592:	31 d2                	xor    %edx,%edx
    3594:	89 cf                	mov    %ecx,%edi
    3596:	f7 75 c4             	divl   -0x3c(%ebp)
    3599:	0f b6 92 a4 39 00 00 	movzbl 0x39a4(%edx),%edx
    35a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    35a3:	89 d8                	mov    %ebx,%eax
    35a5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    35a8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    35ab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    35ae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    35b1:	76 dd                	jbe    3590 <printint+0x30>
  if(neg)
    35b3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    35b6:	85 c9                	test   %ecx,%ecx
    35b8:	74 0c                	je     35c6 <printint+0x66>
    buf[i++] = '-';
    35ba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    35bf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    35c1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    35c6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    35c9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    35cd:	eb 07                	jmp    35d6 <printint+0x76>
    35cf:	90                   	nop
    putc(fd, buf[i]);
    35d0:	0f b6 13             	movzbl (%ebx),%edx
    35d3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    35d6:	83 ec 04             	sub    $0x4,%esp
    35d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    35dc:	6a 01                	push   $0x1
    35de:	56                   	push   %esi
    35df:	57                   	push   %edi
    35e0:	e8 de fe ff ff       	call   34c3 <write>
  while(--i >= 0)
    35e5:	83 c4 10             	add    $0x10,%esp
    35e8:	39 de                	cmp    %ebx,%esi
    35ea:	75 e4                	jne    35d0 <printint+0x70>
}
    35ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    35ef:	5b                   	pop    %ebx
    35f0:	5e                   	pop    %esi
    35f1:	5f                   	pop    %edi
    35f2:	5d                   	pop    %ebp
    35f3:	c3                   	ret    
    35f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    35f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    35ff:	eb 87                	jmp    3588 <printint+0x28>
    3601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    360f:	90                   	nop

00003610 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3610:	55                   	push   %ebp
    3611:	89 e5                	mov    %esp,%ebp
    3613:	57                   	push   %edi
    3614:	56                   	push   %esi
    3615:	53                   	push   %ebx
    3616:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3619:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    361c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    361f:	0f b6 13             	movzbl (%ebx),%edx
    3622:	84 d2                	test   %dl,%dl
    3624:	74 6a                	je     3690 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3626:	8d 45 10             	lea    0x10(%ebp),%eax
    3629:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    362c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    362f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3631:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3634:	eb 36                	jmp    366c <printf+0x5c>
    3636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    363d:	8d 76 00             	lea    0x0(%esi),%esi
    3640:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3643:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3648:	83 f8 25             	cmp    $0x25,%eax
    364b:	74 15                	je     3662 <printf+0x52>
  write(fd, &c, 1);
    364d:	83 ec 04             	sub    $0x4,%esp
    3650:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3653:	6a 01                	push   $0x1
    3655:	57                   	push   %edi
    3656:	56                   	push   %esi
    3657:	e8 67 fe ff ff       	call   34c3 <write>
    365c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    365f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3662:	0f b6 13             	movzbl (%ebx),%edx
    3665:	83 c3 01             	add    $0x1,%ebx
    3668:	84 d2                	test   %dl,%dl
    366a:	74 24                	je     3690 <printf+0x80>
    c = fmt[i] & 0xff;
    366c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    366f:	85 c9                	test   %ecx,%ecx
    3671:	74 cd                	je     3640 <printf+0x30>
      }
    } else if(state == '%'){
    3673:	83 f9 25             	cmp    $0x25,%ecx
    3676:	75 ea                	jne    3662 <printf+0x52>
      if(c == 'd'){
    3678:	83 f8 25             	cmp    $0x25,%eax
    367b:	0f 84 07 01 00 00    	je     3788 <printf+0x178>
    3681:	83 e8 63             	sub    $0x63,%eax
    3684:	83 f8 15             	cmp    $0x15,%eax
    3687:	77 17                	ja     36a0 <printf+0x90>
    3689:	ff 24 85 4c 39 00 00 	jmp    *0x394c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3690:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3693:	5b                   	pop    %ebx
    3694:	5e                   	pop    %esi
    3695:	5f                   	pop    %edi
    3696:	5d                   	pop    %ebp
    3697:	c3                   	ret    
    3698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    369f:	90                   	nop
  write(fd, &c, 1);
    36a0:	83 ec 04             	sub    $0x4,%esp
    36a3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    36a6:	6a 01                	push   $0x1
    36a8:	57                   	push   %edi
    36a9:	56                   	push   %esi
    36aa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    36ae:	e8 10 fe ff ff       	call   34c3 <write>
        putc(fd, c);
    36b3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    36b7:	83 c4 0c             	add    $0xc,%esp
    36ba:	88 55 e7             	mov    %dl,-0x19(%ebp)
    36bd:	6a 01                	push   $0x1
    36bf:	57                   	push   %edi
    36c0:	56                   	push   %esi
    36c1:	e8 fd fd ff ff       	call   34c3 <write>
        putc(fd, c);
    36c6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    36c9:	31 c9                	xor    %ecx,%ecx
    36cb:	eb 95                	jmp    3662 <printf+0x52>
    36cd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    36d0:	83 ec 0c             	sub    $0xc,%esp
    36d3:	b9 10 00 00 00       	mov    $0x10,%ecx
    36d8:	6a 00                	push   $0x0
    36da:	8b 45 d0             	mov    -0x30(%ebp),%eax
    36dd:	8b 10                	mov    (%eax),%edx
    36df:	89 f0                	mov    %esi,%eax
    36e1:	e8 7a fe ff ff       	call   3560 <printint>
        ap++;
    36e6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    36ea:	83 c4 10             	add    $0x10,%esp
      state = 0;
    36ed:	31 c9                	xor    %ecx,%ecx
    36ef:	e9 6e ff ff ff       	jmp    3662 <printf+0x52>
    36f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    36f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    36fb:	8b 10                	mov    (%eax),%edx
        ap++;
    36fd:	83 c0 04             	add    $0x4,%eax
    3700:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3703:	85 d2                	test   %edx,%edx
    3705:	0f 84 8d 00 00 00    	je     3798 <printf+0x188>
        while(*s != 0){
    370b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    370e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3710:	84 c0                	test   %al,%al
    3712:	0f 84 4a ff ff ff    	je     3662 <printf+0x52>
    3718:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    371b:	89 d3                	mov    %edx,%ebx
    371d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3720:	83 ec 04             	sub    $0x4,%esp
          s++;
    3723:	83 c3 01             	add    $0x1,%ebx
    3726:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3729:	6a 01                	push   $0x1
    372b:	57                   	push   %edi
    372c:	56                   	push   %esi
    372d:	e8 91 fd ff ff       	call   34c3 <write>
        while(*s != 0){
    3732:	0f b6 03             	movzbl (%ebx),%eax
    3735:	83 c4 10             	add    $0x10,%esp
    3738:	84 c0                	test   %al,%al
    373a:	75 e4                	jne    3720 <printf+0x110>
      state = 0;
    373c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    373f:	31 c9                	xor    %ecx,%ecx
    3741:	e9 1c ff ff ff       	jmp    3662 <printf+0x52>
    3746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    374d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3750:	83 ec 0c             	sub    $0xc,%esp
    3753:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3758:	6a 01                	push   $0x1
    375a:	e9 7b ff ff ff       	jmp    36da <printf+0xca>
    375f:	90                   	nop
        putc(fd, *ap);
    3760:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3763:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3766:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3768:	6a 01                	push   $0x1
    376a:	57                   	push   %edi
    376b:	56                   	push   %esi
        putc(fd, *ap);
    376c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    376f:	e8 4f fd ff ff       	call   34c3 <write>
        ap++;
    3774:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3778:	83 c4 10             	add    $0x10,%esp
      state = 0;
    377b:	31 c9                	xor    %ecx,%ecx
    377d:	e9 e0 fe ff ff       	jmp    3662 <printf+0x52>
    3782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3788:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    378b:	83 ec 04             	sub    $0x4,%esp
    378e:	e9 2a ff ff ff       	jmp    36bd <printf+0xad>
    3793:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3797:	90                   	nop
          s = "(null)";
    3798:	ba 42 39 00 00       	mov    $0x3942,%edx
        while(*s != 0){
    379d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    37a0:	b8 28 00 00 00       	mov    $0x28,%eax
    37a5:	89 d3                	mov    %edx,%ebx
    37a7:	e9 74 ff ff ff       	jmp    3720 <printf+0x110>
    37ac:	66 90                	xchg   %ax,%ax
    37ae:	66 90                	xchg   %ax,%ax

000037b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37b1:	a1 5c 3c 00 00       	mov    0x3c5c,%eax
{
    37b6:	89 e5                	mov    %esp,%ebp
    37b8:	57                   	push   %edi
    37b9:	56                   	push   %esi
    37ba:	53                   	push   %ebx
    37bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    37be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37c8:	89 c2                	mov    %eax,%edx
    37ca:	8b 00                	mov    (%eax),%eax
    37cc:	39 ca                	cmp    %ecx,%edx
    37ce:	73 30                	jae    3800 <free+0x50>
    37d0:	39 c1                	cmp    %eax,%ecx
    37d2:	72 04                	jb     37d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37d4:	39 c2                	cmp    %eax,%edx
    37d6:	72 f0                	jb     37c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    37d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    37db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    37de:	39 f8                	cmp    %edi,%eax
    37e0:	74 30                	je     3812 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    37e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    37e5:	8b 42 04             	mov    0x4(%edx),%eax
    37e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    37eb:	39 f1                	cmp    %esi,%ecx
    37ed:	74 3a                	je     3829 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    37ef:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    37f1:	5b                   	pop    %ebx
  freep = p;
    37f2:	89 15 5c 3c 00 00    	mov    %edx,0x3c5c
}
    37f8:	5e                   	pop    %esi
    37f9:	5f                   	pop    %edi
    37fa:	5d                   	pop    %ebp
    37fb:	c3                   	ret    
    37fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3800:	39 c2                	cmp    %eax,%edx
    3802:	72 c4                	jb     37c8 <free+0x18>
    3804:	39 c1                	cmp    %eax,%ecx
    3806:	73 c0                	jae    37c8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3808:	8b 73 fc             	mov    -0x4(%ebx),%esi
    380b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    380e:	39 f8                	cmp    %edi,%eax
    3810:	75 d0                	jne    37e2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3812:	03 70 04             	add    0x4(%eax),%esi
    3815:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3818:	8b 02                	mov    (%edx),%eax
    381a:	8b 00                	mov    (%eax),%eax
    381c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    381f:	8b 42 04             	mov    0x4(%edx),%eax
    3822:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3825:	39 f1                	cmp    %esi,%ecx
    3827:	75 c6                	jne    37ef <free+0x3f>
    p->s.size += bp->s.size;
    3829:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    382c:	89 15 5c 3c 00 00    	mov    %edx,0x3c5c
    p->s.size += bp->s.size;
    3832:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3835:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3838:	89 0a                	mov    %ecx,(%edx)
}
    383a:	5b                   	pop    %ebx
    383b:	5e                   	pop    %esi
    383c:	5f                   	pop    %edi
    383d:	5d                   	pop    %ebp
    383e:	c3                   	ret    
    383f:	90                   	nop

00003840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3840:	55                   	push   %ebp
    3841:	89 e5                	mov    %esp,%ebp
    3843:	57                   	push   %edi
    3844:	56                   	push   %esi
    3845:	53                   	push   %ebx
    3846:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    384c:	8b 3d 5c 3c 00 00    	mov    0x3c5c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3852:	8d 70 07             	lea    0x7(%eax),%esi
    3855:	c1 ee 03             	shr    $0x3,%esi
    3858:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    385b:	85 ff                	test   %edi,%edi
    385d:	0f 84 9d 00 00 00    	je     3900 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3863:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3865:	8b 4a 04             	mov    0x4(%edx),%ecx
    3868:	39 f1                	cmp    %esi,%ecx
    386a:	73 6a                	jae    38d6 <malloc+0x96>
    386c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3871:	39 de                	cmp    %ebx,%esi
    3873:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3876:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    387d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3880:	eb 17                	jmp    3899 <malloc+0x59>
    3882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3888:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    388a:	8b 48 04             	mov    0x4(%eax),%ecx
    388d:	39 f1                	cmp    %esi,%ecx
    388f:	73 4f                	jae    38e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3891:	8b 3d 5c 3c 00 00    	mov    0x3c5c,%edi
    3897:	89 c2                	mov    %eax,%edx
    3899:	39 d7                	cmp    %edx,%edi
    389b:	75 eb                	jne    3888 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    389d:	83 ec 0c             	sub    $0xc,%esp
    38a0:	ff 75 e4             	push   -0x1c(%ebp)
    38a3:	e8 83 fc ff ff       	call   352b <sbrk>
  if(p == (char*)-1)
    38a8:	83 c4 10             	add    $0x10,%esp
    38ab:	83 f8 ff             	cmp    $0xffffffff,%eax
    38ae:	74 1c                	je     38cc <malloc+0x8c>
  hp->s.size = nu;
    38b0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    38b3:	83 ec 0c             	sub    $0xc,%esp
    38b6:	83 c0 08             	add    $0x8,%eax
    38b9:	50                   	push   %eax
    38ba:	e8 f1 fe ff ff       	call   37b0 <free>
  return freep;
    38bf:	8b 15 5c 3c 00 00    	mov    0x3c5c,%edx
      if((p = morecore(nunits)) == 0)
    38c5:	83 c4 10             	add    $0x10,%esp
    38c8:	85 d2                	test   %edx,%edx
    38ca:	75 bc                	jne    3888 <malloc+0x48>
        return 0;
  }
}
    38cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    38cf:	31 c0                	xor    %eax,%eax
}
    38d1:	5b                   	pop    %ebx
    38d2:	5e                   	pop    %esi
    38d3:	5f                   	pop    %edi
    38d4:	5d                   	pop    %ebp
    38d5:	c3                   	ret    
    if(p->s.size >= nunits){
    38d6:	89 d0                	mov    %edx,%eax
    38d8:	89 fa                	mov    %edi,%edx
    38da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    38e0:	39 ce                	cmp    %ecx,%esi
    38e2:	74 4c                	je     3930 <malloc+0xf0>
        p->s.size -= nunits;
    38e4:	29 f1                	sub    %esi,%ecx
    38e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    38e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    38ec:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    38ef:	89 15 5c 3c 00 00    	mov    %edx,0x3c5c
}
    38f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    38f8:	83 c0 08             	add    $0x8,%eax
}
    38fb:	5b                   	pop    %ebx
    38fc:	5e                   	pop    %esi
    38fd:	5f                   	pop    %edi
    38fe:	5d                   	pop    %ebp
    38ff:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3900:	c7 05 5c 3c 00 00 60 	movl   $0x3c60,0x3c5c
    3907:	3c 00 00 
    base.s.size = 0;
    390a:	bf 60 3c 00 00       	mov    $0x3c60,%edi
    base.s.ptr = freep = prevp = &base;
    390f:	c7 05 60 3c 00 00 60 	movl   $0x3c60,0x3c60
    3916:	3c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3919:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    391b:	c7 05 64 3c 00 00 00 	movl   $0x0,0x3c64
    3922:	00 00 00 
    if(p->s.size >= nunits){
    3925:	e9 42 ff ff ff       	jmp    386c <malloc+0x2c>
    392a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3930:	8b 08                	mov    (%eax),%ecx
    3932:	89 0a                	mov    %ecx,(%edx)
    3934:	eb b9                	jmp    38ef <malloc+0xaf>
