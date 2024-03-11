
_init:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	53                   	push   %ebx
    300e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    300f:	83 ec 08             	sub    $0x8,%esp
    3012:	6a 02                	push   $0x2
    3014:	68 d8 37 00 00       	push   $0x37d8
    3019:	e8 65 03 00 00       	call   3383 <open>
    301e:	83 c4 10             	add    $0x10,%esp
    3021:	85 c0                	test   %eax,%eax
    3023:	0f 88 9f 00 00 00    	js     30c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    3029:	83 ec 0c             	sub    $0xc,%esp
    302c:	6a 00                	push   $0x0
    302e:	e8 88 03 00 00       	call   33bb <dup>
  dup(0);  // stderr
    3033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    303a:	e8 7c 03 00 00       	call   33bb <dup>
    303f:	83 c4 10             	add    $0x10,%esp
    3042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
    3048:	83 ec 08             	sub    $0x8,%esp
    304b:	68 e0 37 00 00       	push   $0x37e0
    3050:	6a 01                	push   $0x1
    3052:	e8 59 04 00 00       	call   34b0 <printf>
    pid = fork();
    3057:	e8 df 02 00 00       	call   333b <fork>
    if(pid < 0){
    305c:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    305f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    3061:	85 c0                	test   %eax,%eax
    3063:	78 2c                	js     3091 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
    3065:	74 3d                	je     30a4 <main+0xa4>
    3067:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    306e:	66 90                	xchg   %ax,%ax
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
    3070:	e8 d6 02 00 00       	call   334b <wait>
    3075:	85 c0                	test   %eax,%eax
    3077:	78 cf                	js     3048 <main+0x48>
    3079:	39 c3                	cmp    %eax,%ebx
    307b:	74 cb                	je     3048 <main+0x48>
      printf(1, "zombie!\n");
    307d:	83 ec 08             	sub    $0x8,%esp
    3080:	68 1f 38 00 00       	push   $0x381f
    3085:	6a 01                	push   $0x1
    3087:	e8 24 04 00 00       	call   34b0 <printf>
    308c:	83 c4 10             	add    $0x10,%esp
    308f:	eb df                	jmp    3070 <main+0x70>
      printf(1, "init: fork failed\n");
    3091:	53                   	push   %ebx
    3092:	53                   	push   %ebx
    3093:	68 f3 37 00 00       	push   $0x37f3
    3098:	6a 01                	push   $0x1
    309a:	e8 11 04 00 00       	call   34b0 <printf>
      exit();
    309f:	e8 9f 02 00 00       	call   3343 <exit>
      exec("sh", argv);
    30a4:	50                   	push   %eax
    30a5:	50                   	push   %eax
    30a6:	68 34 3b 00 00       	push   $0x3b34
    30ab:	68 06 38 00 00       	push   $0x3806
    30b0:	e8 c6 02 00 00       	call   337b <exec>
      printf(1, "init: exec sh failed\n");
    30b5:	5a                   	pop    %edx
    30b6:	59                   	pop    %ecx
    30b7:	68 09 38 00 00       	push   $0x3809
    30bc:	6a 01                	push   $0x1
    30be:	e8 ed 03 00 00       	call   34b0 <printf>
      exit();
    30c3:	e8 7b 02 00 00       	call   3343 <exit>
    mknod("console", 1, 1);
    30c8:	50                   	push   %eax
    30c9:	6a 01                	push   $0x1
    30cb:	6a 01                	push   $0x1
    30cd:	68 d8 37 00 00       	push   $0x37d8
    30d2:	e8 b4 02 00 00       	call   338b <mknod>
    open("console", O_RDWR);
    30d7:	58                   	pop    %eax
    30d8:	5a                   	pop    %edx
    30d9:	6a 02                	push   $0x2
    30db:	68 d8 37 00 00       	push   $0x37d8
    30e0:	e8 9e 02 00 00       	call   3383 <open>
    30e5:	83 c4 10             	add    $0x10,%esp
    30e8:	e9 3c ff ff ff       	jmp    3029 <main+0x29>
    30ed:	66 90                	xchg   %ax,%ax
    30ef:	90                   	nop

000030f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    30f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    30f1:	31 c0                	xor    %eax,%eax
{
    30f3:	89 e5                	mov    %esp,%ebp
    30f5:	53                   	push   %ebx
    30f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    30f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    30fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3100:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3104:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3107:	83 c0 01             	add    $0x1,%eax
    310a:	84 d2                	test   %dl,%dl
    310c:	75 f2                	jne    3100 <strcpy+0x10>
    ;
  return os;
}
    310e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3111:	89 c8                	mov    %ecx,%eax
    3113:	c9                   	leave  
    3114:	c3                   	ret    
    3115:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    311c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3120:	55                   	push   %ebp
    3121:	89 e5                	mov    %esp,%ebp
    3123:	53                   	push   %ebx
    3124:	8b 55 08             	mov    0x8(%ebp),%edx
    3127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    312a:	0f b6 02             	movzbl (%edx),%eax
    312d:	84 c0                	test   %al,%al
    312f:	75 17                	jne    3148 <strcmp+0x28>
    3131:	eb 3a                	jmp    316d <strcmp+0x4d>
    3133:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3137:	90                   	nop
    3138:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    313c:	83 c2 01             	add    $0x1,%edx
    313f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3142:	84 c0                	test   %al,%al
    3144:	74 1a                	je     3160 <strcmp+0x40>
    p++, q++;
    3146:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3148:	0f b6 19             	movzbl (%ecx),%ebx
    314b:	38 c3                	cmp    %al,%bl
    314d:	74 e9                	je     3138 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    314f:	29 d8                	sub    %ebx,%eax
}
    3151:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3154:	c9                   	leave  
    3155:	c3                   	ret    
    3156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    315d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3160:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3164:	31 c0                	xor    %eax,%eax
    3166:	29 d8                	sub    %ebx,%eax
}
    3168:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    316b:	c9                   	leave  
    316c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    316d:	0f b6 19             	movzbl (%ecx),%ebx
    3170:	31 c0                	xor    %eax,%eax
    3172:	eb db                	jmp    314f <strcmp+0x2f>
    3174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    317f:	90                   	nop

00003180 <strlen>:

uint
strlen(const char *s)
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3186:	80 3a 00             	cmpb   $0x0,(%edx)
    3189:	74 15                	je     31a0 <strlen+0x20>
    318b:	31 c0                	xor    %eax,%eax
    318d:	8d 76 00             	lea    0x0(%esi),%esi
    3190:	83 c0 01             	add    $0x1,%eax
    3193:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3197:	89 c1                	mov    %eax,%ecx
    3199:	75 f5                	jne    3190 <strlen+0x10>
    ;
  return n;
}
    319b:	89 c8                	mov    %ecx,%eax
    319d:	5d                   	pop    %ebp
    319e:	c3                   	ret    
    319f:	90                   	nop
  for(n = 0; s[n]; n++)
    31a0:	31 c9                	xor    %ecx,%ecx
}
    31a2:	5d                   	pop    %ebp
    31a3:	89 c8                	mov    %ecx,%eax
    31a5:	c3                   	ret    
    31a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31ad:	8d 76 00             	lea    0x0(%esi),%esi

000031b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    31b0:	55                   	push   %ebp
    31b1:	89 e5                	mov    %esp,%ebp
    31b3:	57                   	push   %edi
    31b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    31b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    31ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    31bd:	89 d7                	mov    %edx,%edi
    31bf:	fc                   	cld    
    31c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    31c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    31c5:	89 d0                	mov    %edx,%eax
    31c7:	c9                   	leave  
    31c8:	c3                   	ret    
    31c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000031d0 <strchr>:

char*
strchr(const char *s, char c)
{
    31d0:	55                   	push   %ebp
    31d1:	89 e5                	mov    %esp,%ebp
    31d3:	8b 45 08             	mov    0x8(%ebp),%eax
    31d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    31da:	0f b6 10             	movzbl (%eax),%edx
    31dd:	84 d2                	test   %dl,%dl
    31df:	75 12                	jne    31f3 <strchr+0x23>
    31e1:	eb 1d                	jmp    3200 <strchr+0x30>
    31e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31e7:	90                   	nop
    31e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    31ec:	83 c0 01             	add    $0x1,%eax
    31ef:	84 d2                	test   %dl,%dl
    31f1:	74 0d                	je     3200 <strchr+0x30>
    if(*s == c)
    31f3:	38 d1                	cmp    %dl,%cl
    31f5:	75 f1                	jne    31e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    31f7:	5d                   	pop    %ebp
    31f8:	c3                   	ret    
    31f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3200:	31 c0                	xor    %eax,%eax
}
    3202:	5d                   	pop    %ebp
    3203:	c3                   	ret    
    3204:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    320f:	90                   	nop

00003210 <gets>:

char*
gets(char *buf, int max)
{
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	57                   	push   %edi
    3214:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3215:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3218:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3219:	31 db                	xor    %ebx,%ebx
{
    321b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    321e:	eb 27                	jmp    3247 <gets+0x37>
    cc = read(0, &c, 1);
    3220:	83 ec 04             	sub    $0x4,%esp
    3223:	6a 01                	push   $0x1
    3225:	57                   	push   %edi
    3226:	6a 00                	push   $0x0
    3228:	e8 2e 01 00 00       	call   335b <read>
    if(cc < 1)
    322d:	83 c4 10             	add    $0x10,%esp
    3230:	85 c0                	test   %eax,%eax
    3232:	7e 1d                	jle    3251 <gets+0x41>
      break;
    buf[i++] = c;
    3234:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3238:	8b 55 08             	mov    0x8(%ebp),%edx
    323b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    323f:	3c 0a                	cmp    $0xa,%al
    3241:	74 1d                	je     3260 <gets+0x50>
    3243:	3c 0d                	cmp    $0xd,%al
    3245:	74 19                	je     3260 <gets+0x50>
  for(i=0; i+1 < max; ){
    3247:	89 de                	mov    %ebx,%esi
    3249:	83 c3 01             	add    $0x1,%ebx
    324c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    324f:	7c cf                	jl     3220 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3251:	8b 45 08             	mov    0x8(%ebp),%eax
    3254:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3258:	8d 65 f4             	lea    -0xc(%ebp),%esp
    325b:	5b                   	pop    %ebx
    325c:	5e                   	pop    %esi
    325d:	5f                   	pop    %edi
    325e:	5d                   	pop    %ebp
    325f:	c3                   	ret    
  buf[i] = '\0';
    3260:	8b 45 08             	mov    0x8(%ebp),%eax
    3263:	89 de                	mov    %ebx,%esi
    3265:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3269:	8d 65 f4             	lea    -0xc(%ebp),%esp
    326c:	5b                   	pop    %ebx
    326d:	5e                   	pop    %esi
    326e:	5f                   	pop    %edi
    326f:	5d                   	pop    %ebp
    3270:	c3                   	ret    
    3271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3278:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    327f:	90                   	nop

00003280 <stat>:

int
stat(const char *n, struct stat *st)
{
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	56                   	push   %esi
    3284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3285:	83 ec 08             	sub    $0x8,%esp
    3288:	6a 00                	push   $0x0
    328a:	ff 75 08             	push   0x8(%ebp)
    328d:	e8 f1 00 00 00       	call   3383 <open>
  if(fd < 0)
    3292:	83 c4 10             	add    $0x10,%esp
    3295:	85 c0                	test   %eax,%eax
    3297:	78 27                	js     32c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3299:	83 ec 08             	sub    $0x8,%esp
    329c:	ff 75 0c             	push   0xc(%ebp)
    329f:	89 c3                	mov    %eax,%ebx
    32a1:	50                   	push   %eax
    32a2:	e8 f4 00 00 00       	call   339b <fstat>
  close(fd);
    32a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    32aa:	89 c6                	mov    %eax,%esi
  close(fd);
    32ac:	e8 ba 00 00 00       	call   336b <close>
  return r;
    32b1:	83 c4 10             	add    $0x10,%esp
}
    32b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    32b7:	89 f0                	mov    %esi,%eax
    32b9:	5b                   	pop    %ebx
    32ba:	5e                   	pop    %esi
    32bb:	5d                   	pop    %ebp
    32bc:	c3                   	ret    
    32bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    32c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    32c5:	eb ed                	jmp    32b4 <stat+0x34>
    32c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32ce:	66 90                	xchg   %ax,%ax

000032d0 <atoi>:

int
atoi(const char *s)
{
    32d0:	55                   	push   %ebp
    32d1:	89 e5                	mov    %esp,%ebp
    32d3:	53                   	push   %ebx
    32d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32d7:	0f be 02             	movsbl (%edx),%eax
    32da:	8d 48 d0             	lea    -0x30(%eax),%ecx
    32dd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    32e0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    32e5:	77 1e                	ja     3305 <atoi+0x35>
    32e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32ee:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    32f0:	83 c2 01             	add    $0x1,%edx
    32f3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    32f6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    32fa:	0f be 02             	movsbl (%edx),%eax
    32fd:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3300:	80 fb 09             	cmp    $0x9,%bl
    3303:	76 eb                	jbe    32f0 <atoi+0x20>
  return n;
}
    3305:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3308:	89 c8                	mov    %ecx,%eax
    330a:	c9                   	leave  
    330b:	c3                   	ret    
    330c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3310:	55                   	push   %ebp
    3311:	89 e5                	mov    %esp,%ebp
    3313:	57                   	push   %edi
    3314:	8b 45 10             	mov    0x10(%ebp),%eax
    3317:	8b 55 08             	mov    0x8(%ebp),%edx
    331a:	56                   	push   %esi
    331b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    331e:	85 c0                	test   %eax,%eax
    3320:	7e 13                	jle    3335 <memmove+0x25>
    3322:	01 d0                	add    %edx,%eax
  dst = vdst;
    3324:	89 d7                	mov    %edx,%edi
    3326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    332d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3331:	39 f8                	cmp    %edi,%eax
    3333:	75 fb                	jne    3330 <memmove+0x20>
  return vdst;
}
    3335:	5e                   	pop    %esi
    3336:	89 d0                	mov    %edx,%eax
    3338:	5f                   	pop    %edi
    3339:	5d                   	pop    %ebp
    333a:	c3                   	ret    

0000333b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    333b:	b8 01 00 00 00       	mov    $0x1,%eax
    3340:	cd 40                	int    $0x40
    3342:	c3                   	ret    

00003343 <exit>:
SYSCALL(exit)
    3343:	b8 02 00 00 00       	mov    $0x2,%eax
    3348:	cd 40                	int    $0x40
    334a:	c3                   	ret    

0000334b <wait>:
SYSCALL(wait)
    334b:	b8 03 00 00 00       	mov    $0x3,%eax
    3350:	cd 40                	int    $0x40
    3352:	c3                   	ret    

00003353 <pipe>:
SYSCALL(pipe)
    3353:	b8 04 00 00 00       	mov    $0x4,%eax
    3358:	cd 40                	int    $0x40
    335a:	c3                   	ret    

0000335b <read>:
SYSCALL(read)
    335b:	b8 05 00 00 00       	mov    $0x5,%eax
    3360:	cd 40                	int    $0x40
    3362:	c3                   	ret    

00003363 <write>:
SYSCALL(write)
    3363:	b8 10 00 00 00       	mov    $0x10,%eax
    3368:	cd 40                	int    $0x40
    336a:	c3                   	ret    

0000336b <close>:
SYSCALL(close)
    336b:	b8 15 00 00 00       	mov    $0x15,%eax
    3370:	cd 40                	int    $0x40
    3372:	c3                   	ret    

00003373 <kill>:
SYSCALL(kill)
    3373:	b8 06 00 00 00       	mov    $0x6,%eax
    3378:	cd 40                	int    $0x40
    337a:	c3                   	ret    

0000337b <exec>:
SYSCALL(exec)
    337b:	b8 07 00 00 00       	mov    $0x7,%eax
    3380:	cd 40                	int    $0x40
    3382:	c3                   	ret    

00003383 <open>:
SYSCALL(open)
    3383:	b8 0f 00 00 00       	mov    $0xf,%eax
    3388:	cd 40                	int    $0x40
    338a:	c3                   	ret    

0000338b <mknod>:
SYSCALL(mknod)
    338b:	b8 11 00 00 00       	mov    $0x11,%eax
    3390:	cd 40                	int    $0x40
    3392:	c3                   	ret    

00003393 <unlink>:
SYSCALL(unlink)
    3393:	b8 12 00 00 00       	mov    $0x12,%eax
    3398:	cd 40                	int    $0x40
    339a:	c3                   	ret    

0000339b <fstat>:
SYSCALL(fstat)
    339b:	b8 08 00 00 00       	mov    $0x8,%eax
    33a0:	cd 40                	int    $0x40
    33a2:	c3                   	ret    

000033a3 <link>:
SYSCALL(link)
    33a3:	b8 13 00 00 00       	mov    $0x13,%eax
    33a8:	cd 40                	int    $0x40
    33aa:	c3                   	ret    

000033ab <mkdir>:
SYSCALL(mkdir)
    33ab:	b8 14 00 00 00       	mov    $0x14,%eax
    33b0:	cd 40                	int    $0x40
    33b2:	c3                   	ret    

000033b3 <chdir>:
SYSCALL(chdir)
    33b3:	b8 09 00 00 00       	mov    $0x9,%eax
    33b8:	cd 40                	int    $0x40
    33ba:	c3                   	ret    

000033bb <dup>:
SYSCALL(dup)
    33bb:	b8 0a 00 00 00       	mov    $0xa,%eax
    33c0:	cd 40                	int    $0x40
    33c2:	c3                   	ret    

000033c3 <getpid>:
SYSCALL(getpid)
    33c3:	b8 0b 00 00 00       	mov    $0xb,%eax
    33c8:	cd 40                	int    $0x40
    33ca:	c3                   	ret    

000033cb <sbrk>:
SYSCALL(sbrk)
    33cb:	b8 0c 00 00 00       	mov    $0xc,%eax
    33d0:	cd 40                	int    $0x40
    33d2:	c3                   	ret    

000033d3 <sleep>:
SYSCALL(sleep)
    33d3:	b8 0d 00 00 00       	mov    $0xd,%eax
    33d8:	cd 40                	int    $0x40
    33da:	c3                   	ret    

000033db <uptime>:
SYSCALL(uptime)
    33db:	b8 0e 00 00 00       	mov    $0xe,%eax
    33e0:	cd 40                	int    $0x40
    33e2:	c3                   	ret    

000033e3 <uniq>:
SYSCALL(uniq)
    33e3:	b8 16 00 00 00       	mov    $0x16,%eax
    33e8:	cd 40                	int    $0x40
    33ea:	c3                   	ret    

000033eb <head>:
SYSCALL(head)
    33eb:	b8 17 00 00 00       	mov    $0x17,%eax
    33f0:	cd 40                	int    $0x40
    33f2:	c3                   	ret    

000033f3 <ps>:
    33f3:	b8 18 00 00 00       	mov    $0x18,%eax
    33f8:	cd 40                	int    $0x40
    33fa:	c3                   	ret    
    33fb:	66 90                	xchg   %ax,%ax
    33fd:	66 90                	xchg   %ax,%ax
    33ff:	90                   	nop

00003400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3400:	55                   	push   %ebp
    3401:	89 e5                	mov    %esp,%ebp
    3403:	57                   	push   %edi
    3404:	56                   	push   %esi
    3405:	53                   	push   %ebx
    3406:	83 ec 3c             	sub    $0x3c,%esp
    3409:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    340c:	89 d1                	mov    %edx,%ecx
{
    340e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3411:	85 d2                	test   %edx,%edx
    3413:	0f 89 7f 00 00 00    	jns    3498 <printint+0x98>
    3419:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    341d:	74 79                	je     3498 <printint+0x98>
    neg = 1;
    341f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3426:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3428:	31 db                	xor    %ebx,%ebx
    342a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    342d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3430:	89 c8                	mov    %ecx,%eax
    3432:	31 d2                	xor    %edx,%edx
    3434:	89 cf                	mov    %ecx,%edi
    3436:	f7 75 c4             	divl   -0x3c(%ebp)
    3439:	0f b6 92 88 38 00 00 	movzbl 0x3888(%edx),%edx
    3440:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3443:	89 d8                	mov    %ebx,%eax
    3445:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3448:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    344b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    344e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3451:	76 dd                	jbe    3430 <printint+0x30>
  if(neg)
    3453:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3456:	85 c9                	test   %ecx,%ecx
    3458:	74 0c                	je     3466 <printint+0x66>
    buf[i++] = '-';
    345a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    345f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3461:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3466:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3469:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    346d:	eb 07                	jmp    3476 <printint+0x76>
    346f:	90                   	nop
    putc(fd, buf[i]);
    3470:	0f b6 13             	movzbl (%ebx),%edx
    3473:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3476:	83 ec 04             	sub    $0x4,%esp
    3479:	88 55 d7             	mov    %dl,-0x29(%ebp)
    347c:	6a 01                	push   $0x1
    347e:	56                   	push   %esi
    347f:	57                   	push   %edi
    3480:	e8 de fe ff ff       	call   3363 <write>
  while(--i >= 0)
    3485:	83 c4 10             	add    $0x10,%esp
    3488:	39 de                	cmp    %ebx,%esi
    348a:	75 e4                	jne    3470 <printint+0x70>
}
    348c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    348f:	5b                   	pop    %ebx
    3490:	5e                   	pop    %esi
    3491:	5f                   	pop    %edi
    3492:	5d                   	pop    %ebp
    3493:	c3                   	ret    
    3494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3498:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    349f:	eb 87                	jmp    3428 <printint+0x28>
    34a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34af:	90                   	nop

000034b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    34b0:	55                   	push   %ebp
    34b1:	89 e5                	mov    %esp,%ebp
    34b3:	57                   	push   %edi
    34b4:	56                   	push   %esi
    34b5:	53                   	push   %ebx
    34b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    34b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    34bc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    34bf:	0f b6 13             	movzbl (%ebx),%edx
    34c2:	84 d2                	test   %dl,%dl
    34c4:	74 6a                	je     3530 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    34c6:	8d 45 10             	lea    0x10(%ebp),%eax
    34c9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    34cc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    34cf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    34d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    34d4:	eb 36                	jmp    350c <printf+0x5c>
    34d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34dd:	8d 76 00             	lea    0x0(%esi),%esi
    34e0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    34e3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    34e8:	83 f8 25             	cmp    $0x25,%eax
    34eb:	74 15                	je     3502 <printf+0x52>
  write(fd, &c, 1);
    34ed:	83 ec 04             	sub    $0x4,%esp
    34f0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    34f3:	6a 01                	push   $0x1
    34f5:	57                   	push   %edi
    34f6:	56                   	push   %esi
    34f7:	e8 67 fe ff ff       	call   3363 <write>
    34fc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    34ff:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3502:	0f b6 13             	movzbl (%ebx),%edx
    3505:	83 c3 01             	add    $0x1,%ebx
    3508:	84 d2                	test   %dl,%dl
    350a:	74 24                	je     3530 <printf+0x80>
    c = fmt[i] & 0xff;
    350c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    350f:	85 c9                	test   %ecx,%ecx
    3511:	74 cd                	je     34e0 <printf+0x30>
      }
    } else if(state == '%'){
    3513:	83 f9 25             	cmp    $0x25,%ecx
    3516:	75 ea                	jne    3502 <printf+0x52>
      if(c == 'd'){
    3518:	83 f8 25             	cmp    $0x25,%eax
    351b:	0f 84 07 01 00 00    	je     3628 <printf+0x178>
    3521:	83 e8 63             	sub    $0x63,%eax
    3524:	83 f8 15             	cmp    $0x15,%eax
    3527:	77 17                	ja     3540 <printf+0x90>
    3529:	ff 24 85 30 38 00 00 	jmp    *0x3830(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3530:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3533:	5b                   	pop    %ebx
    3534:	5e                   	pop    %esi
    3535:	5f                   	pop    %edi
    3536:	5d                   	pop    %ebp
    3537:	c3                   	ret    
    3538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    353f:	90                   	nop
  write(fd, &c, 1);
    3540:	83 ec 04             	sub    $0x4,%esp
    3543:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3546:	6a 01                	push   $0x1
    3548:	57                   	push   %edi
    3549:	56                   	push   %esi
    354a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    354e:	e8 10 fe ff ff       	call   3363 <write>
        putc(fd, c);
    3553:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3557:	83 c4 0c             	add    $0xc,%esp
    355a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    355d:	6a 01                	push   $0x1
    355f:	57                   	push   %edi
    3560:	56                   	push   %esi
    3561:	e8 fd fd ff ff       	call   3363 <write>
        putc(fd, c);
    3566:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3569:	31 c9                	xor    %ecx,%ecx
    356b:	eb 95                	jmp    3502 <printf+0x52>
    356d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3570:	83 ec 0c             	sub    $0xc,%esp
    3573:	b9 10 00 00 00       	mov    $0x10,%ecx
    3578:	6a 00                	push   $0x0
    357a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    357d:	8b 10                	mov    (%eax),%edx
    357f:	89 f0                	mov    %esi,%eax
    3581:	e8 7a fe ff ff       	call   3400 <printint>
        ap++;
    3586:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    358a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    358d:	31 c9                	xor    %ecx,%ecx
    358f:	e9 6e ff ff ff       	jmp    3502 <printf+0x52>
    3594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3598:	8b 45 d0             	mov    -0x30(%ebp),%eax
    359b:	8b 10                	mov    (%eax),%edx
        ap++;
    359d:	83 c0 04             	add    $0x4,%eax
    35a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    35a3:	85 d2                	test   %edx,%edx
    35a5:	0f 84 8d 00 00 00    	je     3638 <printf+0x188>
        while(*s != 0){
    35ab:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    35ae:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    35b0:	84 c0                	test   %al,%al
    35b2:	0f 84 4a ff ff ff    	je     3502 <printf+0x52>
    35b8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    35bb:	89 d3                	mov    %edx,%ebx
    35bd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    35c0:	83 ec 04             	sub    $0x4,%esp
          s++;
    35c3:	83 c3 01             	add    $0x1,%ebx
    35c6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    35c9:	6a 01                	push   $0x1
    35cb:	57                   	push   %edi
    35cc:	56                   	push   %esi
    35cd:	e8 91 fd ff ff       	call   3363 <write>
        while(*s != 0){
    35d2:	0f b6 03             	movzbl (%ebx),%eax
    35d5:	83 c4 10             	add    $0x10,%esp
    35d8:	84 c0                	test   %al,%al
    35da:	75 e4                	jne    35c0 <printf+0x110>
      state = 0;
    35dc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    35df:	31 c9                	xor    %ecx,%ecx
    35e1:	e9 1c ff ff ff       	jmp    3502 <printf+0x52>
    35e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35ed:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    35f0:	83 ec 0c             	sub    $0xc,%esp
    35f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    35f8:	6a 01                	push   $0x1
    35fa:	e9 7b ff ff ff       	jmp    357a <printf+0xca>
    35ff:	90                   	nop
        putc(fd, *ap);
    3600:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3603:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3606:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3608:	6a 01                	push   $0x1
    360a:	57                   	push   %edi
    360b:	56                   	push   %esi
        putc(fd, *ap);
    360c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    360f:	e8 4f fd ff ff       	call   3363 <write>
        ap++;
    3614:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3618:	83 c4 10             	add    $0x10,%esp
      state = 0;
    361b:	31 c9                	xor    %ecx,%ecx
    361d:	e9 e0 fe ff ff       	jmp    3502 <printf+0x52>
    3622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3628:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    362b:	83 ec 04             	sub    $0x4,%esp
    362e:	e9 2a ff ff ff       	jmp    355d <printf+0xad>
    3633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3637:	90                   	nop
          s = "(null)";
    3638:	ba 28 38 00 00       	mov    $0x3828,%edx
        while(*s != 0){
    363d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3640:	b8 28 00 00 00       	mov    $0x28,%eax
    3645:	89 d3                	mov    %edx,%ebx
    3647:	e9 74 ff ff ff       	jmp    35c0 <printf+0x110>
    364c:	66 90                	xchg   %ax,%ax
    364e:	66 90                	xchg   %ax,%ax

00003650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3651:	a1 3c 3b 00 00       	mov    0x3b3c,%eax
{
    3656:	89 e5                	mov    %esp,%ebp
    3658:	57                   	push   %edi
    3659:	56                   	push   %esi
    365a:	53                   	push   %ebx
    365b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    365e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3668:	89 c2                	mov    %eax,%edx
    366a:	8b 00                	mov    (%eax),%eax
    366c:	39 ca                	cmp    %ecx,%edx
    366e:	73 30                	jae    36a0 <free+0x50>
    3670:	39 c1                	cmp    %eax,%ecx
    3672:	72 04                	jb     3678 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3674:	39 c2                	cmp    %eax,%edx
    3676:	72 f0                	jb     3668 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3678:	8b 73 fc             	mov    -0x4(%ebx),%esi
    367b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    367e:	39 f8                	cmp    %edi,%eax
    3680:	74 30                	je     36b2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3682:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3685:	8b 42 04             	mov    0x4(%edx),%eax
    3688:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    368b:	39 f1                	cmp    %esi,%ecx
    368d:	74 3a                	je     36c9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    368f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3691:	5b                   	pop    %ebx
  freep = p;
    3692:	89 15 3c 3b 00 00    	mov    %edx,0x3b3c
}
    3698:	5e                   	pop    %esi
    3699:	5f                   	pop    %edi
    369a:	5d                   	pop    %ebp
    369b:	c3                   	ret    
    369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    36a0:	39 c2                	cmp    %eax,%edx
    36a2:	72 c4                	jb     3668 <free+0x18>
    36a4:	39 c1                	cmp    %eax,%ecx
    36a6:	73 c0                	jae    3668 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    36a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    36ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    36ae:	39 f8                	cmp    %edi,%eax
    36b0:	75 d0                	jne    3682 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    36b2:	03 70 04             	add    0x4(%eax),%esi
    36b5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    36b8:	8b 02                	mov    (%edx),%eax
    36ba:	8b 00                	mov    (%eax),%eax
    36bc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    36bf:	8b 42 04             	mov    0x4(%edx),%eax
    36c2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    36c5:	39 f1                	cmp    %esi,%ecx
    36c7:	75 c6                	jne    368f <free+0x3f>
    p->s.size += bp->s.size;
    36c9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    36cc:	89 15 3c 3b 00 00    	mov    %edx,0x3b3c
    p->s.size += bp->s.size;
    36d2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    36d5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    36d8:	89 0a                	mov    %ecx,(%edx)
}
    36da:	5b                   	pop    %ebx
    36db:	5e                   	pop    %esi
    36dc:	5f                   	pop    %edi
    36dd:	5d                   	pop    %ebp
    36de:	c3                   	ret    
    36df:	90                   	nop

000036e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    36e0:	55                   	push   %ebp
    36e1:	89 e5                	mov    %esp,%ebp
    36e3:	57                   	push   %edi
    36e4:	56                   	push   %esi
    36e5:	53                   	push   %ebx
    36e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    36e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    36ec:	8b 3d 3c 3b 00 00    	mov    0x3b3c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    36f2:	8d 70 07             	lea    0x7(%eax),%esi
    36f5:	c1 ee 03             	shr    $0x3,%esi
    36f8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    36fb:	85 ff                	test   %edi,%edi
    36fd:	0f 84 9d 00 00 00    	je     37a0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3703:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3705:	8b 4a 04             	mov    0x4(%edx),%ecx
    3708:	39 f1                	cmp    %esi,%ecx
    370a:	73 6a                	jae    3776 <malloc+0x96>
    370c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3711:	39 de                	cmp    %ebx,%esi
    3713:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3716:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    371d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3720:	eb 17                	jmp    3739 <malloc+0x59>
    3722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3728:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    372a:	8b 48 04             	mov    0x4(%eax),%ecx
    372d:	39 f1                	cmp    %esi,%ecx
    372f:	73 4f                	jae    3780 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3731:	8b 3d 3c 3b 00 00    	mov    0x3b3c,%edi
    3737:	89 c2                	mov    %eax,%edx
    3739:	39 d7                	cmp    %edx,%edi
    373b:	75 eb                	jne    3728 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    373d:	83 ec 0c             	sub    $0xc,%esp
    3740:	ff 75 e4             	push   -0x1c(%ebp)
    3743:	e8 83 fc ff ff       	call   33cb <sbrk>
  if(p == (char*)-1)
    3748:	83 c4 10             	add    $0x10,%esp
    374b:	83 f8 ff             	cmp    $0xffffffff,%eax
    374e:	74 1c                	je     376c <malloc+0x8c>
  hp->s.size = nu;
    3750:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3753:	83 ec 0c             	sub    $0xc,%esp
    3756:	83 c0 08             	add    $0x8,%eax
    3759:	50                   	push   %eax
    375a:	e8 f1 fe ff ff       	call   3650 <free>
  return freep;
    375f:	8b 15 3c 3b 00 00    	mov    0x3b3c,%edx
      if((p = morecore(nunits)) == 0)
    3765:	83 c4 10             	add    $0x10,%esp
    3768:	85 d2                	test   %edx,%edx
    376a:	75 bc                	jne    3728 <malloc+0x48>
        return 0;
  }
}
    376c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    376f:	31 c0                	xor    %eax,%eax
}
    3771:	5b                   	pop    %ebx
    3772:	5e                   	pop    %esi
    3773:	5f                   	pop    %edi
    3774:	5d                   	pop    %ebp
    3775:	c3                   	ret    
    if(p->s.size >= nunits){
    3776:	89 d0                	mov    %edx,%eax
    3778:	89 fa                	mov    %edi,%edx
    377a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3780:	39 ce                	cmp    %ecx,%esi
    3782:	74 4c                	je     37d0 <malloc+0xf0>
        p->s.size -= nunits;
    3784:	29 f1                	sub    %esi,%ecx
    3786:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3789:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    378c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    378f:	89 15 3c 3b 00 00    	mov    %edx,0x3b3c
}
    3795:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3798:	83 c0 08             	add    $0x8,%eax
}
    379b:	5b                   	pop    %ebx
    379c:	5e                   	pop    %esi
    379d:	5f                   	pop    %edi
    379e:	5d                   	pop    %ebp
    379f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    37a0:	c7 05 3c 3b 00 00 40 	movl   $0x3b40,0x3b3c
    37a7:	3b 00 00 
    base.s.size = 0;
    37aa:	bf 40 3b 00 00       	mov    $0x3b40,%edi
    base.s.ptr = freep = prevp = &base;
    37af:	c7 05 40 3b 00 00 40 	movl   $0x3b40,0x3b40
    37b6:	3b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37b9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    37bb:	c7 05 44 3b 00 00 00 	movl   $0x0,0x3b44
    37c2:	00 00 00 
    if(p->s.size >= nunits){
    37c5:	e9 42 ff ff ff       	jmp    370c <malloc+0x2c>
    37ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    37d0:	8b 08                	mov    (%eax),%ecx
    37d2:	89 0a                	mov    %ecx,(%edx)
    37d4:	eb b9                	jmp    378f <malloc+0xaf>
