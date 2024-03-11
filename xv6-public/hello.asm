
_hello:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
 
int main(int argc,char* argv[]){
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	51                   	push   %ecx
    300e:	83 ec 0c             	sub    $0xc,%esp
printf(1,"HELLO WORLD IN XV6");
    3011:	68 18 37 00 00       	push   $0x3718
    3016:	6a 01                	push   $0x1
    3018:	e8 d3 03 00 00       	call   33f0 <printf>
exit();
    301d:	e8 61 02 00 00       	call   3283 <exit>
    3022:	66 90                	xchg   %ax,%ax
    3024:	66 90                	xchg   %ax,%ax
    3026:	66 90                	xchg   %ax,%ax
    3028:	66 90                	xchg   %ax,%ax
    302a:	66 90                	xchg   %ax,%ax
    302c:	66 90                	xchg   %ax,%ax
    302e:	66 90                	xchg   %ax,%ax

00003030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3030:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3031:	31 c0                	xor    %eax,%eax
{
    3033:	89 e5                	mov    %esp,%ebp
    3035:	53                   	push   %ebx
    3036:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3039:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    303c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3040:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3044:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3047:	83 c0 01             	add    $0x1,%eax
    304a:	84 d2                	test   %dl,%dl
    304c:	75 f2                	jne    3040 <strcpy+0x10>
    ;
  return os;
}
    304e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3051:	89 c8                	mov    %ecx,%eax
    3053:	c9                   	leave  
    3054:	c3                   	ret    
    3055:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    305c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3060:	55                   	push   %ebp
    3061:	89 e5                	mov    %esp,%ebp
    3063:	53                   	push   %ebx
    3064:	8b 55 08             	mov    0x8(%ebp),%edx
    3067:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    306a:	0f b6 02             	movzbl (%edx),%eax
    306d:	84 c0                	test   %al,%al
    306f:	75 17                	jne    3088 <strcmp+0x28>
    3071:	eb 3a                	jmp    30ad <strcmp+0x4d>
    3073:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3077:	90                   	nop
    3078:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    307c:	83 c2 01             	add    $0x1,%edx
    307f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3082:	84 c0                	test   %al,%al
    3084:	74 1a                	je     30a0 <strcmp+0x40>
    p++, q++;
    3086:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3088:	0f b6 19             	movzbl (%ecx),%ebx
    308b:	38 c3                	cmp    %al,%bl
    308d:	74 e9                	je     3078 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    308f:	29 d8                	sub    %ebx,%eax
}
    3091:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3094:	c9                   	leave  
    3095:	c3                   	ret    
    3096:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    309d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    30a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    30a4:	31 c0                	xor    %eax,%eax
    30a6:	29 d8                	sub    %ebx,%eax
}
    30a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30ab:	c9                   	leave  
    30ac:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    30ad:	0f b6 19             	movzbl (%ecx),%ebx
    30b0:	31 c0                	xor    %eax,%eax
    30b2:	eb db                	jmp    308f <strcmp+0x2f>
    30b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30bf:	90                   	nop

000030c0 <strlen>:

uint
strlen(const char *s)
{
    30c0:	55                   	push   %ebp
    30c1:	89 e5                	mov    %esp,%ebp
    30c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    30c6:	80 3a 00             	cmpb   $0x0,(%edx)
    30c9:	74 15                	je     30e0 <strlen+0x20>
    30cb:	31 c0                	xor    %eax,%eax
    30cd:	8d 76 00             	lea    0x0(%esi),%esi
    30d0:	83 c0 01             	add    $0x1,%eax
    30d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    30d7:	89 c1                	mov    %eax,%ecx
    30d9:	75 f5                	jne    30d0 <strlen+0x10>
    ;
  return n;
}
    30db:	89 c8                	mov    %ecx,%eax
    30dd:	5d                   	pop    %ebp
    30de:	c3                   	ret    
    30df:	90                   	nop
  for(n = 0; s[n]; n++)
    30e0:	31 c9                	xor    %ecx,%ecx
}
    30e2:	5d                   	pop    %ebp
    30e3:	89 c8                	mov    %ecx,%eax
    30e5:	c3                   	ret    
    30e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30ed:	8d 76 00             	lea    0x0(%esi),%esi

000030f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    30f0:	55                   	push   %ebp
    30f1:	89 e5                	mov    %esp,%ebp
    30f3:	57                   	push   %edi
    30f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    30f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    30fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    30fd:	89 d7                	mov    %edx,%edi
    30ff:	fc                   	cld    
    3100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3102:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3105:	89 d0                	mov    %edx,%eax
    3107:	c9                   	leave  
    3108:	c3                   	ret    
    3109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003110 <strchr>:

char*
strchr(const char *s, char c)
{
    3110:	55                   	push   %ebp
    3111:	89 e5                	mov    %esp,%ebp
    3113:	8b 45 08             	mov    0x8(%ebp),%eax
    3116:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    311a:	0f b6 10             	movzbl (%eax),%edx
    311d:	84 d2                	test   %dl,%dl
    311f:	75 12                	jne    3133 <strchr+0x23>
    3121:	eb 1d                	jmp    3140 <strchr+0x30>
    3123:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3127:	90                   	nop
    3128:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    312c:	83 c0 01             	add    $0x1,%eax
    312f:	84 d2                	test   %dl,%dl
    3131:	74 0d                	je     3140 <strchr+0x30>
    if(*s == c)
    3133:	38 d1                	cmp    %dl,%cl
    3135:	75 f1                	jne    3128 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3137:	5d                   	pop    %ebp
    3138:	c3                   	ret    
    3139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3140:	31 c0                	xor    %eax,%eax
}
    3142:	5d                   	pop    %ebp
    3143:	c3                   	ret    
    3144:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    314b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    314f:	90                   	nop

00003150 <gets>:

char*
gets(char *buf, int max)
{
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
    3153:	57                   	push   %edi
    3154:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3155:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3158:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3159:	31 db                	xor    %ebx,%ebx
{
    315b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    315e:	eb 27                	jmp    3187 <gets+0x37>
    cc = read(0, &c, 1);
    3160:	83 ec 04             	sub    $0x4,%esp
    3163:	6a 01                	push   $0x1
    3165:	57                   	push   %edi
    3166:	6a 00                	push   $0x0
    3168:	e8 2e 01 00 00       	call   329b <read>
    if(cc < 1)
    316d:	83 c4 10             	add    $0x10,%esp
    3170:	85 c0                	test   %eax,%eax
    3172:	7e 1d                	jle    3191 <gets+0x41>
      break;
    buf[i++] = c;
    3174:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3178:	8b 55 08             	mov    0x8(%ebp),%edx
    317b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    317f:	3c 0a                	cmp    $0xa,%al
    3181:	74 1d                	je     31a0 <gets+0x50>
    3183:	3c 0d                	cmp    $0xd,%al
    3185:	74 19                	je     31a0 <gets+0x50>
  for(i=0; i+1 < max; ){
    3187:	89 de                	mov    %ebx,%esi
    3189:	83 c3 01             	add    $0x1,%ebx
    318c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    318f:	7c cf                	jl     3160 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3191:	8b 45 08             	mov    0x8(%ebp),%eax
    3194:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3198:	8d 65 f4             	lea    -0xc(%ebp),%esp
    319b:	5b                   	pop    %ebx
    319c:	5e                   	pop    %esi
    319d:	5f                   	pop    %edi
    319e:	5d                   	pop    %ebp
    319f:	c3                   	ret    
  buf[i] = '\0';
    31a0:	8b 45 08             	mov    0x8(%ebp),%eax
    31a3:	89 de                	mov    %ebx,%esi
    31a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    31a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31ac:	5b                   	pop    %ebx
    31ad:	5e                   	pop    %esi
    31ae:	5f                   	pop    %edi
    31af:	5d                   	pop    %ebp
    31b0:	c3                   	ret    
    31b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31bf:	90                   	nop

000031c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    31c0:	55                   	push   %ebp
    31c1:	89 e5                	mov    %esp,%ebp
    31c3:	56                   	push   %esi
    31c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31c5:	83 ec 08             	sub    $0x8,%esp
    31c8:	6a 00                	push   $0x0
    31ca:	ff 75 08             	push   0x8(%ebp)
    31cd:	e8 f1 00 00 00       	call   32c3 <open>
  if(fd < 0)
    31d2:	83 c4 10             	add    $0x10,%esp
    31d5:	85 c0                	test   %eax,%eax
    31d7:	78 27                	js     3200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    31d9:	83 ec 08             	sub    $0x8,%esp
    31dc:	ff 75 0c             	push   0xc(%ebp)
    31df:	89 c3                	mov    %eax,%ebx
    31e1:	50                   	push   %eax
    31e2:	e8 f4 00 00 00       	call   32db <fstat>
  close(fd);
    31e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    31ea:	89 c6                	mov    %eax,%esi
  close(fd);
    31ec:	e8 ba 00 00 00       	call   32ab <close>
  return r;
    31f1:	83 c4 10             	add    $0x10,%esp
}
    31f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31f7:	89 f0                	mov    %esi,%eax
    31f9:	5b                   	pop    %ebx
    31fa:	5e                   	pop    %esi
    31fb:	5d                   	pop    %ebp
    31fc:	c3                   	ret    
    31fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3200:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3205:	eb ed                	jmp    31f4 <stat+0x34>
    3207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    320e:	66 90                	xchg   %ax,%ax

00003210 <atoi>:

int
atoi(const char *s)
{
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	53                   	push   %ebx
    3214:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3217:	0f be 02             	movsbl (%edx),%eax
    321a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    321d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3220:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3225:	77 1e                	ja     3245 <atoi+0x35>
    3227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    322e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3230:	83 c2 01             	add    $0x1,%edx
    3233:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3236:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    323a:	0f be 02             	movsbl (%edx),%eax
    323d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3240:	80 fb 09             	cmp    $0x9,%bl
    3243:	76 eb                	jbe    3230 <atoi+0x20>
  return n;
}
    3245:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3248:	89 c8                	mov    %ecx,%eax
    324a:	c9                   	leave  
    324b:	c3                   	ret    
    324c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3250:	55                   	push   %ebp
    3251:	89 e5                	mov    %esp,%ebp
    3253:	57                   	push   %edi
    3254:	8b 45 10             	mov    0x10(%ebp),%eax
    3257:	8b 55 08             	mov    0x8(%ebp),%edx
    325a:	56                   	push   %esi
    325b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    325e:	85 c0                	test   %eax,%eax
    3260:	7e 13                	jle    3275 <memmove+0x25>
    3262:	01 d0                	add    %edx,%eax
  dst = vdst;
    3264:	89 d7                	mov    %edx,%edi
    3266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    326d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3270:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3271:	39 f8                	cmp    %edi,%eax
    3273:	75 fb                	jne    3270 <memmove+0x20>
  return vdst;
}
    3275:	5e                   	pop    %esi
    3276:	89 d0                	mov    %edx,%eax
    3278:	5f                   	pop    %edi
    3279:	5d                   	pop    %ebp
    327a:	c3                   	ret    

0000327b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    327b:	b8 01 00 00 00       	mov    $0x1,%eax
    3280:	cd 40                	int    $0x40
    3282:	c3                   	ret    

00003283 <exit>:
SYSCALL(exit)
    3283:	b8 02 00 00 00       	mov    $0x2,%eax
    3288:	cd 40                	int    $0x40
    328a:	c3                   	ret    

0000328b <wait>:
SYSCALL(wait)
    328b:	b8 03 00 00 00       	mov    $0x3,%eax
    3290:	cd 40                	int    $0x40
    3292:	c3                   	ret    

00003293 <pipe>:
SYSCALL(pipe)
    3293:	b8 04 00 00 00       	mov    $0x4,%eax
    3298:	cd 40                	int    $0x40
    329a:	c3                   	ret    

0000329b <read>:
SYSCALL(read)
    329b:	b8 05 00 00 00       	mov    $0x5,%eax
    32a0:	cd 40                	int    $0x40
    32a2:	c3                   	ret    

000032a3 <write>:
SYSCALL(write)
    32a3:	b8 10 00 00 00       	mov    $0x10,%eax
    32a8:	cd 40                	int    $0x40
    32aa:	c3                   	ret    

000032ab <close>:
SYSCALL(close)
    32ab:	b8 15 00 00 00       	mov    $0x15,%eax
    32b0:	cd 40                	int    $0x40
    32b2:	c3                   	ret    

000032b3 <kill>:
SYSCALL(kill)
    32b3:	b8 06 00 00 00       	mov    $0x6,%eax
    32b8:	cd 40                	int    $0x40
    32ba:	c3                   	ret    

000032bb <exec>:
SYSCALL(exec)
    32bb:	b8 07 00 00 00       	mov    $0x7,%eax
    32c0:	cd 40                	int    $0x40
    32c2:	c3                   	ret    

000032c3 <open>:
SYSCALL(open)
    32c3:	b8 0f 00 00 00       	mov    $0xf,%eax
    32c8:	cd 40                	int    $0x40
    32ca:	c3                   	ret    

000032cb <mknod>:
SYSCALL(mknod)
    32cb:	b8 11 00 00 00       	mov    $0x11,%eax
    32d0:	cd 40                	int    $0x40
    32d2:	c3                   	ret    

000032d3 <unlink>:
SYSCALL(unlink)
    32d3:	b8 12 00 00 00       	mov    $0x12,%eax
    32d8:	cd 40                	int    $0x40
    32da:	c3                   	ret    

000032db <fstat>:
SYSCALL(fstat)
    32db:	b8 08 00 00 00       	mov    $0x8,%eax
    32e0:	cd 40                	int    $0x40
    32e2:	c3                   	ret    

000032e3 <link>:
SYSCALL(link)
    32e3:	b8 13 00 00 00       	mov    $0x13,%eax
    32e8:	cd 40                	int    $0x40
    32ea:	c3                   	ret    

000032eb <mkdir>:
SYSCALL(mkdir)
    32eb:	b8 14 00 00 00       	mov    $0x14,%eax
    32f0:	cd 40                	int    $0x40
    32f2:	c3                   	ret    

000032f3 <chdir>:
SYSCALL(chdir)
    32f3:	b8 09 00 00 00       	mov    $0x9,%eax
    32f8:	cd 40                	int    $0x40
    32fa:	c3                   	ret    

000032fb <dup>:
SYSCALL(dup)
    32fb:	b8 0a 00 00 00       	mov    $0xa,%eax
    3300:	cd 40                	int    $0x40
    3302:	c3                   	ret    

00003303 <getpid>:
SYSCALL(getpid)
    3303:	b8 0b 00 00 00       	mov    $0xb,%eax
    3308:	cd 40                	int    $0x40
    330a:	c3                   	ret    

0000330b <sbrk>:
SYSCALL(sbrk)
    330b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3310:	cd 40                	int    $0x40
    3312:	c3                   	ret    

00003313 <sleep>:
SYSCALL(sleep)
    3313:	b8 0d 00 00 00       	mov    $0xd,%eax
    3318:	cd 40                	int    $0x40
    331a:	c3                   	ret    

0000331b <uptime>:
SYSCALL(uptime)
    331b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3320:	cd 40                	int    $0x40
    3322:	c3                   	ret    

00003323 <uniq>:
SYSCALL(uniq)
    3323:	b8 16 00 00 00       	mov    $0x16,%eax
    3328:	cd 40                	int    $0x40
    332a:	c3                   	ret    

0000332b <head>:
SYSCALL(head)
    332b:	b8 17 00 00 00       	mov    $0x17,%eax
    3330:	cd 40                	int    $0x40
    3332:	c3                   	ret    

00003333 <ps>:
    3333:	b8 18 00 00 00       	mov    $0x18,%eax
    3338:	cd 40                	int    $0x40
    333a:	c3                   	ret    
    333b:	66 90                	xchg   %ax,%ax
    333d:	66 90                	xchg   %ax,%ax
    333f:	90                   	nop

00003340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3340:	55                   	push   %ebp
    3341:	89 e5                	mov    %esp,%ebp
    3343:	57                   	push   %edi
    3344:	56                   	push   %esi
    3345:	53                   	push   %ebx
    3346:	83 ec 3c             	sub    $0x3c,%esp
    3349:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    334c:	89 d1                	mov    %edx,%ecx
{
    334e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3351:	85 d2                	test   %edx,%edx
    3353:	0f 89 7f 00 00 00    	jns    33d8 <printint+0x98>
    3359:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    335d:	74 79                	je     33d8 <printint+0x98>
    neg = 1;
    335f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3366:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3368:	31 db                	xor    %ebx,%ebx
    336a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    336d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3370:	89 c8                	mov    %ecx,%eax
    3372:	31 d2                	xor    %edx,%edx
    3374:	89 cf                	mov    %ecx,%edi
    3376:	f7 75 c4             	divl   -0x3c(%ebp)
    3379:	0f b6 92 8c 37 00 00 	movzbl 0x378c(%edx),%edx
    3380:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3383:	89 d8                	mov    %ebx,%eax
    3385:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3388:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    338b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    338e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3391:	76 dd                	jbe    3370 <printint+0x30>
  if(neg)
    3393:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3396:	85 c9                	test   %ecx,%ecx
    3398:	74 0c                	je     33a6 <printint+0x66>
    buf[i++] = '-';
    339a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    339f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    33a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    33a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    33a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    33ad:	eb 07                	jmp    33b6 <printint+0x76>
    33af:	90                   	nop
    putc(fd, buf[i]);
    33b0:	0f b6 13             	movzbl (%ebx),%edx
    33b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    33b6:	83 ec 04             	sub    $0x4,%esp
    33b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    33bc:	6a 01                	push   $0x1
    33be:	56                   	push   %esi
    33bf:	57                   	push   %edi
    33c0:	e8 de fe ff ff       	call   32a3 <write>
  while(--i >= 0)
    33c5:	83 c4 10             	add    $0x10,%esp
    33c8:	39 de                	cmp    %ebx,%esi
    33ca:	75 e4                	jne    33b0 <printint+0x70>
}
    33cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    33cf:	5b                   	pop    %ebx
    33d0:	5e                   	pop    %esi
    33d1:	5f                   	pop    %edi
    33d2:	5d                   	pop    %ebp
    33d3:	c3                   	ret    
    33d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    33d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    33df:	eb 87                	jmp    3368 <printint+0x28>
    33e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33ef:	90                   	nop

000033f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    33f0:	55                   	push   %ebp
    33f1:	89 e5                	mov    %esp,%ebp
    33f3:	57                   	push   %edi
    33f4:	56                   	push   %esi
    33f5:	53                   	push   %ebx
    33f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    33f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    33fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    33ff:	0f b6 13             	movzbl (%ebx),%edx
    3402:	84 d2                	test   %dl,%dl
    3404:	74 6a                	je     3470 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3406:	8d 45 10             	lea    0x10(%ebp),%eax
    3409:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    340c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    340f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3411:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3414:	eb 36                	jmp    344c <printf+0x5c>
    3416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    341d:	8d 76 00             	lea    0x0(%esi),%esi
    3420:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3423:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3428:	83 f8 25             	cmp    $0x25,%eax
    342b:	74 15                	je     3442 <printf+0x52>
  write(fd, &c, 1);
    342d:	83 ec 04             	sub    $0x4,%esp
    3430:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3433:	6a 01                	push   $0x1
    3435:	57                   	push   %edi
    3436:	56                   	push   %esi
    3437:	e8 67 fe ff ff       	call   32a3 <write>
    343c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    343f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3442:	0f b6 13             	movzbl (%ebx),%edx
    3445:	83 c3 01             	add    $0x1,%ebx
    3448:	84 d2                	test   %dl,%dl
    344a:	74 24                	je     3470 <printf+0x80>
    c = fmt[i] & 0xff;
    344c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    344f:	85 c9                	test   %ecx,%ecx
    3451:	74 cd                	je     3420 <printf+0x30>
      }
    } else if(state == '%'){
    3453:	83 f9 25             	cmp    $0x25,%ecx
    3456:	75 ea                	jne    3442 <printf+0x52>
      if(c == 'd'){
    3458:	83 f8 25             	cmp    $0x25,%eax
    345b:	0f 84 07 01 00 00    	je     3568 <printf+0x178>
    3461:	83 e8 63             	sub    $0x63,%eax
    3464:	83 f8 15             	cmp    $0x15,%eax
    3467:	77 17                	ja     3480 <printf+0x90>
    3469:	ff 24 85 34 37 00 00 	jmp    *0x3734(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3470:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3473:	5b                   	pop    %ebx
    3474:	5e                   	pop    %esi
    3475:	5f                   	pop    %edi
    3476:	5d                   	pop    %ebp
    3477:	c3                   	ret    
    3478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    347f:	90                   	nop
  write(fd, &c, 1);
    3480:	83 ec 04             	sub    $0x4,%esp
    3483:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3486:	6a 01                	push   $0x1
    3488:	57                   	push   %edi
    3489:	56                   	push   %esi
    348a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    348e:	e8 10 fe ff ff       	call   32a3 <write>
        putc(fd, c);
    3493:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3497:	83 c4 0c             	add    $0xc,%esp
    349a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    349d:	6a 01                	push   $0x1
    349f:	57                   	push   %edi
    34a0:	56                   	push   %esi
    34a1:	e8 fd fd ff ff       	call   32a3 <write>
        putc(fd, c);
    34a6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34a9:	31 c9                	xor    %ecx,%ecx
    34ab:	eb 95                	jmp    3442 <printf+0x52>
    34ad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    34b0:	83 ec 0c             	sub    $0xc,%esp
    34b3:	b9 10 00 00 00       	mov    $0x10,%ecx
    34b8:	6a 00                	push   $0x0
    34ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
    34bd:	8b 10                	mov    (%eax),%edx
    34bf:	89 f0                	mov    %esi,%eax
    34c1:	e8 7a fe ff ff       	call   3340 <printint>
        ap++;
    34c6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    34ca:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34cd:	31 c9                	xor    %ecx,%ecx
    34cf:	e9 6e ff ff ff       	jmp    3442 <printf+0x52>
    34d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    34d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    34db:	8b 10                	mov    (%eax),%edx
        ap++;
    34dd:	83 c0 04             	add    $0x4,%eax
    34e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    34e3:	85 d2                	test   %edx,%edx
    34e5:	0f 84 8d 00 00 00    	je     3578 <printf+0x188>
        while(*s != 0){
    34eb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    34ee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    34f0:	84 c0                	test   %al,%al
    34f2:	0f 84 4a ff ff ff    	je     3442 <printf+0x52>
    34f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    34fb:	89 d3                	mov    %edx,%ebx
    34fd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3500:	83 ec 04             	sub    $0x4,%esp
          s++;
    3503:	83 c3 01             	add    $0x1,%ebx
    3506:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3509:	6a 01                	push   $0x1
    350b:	57                   	push   %edi
    350c:	56                   	push   %esi
    350d:	e8 91 fd ff ff       	call   32a3 <write>
        while(*s != 0){
    3512:	0f b6 03             	movzbl (%ebx),%eax
    3515:	83 c4 10             	add    $0x10,%esp
    3518:	84 c0                	test   %al,%al
    351a:	75 e4                	jne    3500 <printf+0x110>
      state = 0;
    351c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    351f:	31 c9                	xor    %ecx,%ecx
    3521:	e9 1c ff ff ff       	jmp    3442 <printf+0x52>
    3526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    352d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3530:	83 ec 0c             	sub    $0xc,%esp
    3533:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3538:	6a 01                	push   $0x1
    353a:	e9 7b ff ff ff       	jmp    34ba <printf+0xca>
    353f:	90                   	nop
        putc(fd, *ap);
    3540:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3543:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3546:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3548:	6a 01                	push   $0x1
    354a:	57                   	push   %edi
    354b:	56                   	push   %esi
        putc(fd, *ap);
    354c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    354f:	e8 4f fd ff ff       	call   32a3 <write>
        ap++;
    3554:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3558:	83 c4 10             	add    $0x10,%esp
      state = 0;
    355b:	31 c9                	xor    %ecx,%ecx
    355d:	e9 e0 fe ff ff       	jmp    3442 <printf+0x52>
    3562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3568:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    356b:	83 ec 04             	sub    $0x4,%esp
    356e:	e9 2a ff ff ff       	jmp    349d <printf+0xad>
    3573:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3577:	90                   	nop
          s = "(null)";
    3578:	ba 2b 37 00 00       	mov    $0x372b,%edx
        while(*s != 0){
    357d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3580:	b8 28 00 00 00       	mov    $0x28,%eax
    3585:	89 d3                	mov    %edx,%ebx
    3587:	e9 74 ff ff ff       	jmp    3500 <printf+0x110>
    358c:	66 90                	xchg   %ax,%ax
    358e:	66 90                	xchg   %ax,%ax

00003590 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3590:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3591:	a1 34 3a 00 00       	mov    0x3a34,%eax
{
    3596:	89 e5                	mov    %esp,%ebp
    3598:	57                   	push   %edi
    3599:	56                   	push   %esi
    359a:	53                   	push   %ebx
    359b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    359e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35a8:	89 c2                	mov    %eax,%edx
    35aa:	8b 00                	mov    (%eax),%eax
    35ac:	39 ca                	cmp    %ecx,%edx
    35ae:	73 30                	jae    35e0 <free+0x50>
    35b0:	39 c1                	cmp    %eax,%ecx
    35b2:	72 04                	jb     35b8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35b4:	39 c2                	cmp    %eax,%edx
    35b6:	72 f0                	jb     35a8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    35b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    35bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    35be:	39 f8                	cmp    %edi,%eax
    35c0:	74 30                	je     35f2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    35c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    35c5:	8b 42 04             	mov    0x4(%edx),%eax
    35c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    35cb:	39 f1                	cmp    %esi,%ecx
    35cd:	74 3a                	je     3609 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    35cf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    35d1:	5b                   	pop    %ebx
  freep = p;
    35d2:	89 15 34 3a 00 00    	mov    %edx,0x3a34
}
    35d8:	5e                   	pop    %esi
    35d9:	5f                   	pop    %edi
    35da:	5d                   	pop    %ebp
    35db:	c3                   	ret    
    35dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35e0:	39 c2                	cmp    %eax,%edx
    35e2:	72 c4                	jb     35a8 <free+0x18>
    35e4:	39 c1                	cmp    %eax,%ecx
    35e6:	73 c0                	jae    35a8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    35e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    35eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    35ee:	39 f8                	cmp    %edi,%eax
    35f0:	75 d0                	jne    35c2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    35f2:	03 70 04             	add    0x4(%eax),%esi
    35f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    35f8:	8b 02                	mov    (%edx),%eax
    35fa:	8b 00                	mov    (%eax),%eax
    35fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    35ff:	8b 42 04             	mov    0x4(%edx),%eax
    3602:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3605:	39 f1                	cmp    %esi,%ecx
    3607:	75 c6                	jne    35cf <free+0x3f>
    p->s.size += bp->s.size;
    3609:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    360c:	89 15 34 3a 00 00    	mov    %edx,0x3a34
    p->s.size += bp->s.size;
    3612:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3615:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3618:	89 0a                	mov    %ecx,(%edx)
}
    361a:	5b                   	pop    %ebx
    361b:	5e                   	pop    %esi
    361c:	5f                   	pop    %edi
    361d:	5d                   	pop    %ebp
    361e:	c3                   	ret    
    361f:	90                   	nop

00003620 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3620:	55                   	push   %ebp
    3621:	89 e5                	mov    %esp,%ebp
    3623:	57                   	push   %edi
    3624:	56                   	push   %esi
    3625:	53                   	push   %ebx
    3626:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3629:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    362c:	8b 3d 34 3a 00 00    	mov    0x3a34,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3632:	8d 70 07             	lea    0x7(%eax),%esi
    3635:	c1 ee 03             	shr    $0x3,%esi
    3638:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    363b:	85 ff                	test   %edi,%edi
    363d:	0f 84 9d 00 00 00    	je     36e0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3643:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3645:	8b 4a 04             	mov    0x4(%edx),%ecx
    3648:	39 f1                	cmp    %esi,%ecx
    364a:	73 6a                	jae    36b6 <malloc+0x96>
    364c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3651:	39 de                	cmp    %ebx,%esi
    3653:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3656:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    365d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3660:	eb 17                	jmp    3679 <malloc+0x59>
    3662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3668:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    366a:	8b 48 04             	mov    0x4(%eax),%ecx
    366d:	39 f1                	cmp    %esi,%ecx
    366f:	73 4f                	jae    36c0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3671:	8b 3d 34 3a 00 00    	mov    0x3a34,%edi
    3677:	89 c2                	mov    %eax,%edx
    3679:	39 d7                	cmp    %edx,%edi
    367b:	75 eb                	jne    3668 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    367d:	83 ec 0c             	sub    $0xc,%esp
    3680:	ff 75 e4             	push   -0x1c(%ebp)
    3683:	e8 83 fc ff ff       	call   330b <sbrk>
  if(p == (char*)-1)
    3688:	83 c4 10             	add    $0x10,%esp
    368b:	83 f8 ff             	cmp    $0xffffffff,%eax
    368e:	74 1c                	je     36ac <malloc+0x8c>
  hp->s.size = nu;
    3690:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3693:	83 ec 0c             	sub    $0xc,%esp
    3696:	83 c0 08             	add    $0x8,%eax
    3699:	50                   	push   %eax
    369a:	e8 f1 fe ff ff       	call   3590 <free>
  return freep;
    369f:	8b 15 34 3a 00 00    	mov    0x3a34,%edx
      if((p = morecore(nunits)) == 0)
    36a5:	83 c4 10             	add    $0x10,%esp
    36a8:	85 d2                	test   %edx,%edx
    36aa:	75 bc                	jne    3668 <malloc+0x48>
        return 0;
  }
}
    36ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    36af:	31 c0                	xor    %eax,%eax
}
    36b1:	5b                   	pop    %ebx
    36b2:	5e                   	pop    %esi
    36b3:	5f                   	pop    %edi
    36b4:	5d                   	pop    %ebp
    36b5:	c3                   	ret    
    if(p->s.size >= nunits){
    36b6:	89 d0                	mov    %edx,%eax
    36b8:	89 fa                	mov    %edi,%edx
    36ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    36c0:	39 ce                	cmp    %ecx,%esi
    36c2:	74 4c                	je     3710 <malloc+0xf0>
        p->s.size -= nunits;
    36c4:	29 f1                	sub    %esi,%ecx
    36c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    36c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    36cc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    36cf:	89 15 34 3a 00 00    	mov    %edx,0x3a34
}
    36d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    36d8:	83 c0 08             	add    $0x8,%eax
}
    36db:	5b                   	pop    %ebx
    36dc:	5e                   	pop    %esi
    36dd:	5f                   	pop    %edi
    36de:	5d                   	pop    %ebp
    36df:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    36e0:	c7 05 34 3a 00 00 38 	movl   $0x3a38,0x3a34
    36e7:	3a 00 00 
    base.s.size = 0;
    36ea:	bf 38 3a 00 00       	mov    $0x3a38,%edi
    base.s.ptr = freep = prevp = &base;
    36ef:	c7 05 38 3a 00 00 38 	movl   $0x3a38,0x3a38
    36f6:	3a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    36f9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    36fb:	c7 05 3c 3a 00 00 00 	movl   $0x0,0x3a3c
    3702:	00 00 00 
    if(p->s.size >= nunits){
    3705:	e9 42 ff ff ff       	jmp    364c <malloc+0x2c>
    370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3710:	8b 08                	mov    (%eax),%ecx
    3712:	89 0a                	mov    %ecx,(%edx)
    3714:	eb b9                	jmp    36cf <malloc+0xaf>
