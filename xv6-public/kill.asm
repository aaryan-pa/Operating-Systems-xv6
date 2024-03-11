
_kill:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	57                   	push   %edi
    300e:	56                   	push   %esi
    300f:	53                   	push   %ebx
    3010:	bb 01 00 00 00       	mov    $0x1,%ebx
    3015:	51                   	push   %ecx
    3016:	83 ec 08             	sub    $0x8,%esp
    3019:	8b 31                	mov    (%ecx),%esi
    301b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
    301e:	83 fe 01             	cmp    $0x1,%esi
    3021:	7e 27                	jle    304a <main+0x4a>
    3023:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3027:	90                   	nop
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
    3028:	83 ec 0c             	sub    $0xc,%esp
    302b:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
    302e:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
    3031:	e8 0a 02 00 00       	call   3240 <atoi>
    3036:	89 04 24             	mov    %eax,(%esp)
    3039:	e8 a5 02 00 00       	call   32e3 <kill>
  for(i=1; i<argc; i++)
    303e:	83 c4 10             	add    $0x10,%esp
    3041:	39 de                	cmp    %ebx,%esi
    3043:	75 e3                	jne    3028 <main+0x28>
  exit();
    3045:	e8 69 02 00 00       	call   32b3 <exit>
    printf(2, "usage: kill pid...\n");
    304a:	50                   	push   %eax
    304b:	50                   	push   %eax
    304c:	68 48 37 00 00       	push   $0x3748
    3051:	6a 02                	push   $0x2
    3053:	e8 c8 03 00 00       	call   3420 <printf>
    exit();
    3058:	e8 56 02 00 00       	call   32b3 <exit>
    305d:	66 90                	xchg   %ax,%ax
    305f:	90                   	nop

00003060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3060:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3061:	31 c0                	xor    %eax,%eax
{
    3063:	89 e5                	mov    %esp,%ebp
    3065:	53                   	push   %ebx
    3066:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3069:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    306c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3070:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3074:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3077:	83 c0 01             	add    $0x1,%eax
    307a:	84 d2                	test   %dl,%dl
    307c:	75 f2                	jne    3070 <strcpy+0x10>
    ;
  return os;
}
    307e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3081:	89 c8                	mov    %ecx,%eax
    3083:	c9                   	leave  
    3084:	c3                   	ret    
    3085:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    308c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3090:	55                   	push   %ebp
    3091:	89 e5                	mov    %esp,%ebp
    3093:	53                   	push   %ebx
    3094:	8b 55 08             	mov    0x8(%ebp),%edx
    3097:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    309a:	0f b6 02             	movzbl (%edx),%eax
    309d:	84 c0                	test   %al,%al
    309f:	75 17                	jne    30b8 <strcmp+0x28>
    30a1:	eb 3a                	jmp    30dd <strcmp+0x4d>
    30a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30a7:	90                   	nop
    30a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    30ac:	83 c2 01             	add    $0x1,%edx
    30af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    30b2:	84 c0                	test   %al,%al
    30b4:	74 1a                	je     30d0 <strcmp+0x40>
    p++, q++;
    30b6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    30b8:	0f b6 19             	movzbl (%ecx),%ebx
    30bb:	38 c3                	cmp    %al,%bl
    30bd:	74 e9                	je     30a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    30bf:	29 d8                	sub    %ebx,%eax
}
    30c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30c4:	c9                   	leave  
    30c5:	c3                   	ret    
    30c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30cd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    30d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    30d4:	31 c0                	xor    %eax,%eax
    30d6:	29 d8                	sub    %ebx,%eax
}
    30d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30db:	c9                   	leave  
    30dc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    30dd:	0f b6 19             	movzbl (%ecx),%ebx
    30e0:	31 c0                	xor    %eax,%eax
    30e2:	eb db                	jmp    30bf <strcmp+0x2f>
    30e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30ef:	90                   	nop

000030f0 <strlen>:

uint
strlen(const char *s)
{
    30f0:	55                   	push   %ebp
    30f1:	89 e5                	mov    %esp,%ebp
    30f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    30f6:	80 3a 00             	cmpb   $0x0,(%edx)
    30f9:	74 15                	je     3110 <strlen+0x20>
    30fb:	31 c0                	xor    %eax,%eax
    30fd:	8d 76 00             	lea    0x0(%esi),%esi
    3100:	83 c0 01             	add    $0x1,%eax
    3103:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3107:	89 c1                	mov    %eax,%ecx
    3109:	75 f5                	jne    3100 <strlen+0x10>
    ;
  return n;
}
    310b:	89 c8                	mov    %ecx,%eax
    310d:	5d                   	pop    %ebp
    310e:	c3                   	ret    
    310f:	90                   	nop
  for(n = 0; s[n]; n++)
    3110:	31 c9                	xor    %ecx,%ecx
}
    3112:	5d                   	pop    %ebp
    3113:	89 c8                	mov    %ecx,%eax
    3115:	c3                   	ret    
    3116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    311d:	8d 76 00             	lea    0x0(%esi),%esi

00003120 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3120:	55                   	push   %ebp
    3121:	89 e5                	mov    %esp,%ebp
    3123:	57                   	push   %edi
    3124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3127:	8b 4d 10             	mov    0x10(%ebp),%ecx
    312a:	8b 45 0c             	mov    0xc(%ebp),%eax
    312d:	89 d7                	mov    %edx,%edi
    312f:	fc                   	cld    
    3130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3132:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3135:	89 d0                	mov    %edx,%eax
    3137:	c9                   	leave  
    3138:	c3                   	ret    
    3139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003140 <strchr>:

char*
strchr(const char *s, char c)
{
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	8b 45 08             	mov    0x8(%ebp),%eax
    3146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    314a:	0f b6 10             	movzbl (%eax),%edx
    314d:	84 d2                	test   %dl,%dl
    314f:	75 12                	jne    3163 <strchr+0x23>
    3151:	eb 1d                	jmp    3170 <strchr+0x30>
    3153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3157:	90                   	nop
    3158:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    315c:	83 c0 01             	add    $0x1,%eax
    315f:	84 d2                	test   %dl,%dl
    3161:	74 0d                	je     3170 <strchr+0x30>
    if(*s == c)
    3163:	38 d1                	cmp    %dl,%cl
    3165:	75 f1                	jne    3158 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3167:	5d                   	pop    %ebp
    3168:	c3                   	ret    
    3169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3170:	31 c0                	xor    %eax,%eax
}
    3172:	5d                   	pop    %ebp
    3173:	c3                   	ret    
    3174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    317f:	90                   	nop

00003180 <gets>:

char*
gets(char *buf, int max)
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	57                   	push   %edi
    3184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3185:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3188:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3189:	31 db                	xor    %ebx,%ebx
{
    318b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    318e:	eb 27                	jmp    31b7 <gets+0x37>
    cc = read(0, &c, 1);
    3190:	83 ec 04             	sub    $0x4,%esp
    3193:	6a 01                	push   $0x1
    3195:	57                   	push   %edi
    3196:	6a 00                	push   $0x0
    3198:	e8 2e 01 00 00       	call   32cb <read>
    if(cc < 1)
    319d:	83 c4 10             	add    $0x10,%esp
    31a0:	85 c0                	test   %eax,%eax
    31a2:	7e 1d                	jle    31c1 <gets+0x41>
      break;
    buf[i++] = c;
    31a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    31a8:	8b 55 08             	mov    0x8(%ebp),%edx
    31ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    31af:	3c 0a                	cmp    $0xa,%al
    31b1:	74 1d                	je     31d0 <gets+0x50>
    31b3:	3c 0d                	cmp    $0xd,%al
    31b5:	74 19                	je     31d0 <gets+0x50>
  for(i=0; i+1 < max; ){
    31b7:	89 de                	mov    %ebx,%esi
    31b9:	83 c3 01             	add    $0x1,%ebx
    31bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    31bf:	7c cf                	jl     3190 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    31c1:	8b 45 08             	mov    0x8(%ebp),%eax
    31c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    31c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31cb:	5b                   	pop    %ebx
    31cc:	5e                   	pop    %esi
    31cd:	5f                   	pop    %edi
    31ce:	5d                   	pop    %ebp
    31cf:	c3                   	ret    
  buf[i] = '\0';
    31d0:	8b 45 08             	mov    0x8(%ebp),%eax
    31d3:	89 de                	mov    %ebx,%esi
    31d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    31d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31dc:	5b                   	pop    %ebx
    31dd:	5e                   	pop    %esi
    31de:	5f                   	pop    %edi
    31df:	5d                   	pop    %ebp
    31e0:	c3                   	ret    
    31e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31ef:	90                   	nop

000031f0 <stat>:

int
stat(const char *n, struct stat *st)
{
    31f0:	55                   	push   %ebp
    31f1:	89 e5                	mov    %esp,%ebp
    31f3:	56                   	push   %esi
    31f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31f5:	83 ec 08             	sub    $0x8,%esp
    31f8:	6a 00                	push   $0x0
    31fa:	ff 75 08             	push   0x8(%ebp)
    31fd:	e8 f1 00 00 00       	call   32f3 <open>
  if(fd < 0)
    3202:	83 c4 10             	add    $0x10,%esp
    3205:	85 c0                	test   %eax,%eax
    3207:	78 27                	js     3230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3209:	83 ec 08             	sub    $0x8,%esp
    320c:	ff 75 0c             	push   0xc(%ebp)
    320f:	89 c3                	mov    %eax,%ebx
    3211:	50                   	push   %eax
    3212:	e8 f4 00 00 00       	call   330b <fstat>
  close(fd);
    3217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    321a:	89 c6                	mov    %eax,%esi
  close(fd);
    321c:	e8 ba 00 00 00       	call   32db <close>
  return r;
    3221:	83 c4 10             	add    $0x10,%esp
}
    3224:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3227:	89 f0                	mov    %esi,%eax
    3229:	5b                   	pop    %ebx
    322a:	5e                   	pop    %esi
    322b:	5d                   	pop    %ebp
    322c:	c3                   	ret    
    322d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3230:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3235:	eb ed                	jmp    3224 <stat+0x34>
    3237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    323e:	66 90                	xchg   %ax,%ax

00003240 <atoi>:

int
atoi(const char *s)
{
    3240:	55                   	push   %ebp
    3241:	89 e5                	mov    %esp,%ebp
    3243:	53                   	push   %ebx
    3244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3247:	0f be 02             	movsbl (%edx),%eax
    324a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    324d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3250:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3255:	77 1e                	ja     3275 <atoi+0x35>
    3257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    325e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3260:	83 c2 01             	add    $0x1,%edx
    3263:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3266:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    326a:	0f be 02             	movsbl (%edx),%eax
    326d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3270:	80 fb 09             	cmp    $0x9,%bl
    3273:	76 eb                	jbe    3260 <atoi+0x20>
  return n;
}
    3275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3278:	89 c8                	mov    %ecx,%eax
    327a:	c9                   	leave  
    327b:	c3                   	ret    
    327c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	57                   	push   %edi
    3284:	8b 45 10             	mov    0x10(%ebp),%eax
    3287:	8b 55 08             	mov    0x8(%ebp),%edx
    328a:	56                   	push   %esi
    328b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    328e:	85 c0                	test   %eax,%eax
    3290:	7e 13                	jle    32a5 <memmove+0x25>
    3292:	01 d0                	add    %edx,%eax
  dst = vdst;
    3294:	89 d7                	mov    %edx,%edi
    3296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    32a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    32a1:	39 f8                	cmp    %edi,%eax
    32a3:	75 fb                	jne    32a0 <memmove+0x20>
  return vdst;
}
    32a5:	5e                   	pop    %esi
    32a6:	89 d0                	mov    %edx,%eax
    32a8:	5f                   	pop    %edi
    32a9:	5d                   	pop    %ebp
    32aa:	c3                   	ret    

000032ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    32ab:	b8 01 00 00 00       	mov    $0x1,%eax
    32b0:	cd 40                	int    $0x40
    32b2:	c3                   	ret    

000032b3 <exit>:
SYSCALL(exit)
    32b3:	b8 02 00 00 00       	mov    $0x2,%eax
    32b8:	cd 40                	int    $0x40
    32ba:	c3                   	ret    

000032bb <wait>:
SYSCALL(wait)
    32bb:	b8 03 00 00 00       	mov    $0x3,%eax
    32c0:	cd 40                	int    $0x40
    32c2:	c3                   	ret    

000032c3 <pipe>:
SYSCALL(pipe)
    32c3:	b8 04 00 00 00       	mov    $0x4,%eax
    32c8:	cd 40                	int    $0x40
    32ca:	c3                   	ret    

000032cb <read>:
SYSCALL(read)
    32cb:	b8 05 00 00 00       	mov    $0x5,%eax
    32d0:	cd 40                	int    $0x40
    32d2:	c3                   	ret    

000032d3 <write>:
SYSCALL(write)
    32d3:	b8 10 00 00 00       	mov    $0x10,%eax
    32d8:	cd 40                	int    $0x40
    32da:	c3                   	ret    

000032db <close>:
SYSCALL(close)
    32db:	b8 15 00 00 00       	mov    $0x15,%eax
    32e0:	cd 40                	int    $0x40
    32e2:	c3                   	ret    

000032e3 <kill>:
SYSCALL(kill)
    32e3:	b8 06 00 00 00       	mov    $0x6,%eax
    32e8:	cd 40                	int    $0x40
    32ea:	c3                   	ret    

000032eb <exec>:
SYSCALL(exec)
    32eb:	b8 07 00 00 00       	mov    $0x7,%eax
    32f0:	cd 40                	int    $0x40
    32f2:	c3                   	ret    

000032f3 <open>:
SYSCALL(open)
    32f3:	b8 0f 00 00 00       	mov    $0xf,%eax
    32f8:	cd 40                	int    $0x40
    32fa:	c3                   	ret    

000032fb <mknod>:
SYSCALL(mknod)
    32fb:	b8 11 00 00 00       	mov    $0x11,%eax
    3300:	cd 40                	int    $0x40
    3302:	c3                   	ret    

00003303 <unlink>:
SYSCALL(unlink)
    3303:	b8 12 00 00 00       	mov    $0x12,%eax
    3308:	cd 40                	int    $0x40
    330a:	c3                   	ret    

0000330b <fstat>:
SYSCALL(fstat)
    330b:	b8 08 00 00 00       	mov    $0x8,%eax
    3310:	cd 40                	int    $0x40
    3312:	c3                   	ret    

00003313 <link>:
SYSCALL(link)
    3313:	b8 13 00 00 00       	mov    $0x13,%eax
    3318:	cd 40                	int    $0x40
    331a:	c3                   	ret    

0000331b <mkdir>:
SYSCALL(mkdir)
    331b:	b8 14 00 00 00       	mov    $0x14,%eax
    3320:	cd 40                	int    $0x40
    3322:	c3                   	ret    

00003323 <chdir>:
SYSCALL(chdir)
    3323:	b8 09 00 00 00       	mov    $0x9,%eax
    3328:	cd 40                	int    $0x40
    332a:	c3                   	ret    

0000332b <dup>:
SYSCALL(dup)
    332b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3330:	cd 40                	int    $0x40
    3332:	c3                   	ret    

00003333 <getpid>:
SYSCALL(getpid)
    3333:	b8 0b 00 00 00       	mov    $0xb,%eax
    3338:	cd 40                	int    $0x40
    333a:	c3                   	ret    

0000333b <sbrk>:
SYSCALL(sbrk)
    333b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3340:	cd 40                	int    $0x40
    3342:	c3                   	ret    

00003343 <sleep>:
SYSCALL(sleep)
    3343:	b8 0d 00 00 00       	mov    $0xd,%eax
    3348:	cd 40                	int    $0x40
    334a:	c3                   	ret    

0000334b <uptime>:
SYSCALL(uptime)
    334b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3350:	cd 40                	int    $0x40
    3352:	c3                   	ret    

00003353 <uniq>:
SYSCALL(uniq)
    3353:	b8 16 00 00 00       	mov    $0x16,%eax
    3358:	cd 40                	int    $0x40
    335a:	c3                   	ret    

0000335b <head>:
SYSCALL(head)
    335b:	b8 17 00 00 00       	mov    $0x17,%eax
    3360:	cd 40                	int    $0x40
    3362:	c3                   	ret    

00003363 <ps>:
    3363:	b8 18 00 00 00       	mov    $0x18,%eax
    3368:	cd 40                	int    $0x40
    336a:	c3                   	ret    
    336b:	66 90                	xchg   %ax,%ax
    336d:	66 90                	xchg   %ax,%ax
    336f:	90                   	nop

00003370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3370:	55                   	push   %ebp
    3371:	89 e5                	mov    %esp,%ebp
    3373:	57                   	push   %edi
    3374:	56                   	push   %esi
    3375:	53                   	push   %ebx
    3376:	83 ec 3c             	sub    $0x3c,%esp
    3379:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    337c:	89 d1                	mov    %edx,%ecx
{
    337e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3381:	85 d2                	test   %edx,%edx
    3383:	0f 89 7f 00 00 00    	jns    3408 <printint+0x98>
    3389:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    338d:	74 79                	je     3408 <printint+0x98>
    neg = 1;
    338f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3396:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3398:	31 db                	xor    %ebx,%ebx
    339a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    339d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    33a0:	89 c8                	mov    %ecx,%eax
    33a2:	31 d2                	xor    %edx,%edx
    33a4:	89 cf                	mov    %ecx,%edi
    33a6:	f7 75 c4             	divl   -0x3c(%ebp)
    33a9:	0f b6 92 bc 37 00 00 	movzbl 0x37bc(%edx),%edx
    33b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    33b3:	89 d8                	mov    %ebx,%eax
    33b5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    33b8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    33bb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    33be:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    33c1:	76 dd                	jbe    33a0 <printint+0x30>
  if(neg)
    33c3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    33c6:	85 c9                	test   %ecx,%ecx
    33c8:	74 0c                	je     33d6 <printint+0x66>
    buf[i++] = '-';
    33ca:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    33cf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    33d1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    33d6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    33d9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    33dd:	eb 07                	jmp    33e6 <printint+0x76>
    33df:	90                   	nop
    putc(fd, buf[i]);
    33e0:	0f b6 13             	movzbl (%ebx),%edx
    33e3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    33e6:	83 ec 04             	sub    $0x4,%esp
    33e9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    33ec:	6a 01                	push   $0x1
    33ee:	56                   	push   %esi
    33ef:	57                   	push   %edi
    33f0:	e8 de fe ff ff       	call   32d3 <write>
  while(--i >= 0)
    33f5:	83 c4 10             	add    $0x10,%esp
    33f8:	39 de                	cmp    %ebx,%esi
    33fa:	75 e4                	jne    33e0 <printint+0x70>
}
    33fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    33ff:	5b                   	pop    %ebx
    3400:	5e                   	pop    %esi
    3401:	5f                   	pop    %edi
    3402:	5d                   	pop    %ebp
    3403:	c3                   	ret    
    3404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3408:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    340f:	eb 87                	jmp    3398 <printint+0x28>
    3411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    341f:	90                   	nop

00003420 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3420:	55                   	push   %ebp
    3421:	89 e5                	mov    %esp,%ebp
    3423:	57                   	push   %edi
    3424:	56                   	push   %esi
    3425:	53                   	push   %ebx
    3426:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3429:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    342c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    342f:	0f b6 13             	movzbl (%ebx),%edx
    3432:	84 d2                	test   %dl,%dl
    3434:	74 6a                	je     34a0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3436:	8d 45 10             	lea    0x10(%ebp),%eax
    3439:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    343c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    343f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3441:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3444:	eb 36                	jmp    347c <printf+0x5c>
    3446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    344d:	8d 76 00             	lea    0x0(%esi),%esi
    3450:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3453:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3458:	83 f8 25             	cmp    $0x25,%eax
    345b:	74 15                	je     3472 <printf+0x52>
  write(fd, &c, 1);
    345d:	83 ec 04             	sub    $0x4,%esp
    3460:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3463:	6a 01                	push   $0x1
    3465:	57                   	push   %edi
    3466:	56                   	push   %esi
    3467:	e8 67 fe ff ff       	call   32d3 <write>
    346c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    346f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3472:	0f b6 13             	movzbl (%ebx),%edx
    3475:	83 c3 01             	add    $0x1,%ebx
    3478:	84 d2                	test   %dl,%dl
    347a:	74 24                	je     34a0 <printf+0x80>
    c = fmt[i] & 0xff;
    347c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    347f:	85 c9                	test   %ecx,%ecx
    3481:	74 cd                	je     3450 <printf+0x30>
      }
    } else if(state == '%'){
    3483:	83 f9 25             	cmp    $0x25,%ecx
    3486:	75 ea                	jne    3472 <printf+0x52>
      if(c == 'd'){
    3488:	83 f8 25             	cmp    $0x25,%eax
    348b:	0f 84 07 01 00 00    	je     3598 <printf+0x178>
    3491:	83 e8 63             	sub    $0x63,%eax
    3494:	83 f8 15             	cmp    $0x15,%eax
    3497:	77 17                	ja     34b0 <printf+0x90>
    3499:	ff 24 85 64 37 00 00 	jmp    *0x3764(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    34a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34a3:	5b                   	pop    %ebx
    34a4:	5e                   	pop    %esi
    34a5:	5f                   	pop    %edi
    34a6:	5d                   	pop    %ebp
    34a7:	c3                   	ret    
    34a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34af:	90                   	nop
  write(fd, &c, 1);
    34b0:	83 ec 04             	sub    $0x4,%esp
    34b3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    34b6:	6a 01                	push   $0x1
    34b8:	57                   	push   %edi
    34b9:	56                   	push   %esi
    34ba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    34be:	e8 10 fe ff ff       	call   32d3 <write>
        putc(fd, c);
    34c3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    34c7:	83 c4 0c             	add    $0xc,%esp
    34ca:	88 55 e7             	mov    %dl,-0x19(%ebp)
    34cd:	6a 01                	push   $0x1
    34cf:	57                   	push   %edi
    34d0:	56                   	push   %esi
    34d1:	e8 fd fd ff ff       	call   32d3 <write>
        putc(fd, c);
    34d6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34d9:	31 c9                	xor    %ecx,%ecx
    34db:	eb 95                	jmp    3472 <printf+0x52>
    34dd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    34e0:	83 ec 0c             	sub    $0xc,%esp
    34e3:	b9 10 00 00 00       	mov    $0x10,%ecx
    34e8:	6a 00                	push   $0x0
    34ea:	8b 45 d0             	mov    -0x30(%ebp),%eax
    34ed:	8b 10                	mov    (%eax),%edx
    34ef:	89 f0                	mov    %esi,%eax
    34f1:	e8 7a fe ff ff       	call   3370 <printint>
        ap++;
    34f6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    34fa:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34fd:	31 c9                	xor    %ecx,%ecx
    34ff:	e9 6e ff ff ff       	jmp    3472 <printf+0x52>
    3504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3508:	8b 45 d0             	mov    -0x30(%ebp),%eax
    350b:	8b 10                	mov    (%eax),%edx
        ap++;
    350d:	83 c0 04             	add    $0x4,%eax
    3510:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3513:	85 d2                	test   %edx,%edx
    3515:	0f 84 8d 00 00 00    	je     35a8 <printf+0x188>
        while(*s != 0){
    351b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    351e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3520:	84 c0                	test   %al,%al
    3522:	0f 84 4a ff ff ff    	je     3472 <printf+0x52>
    3528:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    352b:	89 d3                	mov    %edx,%ebx
    352d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3530:	83 ec 04             	sub    $0x4,%esp
          s++;
    3533:	83 c3 01             	add    $0x1,%ebx
    3536:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3539:	6a 01                	push   $0x1
    353b:	57                   	push   %edi
    353c:	56                   	push   %esi
    353d:	e8 91 fd ff ff       	call   32d3 <write>
        while(*s != 0){
    3542:	0f b6 03             	movzbl (%ebx),%eax
    3545:	83 c4 10             	add    $0x10,%esp
    3548:	84 c0                	test   %al,%al
    354a:	75 e4                	jne    3530 <printf+0x110>
      state = 0;
    354c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    354f:	31 c9                	xor    %ecx,%ecx
    3551:	e9 1c ff ff ff       	jmp    3472 <printf+0x52>
    3556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    355d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3560:	83 ec 0c             	sub    $0xc,%esp
    3563:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3568:	6a 01                	push   $0x1
    356a:	e9 7b ff ff ff       	jmp    34ea <printf+0xca>
    356f:	90                   	nop
        putc(fd, *ap);
    3570:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3573:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3576:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3578:	6a 01                	push   $0x1
    357a:	57                   	push   %edi
    357b:	56                   	push   %esi
        putc(fd, *ap);
    357c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    357f:	e8 4f fd ff ff       	call   32d3 <write>
        ap++;
    3584:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3588:	83 c4 10             	add    $0x10,%esp
      state = 0;
    358b:	31 c9                	xor    %ecx,%ecx
    358d:	e9 e0 fe ff ff       	jmp    3472 <printf+0x52>
    3592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3598:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    359b:	83 ec 04             	sub    $0x4,%esp
    359e:	e9 2a ff ff ff       	jmp    34cd <printf+0xad>
    35a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    35a7:	90                   	nop
          s = "(null)";
    35a8:	ba 5c 37 00 00       	mov    $0x375c,%edx
        while(*s != 0){
    35ad:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    35b0:	b8 28 00 00 00       	mov    $0x28,%eax
    35b5:	89 d3                	mov    %edx,%ebx
    35b7:	e9 74 ff ff ff       	jmp    3530 <printf+0x110>
    35bc:	66 90                	xchg   %ax,%ax
    35be:	66 90                	xchg   %ax,%ax

000035c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    35c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35c1:	a1 74 3a 00 00       	mov    0x3a74,%eax
{
    35c6:	89 e5                	mov    %esp,%ebp
    35c8:	57                   	push   %edi
    35c9:	56                   	push   %esi
    35ca:	53                   	push   %ebx
    35cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    35ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35d8:	89 c2                	mov    %eax,%edx
    35da:	8b 00                	mov    (%eax),%eax
    35dc:	39 ca                	cmp    %ecx,%edx
    35de:	73 30                	jae    3610 <free+0x50>
    35e0:	39 c1                	cmp    %eax,%ecx
    35e2:	72 04                	jb     35e8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    35e4:	39 c2                	cmp    %eax,%edx
    35e6:	72 f0                	jb     35d8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    35e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    35eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    35ee:	39 f8                	cmp    %edi,%eax
    35f0:	74 30                	je     3622 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    35f2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    35f5:	8b 42 04             	mov    0x4(%edx),%eax
    35f8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    35fb:	39 f1                	cmp    %esi,%ecx
    35fd:	74 3a                	je     3639 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    35ff:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3601:	5b                   	pop    %ebx
  freep = p;
    3602:	89 15 74 3a 00 00    	mov    %edx,0x3a74
}
    3608:	5e                   	pop    %esi
    3609:	5f                   	pop    %edi
    360a:	5d                   	pop    %ebp
    360b:	c3                   	ret    
    360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3610:	39 c2                	cmp    %eax,%edx
    3612:	72 c4                	jb     35d8 <free+0x18>
    3614:	39 c1                	cmp    %eax,%ecx
    3616:	73 c0                	jae    35d8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3618:	8b 73 fc             	mov    -0x4(%ebx),%esi
    361b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    361e:	39 f8                	cmp    %edi,%eax
    3620:	75 d0                	jne    35f2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3622:	03 70 04             	add    0x4(%eax),%esi
    3625:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3628:	8b 02                	mov    (%edx),%eax
    362a:	8b 00                	mov    (%eax),%eax
    362c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    362f:	8b 42 04             	mov    0x4(%edx),%eax
    3632:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3635:	39 f1                	cmp    %esi,%ecx
    3637:	75 c6                	jne    35ff <free+0x3f>
    p->s.size += bp->s.size;
    3639:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    363c:	89 15 74 3a 00 00    	mov    %edx,0x3a74
    p->s.size += bp->s.size;
    3642:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3645:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3648:	89 0a                	mov    %ecx,(%edx)
}
    364a:	5b                   	pop    %ebx
    364b:	5e                   	pop    %esi
    364c:	5f                   	pop    %edi
    364d:	5d                   	pop    %ebp
    364e:	c3                   	ret    
    364f:	90                   	nop

00003650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3650:	55                   	push   %ebp
    3651:	89 e5                	mov    %esp,%ebp
    3653:	57                   	push   %edi
    3654:	56                   	push   %esi
    3655:	53                   	push   %ebx
    3656:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3659:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    365c:	8b 3d 74 3a 00 00    	mov    0x3a74,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3662:	8d 70 07             	lea    0x7(%eax),%esi
    3665:	c1 ee 03             	shr    $0x3,%esi
    3668:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    366b:	85 ff                	test   %edi,%edi
    366d:	0f 84 9d 00 00 00    	je     3710 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3673:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3675:	8b 4a 04             	mov    0x4(%edx),%ecx
    3678:	39 f1                	cmp    %esi,%ecx
    367a:	73 6a                	jae    36e6 <malloc+0x96>
    367c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3681:	39 de                	cmp    %ebx,%esi
    3683:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3686:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    368d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3690:	eb 17                	jmp    36a9 <malloc+0x59>
    3692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3698:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    369a:	8b 48 04             	mov    0x4(%eax),%ecx
    369d:	39 f1                	cmp    %esi,%ecx
    369f:	73 4f                	jae    36f0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    36a1:	8b 3d 74 3a 00 00    	mov    0x3a74,%edi
    36a7:	89 c2                	mov    %eax,%edx
    36a9:	39 d7                	cmp    %edx,%edi
    36ab:	75 eb                	jne    3698 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    36ad:	83 ec 0c             	sub    $0xc,%esp
    36b0:	ff 75 e4             	push   -0x1c(%ebp)
    36b3:	e8 83 fc ff ff       	call   333b <sbrk>
  if(p == (char*)-1)
    36b8:	83 c4 10             	add    $0x10,%esp
    36bb:	83 f8 ff             	cmp    $0xffffffff,%eax
    36be:	74 1c                	je     36dc <malloc+0x8c>
  hp->s.size = nu;
    36c0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    36c3:	83 ec 0c             	sub    $0xc,%esp
    36c6:	83 c0 08             	add    $0x8,%eax
    36c9:	50                   	push   %eax
    36ca:	e8 f1 fe ff ff       	call   35c0 <free>
  return freep;
    36cf:	8b 15 74 3a 00 00    	mov    0x3a74,%edx
      if((p = morecore(nunits)) == 0)
    36d5:	83 c4 10             	add    $0x10,%esp
    36d8:	85 d2                	test   %edx,%edx
    36da:	75 bc                	jne    3698 <malloc+0x48>
        return 0;
  }
}
    36dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    36df:	31 c0                	xor    %eax,%eax
}
    36e1:	5b                   	pop    %ebx
    36e2:	5e                   	pop    %esi
    36e3:	5f                   	pop    %edi
    36e4:	5d                   	pop    %ebp
    36e5:	c3                   	ret    
    if(p->s.size >= nunits){
    36e6:	89 d0                	mov    %edx,%eax
    36e8:	89 fa                	mov    %edi,%edx
    36ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    36f0:	39 ce                	cmp    %ecx,%esi
    36f2:	74 4c                	je     3740 <malloc+0xf0>
        p->s.size -= nunits;
    36f4:	29 f1                	sub    %esi,%ecx
    36f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    36f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    36fc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    36ff:	89 15 74 3a 00 00    	mov    %edx,0x3a74
}
    3705:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3708:	83 c0 08             	add    $0x8,%eax
}
    370b:	5b                   	pop    %ebx
    370c:	5e                   	pop    %esi
    370d:	5f                   	pop    %edi
    370e:	5d                   	pop    %ebp
    370f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3710:	c7 05 74 3a 00 00 78 	movl   $0x3a78,0x3a74
    3717:	3a 00 00 
    base.s.size = 0;
    371a:	bf 78 3a 00 00       	mov    $0x3a78,%edi
    base.s.ptr = freep = prevp = &base;
    371f:	c7 05 78 3a 00 00 78 	movl   $0x3a78,0x3a78
    3726:	3a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3729:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    372b:	c7 05 7c 3a 00 00 00 	movl   $0x0,0x3a7c
    3732:	00 00 00 
    if(p->s.size >= nunits){
    3735:	e9 42 ff ff ff       	jmp    367c <malloc+0x2c>
    373a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3740:	8b 08                	mov    (%eax),%ecx
    3742:	89 0a                	mov    %ecx,(%edx)
    3744:	eb b9                	jmp    36ff <malloc+0xaf>
