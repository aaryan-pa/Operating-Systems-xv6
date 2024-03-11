
_uniq_ker:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	57                   	push   %edi
    300e:	56                   	push   %esi
    300f:	53                   	push   %ebx
    3010:	51                   	push   %ecx
    3011:	81 ec 08 04 00 00    	sub    $0x408,%esp
    3017:	8b 59 04             	mov    0x4(%ecx),%ebx
    301a:	8b 39                	mov    (%ecx),%edi

        char buf[1024];
        //int sentences = 0;
        //char curr_line[15][100]; // prev_line[] = "";
        char *filename = argv[1];
    301c:	8b 43 04             	mov    0x4(%ebx),%eax
        if(argc > 2)
    301f:	83 ff 02             	cmp    $0x2,%edi
    3022:	7e 49                	jle    306d <main+0x6d>
        { filename = argv[2]; }
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3024:	51                   	push   %ecx
        read(fd,buf,sizeof(buf));
    3025:	8d b5 e8 fb ff ff    	lea    -0x418(%ebp),%esi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    302b:	51                   	push   %ecx
    302c:	6a 00                	push   $0x0
    302e:	ff 73 08             	push   0x8(%ebx)
    3031:	e8 fd 02 00 00       	call   3333 <open>
        read(fd,buf,sizeof(buf));
    3036:	83 c4 0c             	add    $0xc,%esp
    3039:	68 00 04 00 00       	push   $0x400
    303e:	56                   	push   %esi
    303f:	50                   	push   %eax
    3040:	e8 c6 02 00 00       	call   330b <read>
    3045:	83 c4 10             	add    $0x10,%esp
        // }
        int option=-1;
        if(argc == 2)
        option=0;
        else{
            if(argv[1][1] == 'd')
    3048:	8b 43 04             	mov    0x4(%ebx),%eax
    304b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    304f:	3c 64                	cmp    $0x64,%al
    3051:	74 45                	je     3098 <main+0x98>
            option=1;
            else if (argv[1][1] == 'c')
            option=2;
            else
            option=3;
    3053:	3c 63                	cmp    $0x63,%al
    3055:	0f 95 c0             	setne  %al
    3058:	0f b6 c0             	movzbl %al,%eax
    305b:	83 c0 02             	add    $0x2,%eax
        }
        //printf(1,"option = %d\n",option);
        
        uniq(option,buf);
    305e:	83 ec 08             	sub    $0x8,%esp
    3061:	56                   	push   %esi
    3062:	50                   	push   %eax
    3063:	e8 2b 03 00 00       	call   3393 <uniq>
        // exit();
    
    
    // open()
    // close()
    exit();
    3068:	e8 86 02 00 00       	call   32f3 <exit>
        int fd = open(filename, O_RDONLY); // Open the file for reading
    306d:	52                   	push   %edx
        read(fd,buf,sizeof(buf));
    306e:	8d b5 e8 fb ff ff    	lea    -0x418(%ebp),%esi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3074:	52                   	push   %edx
    3075:	6a 00                	push   $0x0
    3077:	50                   	push   %eax
    3078:	e8 b6 02 00 00       	call   3333 <open>
        read(fd,buf,sizeof(buf));
    307d:	83 c4 0c             	add    $0xc,%esp
    3080:	68 00 04 00 00       	push   $0x400
    3085:	56                   	push   %esi
    3086:	50                   	push   %eax
    3087:	e8 7f 02 00 00       	call   330b <read>
        if(argc == 2)
    308c:	83 c4 10             	add    $0x10,%esp
        option=0;
    308f:	31 c0                	xor    %eax,%eax
        if(argc == 2)
    3091:	83 ff 02             	cmp    $0x2,%edi
    3094:	74 c8                	je     305e <main+0x5e>
    3096:	eb b0                	jmp    3048 <main+0x48>
            option=1;
    3098:	b8 01 00 00 00       	mov    $0x1,%eax
    309d:	eb bf                	jmp    305e <main+0x5e>
    309f:	90                   	nop

000030a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    30a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    30a1:	31 c0                	xor    %eax,%eax
{
    30a3:	89 e5                	mov    %esp,%ebp
    30a5:	53                   	push   %ebx
    30a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    30a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    30ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    30b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    30b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    30b7:	83 c0 01             	add    $0x1,%eax
    30ba:	84 d2                	test   %dl,%dl
    30bc:	75 f2                	jne    30b0 <strcpy+0x10>
    ;
  return os;
}
    30be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30c1:	89 c8                	mov    %ecx,%eax
    30c3:	c9                   	leave  
    30c4:	c3                   	ret    
    30c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000030d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30d0:	55                   	push   %ebp
    30d1:	89 e5                	mov    %esp,%ebp
    30d3:	53                   	push   %ebx
    30d4:	8b 55 08             	mov    0x8(%ebp),%edx
    30d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    30da:	0f b6 02             	movzbl (%edx),%eax
    30dd:	84 c0                	test   %al,%al
    30df:	75 17                	jne    30f8 <strcmp+0x28>
    30e1:	eb 3a                	jmp    311d <strcmp+0x4d>
    30e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30e7:	90                   	nop
    30e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    30ec:	83 c2 01             	add    $0x1,%edx
    30ef:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    30f2:	84 c0                	test   %al,%al
    30f4:	74 1a                	je     3110 <strcmp+0x40>
    p++, q++;
    30f6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    30f8:	0f b6 19             	movzbl (%ecx),%ebx
    30fb:	38 c3                	cmp    %al,%bl
    30fd:	74 e9                	je     30e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    30ff:	29 d8                	sub    %ebx,%eax
}
    3101:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3104:	c9                   	leave  
    3105:	c3                   	ret    
    3106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    310d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3110:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3114:	31 c0                	xor    %eax,%eax
    3116:	29 d8                	sub    %ebx,%eax
}
    3118:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    311b:	c9                   	leave  
    311c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    311d:	0f b6 19             	movzbl (%ecx),%ebx
    3120:	31 c0                	xor    %eax,%eax
    3122:	eb db                	jmp    30ff <strcmp+0x2f>
    3124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    312b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    312f:	90                   	nop

00003130 <strlen>:

uint
strlen(const char *s)
{
    3130:	55                   	push   %ebp
    3131:	89 e5                	mov    %esp,%ebp
    3133:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3136:	80 3a 00             	cmpb   $0x0,(%edx)
    3139:	74 15                	je     3150 <strlen+0x20>
    313b:	31 c0                	xor    %eax,%eax
    313d:	8d 76 00             	lea    0x0(%esi),%esi
    3140:	83 c0 01             	add    $0x1,%eax
    3143:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3147:	89 c1                	mov    %eax,%ecx
    3149:	75 f5                	jne    3140 <strlen+0x10>
    ;
  return n;
}
    314b:	89 c8                	mov    %ecx,%eax
    314d:	5d                   	pop    %ebp
    314e:	c3                   	ret    
    314f:	90                   	nop
  for(n = 0; s[n]; n++)
    3150:	31 c9                	xor    %ecx,%ecx
}
    3152:	5d                   	pop    %ebp
    3153:	89 c8                	mov    %ecx,%eax
    3155:	c3                   	ret    
    3156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    315d:	8d 76 00             	lea    0x0(%esi),%esi

00003160 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	57                   	push   %edi
    3164:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3167:	8b 4d 10             	mov    0x10(%ebp),%ecx
    316a:	8b 45 0c             	mov    0xc(%ebp),%eax
    316d:	89 d7                	mov    %edx,%edi
    316f:	fc                   	cld    
    3170:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3172:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3175:	89 d0                	mov    %edx,%eax
    3177:	c9                   	leave  
    3178:	c3                   	ret    
    3179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003180 <strchr>:

char*
strchr(const char *s, char c)
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	8b 45 08             	mov    0x8(%ebp),%eax
    3186:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    318a:	0f b6 10             	movzbl (%eax),%edx
    318d:	84 d2                	test   %dl,%dl
    318f:	75 12                	jne    31a3 <strchr+0x23>
    3191:	eb 1d                	jmp    31b0 <strchr+0x30>
    3193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3197:	90                   	nop
    3198:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    319c:	83 c0 01             	add    $0x1,%eax
    319f:	84 d2                	test   %dl,%dl
    31a1:	74 0d                	je     31b0 <strchr+0x30>
    if(*s == c)
    31a3:	38 d1                	cmp    %dl,%cl
    31a5:	75 f1                	jne    3198 <strchr+0x18>
      return (char*)s;
  return 0;
}
    31a7:	5d                   	pop    %ebp
    31a8:	c3                   	ret    
    31a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    31b0:	31 c0                	xor    %eax,%eax
}
    31b2:	5d                   	pop    %ebp
    31b3:	c3                   	ret    
    31b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31bf:	90                   	nop

000031c0 <gets>:

char*
gets(char *buf, int max)
{
    31c0:	55                   	push   %ebp
    31c1:	89 e5                	mov    %esp,%ebp
    31c3:	57                   	push   %edi
    31c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    31c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    31c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    31c9:	31 db                	xor    %ebx,%ebx
{
    31cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    31ce:	eb 27                	jmp    31f7 <gets+0x37>
    cc = read(0, &c, 1);
    31d0:	83 ec 04             	sub    $0x4,%esp
    31d3:	6a 01                	push   $0x1
    31d5:	57                   	push   %edi
    31d6:	6a 00                	push   $0x0
    31d8:	e8 2e 01 00 00       	call   330b <read>
    if(cc < 1)
    31dd:	83 c4 10             	add    $0x10,%esp
    31e0:	85 c0                	test   %eax,%eax
    31e2:	7e 1d                	jle    3201 <gets+0x41>
      break;
    buf[i++] = c;
    31e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    31e8:	8b 55 08             	mov    0x8(%ebp),%edx
    31eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    31ef:	3c 0a                	cmp    $0xa,%al
    31f1:	74 1d                	je     3210 <gets+0x50>
    31f3:	3c 0d                	cmp    $0xd,%al
    31f5:	74 19                	je     3210 <gets+0x50>
  for(i=0; i+1 < max; ){
    31f7:	89 de                	mov    %ebx,%esi
    31f9:	83 c3 01             	add    $0x1,%ebx
    31fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    31ff:	7c cf                	jl     31d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3201:	8b 45 08             	mov    0x8(%ebp),%eax
    3204:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3208:	8d 65 f4             	lea    -0xc(%ebp),%esp
    320b:	5b                   	pop    %ebx
    320c:	5e                   	pop    %esi
    320d:	5f                   	pop    %edi
    320e:	5d                   	pop    %ebp
    320f:	c3                   	ret    
  buf[i] = '\0';
    3210:	8b 45 08             	mov    0x8(%ebp),%eax
    3213:	89 de                	mov    %ebx,%esi
    3215:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3219:	8d 65 f4             	lea    -0xc(%ebp),%esp
    321c:	5b                   	pop    %ebx
    321d:	5e                   	pop    %esi
    321e:	5f                   	pop    %edi
    321f:	5d                   	pop    %ebp
    3220:	c3                   	ret    
    3221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    322f:	90                   	nop

00003230 <stat>:

int
stat(const char *n, struct stat *st)
{
    3230:	55                   	push   %ebp
    3231:	89 e5                	mov    %esp,%ebp
    3233:	56                   	push   %esi
    3234:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3235:	83 ec 08             	sub    $0x8,%esp
    3238:	6a 00                	push   $0x0
    323a:	ff 75 08             	push   0x8(%ebp)
    323d:	e8 f1 00 00 00       	call   3333 <open>
  if(fd < 0)
    3242:	83 c4 10             	add    $0x10,%esp
    3245:	85 c0                	test   %eax,%eax
    3247:	78 27                	js     3270 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3249:	83 ec 08             	sub    $0x8,%esp
    324c:	ff 75 0c             	push   0xc(%ebp)
    324f:	89 c3                	mov    %eax,%ebx
    3251:	50                   	push   %eax
    3252:	e8 f4 00 00 00       	call   334b <fstat>
  close(fd);
    3257:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    325a:	89 c6                	mov    %eax,%esi
  close(fd);
    325c:	e8 ba 00 00 00       	call   331b <close>
  return r;
    3261:	83 c4 10             	add    $0x10,%esp
}
    3264:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3267:	89 f0                	mov    %esi,%eax
    3269:	5b                   	pop    %ebx
    326a:	5e                   	pop    %esi
    326b:	5d                   	pop    %ebp
    326c:	c3                   	ret    
    326d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3270:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3275:	eb ed                	jmp    3264 <stat+0x34>
    3277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    327e:	66 90                	xchg   %ax,%ax

00003280 <atoi>:

int
atoi(const char *s)
{
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	53                   	push   %ebx
    3284:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3287:	0f be 02             	movsbl (%edx),%eax
    328a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    328d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3290:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3295:	77 1e                	ja     32b5 <atoi+0x35>
    3297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    32a0:	83 c2 01             	add    $0x1,%edx
    32a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    32a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    32aa:	0f be 02             	movsbl (%edx),%eax
    32ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
    32b0:	80 fb 09             	cmp    $0x9,%bl
    32b3:	76 eb                	jbe    32a0 <atoi+0x20>
  return n;
}
    32b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    32b8:	89 c8                	mov    %ecx,%eax
    32ba:	c9                   	leave  
    32bb:	c3                   	ret    
    32bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000032c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32c0:	55                   	push   %ebp
    32c1:	89 e5                	mov    %esp,%ebp
    32c3:	57                   	push   %edi
    32c4:	8b 45 10             	mov    0x10(%ebp),%eax
    32c7:	8b 55 08             	mov    0x8(%ebp),%edx
    32ca:	56                   	push   %esi
    32cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    32ce:	85 c0                	test   %eax,%eax
    32d0:	7e 13                	jle    32e5 <memmove+0x25>
    32d2:	01 d0                	add    %edx,%eax
  dst = vdst;
    32d4:	89 d7                	mov    %edx,%edi
    32d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    32e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    32e1:	39 f8                	cmp    %edi,%eax
    32e3:	75 fb                	jne    32e0 <memmove+0x20>
  return vdst;
}
    32e5:	5e                   	pop    %esi
    32e6:	89 d0                	mov    %edx,%eax
    32e8:	5f                   	pop    %edi
    32e9:	5d                   	pop    %ebp
    32ea:	c3                   	ret    

000032eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    32eb:	b8 01 00 00 00       	mov    $0x1,%eax
    32f0:	cd 40                	int    $0x40
    32f2:	c3                   	ret    

000032f3 <exit>:
SYSCALL(exit)
    32f3:	b8 02 00 00 00       	mov    $0x2,%eax
    32f8:	cd 40                	int    $0x40
    32fa:	c3                   	ret    

000032fb <wait>:
SYSCALL(wait)
    32fb:	b8 03 00 00 00       	mov    $0x3,%eax
    3300:	cd 40                	int    $0x40
    3302:	c3                   	ret    

00003303 <pipe>:
SYSCALL(pipe)
    3303:	b8 04 00 00 00       	mov    $0x4,%eax
    3308:	cd 40                	int    $0x40
    330a:	c3                   	ret    

0000330b <read>:
SYSCALL(read)
    330b:	b8 05 00 00 00       	mov    $0x5,%eax
    3310:	cd 40                	int    $0x40
    3312:	c3                   	ret    

00003313 <write>:
SYSCALL(write)
    3313:	b8 10 00 00 00       	mov    $0x10,%eax
    3318:	cd 40                	int    $0x40
    331a:	c3                   	ret    

0000331b <close>:
SYSCALL(close)
    331b:	b8 15 00 00 00       	mov    $0x15,%eax
    3320:	cd 40                	int    $0x40
    3322:	c3                   	ret    

00003323 <kill>:
SYSCALL(kill)
    3323:	b8 06 00 00 00       	mov    $0x6,%eax
    3328:	cd 40                	int    $0x40
    332a:	c3                   	ret    

0000332b <exec>:
SYSCALL(exec)
    332b:	b8 07 00 00 00       	mov    $0x7,%eax
    3330:	cd 40                	int    $0x40
    3332:	c3                   	ret    

00003333 <open>:
SYSCALL(open)
    3333:	b8 0f 00 00 00       	mov    $0xf,%eax
    3338:	cd 40                	int    $0x40
    333a:	c3                   	ret    

0000333b <mknod>:
SYSCALL(mknod)
    333b:	b8 11 00 00 00       	mov    $0x11,%eax
    3340:	cd 40                	int    $0x40
    3342:	c3                   	ret    

00003343 <unlink>:
SYSCALL(unlink)
    3343:	b8 12 00 00 00       	mov    $0x12,%eax
    3348:	cd 40                	int    $0x40
    334a:	c3                   	ret    

0000334b <fstat>:
SYSCALL(fstat)
    334b:	b8 08 00 00 00       	mov    $0x8,%eax
    3350:	cd 40                	int    $0x40
    3352:	c3                   	ret    

00003353 <link>:
SYSCALL(link)
    3353:	b8 13 00 00 00       	mov    $0x13,%eax
    3358:	cd 40                	int    $0x40
    335a:	c3                   	ret    

0000335b <mkdir>:
SYSCALL(mkdir)
    335b:	b8 14 00 00 00       	mov    $0x14,%eax
    3360:	cd 40                	int    $0x40
    3362:	c3                   	ret    

00003363 <chdir>:
SYSCALL(chdir)
    3363:	b8 09 00 00 00       	mov    $0x9,%eax
    3368:	cd 40                	int    $0x40
    336a:	c3                   	ret    

0000336b <dup>:
SYSCALL(dup)
    336b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3370:	cd 40                	int    $0x40
    3372:	c3                   	ret    

00003373 <getpid>:
SYSCALL(getpid)
    3373:	b8 0b 00 00 00       	mov    $0xb,%eax
    3378:	cd 40                	int    $0x40
    337a:	c3                   	ret    

0000337b <sbrk>:
SYSCALL(sbrk)
    337b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3380:	cd 40                	int    $0x40
    3382:	c3                   	ret    

00003383 <sleep>:
SYSCALL(sleep)
    3383:	b8 0d 00 00 00       	mov    $0xd,%eax
    3388:	cd 40                	int    $0x40
    338a:	c3                   	ret    

0000338b <uptime>:
SYSCALL(uptime)
    338b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3390:	cd 40                	int    $0x40
    3392:	c3                   	ret    

00003393 <uniq>:
SYSCALL(uniq)
    3393:	b8 16 00 00 00       	mov    $0x16,%eax
    3398:	cd 40                	int    $0x40
    339a:	c3                   	ret    

0000339b <head>:
SYSCALL(head)
    339b:	b8 17 00 00 00       	mov    $0x17,%eax
    33a0:	cd 40                	int    $0x40
    33a2:	c3                   	ret    

000033a3 <ps>:
    33a3:	b8 18 00 00 00       	mov    $0x18,%eax
    33a8:	cd 40                	int    $0x40
    33aa:	c3                   	ret    
    33ab:	66 90                	xchg   %ax,%ax
    33ad:	66 90                	xchg   %ax,%ax
    33af:	90                   	nop

000033b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    33b0:	55                   	push   %ebp
    33b1:	89 e5                	mov    %esp,%ebp
    33b3:	57                   	push   %edi
    33b4:	56                   	push   %esi
    33b5:	53                   	push   %ebx
    33b6:	83 ec 3c             	sub    $0x3c,%esp
    33b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    33bc:	89 d1                	mov    %edx,%ecx
{
    33be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    33c1:	85 d2                	test   %edx,%edx
    33c3:	0f 89 7f 00 00 00    	jns    3448 <printint+0x98>
    33c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    33cd:	74 79                	je     3448 <printint+0x98>
    neg = 1;
    33cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    33d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    33d8:	31 db                	xor    %ebx,%ebx
    33da:	8d 75 d7             	lea    -0x29(%ebp),%esi
    33dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    33e0:	89 c8                	mov    %ecx,%eax
    33e2:	31 d2                	xor    %edx,%edx
    33e4:	89 cf                	mov    %ecx,%edi
    33e6:	f7 75 c4             	divl   -0x3c(%ebp)
    33e9:	0f b6 92 e8 37 00 00 	movzbl 0x37e8(%edx),%edx
    33f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    33f3:	89 d8                	mov    %ebx,%eax
    33f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    33f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    33fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    33fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3401:	76 dd                	jbe    33e0 <printint+0x30>
  if(neg)
    3403:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3406:	85 c9                	test   %ecx,%ecx
    3408:	74 0c                	je     3416 <printint+0x66>
    buf[i++] = '-';
    340a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    340f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3411:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3416:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3419:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    341d:	eb 07                	jmp    3426 <printint+0x76>
    341f:	90                   	nop
    putc(fd, buf[i]);
    3420:	0f b6 13             	movzbl (%ebx),%edx
    3423:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3426:	83 ec 04             	sub    $0x4,%esp
    3429:	88 55 d7             	mov    %dl,-0x29(%ebp)
    342c:	6a 01                	push   $0x1
    342e:	56                   	push   %esi
    342f:	57                   	push   %edi
    3430:	e8 de fe ff ff       	call   3313 <write>
  while(--i >= 0)
    3435:	83 c4 10             	add    $0x10,%esp
    3438:	39 de                	cmp    %ebx,%esi
    343a:	75 e4                	jne    3420 <printint+0x70>
}
    343c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    343f:	5b                   	pop    %ebx
    3440:	5e                   	pop    %esi
    3441:	5f                   	pop    %edi
    3442:	5d                   	pop    %ebp
    3443:	c3                   	ret    
    3444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3448:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    344f:	eb 87                	jmp    33d8 <printint+0x28>
    3451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    345f:	90                   	nop

00003460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3460:	55                   	push   %ebp
    3461:	89 e5                	mov    %esp,%ebp
    3463:	57                   	push   %edi
    3464:	56                   	push   %esi
    3465:	53                   	push   %ebx
    3466:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3469:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    346c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    346f:	0f b6 13             	movzbl (%ebx),%edx
    3472:	84 d2                	test   %dl,%dl
    3474:	74 6a                	je     34e0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3476:	8d 45 10             	lea    0x10(%ebp),%eax
    3479:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    347c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    347f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3481:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3484:	eb 36                	jmp    34bc <printf+0x5c>
    3486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    348d:	8d 76 00             	lea    0x0(%esi),%esi
    3490:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3493:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3498:	83 f8 25             	cmp    $0x25,%eax
    349b:	74 15                	je     34b2 <printf+0x52>
  write(fd, &c, 1);
    349d:	83 ec 04             	sub    $0x4,%esp
    34a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    34a3:	6a 01                	push   $0x1
    34a5:	57                   	push   %edi
    34a6:	56                   	push   %esi
    34a7:	e8 67 fe ff ff       	call   3313 <write>
    34ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    34af:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    34b2:	0f b6 13             	movzbl (%ebx),%edx
    34b5:	83 c3 01             	add    $0x1,%ebx
    34b8:	84 d2                	test   %dl,%dl
    34ba:	74 24                	je     34e0 <printf+0x80>
    c = fmt[i] & 0xff;
    34bc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    34bf:	85 c9                	test   %ecx,%ecx
    34c1:	74 cd                	je     3490 <printf+0x30>
      }
    } else if(state == '%'){
    34c3:	83 f9 25             	cmp    $0x25,%ecx
    34c6:	75 ea                	jne    34b2 <printf+0x52>
      if(c == 'd'){
    34c8:	83 f8 25             	cmp    $0x25,%eax
    34cb:	0f 84 07 01 00 00    	je     35d8 <printf+0x178>
    34d1:	83 e8 63             	sub    $0x63,%eax
    34d4:	83 f8 15             	cmp    $0x15,%eax
    34d7:	77 17                	ja     34f0 <printf+0x90>
    34d9:	ff 24 85 90 37 00 00 	jmp    *0x3790(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    34e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34e3:	5b                   	pop    %ebx
    34e4:	5e                   	pop    %esi
    34e5:	5f                   	pop    %edi
    34e6:	5d                   	pop    %ebp
    34e7:	c3                   	ret    
    34e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34ef:	90                   	nop
  write(fd, &c, 1);
    34f0:	83 ec 04             	sub    $0x4,%esp
    34f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    34f6:	6a 01                	push   $0x1
    34f8:	57                   	push   %edi
    34f9:	56                   	push   %esi
    34fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    34fe:	e8 10 fe ff ff       	call   3313 <write>
        putc(fd, c);
    3503:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3507:	83 c4 0c             	add    $0xc,%esp
    350a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    350d:	6a 01                	push   $0x1
    350f:	57                   	push   %edi
    3510:	56                   	push   %esi
    3511:	e8 fd fd ff ff       	call   3313 <write>
        putc(fd, c);
    3516:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3519:	31 c9                	xor    %ecx,%ecx
    351b:	eb 95                	jmp    34b2 <printf+0x52>
    351d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3520:	83 ec 0c             	sub    $0xc,%esp
    3523:	b9 10 00 00 00       	mov    $0x10,%ecx
    3528:	6a 00                	push   $0x0
    352a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    352d:	8b 10                	mov    (%eax),%edx
    352f:	89 f0                	mov    %esi,%eax
    3531:	e8 7a fe ff ff       	call   33b0 <printint>
        ap++;
    3536:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    353a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    353d:	31 c9                	xor    %ecx,%ecx
    353f:	e9 6e ff ff ff       	jmp    34b2 <printf+0x52>
    3544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3548:	8b 45 d0             	mov    -0x30(%ebp),%eax
    354b:	8b 10                	mov    (%eax),%edx
        ap++;
    354d:	83 c0 04             	add    $0x4,%eax
    3550:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3553:	85 d2                	test   %edx,%edx
    3555:	0f 84 8d 00 00 00    	je     35e8 <printf+0x188>
        while(*s != 0){
    355b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    355e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3560:	84 c0                	test   %al,%al
    3562:	0f 84 4a ff ff ff    	je     34b2 <printf+0x52>
    3568:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    356b:	89 d3                	mov    %edx,%ebx
    356d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3570:	83 ec 04             	sub    $0x4,%esp
          s++;
    3573:	83 c3 01             	add    $0x1,%ebx
    3576:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3579:	6a 01                	push   $0x1
    357b:	57                   	push   %edi
    357c:	56                   	push   %esi
    357d:	e8 91 fd ff ff       	call   3313 <write>
        while(*s != 0){
    3582:	0f b6 03             	movzbl (%ebx),%eax
    3585:	83 c4 10             	add    $0x10,%esp
    3588:	84 c0                	test   %al,%al
    358a:	75 e4                	jne    3570 <printf+0x110>
      state = 0;
    358c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    358f:	31 c9                	xor    %ecx,%ecx
    3591:	e9 1c ff ff ff       	jmp    34b2 <printf+0x52>
    3596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    359d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    35a0:	83 ec 0c             	sub    $0xc,%esp
    35a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    35a8:	6a 01                	push   $0x1
    35aa:	e9 7b ff ff ff       	jmp    352a <printf+0xca>
    35af:	90                   	nop
        putc(fd, *ap);
    35b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    35b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    35b6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    35b8:	6a 01                	push   $0x1
    35ba:	57                   	push   %edi
    35bb:	56                   	push   %esi
        putc(fd, *ap);
    35bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    35bf:	e8 4f fd ff ff       	call   3313 <write>
        ap++;
    35c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    35c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    35cb:	31 c9                	xor    %ecx,%ecx
    35cd:	e9 e0 fe ff ff       	jmp    34b2 <printf+0x52>
    35d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    35d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    35db:	83 ec 04             	sub    $0x4,%esp
    35de:	e9 2a ff ff ff       	jmp    350d <printf+0xad>
    35e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    35e7:	90                   	nop
          s = "(null)";
    35e8:	ba 88 37 00 00       	mov    $0x3788,%edx
        while(*s != 0){
    35ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    35f0:	b8 28 00 00 00       	mov    $0x28,%eax
    35f5:	89 d3                	mov    %edx,%ebx
    35f7:	e9 74 ff ff ff       	jmp    3570 <printf+0x110>
    35fc:	66 90                	xchg   %ax,%ax
    35fe:	66 90                	xchg   %ax,%ax

00003600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3601:	a1 9c 3a 00 00       	mov    0x3a9c,%eax
{
    3606:	89 e5                	mov    %esp,%ebp
    3608:	57                   	push   %edi
    3609:	56                   	push   %esi
    360a:	53                   	push   %ebx
    360b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    360e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3618:	89 c2                	mov    %eax,%edx
    361a:	8b 00                	mov    (%eax),%eax
    361c:	39 ca                	cmp    %ecx,%edx
    361e:	73 30                	jae    3650 <free+0x50>
    3620:	39 c1                	cmp    %eax,%ecx
    3622:	72 04                	jb     3628 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3624:	39 c2                	cmp    %eax,%edx
    3626:	72 f0                	jb     3618 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3628:	8b 73 fc             	mov    -0x4(%ebx),%esi
    362b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    362e:	39 f8                	cmp    %edi,%eax
    3630:	74 30                	je     3662 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3632:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3635:	8b 42 04             	mov    0x4(%edx),%eax
    3638:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    363b:	39 f1                	cmp    %esi,%ecx
    363d:	74 3a                	je     3679 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    363f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3641:	5b                   	pop    %ebx
  freep = p;
    3642:	89 15 9c 3a 00 00    	mov    %edx,0x3a9c
}
    3648:	5e                   	pop    %esi
    3649:	5f                   	pop    %edi
    364a:	5d                   	pop    %ebp
    364b:	c3                   	ret    
    364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3650:	39 c2                	cmp    %eax,%edx
    3652:	72 c4                	jb     3618 <free+0x18>
    3654:	39 c1                	cmp    %eax,%ecx
    3656:	73 c0                	jae    3618 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3658:	8b 73 fc             	mov    -0x4(%ebx),%esi
    365b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    365e:	39 f8                	cmp    %edi,%eax
    3660:	75 d0                	jne    3632 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3662:	03 70 04             	add    0x4(%eax),%esi
    3665:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3668:	8b 02                	mov    (%edx),%eax
    366a:	8b 00                	mov    (%eax),%eax
    366c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    366f:	8b 42 04             	mov    0x4(%edx),%eax
    3672:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3675:	39 f1                	cmp    %esi,%ecx
    3677:	75 c6                	jne    363f <free+0x3f>
    p->s.size += bp->s.size;
    3679:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    367c:	89 15 9c 3a 00 00    	mov    %edx,0x3a9c
    p->s.size += bp->s.size;
    3682:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3685:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3688:	89 0a                	mov    %ecx,(%edx)
}
    368a:	5b                   	pop    %ebx
    368b:	5e                   	pop    %esi
    368c:	5f                   	pop    %edi
    368d:	5d                   	pop    %ebp
    368e:	c3                   	ret    
    368f:	90                   	nop

00003690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3690:	55                   	push   %ebp
    3691:	89 e5                	mov    %esp,%ebp
    3693:	57                   	push   %edi
    3694:	56                   	push   %esi
    3695:	53                   	push   %ebx
    3696:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    369c:	8b 3d 9c 3a 00 00    	mov    0x3a9c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    36a2:	8d 70 07             	lea    0x7(%eax),%esi
    36a5:	c1 ee 03             	shr    $0x3,%esi
    36a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    36ab:	85 ff                	test   %edi,%edi
    36ad:	0f 84 9d 00 00 00    	je     3750 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    36b3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    36b5:	8b 4a 04             	mov    0x4(%edx),%ecx
    36b8:	39 f1                	cmp    %esi,%ecx
    36ba:	73 6a                	jae    3726 <malloc+0x96>
    36bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    36c1:	39 de                	cmp    %ebx,%esi
    36c3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    36c6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    36cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    36d0:	eb 17                	jmp    36e9 <malloc+0x59>
    36d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    36d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    36da:	8b 48 04             	mov    0x4(%eax),%ecx
    36dd:	39 f1                	cmp    %esi,%ecx
    36df:	73 4f                	jae    3730 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    36e1:	8b 3d 9c 3a 00 00    	mov    0x3a9c,%edi
    36e7:	89 c2                	mov    %eax,%edx
    36e9:	39 d7                	cmp    %edx,%edi
    36eb:	75 eb                	jne    36d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    36ed:	83 ec 0c             	sub    $0xc,%esp
    36f0:	ff 75 e4             	push   -0x1c(%ebp)
    36f3:	e8 83 fc ff ff       	call   337b <sbrk>
  if(p == (char*)-1)
    36f8:	83 c4 10             	add    $0x10,%esp
    36fb:	83 f8 ff             	cmp    $0xffffffff,%eax
    36fe:	74 1c                	je     371c <malloc+0x8c>
  hp->s.size = nu;
    3700:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3703:	83 ec 0c             	sub    $0xc,%esp
    3706:	83 c0 08             	add    $0x8,%eax
    3709:	50                   	push   %eax
    370a:	e8 f1 fe ff ff       	call   3600 <free>
  return freep;
    370f:	8b 15 9c 3a 00 00    	mov    0x3a9c,%edx
      if((p = morecore(nunits)) == 0)
    3715:	83 c4 10             	add    $0x10,%esp
    3718:	85 d2                	test   %edx,%edx
    371a:	75 bc                	jne    36d8 <malloc+0x48>
        return 0;
  }
}
    371c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    371f:	31 c0                	xor    %eax,%eax
}
    3721:	5b                   	pop    %ebx
    3722:	5e                   	pop    %esi
    3723:	5f                   	pop    %edi
    3724:	5d                   	pop    %ebp
    3725:	c3                   	ret    
    if(p->s.size >= nunits){
    3726:	89 d0                	mov    %edx,%eax
    3728:	89 fa                	mov    %edi,%edx
    372a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3730:	39 ce                	cmp    %ecx,%esi
    3732:	74 4c                	je     3780 <malloc+0xf0>
        p->s.size -= nunits;
    3734:	29 f1                	sub    %esi,%ecx
    3736:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3739:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    373c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    373f:	89 15 9c 3a 00 00    	mov    %edx,0x3a9c
}
    3745:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3748:	83 c0 08             	add    $0x8,%eax
}
    374b:	5b                   	pop    %ebx
    374c:	5e                   	pop    %esi
    374d:	5f                   	pop    %edi
    374e:	5d                   	pop    %ebp
    374f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3750:	c7 05 9c 3a 00 00 a0 	movl   $0x3aa0,0x3a9c
    3757:	3a 00 00 
    base.s.size = 0;
    375a:	bf a0 3a 00 00       	mov    $0x3aa0,%edi
    base.s.ptr = freep = prevp = &base;
    375f:	c7 05 a0 3a 00 00 a0 	movl   $0x3aa0,0x3aa0
    3766:	3a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3769:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    376b:	c7 05 a4 3a 00 00 00 	movl   $0x0,0x3aa4
    3772:	00 00 00 
    if(p->s.size >= nunits){
    3775:	e9 42 ff ff ff       	jmp    36bc <malloc+0x2c>
    377a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3780:	8b 08                	mov    (%eax),%ecx
    3782:	89 0a                	mov    %ecx,(%edx)
    3784:	eb b9                	jmp    373f <malloc+0xaf>
