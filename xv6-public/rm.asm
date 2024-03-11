
_rm:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	57                   	push   %edi
    300e:	bf 01 00 00 00       	mov    $0x1,%edi
    3013:	56                   	push   %esi
    3014:	53                   	push   %ebx
    3015:	51                   	push   %ecx
    3016:	83 ec 08             	sub    $0x8,%esp
    3019:	8b 59 04             	mov    0x4(%ecx),%ebx
    301c:	8b 31                	mov    (%ecx),%esi
    301e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
    3021:	83 fe 01             	cmp    $0x1,%esi
    3024:	7e 3e                	jle    3064 <main+0x64>
    3026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    302d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
    3030:	83 ec 0c             	sub    $0xc,%esp
    3033:	ff 33                	push   (%ebx)
    3035:	e8 e9 02 00 00       	call   3323 <unlink>
    303a:	83 c4 10             	add    $0x10,%esp
    303d:	85 c0                	test   %eax,%eax
    303f:	78 0f                	js     3050 <main+0x50>
  for(i = 1; i < argc; i++){
    3041:	83 c7 01             	add    $0x1,%edi
    3044:	83 c3 04             	add    $0x4,%ebx
    3047:	39 fe                	cmp    %edi,%esi
    3049:	75 e5                	jne    3030 <main+0x30>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
    304b:	e8 83 02 00 00       	call   32d3 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
    3050:	50                   	push   %eax
    3051:	ff 33                	push   (%ebx)
    3053:	68 7c 37 00 00       	push   $0x377c
    3058:	6a 02                	push   $0x2
    305a:	e8 e1 03 00 00       	call   3440 <printf>
      break;
    305f:	83 c4 10             	add    $0x10,%esp
    3062:	eb e7                	jmp    304b <main+0x4b>
    printf(2, "Usage: rm files...\n");
    3064:	52                   	push   %edx
    3065:	52                   	push   %edx
    3066:	68 68 37 00 00       	push   $0x3768
    306b:	6a 02                	push   $0x2
    306d:	e8 ce 03 00 00       	call   3440 <printf>
    exit();
    3072:	e8 5c 02 00 00       	call   32d3 <exit>
    3077:	66 90                	xchg   %ax,%ax
    3079:	66 90                	xchg   %ax,%ax
    307b:	66 90                	xchg   %ax,%ax
    307d:	66 90                	xchg   %ax,%ax
    307f:	90                   	nop

00003080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3080:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3081:	31 c0                	xor    %eax,%eax
{
    3083:	89 e5                	mov    %esp,%ebp
    3085:	53                   	push   %ebx
    3086:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3089:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    308c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3090:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3094:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3097:	83 c0 01             	add    $0x1,%eax
    309a:	84 d2                	test   %dl,%dl
    309c:	75 f2                	jne    3090 <strcpy+0x10>
    ;
  return os;
}
    309e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30a1:	89 c8                	mov    %ecx,%eax
    30a3:	c9                   	leave  
    30a4:	c3                   	ret    
    30a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000030b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30b0:	55                   	push   %ebp
    30b1:	89 e5                	mov    %esp,%ebp
    30b3:	53                   	push   %ebx
    30b4:	8b 55 08             	mov    0x8(%ebp),%edx
    30b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    30ba:	0f b6 02             	movzbl (%edx),%eax
    30bd:	84 c0                	test   %al,%al
    30bf:	75 17                	jne    30d8 <strcmp+0x28>
    30c1:	eb 3a                	jmp    30fd <strcmp+0x4d>
    30c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30c7:	90                   	nop
    30c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    30cc:	83 c2 01             	add    $0x1,%edx
    30cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    30d2:	84 c0                	test   %al,%al
    30d4:	74 1a                	je     30f0 <strcmp+0x40>
    p++, q++;
    30d6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    30d8:	0f b6 19             	movzbl (%ecx),%ebx
    30db:	38 c3                	cmp    %al,%bl
    30dd:	74 e9                	je     30c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    30df:	29 d8                	sub    %ebx,%eax
}
    30e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30e4:	c9                   	leave  
    30e5:	c3                   	ret    
    30e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30ed:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    30f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    30f4:	31 c0                	xor    %eax,%eax
    30f6:	29 d8                	sub    %ebx,%eax
}
    30f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30fb:	c9                   	leave  
    30fc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    30fd:	0f b6 19             	movzbl (%ecx),%ebx
    3100:	31 c0                	xor    %eax,%eax
    3102:	eb db                	jmp    30df <strcmp+0x2f>
    3104:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    310b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    310f:	90                   	nop

00003110 <strlen>:

uint
strlen(const char *s)
{
    3110:	55                   	push   %ebp
    3111:	89 e5                	mov    %esp,%ebp
    3113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3116:	80 3a 00             	cmpb   $0x0,(%edx)
    3119:	74 15                	je     3130 <strlen+0x20>
    311b:	31 c0                	xor    %eax,%eax
    311d:	8d 76 00             	lea    0x0(%esi),%esi
    3120:	83 c0 01             	add    $0x1,%eax
    3123:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3127:	89 c1                	mov    %eax,%ecx
    3129:	75 f5                	jne    3120 <strlen+0x10>
    ;
  return n;
}
    312b:	89 c8                	mov    %ecx,%eax
    312d:	5d                   	pop    %ebp
    312e:	c3                   	ret    
    312f:	90                   	nop
  for(n = 0; s[n]; n++)
    3130:	31 c9                	xor    %ecx,%ecx
}
    3132:	5d                   	pop    %ebp
    3133:	89 c8                	mov    %ecx,%eax
    3135:	c3                   	ret    
    3136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    313d:	8d 76 00             	lea    0x0(%esi),%esi

00003140 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	57                   	push   %edi
    3144:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3147:	8b 4d 10             	mov    0x10(%ebp),%ecx
    314a:	8b 45 0c             	mov    0xc(%ebp),%eax
    314d:	89 d7                	mov    %edx,%edi
    314f:	fc                   	cld    
    3150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3152:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3155:	89 d0                	mov    %edx,%eax
    3157:	c9                   	leave  
    3158:	c3                   	ret    
    3159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003160 <strchr>:

char*
strchr(const char *s, char c)
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	8b 45 08             	mov    0x8(%ebp),%eax
    3166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    316a:	0f b6 10             	movzbl (%eax),%edx
    316d:	84 d2                	test   %dl,%dl
    316f:	75 12                	jne    3183 <strchr+0x23>
    3171:	eb 1d                	jmp    3190 <strchr+0x30>
    3173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3177:	90                   	nop
    3178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    317c:	83 c0 01             	add    $0x1,%eax
    317f:	84 d2                	test   %dl,%dl
    3181:	74 0d                	je     3190 <strchr+0x30>
    if(*s == c)
    3183:	38 d1                	cmp    %dl,%cl
    3185:	75 f1                	jne    3178 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3187:	5d                   	pop    %ebp
    3188:	c3                   	ret    
    3189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3190:	31 c0                	xor    %eax,%eax
}
    3192:	5d                   	pop    %ebp
    3193:	c3                   	ret    
    3194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    319b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    319f:	90                   	nop

000031a0 <gets>:

char*
gets(char *buf, int max)
{
    31a0:	55                   	push   %ebp
    31a1:	89 e5                	mov    %esp,%ebp
    31a3:	57                   	push   %edi
    31a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    31a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    31a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    31a9:	31 db                	xor    %ebx,%ebx
{
    31ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    31ae:	eb 27                	jmp    31d7 <gets+0x37>
    cc = read(0, &c, 1);
    31b0:	83 ec 04             	sub    $0x4,%esp
    31b3:	6a 01                	push   $0x1
    31b5:	57                   	push   %edi
    31b6:	6a 00                	push   $0x0
    31b8:	e8 2e 01 00 00       	call   32eb <read>
    if(cc < 1)
    31bd:	83 c4 10             	add    $0x10,%esp
    31c0:	85 c0                	test   %eax,%eax
    31c2:	7e 1d                	jle    31e1 <gets+0x41>
      break;
    buf[i++] = c;
    31c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    31c8:	8b 55 08             	mov    0x8(%ebp),%edx
    31cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    31cf:	3c 0a                	cmp    $0xa,%al
    31d1:	74 1d                	je     31f0 <gets+0x50>
    31d3:	3c 0d                	cmp    $0xd,%al
    31d5:	74 19                	je     31f0 <gets+0x50>
  for(i=0; i+1 < max; ){
    31d7:	89 de                	mov    %ebx,%esi
    31d9:	83 c3 01             	add    $0x1,%ebx
    31dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    31df:	7c cf                	jl     31b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    31e1:	8b 45 08             	mov    0x8(%ebp),%eax
    31e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    31e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31eb:	5b                   	pop    %ebx
    31ec:	5e                   	pop    %esi
    31ed:	5f                   	pop    %edi
    31ee:	5d                   	pop    %ebp
    31ef:	c3                   	ret    
  buf[i] = '\0';
    31f0:	8b 45 08             	mov    0x8(%ebp),%eax
    31f3:	89 de                	mov    %ebx,%esi
    31f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    31f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    31fc:	5b                   	pop    %ebx
    31fd:	5e                   	pop    %esi
    31fe:	5f                   	pop    %edi
    31ff:	5d                   	pop    %ebp
    3200:	c3                   	ret    
    3201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    320f:	90                   	nop

00003210 <stat>:

int
stat(const char *n, struct stat *st)
{
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	56                   	push   %esi
    3214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3215:	83 ec 08             	sub    $0x8,%esp
    3218:	6a 00                	push   $0x0
    321a:	ff 75 08             	push   0x8(%ebp)
    321d:	e8 f1 00 00 00       	call   3313 <open>
  if(fd < 0)
    3222:	83 c4 10             	add    $0x10,%esp
    3225:	85 c0                	test   %eax,%eax
    3227:	78 27                	js     3250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3229:	83 ec 08             	sub    $0x8,%esp
    322c:	ff 75 0c             	push   0xc(%ebp)
    322f:	89 c3                	mov    %eax,%ebx
    3231:	50                   	push   %eax
    3232:	e8 f4 00 00 00       	call   332b <fstat>
  close(fd);
    3237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    323a:	89 c6                	mov    %eax,%esi
  close(fd);
    323c:	e8 ba 00 00 00       	call   32fb <close>
  return r;
    3241:	83 c4 10             	add    $0x10,%esp
}
    3244:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3247:	89 f0                	mov    %esi,%eax
    3249:	5b                   	pop    %ebx
    324a:	5e                   	pop    %esi
    324b:	5d                   	pop    %ebp
    324c:	c3                   	ret    
    324d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3250:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3255:	eb ed                	jmp    3244 <stat+0x34>
    3257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    325e:	66 90                	xchg   %ax,%ax

00003260 <atoi>:

int
atoi(const char *s)
{
    3260:	55                   	push   %ebp
    3261:	89 e5                	mov    %esp,%ebp
    3263:	53                   	push   %ebx
    3264:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3267:	0f be 02             	movsbl (%edx),%eax
    326a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    326d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3270:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3275:	77 1e                	ja     3295 <atoi+0x35>
    3277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    327e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3280:	83 c2 01             	add    $0x1,%edx
    3283:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3286:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    328a:	0f be 02             	movsbl (%edx),%eax
    328d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3290:	80 fb 09             	cmp    $0x9,%bl
    3293:	76 eb                	jbe    3280 <atoi+0x20>
  return n;
}
    3295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3298:	89 c8                	mov    %ecx,%eax
    329a:	c9                   	leave  
    329b:	c3                   	ret    
    329c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000032a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	57                   	push   %edi
    32a4:	8b 45 10             	mov    0x10(%ebp),%eax
    32a7:	8b 55 08             	mov    0x8(%ebp),%edx
    32aa:	56                   	push   %esi
    32ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    32ae:	85 c0                	test   %eax,%eax
    32b0:	7e 13                	jle    32c5 <memmove+0x25>
    32b2:	01 d0                	add    %edx,%eax
  dst = vdst;
    32b4:	89 d7                	mov    %edx,%edi
    32b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    32c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    32c1:	39 f8                	cmp    %edi,%eax
    32c3:	75 fb                	jne    32c0 <memmove+0x20>
  return vdst;
}
    32c5:	5e                   	pop    %esi
    32c6:	89 d0                	mov    %edx,%eax
    32c8:	5f                   	pop    %edi
    32c9:	5d                   	pop    %ebp
    32ca:	c3                   	ret    

000032cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    32cb:	b8 01 00 00 00       	mov    $0x1,%eax
    32d0:	cd 40                	int    $0x40
    32d2:	c3                   	ret    

000032d3 <exit>:
SYSCALL(exit)
    32d3:	b8 02 00 00 00       	mov    $0x2,%eax
    32d8:	cd 40                	int    $0x40
    32da:	c3                   	ret    

000032db <wait>:
SYSCALL(wait)
    32db:	b8 03 00 00 00       	mov    $0x3,%eax
    32e0:	cd 40                	int    $0x40
    32e2:	c3                   	ret    

000032e3 <pipe>:
SYSCALL(pipe)
    32e3:	b8 04 00 00 00       	mov    $0x4,%eax
    32e8:	cd 40                	int    $0x40
    32ea:	c3                   	ret    

000032eb <read>:
SYSCALL(read)
    32eb:	b8 05 00 00 00       	mov    $0x5,%eax
    32f0:	cd 40                	int    $0x40
    32f2:	c3                   	ret    

000032f3 <write>:
SYSCALL(write)
    32f3:	b8 10 00 00 00       	mov    $0x10,%eax
    32f8:	cd 40                	int    $0x40
    32fa:	c3                   	ret    

000032fb <close>:
SYSCALL(close)
    32fb:	b8 15 00 00 00       	mov    $0x15,%eax
    3300:	cd 40                	int    $0x40
    3302:	c3                   	ret    

00003303 <kill>:
SYSCALL(kill)
    3303:	b8 06 00 00 00       	mov    $0x6,%eax
    3308:	cd 40                	int    $0x40
    330a:	c3                   	ret    

0000330b <exec>:
SYSCALL(exec)
    330b:	b8 07 00 00 00       	mov    $0x7,%eax
    3310:	cd 40                	int    $0x40
    3312:	c3                   	ret    

00003313 <open>:
SYSCALL(open)
    3313:	b8 0f 00 00 00       	mov    $0xf,%eax
    3318:	cd 40                	int    $0x40
    331a:	c3                   	ret    

0000331b <mknod>:
SYSCALL(mknod)
    331b:	b8 11 00 00 00       	mov    $0x11,%eax
    3320:	cd 40                	int    $0x40
    3322:	c3                   	ret    

00003323 <unlink>:
SYSCALL(unlink)
    3323:	b8 12 00 00 00       	mov    $0x12,%eax
    3328:	cd 40                	int    $0x40
    332a:	c3                   	ret    

0000332b <fstat>:
SYSCALL(fstat)
    332b:	b8 08 00 00 00       	mov    $0x8,%eax
    3330:	cd 40                	int    $0x40
    3332:	c3                   	ret    

00003333 <link>:
SYSCALL(link)
    3333:	b8 13 00 00 00       	mov    $0x13,%eax
    3338:	cd 40                	int    $0x40
    333a:	c3                   	ret    

0000333b <mkdir>:
SYSCALL(mkdir)
    333b:	b8 14 00 00 00       	mov    $0x14,%eax
    3340:	cd 40                	int    $0x40
    3342:	c3                   	ret    

00003343 <chdir>:
SYSCALL(chdir)
    3343:	b8 09 00 00 00       	mov    $0x9,%eax
    3348:	cd 40                	int    $0x40
    334a:	c3                   	ret    

0000334b <dup>:
SYSCALL(dup)
    334b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3350:	cd 40                	int    $0x40
    3352:	c3                   	ret    

00003353 <getpid>:
SYSCALL(getpid)
    3353:	b8 0b 00 00 00       	mov    $0xb,%eax
    3358:	cd 40                	int    $0x40
    335a:	c3                   	ret    

0000335b <sbrk>:
SYSCALL(sbrk)
    335b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3360:	cd 40                	int    $0x40
    3362:	c3                   	ret    

00003363 <sleep>:
SYSCALL(sleep)
    3363:	b8 0d 00 00 00       	mov    $0xd,%eax
    3368:	cd 40                	int    $0x40
    336a:	c3                   	ret    

0000336b <uptime>:
SYSCALL(uptime)
    336b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3370:	cd 40                	int    $0x40
    3372:	c3                   	ret    

00003373 <uniq>:
SYSCALL(uniq)
    3373:	b8 16 00 00 00       	mov    $0x16,%eax
    3378:	cd 40                	int    $0x40
    337a:	c3                   	ret    

0000337b <head>:
SYSCALL(head)
    337b:	b8 17 00 00 00       	mov    $0x17,%eax
    3380:	cd 40                	int    $0x40
    3382:	c3                   	ret    

00003383 <ps>:
    3383:	b8 18 00 00 00       	mov    $0x18,%eax
    3388:	cd 40                	int    $0x40
    338a:	c3                   	ret    
    338b:	66 90                	xchg   %ax,%ax
    338d:	66 90                	xchg   %ax,%ax
    338f:	90                   	nop

00003390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3390:	55                   	push   %ebp
    3391:	89 e5                	mov    %esp,%ebp
    3393:	57                   	push   %edi
    3394:	56                   	push   %esi
    3395:	53                   	push   %ebx
    3396:	83 ec 3c             	sub    $0x3c,%esp
    3399:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    339c:	89 d1                	mov    %edx,%ecx
{
    339e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    33a1:	85 d2                	test   %edx,%edx
    33a3:	0f 89 7f 00 00 00    	jns    3428 <printint+0x98>
    33a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    33ad:	74 79                	je     3428 <printint+0x98>
    neg = 1;
    33af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    33b6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    33b8:	31 db                	xor    %ebx,%ebx
    33ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
    33bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    33c0:	89 c8                	mov    %ecx,%eax
    33c2:	31 d2                	xor    %edx,%edx
    33c4:	89 cf                	mov    %ecx,%edi
    33c6:	f7 75 c4             	divl   -0x3c(%ebp)
    33c9:	0f b6 92 f4 37 00 00 	movzbl 0x37f4(%edx),%edx
    33d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    33d3:	89 d8                	mov    %ebx,%eax
    33d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    33d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    33db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    33de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    33e1:	76 dd                	jbe    33c0 <printint+0x30>
  if(neg)
    33e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    33e6:	85 c9                	test   %ecx,%ecx
    33e8:	74 0c                	je     33f6 <printint+0x66>
    buf[i++] = '-';
    33ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    33ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    33f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    33f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    33f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    33fd:	eb 07                	jmp    3406 <printint+0x76>
    33ff:	90                   	nop
    putc(fd, buf[i]);
    3400:	0f b6 13             	movzbl (%ebx),%edx
    3403:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3406:	83 ec 04             	sub    $0x4,%esp
    3409:	88 55 d7             	mov    %dl,-0x29(%ebp)
    340c:	6a 01                	push   $0x1
    340e:	56                   	push   %esi
    340f:	57                   	push   %edi
    3410:	e8 de fe ff ff       	call   32f3 <write>
  while(--i >= 0)
    3415:	83 c4 10             	add    $0x10,%esp
    3418:	39 de                	cmp    %ebx,%esi
    341a:	75 e4                	jne    3400 <printint+0x70>
}
    341c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    341f:	5b                   	pop    %ebx
    3420:	5e                   	pop    %esi
    3421:	5f                   	pop    %edi
    3422:	5d                   	pop    %ebp
    3423:	c3                   	ret    
    3424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3428:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    342f:	eb 87                	jmp    33b8 <printint+0x28>
    3431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    343f:	90                   	nop

00003440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3440:	55                   	push   %ebp
    3441:	89 e5                	mov    %esp,%ebp
    3443:	57                   	push   %edi
    3444:	56                   	push   %esi
    3445:	53                   	push   %ebx
    3446:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3449:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    344c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    344f:	0f b6 13             	movzbl (%ebx),%edx
    3452:	84 d2                	test   %dl,%dl
    3454:	74 6a                	je     34c0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3456:	8d 45 10             	lea    0x10(%ebp),%eax
    3459:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    345c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    345f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3461:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3464:	eb 36                	jmp    349c <printf+0x5c>
    3466:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    346d:	8d 76 00             	lea    0x0(%esi),%esi
    3470:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3473:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3478:	83 f8 25             	cmp    $0x25,%eax
    347b:	74 15                	je     3492 <printf+0x52>
  write(fd, &c, 1);
    347d:	83 ec 04             	sub    $0x4,%esp
    3480:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3483:	6a 01                	push   $0x1
    3485:	57                   	push   %edi
    3486:	56                   	push   %esi
    3487:	e8 67 fe ff ff       	call   32f3 <write>
    348c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    348f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3492:	0f b6 13             	movzbl (%ebx),%edx
    3495:	83 c3 01             	add    $0x1,%ebx
    3498:	84 d2                	test   %dl,%dl
    349a:	74 24                	je     34c0 <printf+0x80>
    c = fmt[i] & 0xff;
    349c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    349f:	85 c9                	test   %ecx,%ecx
    34a1:	74 cd                	je     3470 <printf+0x30>
      }
    } else if(state == '%'){
    34a3:	83 f9 25             	cmp    $0x25,%ecx
    34a6:	75 ea                	jne    3492 <printf+0x52>
      if(c == 'd'){
    34a8:	83 f8 25             	cmp    $0x25,%eax
    34ab:	0f 84 07 01 00 00    	je     35b8 <printf+0x178>
    34b1:	83 e8 63             	sub    $0x63,%eax
    34b4:	83 f8 15             	cmp    $0x15,%eax
    34b7:	77 17                	ja     34d0 <printf+0x90>
    34b9:	ff 24 85 9c 37 00 00 	jmp    *0x379c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    34c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34c3:	5b                   	pop    %ebx
    34c4:	5e                   	pop    %esi
    34c5:	5f                   	pop    %edi
    34c6:	5d                   	pop    %ebp
    34c7:	c3                   	ret    
    34c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34cf:	90                   	nop
  write(fd, &c, 1);
    34d0:	83 ec 04             	sub    $0x4,%esp
    34d3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    34d6:	6a 01                	push   $0x1
    34d8:	57                   	push   %edi
    34d9:	56                   	push   %esi
    34da:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    34de:	e8 10 fe ff ff       	call   32f3 <write>
        putc(fd, c);
    34e3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    34e7:	83 c4 0c             	add    $0xc,%esp
    34ea:	88 55 e7             	mov    %dl,-0x19(%ebp)
    34ed:	6a 01                	push   $0x1
    34ef:	57                   	push   %edi
    34f0:	56                   	push   %esi
    34f1:	e8 fd fd ff ff       	call   32f3 <write>
        putc(fd, c);
    34f6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    34f9:	31 c9                	xor    %ecx,%ecx
    34fb:	eb 95                	jmp    3492 <printf+0x52>
    34fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3500:	83 ec 0c             	sub    $0xc,%esp
    3503:	b9 10 00 00 00       	mov    $0x10,%ecx
    3508:	6a 00                	push   $0x0
    350a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    350d:	8b 10                	mov    (%eax),%edx
    350f:	89 f0                	mov    %esi,%eax
    3511:	e8 7a fe ff ff       	call   3390 <printint>
        ap++;
    3516:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    351a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    351d:	31 c9                	xor    %ecx,%ecx
    351f:	e9 6e ff ff ff       	jmp    3492 <printf+0x52>
    3524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3528:	8b 45 d0             	mov    -0x30(%ebp),%eax
    352b:	8b 10                	mov    (%eax),%edx
        ap++;
    352d:	83 c0 04             	add    $0x4,%eax
    3530:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3533:	85 d2                	test   %edx,%edx
    3535:	0f 84 8d 00 00 00    	je     35c8 <printf+0x188>
        while(*s != 0){
    353b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    353e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3540:	84 c0                	test   %al,%al
    3542:	0f 84 4a ff ff ff    	je     3492 <printf+0x52>
    3548:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    354b:	89 d3                	mov    %edx,%ebx
    354d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3550:	83 ec 04             	sub    $0x4,%esp
          s++;
    3553:	83 c3 01             	add    $0x1,%ebx
    3556:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3559:	6a 01                	push   $0x1
    355b:	57                   	push   %edi
    355c:	56                   	push   %esi
    355d:	e8 91 fd ff ff       	call   32f3 <write>
        while(*s != 0){
    3562:	0f b6 03             	movzbl (%ebx),%eax
    3565:	83 c4 10             	add    $0x10,%esp
    3568:	84 c0                	test   %al,%al
    356a:	75 e4                	jne    3550 <printf+0x110>
      state = 0;
    356c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    356f:	31 c9                	xor    %ecx,%ecx
    3571:	e9 1c ff ff ff       	jmp    3492 <printf+0x52>
    3576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    357d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3580:	83 ec 0c             	sub    $0xc,%esp
    3583:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3588:	6a 01                	push   $0x1
    358a:	e9 7b ff ff ff       	jmp    350a <printf+0xca>
    358f:	90                   	nop
        putc(fd, *ap);
    3590:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3593:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3596:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3598:	6a 01                	push   $0x1
    359a:	57                   	push   %edi
    359b:	56                   	push   %esi
        putc(fd, *ap);
    359c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    359f:	e8 4f fd ff ff       	call   32f3 <write>
        ap++;
    35a4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    35a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    35ab:	31 c9                	xor    %ecx,%ecx
    35ad:	e9 e0 fe ff ff       	jmp    3492 <printf+0x52>
    35b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    35b8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    35bb:	83 ec 04             	sub    $0x4,%esp
    35be:	e9 2a ff ff ff       	jmp    34ed <printf+0xad>
    35c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    35c7:	90                   	nop
          s = "(null)";
    35c8:	ba 95 37 00 00       	mov    $0x3795,%edx
        while(*s != 0){
    35cd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    35d0:	b8 28 00 00 00       	mov    $0x28,%eax
    35d5:	89 d3                	mov    %edx,%ebx
    35d7:	e9 74 ff ff ff       	jmp    3550 <printf+0x110>
    35dc:	66 90                	xchg   %ax,%ax
    35de:	66 90                	xchg   %ax,%ax

000035e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    35e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35e1:	a1 ac 3a 00 00       	mov    0x3aac,%eax
{
    35e6:	89 e5                	mov    %esp,%ebp
    35e8:	57                   	push   %edi
    35e9:	56                   	push   %esi
    35ea:	53                   	push   %ebx
    35eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    35ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    35f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35f8:	89 c2                	mov    %eax,%edx
    35fa:	8b 00                	mov    (%eax),%eax
    35fc:	39 ca                	cmp    %ecx,%edx
    35fe:	73 30                	jae    3630 <free+0x50>
    3600:	39 c1                	cmp    %eax,%ecx
    3602:	72 04                	jb     3608 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3604:	39 c2                	cmp    %eax,%edx
    3606:	72 f0                	jb     35f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3608:	8b 73 fc             	mov    -0x4(%ebx),%esi
    360b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    360e:	39 f8                	cmp    %edi,%eax
    3610:	74 30                	je     3642 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3612:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3615:	8b 42 04             	mov    0x4(%edx),%eax
    3618:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    361b:	39 f1                	cmp    %esi,%ecx
    361d:	74 3a                	je     3659 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    361f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3621:	5b                   	pop    %ebx
  freep = p;
    3622:	89 15 ac 3a 00 00    	mov    %edx,0x3aac
}
    3628:	5e                   	pop    %esi
    3629:	5f                   	pop    %edi
    362a:	5d                   	pop    %ebp
    362b:	c3                   	ret    
    362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3630:	39 c2                	cmp    %eax,%edx
    3632:	72 c4                	jb     35f8 <free+0x18>
    3634:	39 c1                	cmp    %eax,%ecx
    3636:	73 c0                	jae    35f8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3638:	8b 73 fc             	mov    -0x4(%ebx),%esi
    363b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    363e:	39 f8                	cmp    %edi,%eax
    3640:	75 d0                	jne    3612 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3642:	03 70 04             	add    0x4(%eax),%esi
    3645:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3648:	8b 02                	mov    (%edx),%eax
    364a:	8b 00                	mov    (%eax),%eax
    364c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    364f:	8b 42 04             	mov    0x4(%edx),%eax
    3652:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3655:	39 f1                	cmp    %esi,%ecx
    3657:	75 c6                	jne    361f <free+0x3f>
    p->s.size += bp->s.size;
    3659:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    365c:	89 15 ac 3a 00 00    	mov    %edx,0x3aac
    p->s.size += bp->s.size;
    3662:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3665:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3668:	89 0a                	mov    %ecx,(%edx)
}
    366a:	5b                   	pop    %ebx
    366b:	5e                   	pop    %esi
    366c:	5f                   	pop    %edi
    366d:	5d                   	pop    %ebp
    366e:	c3                   	ret    
    366f:	90                   	nop

00003670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3670:	55                   	push   %ebp
    3671:	89 e5                	mov    %esp,%ebp
    3673:	57                   	push   %edi
    3674:	56                   	push   %esi
    3675:	53                   	push   %ebx
    3676:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    367c:	8b 3d ac 3a 00 00    	mov    0x3aac,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3682:	8d 70 07             	lea    0x7(%eax),%esi
    3685:	c1 ee 03             	shr    $0x3,%esi
    3688:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    368b:	85 ff                	test   %edi,%edi
    368d:	0f 84 9d 00 00 00    	je     3730 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3693:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3695:	8b 4a 04             	mov    0x4(%edx),%ecx
    3698:	39 f1                	cmp    %esi,%ecx
    369a:	73 6a                	jae    3706 <malloc+0x96>
    369c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    36a1:	39 de                	cmp    %ebx,%esi
    36a3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    36a6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    36ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    36b0:	eb 17                	jmp    36c9 <malloc+0x59>
    36b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    36b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    36ba:	8b 48 04             	mov    0x4(%eax),%ecx
    36bd:	39 f1                	cmp    %esi,%ecx
    36bf:	73 4f                	jae    3710 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    36c1:	8b 3d ac 3a 00 00    	mov    0x3aac,%edi
    36c7:	89 c2                	mov    %eax,%edx
    36c9:	39 d7                	cmp    %edx,%edi
    36cb:	75 eb                	jne    36b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    36cd:	83 ec 0c             	sub    $0xc,%esp
    36d0:	ff 75 e4             	push   -0x1c(%ebp)
    36d3:	e8 83 fc ff ff       	call   335b <sbrk>
  if(p == (char*)-1)
    36d8:	83 c4 10             	add    $0x10,%esp
    36db:	83 f8 ff             	cmp    $0xffffffff,%eax
    36de:	74 1c                	je     36fc <malloc+0x8c>
  hp->s.size = nu;
    36e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    36e3:	83 ec 0c             	sub    $0xc,%esp
    36e6:	83 c0 08             	add    $0x8,%eax
    36e9:	50                   	push   %eax
    36ea:	e8 f1 fe ff ff       	call   35e0 <free>
  return freep;
    36ef:	8b 15 ac 3a 00 00    	mov    0x3aac,%edx
      if((p = morecore(nunits)) == 0)
    36f5:	83 c4 10             	add    $0x10,%esp
    36f8:	85 d2                	test   %edx,%edx
    36fa:	75 bc                	jne    36b8 <malloc+0x48>
        return 0;
  }
}
    36fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    36ff:	31 c0                	xor    %eax,%eax
}
    3701:	5b                   	pop    %ebx
    3702:	5e                   	pop    %esi
    3703:	5f                   	pop    %edi
    3704:	5d                   	pop    %ebp
    3705:	c3                   	ret    
    if(p->s.size >= nunits){
    3706:	89 d0                	mov    %edx,%eax
    3708:	89 fa                	mov    %edi,%edx
    370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3710:	39 ce                	cmp    %ecx,%esi
    3712:	74 4c                	je     3760 <malloc+0xf0>
        p->s.size -= nunits;
    3714:	29 f1                	sub    %esi,%ecx
    3716:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3719:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    371c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    371f:	89 15 ac 3a 00 00    	mov    %edx,0x3aac
}
    3725:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3728:	83 c0 08             	add    $0x8,%eax
}
    372b:	5b                   	pop    %ebx
    372c:	5e                   	pop    %esi
    372d:	5f                   	pop    %edi
    372e:	5d                   	pop    %ebp
    372f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3730:	c7 05 ac 3a 00 00 b0 	movl   $0x3ab0,0x3aac
    3737:	3a 00 00 
    base.s.size = 0;
    373a:	bf b0 3a 00 00       	mov    $0x3ab0,%edi
    base.s.ptr = freep = prevp = &base;
    373f:	c7 05 b0 3a 00 00 b0 	movl   $0x3ab0,0x3ab0
    3746:	3a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3749:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    374b:	c7 05 b4 3a 00 00 00 	movl   $0x0,0x3ab4
    3752:	00 00 00 
    if(p->s.size >= nunits){
    3755:	e9 42 ff ff ff       	jmp    369c <malloc+0x2c>
    375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3760:	8b 08                	mov    (%eax),%ecx
    3762:	89 0a                	mov    %ecx,(%edx)
    3764:	eb b9                	jmp    371f <malloc+0xaf>
