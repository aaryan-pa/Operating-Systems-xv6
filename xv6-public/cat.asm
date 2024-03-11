
_cat:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
  }
}

int
main(int argc, char *argv[])
{
    3000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3004:	83 e4 f0             	and    $0xfffffff0,%esp
    3007:	ff 71 fc             	push   -0x4(%ecx)
    300a:	55                   	push   %ebp
    300b:	89 e5                	mov    %esp,%ebp
    300d:	57                   	push   %edi
    300e:	56                   	push   %esi
    300f:	be 01 00 00 00       	mov    $0x1,%esi
    3014:	53                   	push   %ebx
    3015:	51                   	push   %ecx
    3016:	83 ec 18             	sub    $0x18,%esp
    3019:	8b 01                	mov    (%ecx),%eax
    301b:	8b 59 04             	mov    0x4(%ecx),%ebx
    301e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3021:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
    3024:	83 f8 01             	cmp    $0x1,%eax
    3027:	7e 54                	jle    307d <main+0x7d>
    3029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    3030:	83 ec 08             	sub    $0x8,%esp
    3033:	6a 00                	push   $0x0
    3035:	ff 33                	push   (%ebx)
    3037:	e8 67 03 00 00       	call   33a3 <open>
    303c:	83 c4 10             	add    $0x10,%esp
    303f:	89 c7                	mov    %eax,%edi
    3041:	85 c0                	test   %eax,%eax
    3043:	78 24                	js     3069 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
    3045:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
    3048:	83 c6 01             	add    $0x1,%esi
    304b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
    304e:	50                   	push   %eax
    304f:	e8 3c 00 00 00       	call   3090 <cat>
    close(fd);
    3054:	89 3c 24             	mov    %edi,(%esp)
    3057:	e8 2f 03 00 00       	call   338b <close>
  for(i = 1; i < argc; i++){
    305c:	83 c4 10             	add    $0x10,%esp
    305f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
    3062:	75 cc                	jne    3030 <main+0x30>
  }
  exit();
    3064:	e8 fa 02 00 00       	call   3363 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
    3069:	50                   	push   %eax
    306a:	ff 33                	push   (%ebx)
    306c:	68 1b 38 00 00       	push   $0x381b
    3071:	6a 01                	push   $0x1
    3073:	e8 58 04 00 00       	call   34d0 <printf>
      exit();
    3078:	e8 e6 02 00 00       	call   3363 <exit>
    cat(0);
    307d:	83 ec 0c             	sub    $0xc,%esp
    3080:	6a 00                	push   $0x0
    3082:	e8 09 00 00 00       	call   3090 <cat>
    exit();
    3087:	e8 d7 02 00 00       	call   3363 <exit>
    308c:	66 90                	xchg   %ax,%ax
    308e:	66 90                	xchg   %ax,%ax

00003090 <cat>:
{
    3090:	55                   	push   %ebp
    3091:	89 e5                	mov    %esp,%ebp
    3093:	56                   	push   %esi
    3094:	8b 75 08             	mov    0x8(%ebp),%esi
    3097:	53                   	push   %ebx
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    3098:	eb 1d                	jmp    30b7 <cat+0x27>
    309a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
    30a0:	83 ec 04             	sub    $0x4,%esp
    30a3:	53                   	push   %ebx
    30a4:	68 80 3b 00 00       	push   $0x3b80
    30a9:	6a 01                	push   $0x1
    30ab:	e8 d3 02 00 00       	call   3383 <write>
    30b0:	83 c4 10             	add    $0x10,%esp
    30b3:	39 d8                	cmp    %ebx,%eax
    30b5:	75 25                	jne    30dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    30b7:	83 ec 04             	sub    $0x4,%esp
    30ba:	68 00 02 00 00       	push   $0x200
    30bf:	68 80 3b 00 00       	push   $0x3b80
    30c4:	56                   	push   %esi
    30c5:	e8 b1 02 00 00       	call   337b <read>
    30ca:	83 c4 10             	add    $0x10,%esp
    30cd:	89 c3                	mov    %eax,%ebx
    30cf:	85 c0                	test   %eax,%eax
    30d1:	7f cd                	jg     30a0 <cat+0x10>
  if(n < 0){
    30d3:	75 1b                	jne    30f0 <cat+0x60>
}
    30d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
    30d8:	5b                   	pop    %ebx
    30d9:	5e                   	pop    %esi
    30da:	5d                   	pop    %ebp
    30db:	c3                   	ret    
      printf(1, "cat: write error\n");
    30dc:	83 ec 08             	sub    $0x8,%esp
    30df:	68 f8 37 00 00       	push   $0x37f8
    30e4:	6a 01                	push   $0x1
    30e6:	e8 e5 03 00 00       	call   34d0 <printf>
      exit();
    30eb:	e8 73 02 00 00       	call   3363 <exit>
    printf(1, "cat: read error\n");
    30f0:	50                   	push   %eax
    30f1:	50                   	push   %eax
    30f2:	68 0a 38 00 00       	push   $0x380a
    30f7:	6a 01                	push   $0x1
    30f9:	e8 d2 03 00 00       	call   34d0 <printf>
    exit();
    30fe:	e8 60 02 00 00       	call   3363 <exit>
    3103:	66 90                	xchg   %ax,%ax
    3105:	66 90                	xchg   %ax,%ax
    3107:	66 90                	xchg   %ax,%ax
    3109:	66 90                	xchg   %ax,%ax
    310b:	66 90                	xchg   %ax,%ax
    310d:	66 90                	xchg   %ax,%ax
    310f:	90                   	nop

00003110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3111:	31 c0                	xor    %eax,%eax
{
    3113:	89 e5                	mov    %esp,%ebp
    3115:	53                   	push   %ebx
    3116:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    311c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3127:	83 c0 01             	add    $0x1,%eax
    312a:	84 d2                	test   %dl,%dl
    312c:	75 f2                	jne    3120 <strcpy+0x10>
    ;
  return os;
}
    312e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3131:	89 c8                	mov    %ecx,%eax
    3133:	c9                   	leave  
    3134:	c3                   	ret    
    3135:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    313c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	53                   	push   %ebx
    3144:	8b 55 08             	mov    0x8(%ebp),%edx
    3147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    314a:	0f b6 02             	movzbl (%edx),%eax
    314d:	84 c0                	test   %al,%al
    314f:	75 17                	jne    3168 <strcmp+0x28>
    3151:	eb 3a                	jmp    318d <strcmp+0x4d>
    3153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3157:	90                   	nop
    3158:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    315c:	83 c2 01             	add    $0x1,%edx
    315f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3162:	84 c0                	test   %al,%al
    3164:	74 1a                	je     3180 <strcmp+0x40>
    p++, q++;
    3166:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3168:	0f b6 19             	movzbl (%ecx),%ebx
    316b:	38 c3                	cmp    %al,%bl
    316d:	74 e9                	je     3158 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    316f:	29 d8                	sub    %ebx,%eax
}
    3171:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3174:	c9                   	leave  
    3175:	c3                   	ret    
    3176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3180:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3184:	31 c0                	xor    %eax,%eax
    3186:	29 d8                	sub    %ebx,%eax
}
    3188:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    318b:	c9                   	leave  
    318c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    318d:	0f b6 19             	movzbl (%ecx),%ebx
    3190:	31 c0                	xor    %eax,%eax
    3192:	eb db                	jmp    316f <strcmp+0x2f>
    3194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    319b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    319f:	90                   	nop

000031a0 <strlen>:

uint
strlen(const char *s)
{
    31a0:	55                   	push   %ebp
    31a1:	89 e5                	mov    %esp,%ebp
    31a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    31a6:	80 3a 00             	cmpb   $0x0,(%edx)
    31a9:	74 15                	je     31c0 <strlen+0x20>
    31ab:	31 c0                	xor    %eax,%eax
    31ad:	8d 76 00             	lea    0x0(%esi),%esi
    31b0:	83 c0 01             	add    $0x1,%eax
    31b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    31b7:	89 c1                	mov    %eax,%ecx
    31b9:	75 f5                	jne    31b0 <strlen+0x10>
    ;
  return n;
}
    31bb:	89 c8                	mov    %ecx,%eax
    31bd:	5d                   	pop    %ebp
    31be:	c3                   	ret    
    31bf:	90                   	nop
  for(n = 0; s[n]; n++)
    31c0:	31 c9                	xor    %ecx,%ecx
}
    31c2:	5d                   	pop    %ebp
    31c3:	89 c8                	mov    %ecx,%eax
    31c5:	c3                   	ret    
    31c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31cd:	8d 76 00             	lea    0x0(%esi),%esi

000031d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    31d0:	55                   	push   %ebp
    31d1:	89 e5                	mov    %esp,%ebp
    31d3:	57                   	push   %edi
    31d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    31d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    31da:	8b 45 0c             	mov    0xc(%ebp),%eax
    31dd:	89 d7                	mov    %edx,%edi
    31df:	fc                   	cld    
    31e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    31e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    31e5:	89 d0                	mov    %edx,%eax
    31e7:	c9                   	leave  
    31e8:	c3                   	ret    
    31e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000031f0 <strchr>:

char*
strchr(const char *s, char c)
{
    31f0:	55                   	push   %ebp
    31f1:	89 e5                	mov    %esp,%ebp
    31f3:	8b 45 08             	mov    0x8(%ebp),%eax
    31f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    31fa:	0f b6 10             	movzbl (%eax),%edx
    31fd:	84 d2                	test   %dl,%dl
    31ff:	75 12                	jne    3213 <strchr+0x23>
    3201:	eb 1d                	jmp    3220 <strchr+0x30>
    3203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3207:	90                   	nop
    3208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    320c:	83 c0 01             	add    $0x1,%eax
    320f:	84 d2                	test   %dl,%dl
    3211:	74 0d                	je     3220 <strchr+0x30>
    if(*s == c)
    3213:	38 d1                	cmp    %dl,%cl
    3215:	75 f1                	jne    3208 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3217:	5d                   	pop    %ebp
    3218:	c3                   	ret    
    3219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3220:	31 c0                	xor    %eax,%eax
}
    3222:	5d                   	pop    %ebp
    3223:	c3                   	ret    
    3224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    322b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    322f:	90                   	nop

00003230 <gets>:

char*
gets(char *buf, int max)
{
    3230:	55                   	push   %ebp
    3231:	89 e5                	mov    %esp,%ebp
    3233:	57                   	push   %edi
    3234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3235:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3238:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3239:	31 db                	xor    %ebx,%ebx
{
    323b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    323e:	eb 27                	jmp    3267 <gets+0x37>
    cc = read(0, &c, 1);
    3240:	83 ec 04             	sub    $0x4,%esp
    3243:	6a 01                	push   $0x1
    3245:	57                   	push   %edi
    3246:	6a 00                	push   $0x0
    3248:	e8 2e 01 00 00       	call   337b <read>
    if(cc < 1)
    324d:	83 c4 10             	add    $0x10,%esp
    3250:	85 c0                	test   %eax,%eax
    3252:	7e 1d                	jle    3271 <gets+0x41>
      break;
    buf[i++] = c;
    3254:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3258:	8b 55 08             	mov    0x8(%ebp),%edx
    325b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    325f:	3c 0a                	cmp    $0xa,%al
    3261:	74 1d                	je     3280 <gets+0x50>
    3263:	3c 0d                	cmp    $0xd,%al
    3265:	74 19                	je     3280 <gets+0x50>
  for(i=0; i+1 < max; ){
    3267:	89 de                	mov    %ebx,%esi
    3269:	83 c3 01             	add    $0x1,%ebx
    326c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    326f:	7c cf                	jl     3240 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3271:	8b 45 08             	mov    0x8(%ebp),%eax
    3274:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3278:	8d 65 f4             	lea    -0xc(%ebp),%esp
    327b:	5b                   	pop    %ebx
    327c:	5e                   	pop    %esi
    327d:	5f                   	pop    %edi
    327e:	5d                   	pop    %ebp
    327f:	c3                   	ret    
  buf[i] = '\0';
    3280:	8b 45 08             	mov    0x8(%ebp),%eax
    3283:	89 de                	mov    %ebx,%esi
    3285:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3289:	8d 65 f4             	lea    -0xc(%ebp),%esp
    328c:	5b                   	pop    %ebx
    328d:	5e                   	pop    %esi
    328e:	5f                   	pop    %edi
    328f:	5d                   	pop    %ebp
    3290:	c3                   	ret    
    3291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329f:	90                   	nop

000032a0 <stat>:

int
stat(const char *n, struct stat *st)
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	56                   	push   %esi
    32a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    32a5:	83 ec 08             	sub    $0x8,%esp
    32a8:	6a 00                	push   $0x0
    32aa:	ff 75 08             	push   0x8(%ebp)
    32ad:	e8 f1 00 00 00       	call   33a3 <open>
  if(fd < 0)
    32b2:	83 c4 10             	add    $0x10,%esp
    32b5:	85 c0                	test   %eax,%eax
    32b7:	78 27                	js     32e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    32b9:	83 ec 08             	sub    $0x8,%esp
    32bc:	ff 75 0c             	push   0xc(%ebp)
    32bf:	89 c3                	mov    %eax,%ebx
    32c1:	50                   	push   %eax
    32c2:	e8 f4 00 00 00       	call   33bb <fstat>
  close(fd);
    32c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    32ca:	89 c6                	mov    %eax,%esi
  close(fd);
    32cc:	e8 ba 00 00 00       	call   338b <close>
  return r;
    32d1:	83 c4 10             	add    $0x10,%esp
}
    32d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    32d7:	89 f0                	mov    %esi,%eax
    32d9:	5b                   	pop    %ebx
    32da:	5e                   	pop    %esi
    32db:	5d                   	pop    %ebp
    32dc:	c3                   	ret    
    32dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    32e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    32e5:	eb ed                	jmp    32d4 <stat+0x34>
    32e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32ee:	66 90                	xchg   %ax,%ax

000032f0 <atoi>:

int
atoi(const char *s)
{
    32f0:	55                   	push   %ebp
    32f1:	89 e5                	mov    %esp,%ebp
    32f3:	53                   	push   %ebx
    32f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32f7:	0f be 02             	movsbl (%edx),%eax
    32fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
    32fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3300:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3305:	77 1e                	ja     3325 <atoi+0x35>
    3307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    330e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3310:	83 c2 01             	add    $0x1,%edx
    3313:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3316:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    331a:	0f be 02             	movsbl (%edx),%eax
    331d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3320:	80 fb 09             	cmp    $0x9,%bl
    3323:	76 eb                	jbe    3310 <atoi+0x20>
  return n;
}
    3325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3328:	89 c8                	mov    %ecx,%eax
    332a:	c9                   	leave  
    332b:	c3                   	ret    
    332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3330:	55                   	push   %ebp
    3331:	89 e5                	mov    %esp,%ebp
    3333:	57                   	push   %edi
    3334:	8b 45 10             	mov    0x10(%ebp),%eax
    3337:	8b 55 08             	mov    0x8(%ebp),%edx
    333a:	56                   	push   %esi
    333b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    333e:	85 c0                	test   %eax,%eax
    3340:	7e 13                	jle    3355 <memmove+0x25>
    3342:	01 d0                	add    %edx,%eax
  dst = vdst;
    3344:	89 d7                	mov    %edx,%edi
    3346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    334d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3351:	39 f8                	cmp    %edi,%eax
    3353:	75 fb                	jne    3350 <memmove+0x20>
  return vdst;
}
    3355:	5e                   	pop    %esi
    3356:	89 d0                	mov    %edx,%eax
    3358:	5f                   	pop    %edi
    3359:	5d                   	pop    %ebp
    335a:	c3                   	ret    

0000335b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    335b:	b8 01 00 00 00       	mov    $0x1,%eax
    3360:	cd 40                	int    $0x40
    3362:	c3                   	ret    

00003363 <exit>:
SYSCALL(exit)
    3363:	b8 02 00 00 00       	mov    $0x2,%eax
    3368:	cd 40                	int    $0x40
    336a:	c3                   	ret    

0000336b <wait>:
SYSCALL(wait)
    336b:	b8 03 00 00 00       	mov    $0x3,%eax
    3370:	cd 40                	int    $0x40
    3372:	c3                   	ret    

00003373 <pipe>:
SYSCALL(pipe)
    3373:	b8 04 00 00 00       	mov    $0x4,%eax
    3378:	cd 40                	int    $0x40
    337a:	c3                   	ret    

0000337b <read>:
SYSCALL(read)
    337b:	b8 05 00 00 00       	mov    $0x5,%eax
    3380:	cd 40                	int    $0x40
    3382:	c3                   	ret    

00003383 <write>:
SYSCALL(write)
    3383:	b8 10 00 00 00       	mov    $0x10,%eax
    3388:	cd 40                	int    $0x40
    338a:	c3                   	ret    

0000338b <close>:
SYSCALL(close)
    338b:	b8 15 00 00 00       	mov    $0x15,%eax
    3390:	cd 40                	int    $0x40
    3392:	c3                   	ret    

00003393 <kill>:
SYSCALL(kill)
    3393:	b8 06 00 00 00       	mov    $0x6,%eax
    3398:	cd 40                	int    $0x40
    339a:	c3                   	ret    

0000339b <exec>:
SYSCALL(exec)
    339b:	b8 07 00 00 00       	mov    $0x7,%eax
    33a0:	cd 40                	int    $0x40
    33a2:	c3                   	ret    

000033a3 <open>:
SYSCALL(open)
    33a3:	b8 0f 00 00 00       	mov    $0xf,%eax
    33a8:	cd 40                	int    $0x40
    33aa:	c3                   	ret    

000033ab <mknod>:
SYSCALL(mknod)
    33ab:	b8 11 00 00 00       	mov    $0x11,%eax
    33b0:	cd 40                	int    $0x40
    33b2:	c3                   	ret    

000033b3 <unlink>:
SYSCALL(unlink)
    33b3:	b8 12 00 00 00       	mov    $0x12,%eax
    33b8:	cd 40                	int    $0x40
    33ba:	c3                   	ret    

000033bb <fstat>:
SYSCALL(fstat)
    33bb:	b8 08 00 00 00       	mov    $0x8,%eax
    33c0:	cd 40                	int    $0x40
    33c2:	c3                   	ret    

000033c3 <link>:
SYSCALL(link)
    33c3:	b8 13 00 00 00       	mov    $0x13,%eax
    33c8:	cd 40                	int    $0x40
    33ca:	c3                   	ret    

000033cb <mkdir>:
SYSCALL(mkdir)
    33cb:	b8 14 00 00 00       	mov    $0x14,%eax
    33d0:	cd 40                	int    $0x40
    33d2:	c3                   	ret    

000033d3 <chdir>:
SYSCALL(chdir)
    33d3:	b8 09 00 00 00       	mov    $0x9,%eax
    33d8:	cd 40                	int    $0x40
    33da:	c3                   	ret    

000033db <dup>:
SYSCALL(dup)
    33db:	b8 0a 00 00 00       	mov    $0xa,%eax
    33e0:	cd 40                	int    $0x40
    33e2:	c3                   	ret    

000033e3 <getpid>:
SYSCALL(getpid)
    33e3:	b8 0b 00 00 00       	mov    $0xb,%eax
    33e8:	cd 40                	int    $0x40
    33ea:	c3                   	ret    

000033eb <sbrk>:
SYSCALL(sbrk)
    33eb:	b8 0c 00 00 00       	mov    $0xc,%eax
    33f0:	cd 40                	int    $0x40
    33f2:	c3                   	ret    

000033f3 <sleep>:
SYSCALL(sleep)
    33f3:	b8 0d 00 00 00       	mov    $0xd,%eax
    33f8:	cd 40                	int    $0x40
    33fa:	c3                   	ret    

000033fb <uptime>:
SYSCALL(uptime)
    33fb:	b8 0e 00 00 00       	mov    $0xe,%eax
    3400:	cd 40                	int    $0x40
    3402:	c3                   	ret    

00003403 <uniq>:
SYSCALL(uniq)
    3403:	b8 16 00 00 00       	mov    $0x16,%eax
    3408:	cd 40                	int    $0x40
    340a:	c3                   	ret    

0000340b <head>:
SYSCALL(head)
    340b:	b8 17 00 00 00       	mov    $0x17,%eax
    3410:	cd 40                	int    $0x40
    3412:	c3                   	ret    

00003413 <ps>:
    3413:	b8 18 00 00 00       	mov    $0x18,%eax
    3418:	cd 40                	int    $0x40
    341a:	c3                   	ret    
    341b:	66 90                	xchg   %ax,%ax
    341d:	66 90                	xchg   %ax,%ax
    341f:	90                   	nop

00003420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3420:	55                   	push   %ebp
    3421:	89 e5                	mov    %esp,%ebp
    3423:	57                   	push   %edi
    3424:	56                   	push   %esi
    3425:	53                   	push   %ebx
    3426:	83 ec 3c             	sub    $0x3c,%esp
    3429:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    342c:	89 d1                	mov    %edx,%ecx
{
    342e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3431:	85 d2                	test   %edx,%edx
    3433:	0f 89 7f 00 00 00    	jns    34b8 <printint+0x98>
    3439:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    343d:	74 79                	je     34b8 <printint+0x98>
    neg = 1;
    343f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3446:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3448:	31 db                	xor    %ebx,%ebx
    344a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    344d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3450:	89 c8                	mov    %ecx,%eax
    3452:	31 d2                	xor    %edx,%edx
    3454:	89 cf                	mov    %ecx,%edi
    3456:	f7 75 c4             	divl   -0x3c(%ebp)
    3459:	0f b6 92 90 38 00 00 	movzbl 0x3890(%edx),%edx
    3460:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3463:	89 d8                	mov    %ebx,%eax
    3465:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3468:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    346b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    346e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3471:	76 dd                	jbe    3450 <printint+0x30>
  if(neg)
    3473:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3476:	85 c9                	test   %ecx,%ecx
    3478:	74 0c                	je     3486 <printint+0x66>
    buf[i++] = '-';
    347a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    347f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3481:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3486:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3489:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    348d:	eb 07                	jmp    3496 <printint+0x76>
    348f:	90                   	nop
    putc(fd, buf[i]);
    3490:	0f b6 13             	movzbl (%ebx),%edx
    3493:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3496:	83 ec 04             	sub    $0x4,%esp
    3499:	88 55 d7             	mov    %dl,-0x29(%ebp)
    349c:	6a 01                	push   $0x1
    349e:	56                   	push   %esi
    349f:	57                   	push   %edi
    34a0:	e8 de fe ff ff       	call   3383 <write>
  while(--i >= 0)
    34a5:	83 c4 10             	add    $0x10,%esp
    34a8:	39 de                	cmp    %ebx,%esi
    34aa:	75 e4                	jne    3490 <printint+0x70>
}
    34ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34af:	5b                   	pop    %ebx
    34b0:	5e                   	pop    %esi
    34b1:	5f                   	pop    %edi
    34b2:	5d                   	pop    %ebp
    34b3:	c3                   	ret    
    34b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    34b8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    34bf:	eb 87                	jmp    3448 <printint+0x28>
    34c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34cf:	90                   	nop

000034d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    34d0:	55                   	push   %ebp
    34d1:	89 e5                	mov    %esp,%ebp
    34d3:	57                   	push   %edi
    34d4:	56                   	push   %esi
    34d5:	53                   	push   %ebx
    34d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    34d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    34dc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    34df:	0f b6 13             	movzbl (%ebx),%edx
    34e2:	84 d2                	test   %dl,%dl
    34e4:	74 6a                	je     3550 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    34e6:	8d 45 10             	lea    0x10(%ebp),%eax
    34e9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    34ec:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    34ef:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    34f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    34f4:	eb 36                	jmp    352c <printf+0x5c>
    34f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34fd:	8d 76 00             	lea    0x0(%esi),%esi
    3500:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3503:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3508:	83 f8 25             	cmp    $0x25,%eax
    350b:	74 15                	je     3522 <printf+0x52>
  write(fd, &c, 1);
    350d:	83 ec 04             	sub    $0x4,%esp
    3510:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3513:	6a 01                	push   $0x1
    3515:	57                   	push   %edi
    3516:	56                   	push   %esi
    3517:	e8 67 fe ff ff       	call   3383 <write>
    351c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    351f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3522:	0f b6 13             	movzbl (%ebx),%edx
    3525:	83 c3 01             	add    $0x1,%ebx
    3528:	84 d2                	test   %dl,%dl
    352a:	74 24                	je     3550 <printf+0x80>
    c = fmt[i] & 0xff;
    352c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    352f:	85 c9                	test   %ecx,%ecx
    3531:	74 cd                	je     3500 <printf+0x30>
      }
    } else if(state == '%'){
    3533:	83 f9 25             	cmp    $0x25,%ecx
    3536:	75 ea                	jne    3522 <printf+0x52>
      if(c == 'd'){
    3538:	83 f8 25             	cmp    $0x25,%eax
    353b:	0f 84 07 01 00 00    	je     3648 <printf+0x178>
    3541:	83 e8 63             	sub    $0x63,%eax
    3544:	83 f8 15             	cmp    $0x15,%eax
    3547:	77 17                	ja     3560 <printf+0x90>
    3549:	ff 24 85 38 38 00 00 	jmp    *0x3838(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3550:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3553:	5b                   	pop    %ebx
    3554:	5e                   	pop    %esi
    3555:	5f                   	pop    %edi
    3556:	5d                   	pop    %ebp
    3557:	c3                   	ret    
    3558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    355f:	90                   	nop
  write(fd, &c, 1);
    3560:	83 ec 04             	sub    $0x4,%esp
    3563:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3566:	6a 01                	push   $0x1
    3568:	57                   	push   %edi
    3569:	56                   	push   %esi
    356a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    356e:	e8 10 fe ff ff       	call   3383 <write>
        putc(fd, c);
    3573:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3577:	83 c4 0c             	add    $0xc,%esp
    357a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    357d:	6a 01                	push   $0x1
    357f:	57                   	push   %edi
    3580:	56                   	push   %esi
    3581:	e8 fd fd ff ff       	call   3383 <write>
        putc(fd, c);
    3586:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3589:	31 c9                	xor    %ecx,%ecx
    358b:	eb 95                	jmp    3522 <printf+0x52>
    358d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3590:	83 ec 0c             	sub    $0xc,%esp
    3593:	b9 10 00 00 00       	mov    $0x10,%ecx
    3598:	6a 00                	push   $0x0
    359a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    359d:	8b 10                	mov    (%eax),%edx
    359f:	89 f0                	mov    %esi,%eax
    35a1:	e8 7a fe ff ff       	call   3420 <printint>
        ap++;
    35a6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    35aa:	83 c4 10             	add    $0x10,%esp
      state = 0;
    35ad:	31 c9                	xor    %ecx,%ecx
    35af:	e9 6e ff ff ff       	jmp    3522 <printf+0x52>
    35b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    35b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    35bb:	8b 10                	mov    (%eax),%edx
        ap++;
    35bd:	83 c0 04             	add    $0x4,%eax
    35c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    35c3:	85 d2                	test   %edx,%edx
    35c5:	0f 84 8d 00 00 00    	je     3658 <printf+0x188>
        while(*s != 0){
    35cb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    35ce:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    35d0:	84 c0                	test   %al,%al
    35d2:	0f 84 4a ff ff ff    	je     3522 <printf+0x52>
    35d8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    35db:	89 d3                	mov    %edx,%ebx
    35dd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    35e0:	83 ec 04             	sub    $0x4,%esp
          s++;
    35e3:	83 c3 01             	add    $0x1,%ebx
    35e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    35e9:	6a 01                	push   $0x1
    35eb:	57                   	push   %edi
    35ec:	56                   	push   %esi
    35ed:	e8 91 fd ff ff       	call   3383 <write>
        while(*s != 0){
    35f2:	0f b6 03             	movzbl (%ebx),%eax
    35f5:	83 c4 10             	add    $0x10,%esp
    35f8:	84 c0                	test   %al,%al
    35fa:	75 e4                	jne    35e0 <printf+0x110>
      state = 0;
    35fc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    35ff:	31 c9                	xor    %ecx,%ecx
    3601:	e9 1c ff ff ff       	jmp    3522 <printf+0x52>
    3606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    360d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3610:	83 ec 0c             	sub    $0xc,%esp
    3613:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3618:	6a 01                	push   $0x1
    361a:	e9 7b ff ff ff       	jmp    359a <printf+0xca>
    361f:	90                   	nop
        putc(fd, *ap);
    3620:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3623:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3626:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3628:	6a 01                	push   $0x1
    362a:	57                   	push   %edi
    362b:	56                   	push   %esi
        putc(fd, *ap);
    362c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    362f:	e8 4f fd ff ff       	call   3383 <write>
        ap++;
    3634:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3638:	83 c4 10             	add    $0x10,%esp
      state = 0;
    363b:	31 c9                	xor    %ecx,%ecx
    363d:	e9 e0 fe ff ff       	jmp    3522 <printf+0x52>
    3642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3648:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    364b:	83 ec 04             	sub    $0x4,%esp
    364e:	e9 2a ff ff ff       	jmp    357d <printf+0xad>
    3653:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3657:	90                   	nop
          s = "(null)";
    3658:	ba 30 38 00 00       	mov    $0x3830,%edx
        while(*s != 0){
    365d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3660:	b8 28 00 00 00       	mov    $0x28,%eax
    3665:	89 d3                	mov    %edx,%ebx
    3667:	e9 74 ff ff ff       	jmp    35e0 <printf+0x110>
    366c:	66 90                	xchg   %ax,%ax
    366e:	66 90                	xchg   %ax,%ax

00003670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3670:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3671:	a1 80 3d 00 00       	mov    0x3d80,%eax
{
    3676:	89 e5                	mov    %esp,%ebp
    3678:	57                   	push   %edi
    3679:	56                   	push   %esi
    367a:	53                   	push   %ebx
    367b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    367e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3688:	89 c2                	mov    %eax,%edx
    368a:	8b 00                	mov    (%eax),%eax
    368c:	39 ca                	cmp    %ecx,%edx
    368e:	73 30                	jae    36c0 <free+0x50>
    3690:	39 c1                	cmp    %eax,%ecx
    3692:	72 04                	jb     3698 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3694:	39 c2                	cmp    %eax,%edx
    3696:	72 f0                	jb     3688 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3698:	8b 73 fc             	mov    -0x4(%ebx),%esi
    369b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    369e:	39 f8                	cmp    %edi,%eax
    36a0:	74 30                	je     36d2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    36a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    36a5:	8b 42 04             	mov    0x4(%edx),%eax
    36a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    36ab:	39 f1                	cmp    %esi,%ecx
    36ad:	74 3a                	je     36e9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    36af:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    36b1:	5b                   	pop    %ebx
  freep = p;
    36b2:	89 15 80 3d 00 00    	mov    %edx,0x3d80
}
    36b8:	5e                   	pop    %esi
    36b9:	5f                   	pop    %edi
    36ba:	5d                   	pop    %ebp
    36bb:	c3                   	ret    
    36bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    36c0:	39 c2                	cmp    %eax,%edx
    36c2:	72 c4                	jb     3688 <free+0x18>
    36c4:	39 c1                	cmp    %eax,%ecx
    36c6:	73 c0                	jae    3688 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    36c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    36cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    36ce:	39 f8                	cmp    %edi,%eax
    36d0:	75 d0                	jne    36a2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    36d2:	03 70 04             	add    0x4(%eax),%esi
    36d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    36d8:	8b 02                	mov    (%edx),%eax
    36da:	8b 00                	mov    (%eax),%eax
    36dc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    36df:	8b 42 04             	mov    0x4(%edx),%eax
    36e2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    36e5:	39 f1                	cmp    %esi,%ecx
    36e7:	75 c6                	jne    36af <free+0x3f>
    p->s.size += bp->s.size;
    36e9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    36ec:	89 15 80 3d 00 00    	mov    %edx,0x3d80
    p->s.size += bp->s.size;
    36f2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    36f5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    36f8:	89 0a                	mov    %ecx,(%edx)
}
    36fa:	5b                   	pop    %ebx
    36fb:	5e                   	pop    %esi
    36fc:	5f                   	pop    %edi
    36fd:	5d                   	pop    %ebp
    36fe:	c3                   	ret    
    36ff:	90                   	nop

00003700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3700:	55                   	push   %ebp
    3701:	89 e5                	mov    %esp,%ebp
    3703:	57                   	push   %edi
    3704:	56                   	push   %esi
    3705:	53                   	push   %ebx
    3706:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    370c:	8b 3d 80 3d 00 00    	mov    0x3d80,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3712:	8d 70 07             	lea    0x7(%eax),%esi
    3715:	c1 ee 03             	shr    $0x3,%esi
    3718:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    371b:	85 ff                	test   %edi,%edi
    371d:	0f 84 9d 00 00 00    	je     37c0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3723:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3725:	8b 4a 04             	mov    0x4(%edx),%ecx
    3728:	39 f1                	cmp    %esi,%ecx
    372a:	73 6a                	jae    3796 <malloc+0x96>
    372c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3731:	39 de                	cmp    %ebx,%esi
    3733:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3736:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    373d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3740:	eb 17                	jmp    3759 <malloc+0x59>
    3742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3748:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    374a:	8b 48 04             	mov    0x4(%eax),%ecx
    374d:	39 f1                	cmp    %esi,%ecx
    374f:	73 4f                	jae    37a0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3751:	8b 3d 80 3d 00 00    	mov    0x3d80,%edi
    3757:	89 c2                	mov    %eax,%edx
    3759:	39 d7                	cmp    %edx,%edi
    375b:	75 eb                	jne    3748 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    375d:	83 ec 0c             	sub    $0xc,%esp
    3760:	ff 75 e4             	push   -0x1c(%ebp)
    3763:	e8 83 fc ff ff       	call   33eb <sbrk>
  if(p == (char*)-1)
    3768:	83 c4 10             	add    $0x10,%esp
    376b:	83 f8 ff             	cmp    $0xffffffff,%eax
    376e:	74 1c                	je     378c <malloc+0x8c>
  hp->s.size = nu;
    3770:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3773:	83 ec 0c             	sub    $0xc,%esp
    3776:	83 c0 08             	add    $0x8,%eax
    3779:	50                   	push   %eax
    377a:	e8 f1 fe ff ff       	call   3670 <free>
  return freep;
    377f:	8b 15 80 3d 00 00    	mov    0x3d80,%edx
      if((p = morecore(nunits)) == 0)
    3785:	83 c4 10             	add    $0x10,%esp
    3788:	85 d2                	test   %edx,%edx
    378a:	75 bc                	jne    3748 <malloc+0x48>
        return 0;
  }
}
    378c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    378f:	31 c0                	xor    %eax,%eax
}
    3791:	5b                   	pop    %ebx
    3792:	5e                   	pop    %esi
    3793:	5f                   	pop    %edi
    3794:	5d                   	pop    %ebp
    3795:	c3                   	ret    
    if(p->s.size >= nunits){
    3796:	89 d0                	mov    %edx,%eax
    3798:	89 fa                	mov    %edi,%edx
    379a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    37a0:	39 ce                	cmp    %ecx,%esi
    37a2:	74 4c                	je     37f0 <malloc+0xf0>
        p->s.size -= nunits;
    37a4:	29 f1                	sub    %esi,%ecx
    37a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    37a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    37ac:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    37af:	89 15 80 3d 00 00    	mov    %edx,0x3d80
}
    37b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    37b8:	83 c0 08             	add    $0x8,%eax
}
    37bb:	5b                   	pop    %ebx
    37bc:	5e                   	pop    %esi
    37bd:	5f                   	pop    %edi
    37be:	5d                   	pop    %ebp
    37bf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    37c0:	c7 05 80 3d 00 00 84 	movl   $0x3d84,0x3d80
    37c7:	3d 00 00 
    base.s.size = 0;
    37ca:	bf 84 3d 00 00       	mov    $0x3d84,%edi
    base.s.ptr = freep = prevp = &base;
    37cf:	c7 05 84 3d 00 00 84 	movl   $0x3d84,0x3d84
    37d6:	3d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37d9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    37db:	c7 05 88 3d 00 00 00 	movl   $0x0,0x3d88
    37e2:	00 00 00 
    if(p->s.size >= nunits){
    37e5:	e9 42 ff ff ff       	jmp    372c <malloc+0x2c>
    37ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    37f0:	8b 08                	mov    (%eax),%ecx
    37f2:	89 0a                	mov    %ecx,(%edx)
    37f4:	eb b9                	jmp    37af <malloc+0xaf>
