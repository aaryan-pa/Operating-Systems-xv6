
_ps:     file format elf32-i386


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
    300d:	51                   	push   %ecx
    300e:	83 ec 04             	sub    $0x4,%esp
if(argc == 1)
    3011:	83 39 01             	cmpl   $0x1,(%ecx)
int main(int argc,char* argv[]){
    3014:	8b 41 04             	mov    0x4(%ecx),%eax
if(argc == 1)
    3017:	74 13                	je     302c <main+0x2c>
ps("");
else
ps(argv[1]);
    3019:	83 ec 0c             	sub    $0xc,%esp
    301c:	ff 70 04             	push   0x4(%eax)
    301f:	e8 1f 03 00 00       	call   3343 <ps>
    3024:	83 c4 10             	add    $0x10,%esp
exit();
    3027:	e8 67 02 00 00       	call   3293 <exit>
ps("");
    302c:	83 ec 0c             	sub    $0xc,%esp
    302f:	68 2e 37 00 00       	push   $0x372e
    3034:	e8 0a 03 00 00       	call   3343 <ps>
    3039:	83 c4 10             	add    $0x10,%esp
    303c:	eb e9                	jmp    3027 <main+0x27>
    303e:	66 90                	xchg   %ax,%ax

00003040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3040:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3041:	31 c0                	xor    %eax,%eax
{
    3043:	89 e5                	mov    %esp,%ebp
    3045:	53                   	push   %ebx
    3046:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3049:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    304c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3050:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3054:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3057:	83 c0 01             	add    $0x1,%eax
    305a:	84 d2                	test   %dl,%dl
    305c:	75 f2                	jne    3050 <strcpy+0x10>
    ;
  return os;
}
    305e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3061:	89 c8                	mov    %ecx,%eax
    3063:	c9                   	leave  
    3064:	c3                   	ret    
    3065:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    306c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3070:	55                   	push   %ebp
    3071:	89 e5                	mov    %esp,%ebp
    3073:	53                   	push   %ebx
    3074:	8b 55 08             	mov    0x8(%ebp),%edx
    3077:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    307a:	0f b6 02             	movzbl (%edx),%eax
    307d:	84 c0                	test   %al,%al
    307f:	75 17                	jne    3098 <strcmp+0x28>
    3081:	eb 3a                	jmp    30bd <strcmp+0x4d>
    3083:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3087:	90                   	nop
    3088:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    308c:	83 c2 01             	add    $0x1,%edx
    308f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3092:	84 c0                	test   %al,%al
    3094:	74 1a                	je     30b0 <strcmp+0x40>
    p++, q++;
    3096:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3098:	0f b6 19             	movzbl (%ecx),%ebx
    309b:	38 c3                	cmp    %al,%bl
    309d:	74 e9                	je     3088 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    309f:	29 d8                	sub    %ebx,%eax
}
    30a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30a4:	c9                   	leave  
    30a5:	c3                   	ret    
    30a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30ad:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    30b0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    30b4:	31 c0                	xor    %eax,%eax
    30b6:	29 d8                	sub    %ebx,%eax
}
    30b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30bb:	c9                   	leave  
    30bc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    30bd:	0f b6 19             	movzbl (%ecx),%ebx
    30c0:	31 c0                	xor    %eax,%eax
    30c2:	eb db                	jmp    309f <strcmp+0x2f>
    30c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30cf:	90                   	nop

000030d0 <strlen>:

uint
strlen(const char *s)
{
    30d0:	55                   	push   %ebp
    30d1:	89 e5                	mov    %esp,%ebp
    30d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    30d6:	80 3a 00             	cmpb   $0x0,(%edx)
    30d9:	74 15                	je     30f0 <strlen+0x20>
    30db:	31 c0                	xor    %eax,%eax
    30dd:	8d 76 00             	lea    0x0(%esi),%esi
    30e0:	83 c0 01             	add    $0x1,%eax
    30e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    30e7:	89 c1                	mov    %eax,%ecx
    30e9:	75 f5                	jne    30e0 <strlen+0x10>
    ;
  return n;
}
    30eb:	89 c8                	mov    %ecx,%eax
    30ed:	5d                   	pop    %ebp
    30ee:	c3                   	ret    
    30ef:	90                   	nop
  for(n = 0; s[n]; n++)
    30f0:	31 c9                	xor    %ecx,%ecx
}
    30f2:	5d                   	pop    %ebp
    30f3:	89 c8                	mov    %ecx,%eax
    30f5:	c3                   	ret    
    30f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30fd:	8d 76 00             	lea    0x0(%esi),%esi

00003100 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3100:	55                   	push   %ebp
    3101:	89 e5                	mov    %esp,%ebp
    3103:	57                   	push   %edi
    3104:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3107:	8b 4d 10             	mov    0x10(%ebp),%ecx
    310a:	8b 45 0c             	mov    0xc(%ebp),%eax
    310d:	89 d7                	mov    %edx,%edi
    310f:	fc                   	cld    
    3110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3112:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3115:	89 d0                	mov    %edx,%eax
    3117:	c9                   	leave  
    3118:	c3                   	ret    
    3119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003120 <strchr>:

char*
strchr(const char *s, char c)
{
    3120:	55                   	push   %ebp
    3121:	89 e5                	mov    %esp,%ebp
    3123:	8b 45 08             	mov    0x8(%ebp),%eax
    3126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    312a:	0f b6 10             	movzbl (%eax),%edx
    312d:	84 d2                	test   %dl,%dl
    312f:	75 12                	jne    3143 <strchr+0x23>
    3131:	eb 1d                	jmp    3150 <strchr+0x30>
    3133:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3137:	90                   	nop
    3138:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    313c:	83 c0 01             	add    $0x1,%eax
    313f:	84 d2                	test   %dl,%dl
    3141:	74 0d                	je     3150 <strchr+0x30>
    if(*s == c)
    3143:	38 d1                	cmp    %dl,%cl
    3145:	75 f1                	jne    3138 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3147:	5d                   	pop    %ebp
    3148:	c3                   	ret    
    3149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3150:	31 c0                	xor    %eax,%eax
}
    3152:	5d                   	pop    %ebp
    3153:	c3                   	ret    
    3154:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    315b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    315f:	90                   	nop

00003160 <gets>:

char*
gets(char *buf, int max)
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	57                   	push   %edi
    3164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3165:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3168:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3169:	31 db                	xor    %ebx,%ebx
{
    316b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    316e:	eb 27                	jmp    3197 <gets+0x37>
    cc = read(0, &c, 1);
    3170:	83 ec 04             	sub    $0x4,%esp
    3173:	6a 01                	push   $0x1
    3175:	57                   	push   %edi
    3176:	6a 00                	push   $0x0
    3178:	e8 2e 01 00 00       	call   32ab <read>
    if(cc < 1)
    317d:	83 c4 10             	add    $0x10,%esp
    3180:	85 c0                	test   %eax,%eax
    3182:	7e 1d                	jle    31a1 <gets+0x41>
      break;
    buf[i++] = c;
    3184:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3188:	8b 55 08             	mov    0x8(%ebp),%edx
    318b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    318f:	3c 0a                	cmp    $0xa,%al
    3191:	74 1d                	je     31b0 <gets+0x50>
    3193:	3c 0d                	cmp    $0xd,%al
    3195:	74 19                	je     31b0 <gets+0x50>
  for(i=0; i+1 < max; ){
    3197:	89 de                	mov    %ebx,%esi
    3199:	83 c3 01             	add    $0x1,%ebx
    319c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    319f:	7c cf                	jl     3170 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    31a1:	8b 45 08             	mov    0x8(%ebp),%eax
    31a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    31a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31ab:	5b                   	pop    %ebx
    31ac:	5e                   	pop    %esi
    31ad:	5f                   	pop    %edi
    31ae:	5d                   	pop    %ebp
    31af:	c3                   	ret    
  buf[i] = '\0';
    31b0:	8b 45 08             	mov    0x8(%ebp),%eax
    31b3:	89 de                	mov    %ebx,%esi
    31b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    31b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31bc:	5b                   	pop    %ebx
    31bd:	5e                   	pop    %esi
    31be:	5f                   	pop    %edi
    31bf:	5d                   	pop    %ebp
    31c0:	c3                   	ret    
    31c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31cf:	90                   	nop

000031d0 <stat>:

int
stat(const char *n, struct stat *st)
{
    31d0:	55                   	push   %ebp
    31d1:	89 e5                	mov    %esp,%ebp
    31d3:	56                   	push   %esi
    31d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31d5:	83 ec 08             	sub    $0x8,%esp
    31d8:	6a 00                	push   $0x0
    31da:	ff 75 08             	push   0x8(%ebp)
    31dd:	e8 f1 00 00 00       	call   32d3 <open>
  if(fd < 0)
    31e2:	83 c4 10             	add    $0x10,%esp
    31e5:	85 c0                	test   %eax,%eax
    31e7:	78 27                	js     3210 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    31e9:	83 ec 08             	sub    $0x8,%esp
    31ec:	ff 75 0c             	push   0xc(%ebp)
    31ef:	89 c3                	mov    %eax,%ebx
    31f1:	50                   	push   %eax
    31f2:	e8 f4 00 00 00       	call   32eb <fstat>
  close(fd);
    31f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    31fa:	89 c6                	mov    %eax,%esi
  close(fd);
    31fc:	e8 ba 00 00 00       	call   32bb <close>
  return r;
    3201:	83 c4 10             	add    $0x10,%esp
}
    3204:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3207:	89 f0                	mov    %esi,%eax
    3209:	5b                   	pop    %ebx
    320a:	5e                   	pop    %esi
    320b:	5d                   	pop    %ebp
    320c:	c3                   	ret    
    320d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3210:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3215:	eb ed                	jmp    3204 <stat+0x34>
    3217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    321e:	66 90                	xchg   %ax,%ax

00003220 <atoi>:

int
atoi(const char *s)
{
    3220:	55                   	push   %ebp
    3221:	89 e5                	mov    %esp,%ebp
    3223:	53                   	push   %ebx
    3224:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3227:	0f be 02             	movsbl (%edx),%eax
    322a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    322d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3230:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3235:	77 1e                	ja     3255 <atoi+0x35>
    3237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    323e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3240:	83 c2 01             	add    $0x1,%edx
    3243:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3246:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    324a:	0f be 02             	movsbl (%edx),%eax
    324d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3250:	80 fb 09             	cmp    $0x9,%bl
    3253:	76 eb                	jbe    3240 <atoi+0x20>
  return n;
}
    3255:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3258:	89 c8                	mov    %ecx,%eax
    325a:	c9                   	leave  
    325b:	c3                   	ret    
    325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3260:	55                   	push   %ebp
    3261:	89 e5                	mov    %esp,%ebp
    3263:	57                   	push   %edi
    3264:	8b 45 10             	mov    0x10(%ebp),%eax
    3267:	8b 55 08             	mov    0x8(%ebp),%edx
    326a:	56                   	push   %esi
    326b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    326e:	85 c0                	test   %eax,%eax
    3270:	7e 13                	jle    3285 <memmove+0x25>
    3272:	01 d0                	add    %edx,%eax
  dst = vdst;
    3274:	89 d7                	mov    %edx,%edi
    3276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    327d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3281:	39 f8                	cmp    %edi,%eax
    3283:	75 fb                	jne    3280 <memmove+0x20>
  return vdst;
}
    3285:	5e                   	pop    %esi
    3286:	89 d0                	mov    %edx,%eax
    3288:	5f                   	pop    %edi
    3289:	5d                   	pop    %ebp
    328a:	c3                   	ret    

0000328b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    328b:	b8 01 00 00 00       	mov    $0x1,%eax
    3290:	cd 40                	int    $0x40
    3292:	c3                   	ret    

00003293 <exit>:
SYSCALL(exit)
    3293:	b8 02 00 00 00       	mov    $0x2,%eax
    3298:	cd 40                	int    $0x40
    329a:	c3                   	ret    

0000329b <wait>:
SYSCALL(wait)
    329b:	b8 03 00 00 00       	mov    $0x3,%eax
    32a0:	cd 40                	int    $0x40
    32a2:	c3                   	ret    

000032a3 <pipe>:
SYSCALL(pipe)
    32a3:	b8 04 00 00 00       	mov    $0x4,%eax
    32a8:	cd 40                	int    $0x40
    32aa:	c3                   	ret    

000032ab <read>:
SYSCALL(read)
    32ab:	b8 05 00 00 00       	mov    $0x5,%eax
    32b0:	cd 40                	int    $0x40
    32b2:	c3                   	ret    

000032b3 <write>:
SYSCALL(write)
    32b3:	b8 10 00 00 00       	mov    $0x10,%eax
    32b8:	cd 40                	int    $0x40
    32ba:	c3                   	ret    

000032bb <close>:
SYSCALL(close)
    32bb:	b8 15 00 00 00       	mov    $0x15,%eax
    32c0:	cd 40                	int    $0x40
    32c2:	c3                   	ret    

000032c3 <kill>:
SYSCALL(kill)
    32c3:	b8 06 00 00 00       	mov    $0x6,%eax
    32c8:	cd 40                	int    $0x40
    32ca:	c3                   	ret    

000032cb <exec>:
SYSCALL(exec)
    32cb:	b8 07 00 00 00       	mov    $0x7,%eax
    32d0:	cd 40                	int    $0x40
    32d2:	c3                   	ret    

000032d3 <open>:
SYSCALL(open)
    32d3:	b8 0f 00 00 00       	mov    $0xf,%eax
    32d8:	cd 40                	int    $0x40
    32da:	c3                   	ret    

000032db <mknod>:
SYSCALL(mknod)
    32db:	b8 11 00 00 00       	mov    $0x11,%eax
    32e0:	cd 40                	int    $0x40
    32e2:	c3                   	ret    

000032e3 <unlink>:
SYSCALL(unlink)
    32e3:	b8 12 00 00 00       	mov    $0x12,%eax
    32e8:	cd 40                	int    $0x40
    32ea:	c3                   	ret    

000032eb <fstat>:
SYSCALL(fstat)
    32eb:	b8 08 00 00 00       	mov    $0x8,%eax
    32f0:	cd 40                	int    $0x40
    32f2:	c3                   	ret    

000032f3 <link>:
SYSCALL(link)
    32f3:	b8 13 00 00 00       	mov    $0x13,%eax
    32f8:	cd 40                	int    $0x40
    32fa:	c3                   	ret    

000032fb <mkdir>:
SYSCALL(mkdir)
    32fb:	b8 14 00 00 00       	mov    $0x14,%eax
    3300:	cd 40                	int    $0x40
    3302:	c3                   	ret    

00003303 <chdir>:
SYSCALL(chdir)
    3303:	b8 09 00 00 00       	mov    $0x9,%eax
    3308:	cd 40                	int    $0x40
    330a:	c3                   	ret    

0000330b <dup>:
SYSCALL(dup)
    330b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3310:	cd 40                	int    $0x40
    3312:	c3                   	ret    

00003313 <getpid>:
SYSCALL(getpid)
    3313:	b8 0b 00 00 00       	mov    $0xb,%eax
    3318:	cd 40                	int    $0x40
    331a:	c3                   	ret    

0000331b <sbrk>:
SYSCALL(sbrk)
    331b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3320:	cd 40                	int    $0x40
    3322:	c3                   	ret    

00003323 <sleep>:
SYSCALL(sleep)
    3323:	b8 0d 00 00 00       	mov    $0xd,%eax
    3328:	cd 40                	int    $0x40
    332a:	c3                   	ret    

0000332b <uptime>:
SYSCALL(uptime)
    332b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3330:	cd 40                	int    $0x40
    3332:	c3                   	ret    

00003333 <uniq>:
SYSCALL(uniq)
    3333:	b8 16 00 00 00       	mov    $0x16,%eax
    3338:	cd 40                	int    $0x40
    333a:	c3                   	ret    

0000333b <head>:
SYSCALL(head)
    333b:	b8 17 00 00 00       	mov    $0x17,%eax
    3340:	cd 40                	int    $0x40
    3342:	c3                   	ret    

00003343 <ps>:
    3343:	b8 18 00 00 00       	mov    $0x18,%eax
    3348:	cd 40                	int    $0x40
    334a:	c3                   	ret    
    334b:	66 90                	xchg   %ax,%ax
    334d:	66 90                	xchg   %ax,%ax
    334f:	90                   	nop

00003350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3350:	55                   	push   %ebp
    3351:	89 e5                	mov    %esp,%ebp
    3353:	57                   	push   %edi
    3354:	56                   	push   %esi
    3355:	53                   	push   %ebx
    3356:	83 ec 3c             	sub    $0x3c,%esp
    3359:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    335c:	89 d1                	mov    %edx,%ecx
{
    335e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3361:	85 d2                	test   %edx,%edx
    3363:	0f 89 7f 00 00 00    	jns    33e8 <printint+0x98>
    3369:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    336d:	74 79                	je     33e8 <printint+0x98>
    neg = 1;
    336f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3376:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3378:	31 db                	xor    %ebx,%ebx
    337a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    337d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3380:	89 c8                	mov    %ecx,%eax
    3382:	31 d2                	xor    %edx,%edx
    3384:	89 cf                	mov    %ecx,%edi
    3386:	f7 75 c4             	divl   -0x3c(%ebp)
    3389:	0f b6 92 88 37 00 00 	movzbl 0x3788(%edx),%edx
    3390:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3393:	89 d8                	mov    %ebx,%eax
    3395:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3398:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    339b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    339e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    33a1:	76 dd                	jbe    3380 <printint+0x30>
  if(neg)
    33a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    33a6:	85 c9                	test   %ecx,%ecx
    33a8:	74 0c                	je     33b6 <printint+0x66>
    buf[i++] = '-';
    33aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    33af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    33b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    33b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    33b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    33bd:	eb 07                	jmp    33c6 <printint+0x76>
    33bf:	90                   	nop
    putc(fd, buf[i]);
    33c0:	0f b6 13             	movzbl (%ebx),%edx
    33c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    33c6:	83 ec 04             	sub    $0x4,%esp
    33c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    33cc:	6a 01                	push   $0x1
    33ce:	56                   	push   %esi
    33cf:	57                   	push   %edi
    33d0:	e8 de fe ff ff       	call   32b3 <write>
  while(--i >= 0)
    33d5:	83 c4 10             	add    $0x10,%esp
    33d8:	39 de                	cmp    %ebx,%esi
    33da:	75 e4                	jne    33c0 <printint+0x70>
}
    33dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    33df:	5b                   	pop    %ebx
    33e0:	5e                   	pop    %esi
    33e1:	5f                   	pop    %edi
    33e2:	5d                   	pop    %ebp
    33e3:	c3                   	ret    
    33e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    33e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    33ef:	eb 87                	jmp    3378 <printint+0x28>
    33f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33ff:	90                   	nop

00003400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3400:	55                   	push   %ebp
    3401:	89 e5                	mov    %esp,%ebp
    3403:	57                   	push   %edi
    3404:	56                   	push   %esi
    3405:	53                   	push   %ebx
    3406:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3409:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    340c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    340f:	0f b6 13             	movzbl (%ebx),%edx
    3412:	84 d2                	test   %dl,%dl
    3414:	74 6a                	je     3480 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3416:	8d 45 10             	lea    0x10(%ebp),%eax
    3419:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    341c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    341f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3421:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3424:	eb 36                	jmp    345c <printf+0x5c>
    3426:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    342d:	8d 76 00             	lea    0x0(%esi),%esi
    3430:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3433:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3438:	83 f8 25             	cmp    $0x25,%eax
    343b:	74 15                	je     3452 <printf+0x52>
  write(fd, &c, 1);
    343d:	83 ec 04             	sub    $0x4,%esp
    3440:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3443:	6a 01                	push   $0x1
    3445:	57                   	push   %edi
    3446:	56                   	push   %esi
    3447:	e8 67 fe ff ff       	call   32b3 <write>
    344c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    344f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3452:	0f b6 13             	movzbl (%ebx),%edx
    3455:	83 c3 01             	add    $0x1,%ebx
    3458:	84 d2                	test   %dl,%dl
    345a:	74 24                	je     3480 <printf+0x80>
    c = fmt[i] & 0xff;
    345c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    345f:	85 c9                	test   %ecx,%ecx
    3461:	74 cd                	je     3430 <printf+0x30>
      }
    } else if(state == '%'){
    3463:	83 f9 25             	cmp    $0x25,%ecx
    3466:	75 ea                	jne    3452 <printf+0x52>
      if(c == 'd'){
    3468:	83 f8 25             	cmp    $0x25,%eax
    346b:	0f 84 07 01 00 00    	je     3578 <printf+0x178>
    3471:	83 e8 63             	sub    $0x63,%eax
    3474:	83 f8 15             	cmp    $0x15,%eax
    3477:	77 17                	ja     3490 <printf+0x90>
    3479:	ff 24 85 30 37 00 00 	jmp    *0x3730(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3480:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3483:	5b                   	pop    %ebx
    3484:	5e                   	pop    %esi
    3485:	5f                   	pop    %edi
    3486:	5d                   	pop    %ebp
    3487:	c3                   	ret    
    3488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    348f:	90                   	nop
  write(fd, &c, 1);
    3490:	83 ec 04             	sub    $0x4,%esp
    3493:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3496:	6a 01                	push   $0x1
    3498:	57                   	push   %edi
    3499:	56                   	push   %esi
    349a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    349e:	e8 10 fe ff ff       	call   32b3 <write>
        putc(fd, c);
    34a3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    34a7:	83 c4 0c             	add    $0xc,%esp
    34aa:	88 55 e7             	mov    %dl,-0x19(%ebp)
    34ad:	6a 01                	push   $0x1
    34af:	57                   	push   %edi
    34b0:	56                   	push   %esi
    34b1:	e8 fd fd ff ff       	call   32b3 <write>
        putc(fd, c);
    34b6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34b9:	31 c9                	xor    %ecx,%ecx
    34bb:	eb 95                	jmp    3452 <printf+0x52>
    34bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    34c0:	83 ec 0c             	sub    $0xc,%esp
    34c3:	b9 10 00 00 00       	mov    $0x10,%ecx
    34c8:	6a 00                	push   $0x0
    34ca:	8b 45 d0             	mov    -0x30(%ebp),%eax
    34cd:	8b 10                	mov    (%eax),%edx
    34cf:	89 f0                	mov    %esi,%eax
    34d1:	e8 7a fe ff ff       	call   3350 <printint>
        ap++;
    34d6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    34da:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34dd:	31 c9                	xor    %ecx,%ecx
    34df:	e9 6e ff ff ff       	jmp    3452 <printf+0x52>
    34e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    34e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    34eb:	8b 10                	mov    (%eax),%edx
        ap++;
    34ed:	83 c0 04             	add    $0x4,%eax
    34f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    34f3:	85 d2                	test   %edx,%edx
    34f5:	0f 84 8d 00 00 00    	je     3588 <printf+0x188>
        while(*s != 0){
    34fb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    34fe:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3500:	84 c0                	test   %al,%al
    3502:	0f 84 4a ff ff ff    	je     3452 <printf+0x52>
    3508:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    350b:	89 d3                	mov    %edx,%ebx
    350d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3510:	83 ec 04             	sub    $0x4,%esp
          s++;
    3513:	83 c3 01             	add    $0x1,%ebx
    3516:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3519:	6a 01                	push   $0x1
    351b:	57                   	push   %edi
    351c:	56                   	push   %esi
    351d:	e8 91 fd ff ff       	call   32b3 <write>
        while(*s != 0){
    3522:	0f b6 03             	movzbl (%ebx),%eax
    3525:	83 c4 10             	add    $0x10,%esp
    3528:	84 c0                	test   %al,%al
    352a:	75 e4                	jne    3510 <printf+0x110>
      state = 0;
    352c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    352f:	31 c9                	xor    %ecx,%ecx
    3531:	e9 1c ff ff ff       	jmp    3452 <printf+0x52>
    3536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    353d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3540:	83 ec 0c             	sub    $0xc,%esp
    3543:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3548:	6a 01                	push   $0x1
    354a:	e9 7b ff ff ff       	jmp    34ca <printf+0xca>
    354f:	90                   	nop
        putc(fd, *ap);
    3550:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3553:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3556:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3558:	6a 01                	push   $0x1
    355a:	57                   	push   %edi
    355b:	56                   	push   %esi
        putc(fd, *ap);
    355c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    355f:	e8 4f fd ff ff       	call   32b3 <write>
        ap++;
    3564:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3568:	83 c4 10             	add    $0x10,%esp
      state = 0;
    356b:	31 c9                	xor    %ecx,%ecx
    356d:	e9 e0 fe ff ff       	jmp    3452 <printf+0x52>
    3572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3578:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    357b:	83 ec 04             	sub    $0x4,%esp
    357e:	e9 2a ff ff ff       	jmp    34ad <printf+0xad>
    3583:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3587:	90                   	nop
          s = "(null)";
    3588:	ba 28 37 00 00       	mov    $0x3728,%edx
        while(*s != 0){
    358d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3590:	b8 28 00 00 00       	mov    $0x28,%eax
    3595:	89 d3                	mov    %edx,%ebx
    3597:	e9 74 ff ff ff       	jmp    3510 <printf+0x110>
    359c:	66 90                	xchg   %ax,%ax
    359e:	66 90                	xchg   %ax,%ax

000035a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    35a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35a1:	a1 30 3a 00 00       	mov    0x3a30,%eax
{
    35a6:	89 e5                	mov    %esp,%ebp
    35a8:	57                   	push   %edi
    35a9:	56                   	push   %esi
    35aa:	53                   	push   %ebx
    35ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    35ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35b8:	89 c2                	mov    %eax,%edx
    35ba:	8b 00                	mov    (%eax),%eax
    35bc:	39 ca                	cmp    %ecx,%edx
    35be:	73 30                	jae    35f0 <free+0x50>
    35c0:	39 c1                	cmp    %eax,%ecx
    35c2:	72 04                	jb     35c8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35c4:	39 c2                	cmp    %eax,%edx
    35c6:	72 f0                	jb     35b8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    35c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    35cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    35ce:	39 f8                	cmp    %edi,%eax
    35d0:	74 30                	je     3602 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    35d2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    35d5:	8b 42 04             	mov    0x4(%edx),%eax
    35d8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    35db:	39 f1                	cmp    %esi,%ecx
    35dd:	74 3a                	je     3619 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    35df:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    35e1:	5b                   	pop    %ebx
  freep = p;
    35e2:	89 15 30 3a 00 00    	mov    %edx,0x3a30
}
    35e8:	5e                   	pop    %esi
    35e9:	5f                   	pop    %edi
    35ea:	5d                   	pop    %ebp
    35eb:	c3                   	ret    
    35ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35f0:	39 c2                	cmp    %eax,%edx
    35f2:	72 c4                	jb     35b8 <free+0x18>
    35f4:	39 c1                	cmp    %eax,%ecx
    35f6:	73 c0                	jae    35b8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    35f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    35fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    35fe:	39 f8                	cmp    %edi,%eax
    3600:	75 d0                	jne    35d2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3602:	03 70 04             	add    0x4(%eax),%esi
    3605:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3608:	8b 02                	mov    (%edx),%eax
    360a:	8b 00                	mov    (%eax),%eax
    360c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    360f:	8b 42 04             	mov    0x4(%edx),%eax
    3612:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3615:	39 f1                	cmp    %esi,%ecx
    3617:	75 c6                	jne    35df <free+0x3f>
    p->s.size += bp->s.size;
    3619:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    361c:	89 15 30 3a 00 00    	mov    %edx,0x3a30
    p->s.size += bp->s.size;
    3622:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3625:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3628:	89 0a                	mov    %ecx,(%edx)
}
    362a:	5b                   	pop    %ebx
    362b:	5e                   	pop    %esi
    362c:	5f                   	pop    %edi
    362d:	5d                   	pop    %ebp
    362e:	c3                   	ret    
    362f:	90                   	nop

00003630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3630:	55                   	push   %ebp
    3631:	89 e5                	mov    %esp,%ebp
    3633:	57                   	push   %edi
    3634:	56                   	push   %esi
    3635:	53                   	push   %ebx
    3636:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3639:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    363c:	8b 3d 30 3a 00 00    	mov    0x3a30,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3642:	8d 70 07             	lea    0x7(%eax),%esi
    3645:	c1 ee 03             	shr    $0x3,%esi
    3648:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    364b:	85 ff                	test   %edi,%edi
    364d:	0f 84 9d 00 00 00    	je     36f0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3653:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3655:	8b 4a 04             	mov    0x4(%edx),%ecx
    3658:	39 f1                	cmp    %esi,%ecx
    365a:	73 6a                	jae    36c6 <malloc+0x96>
    365c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3661:	39 de                	cmp    %ebx,%esi
    3663:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3666:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    366d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3670:	eb 17                	jmp    3689 <malloc+0x59>
    3672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3678:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    367a:	8b 48 04             	mov    0x4(%eax),%ecx
    367d:	39 f1                	cmp    %esi,%ecx
    367f:	73 4f                	jae    36d0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3681:	8b 3d 30 3a 00 00    	mov    0x3a30,%edi
    3687:	89 c2                	mov    %eax,%edx
    3689:	39 d7                	cmp    %edx,%edi
    368b:	75 eb                	jne    3678 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    368d:	83 ec 0c             	sub    $0xc,%esp
    3690:	ff 75 e4             	push   -0x1c(%ebp)
    3693:	e8 83 fc ff ff       	call   331b <sbrk>
  if(p == (char*)-1)
    3698:	83 c4 10             	add    $0x10,%esp
    369b:	83 f8 ff             	cmp    $0xffffffff,%eax
    369e:	74 1c                	je     36bc <malloc+0x8c>
  hp->s.size = nu;
    36a0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    36a3:	83 ec 0c             	sub    $0xc,%esp
    36a6:	83 c0 08             	add    $0x8,%eax
    36a9:	50                   	push   %eax
    36aa:	e8 f1 fe ff ff       	call   35a0 <free>
  return freep;
    36af:	8b 15 30 3a 00 00    	mov    0x3a30,%edx
      if((p = morecore(nunits)) == 0)
    36b5:	83 c4 10             	add    $0x10,%esp
    36b8:	85 d2                	test   %edx,%edx
    36ba:	75 bc                	jne    3678 <malloc+0x48>
        return 0;
  }
}
    36bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    36bf:	31 c0                	xor    %eax,%eax
}
    36c1:	5b                   	pop    %ebx
    36c2:	5e                   	pop    %esi
    36c3:	5f                   	pop    %edi
    36c4:	5d                   	pop    %ebp
    36c5:	c3                   	ret    
    if(p->s.size >= nunits){
    36c6:	89 d0                	mov    %edx,%eax
    36c8:	89 fa                	mov    %edi,%edx
    36ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    36d0:	39 ce                	cmp    %ecx,%esi
    36d2:	74 4c                	je     3720 <malloc+0xf0>
        p->s.size -= nunits;
    36d4:	29 f1                	sub    %esi,%ecx
    36d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    36d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    36dc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    36df:	89 15 30 3a 00 00    	mov    %edx,0x3a30
}
    36e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    36e8:	83 c0 08             	add    $0x8,%eax
}
    36eb:	5b                   	pop    %ebx
    36ec:	5e                   	pop    %esi
    36ed:	5f                   	pop    %edi
    36ee:	5d                   	pop    %ebp
    36ef:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    36f0:	c7 05 30 3a 00 00 34 	movl   $0x3a34,0x3a30
    36f7:	3a 00 00 
    base.s.size = 0;
    36fa:	bf 34 3a 00 00       	mov    $0x3a34,%edi
    base.s.ptr = freep = prevp = &base;
    36ff:	c7 05 34 3a 00 00 34 	movl   $0x3a34,0x3a34
    3706:	3a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3709:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    370b:	c7 05 38 3a 00 00 00 	movl   $0x0,0x3a38
    3712:	00 00 00 
    if(p->s.size >= nunits){
    3715:	e9 42 ff ff ff       	jmp    365c <malloc+0x2c>
    371a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3720:	8b 08                	mov    (%eax),%ecx
    3722:	89 0a                	mov    %ecx,(%edx)
    3724:	eb b9                	jmp    36df <malloc+0xaf>
