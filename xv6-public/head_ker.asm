
_head_ker:     file format elf32-i386


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
    3017:	8b 79 04             	mov    0x4(%ecx),%edi
char buf[1024];
        //int sentences = 0;
        //char curr_line[15][100]; // prev_line[] = "";
        
       if(argv[1][0] == '-'){
    301a:	8b 47 04             	mov    0x4(%edi),%eax
    301d:	80 38 2d             	cmpb   $0x2d,(%eax)
    3020:	75 61                	jne    3083 <main+0x83>
        int len=0;
        for(int i=0;i<strlen(argv[2]);i++)
    3022:	8b 47 08             	mov    0x8(%edi),%eax
    3025:	31 db                	xor    %ebx,%ebx
        int len=0;
    3027:	31 f6                	xor    %esi,%esi
    3029:	eb 16                	jmp    3041 <main+0x41>
    302b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    302f:	90                   	nop
        len = len*10+argv[2][i]-'0';
    3030:	8b 47 08             	mov    0x8(%edi),%eax
    3033:	8d 0c b6             	lea    (%esi,%esi,4),%ecx
    3036:	0f be 14 18          	movsbl (%eax,%ebx,1),%edx
        for(int i=0;i<strlen(argv[2]);i++)
    303a:	83 c3 01             	add    $0x1,%ebx
        len = len*10+argv[2][i]-'0';
    303d:	8d 74 4a d0          	lea    -0x30(%edx,%ecx,2),%esi
        for(int i=0;i<strlen(argv[2]);i++)
    3041:	83 ec 0c             	sub    $0xc,%esp
    3044:	50                   	push   %eax
    3045:	e8 06 01 00 00       	call   3150 <strlen>
    304a:	83 c4 10             	add    $0x10,%esp
    304d:	39 d8                	cmp    %ebx,%eax
    304f:	77 df                	ja     3030 <main+0x30>
    
       const char *filename = argv[3];
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3051:	50                   	push   %eax
        read(fd,buf,sizeof(buf));
    3052:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3058:	50                   	push   %eax
    3059:	6a 00                	push   $0x0
    305b:	ff 77 0c             	push   0xc(%edi)
    305e:	e8 f0 02 00 00       	call   3353 <open>
        read(fd,buf,sizeof(buf));
    3063:	83 c4 0c             	add    $0xc,%esp
    3066:	68 00 04 00 00       	push   $0x400
    306b:	53                   	push   %ebx
    306c:	50                   	push   %eax
    306d:	e8 b9 02 00 00       	call   332b <read>
        head(len,buf);
    3072:	58                   	pop    %eax
    3073:	5a                   	pop    %edx
    3074:	53                   	push   %ebx
    3075:	56                   	push   %esi
    3076:	e8 40 03 00 00       	call   33bb <head>
    307b:	83 c4 10             	add    $0x10,%esp
       }
    
    
    // open()
    // close()
    exit();
    307e:	e8 90 02 00 00       	call   3313 <exit>
        int fd = open(filename, O_RDONLY); // Open the file for reading
    3083:	52                   	push   %edx
        read(fd,buf,sizeof(buf));
    3084:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
        int fd = open(filename, O_RDONLY); // Open the file for reading
    308a:	52                   	push   %edx
    308b:	6a 00                	push   $0x0
    308d:	50                   	push   %eax
    308e:	e8 c0 02 00 00       	call   3353 <open>
        read(fd,buf,sizeof(buf));
    3093:	83 c4 0c             	add    $0xc,%esp
    3096:	68 00 04 00 00       	push   $0x400
    309b:	53                   	push   %ebx
    309c:	50                   	push   %eax
    309d:	e8 89 02 00 00       	call   332b <read>
        head(14,buf);
    30a2:	59                   	pop    %ecx
    30a3:	5e                   	pop    %esi
    30a4:	53                   	push   %ebx
    30a5:	6a 0e                	push   $0xe
    30a7:	e8 0f 03 00 00       	call   33bb <head>
    30ac:	83 c4 10             	add    $0x10,%esp
    30af:	eb cd                	jmp    307e <main+0x7e>
    30b1:	66 90                	xchg   %ax,%ax
    30b3:	66 90                	xchg   %ax,%ax
    30b5:	66 90                	xchg   %ax,%ax
    30b7:	66 90                	xchg   %ax,%ax
    30b9:	66 90                	xchg   %ax,%ax
    30bb:	66 90                	xchg   %ax,%ax
    30bd:	66 90                	xchg   %ax,%ax
    30bf:	90                   	nop

000030c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    30c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    30c1:	31 c0                	xor    %eax,%eax
{
    30c3:	89 e5                	mov    %esp,%ebp
    30c5:	53                   	push   %ebx
    30c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    30c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    30cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    30d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    30d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    30d7:	83 c0 01             	add    $0x1,%eax
    30da:	84 d2                	test   %dl,%dl
    30dc:	75 f2                	jne    30d0 <strcpy+0x10>
    ;
  return os;
}
    30de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    30e1:	89 c8                	mov    %ecx,%eax
    30e3:	c9                   	leave  
    30e4:	c3                   	ret    
    30e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000030f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30f0:	55                   	push   %ebp
    30f1:	89 e5                	mov    %esp,%ebp
    30f3:	53                   	push   %ebx
    30f4:	8b 55 08             	mov    0x8(%ebp),%edx
    30f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    30fa:	0f b6 02             	movzbl (%edx),%eax
    30fd:	84 c0                	test   %al,%al
    30ff:	75 17                	jne    3118 <strcmp+0x28>
    3101:	eb 3a                	jmp    313d <strcmp+0x4d>
    3103:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3107:	90                   	nop
    3108:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    310c:	83 c2 01             	add    $0x1,%edx
    310f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3112:	84 c0                	test   %al,%al
    3114:	74 1a                	je     3130 <strcmp+0x40>
    p++, q++;
    3116:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3118:	0f b6 19             	movzbl (%ecx),%ebx
    311b:	38 c3                	cmp    %al,%bl
    311d:	74 e9                	je     3108 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    311f:	29 d8                	sub    %ebx,%eax
}
    3121:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3124:	c9                   	leave  
    3125:	c3                   	ret    
    3126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    312d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3130:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3134:	31 c0                	xor    %eax,%eax
    3136:	29 d8                	sub    %ebx,%eax
}
    3138:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    313b:	c9                   	leave  
    313c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    313d:	0f b6 19             	movzbl (%ecx),%ebx
    3140:	31 c0                	xor    %eax,%eax
    3142:	eb db                	jmp    311f <strcmp+0x2f>
    3144:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    314b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    314f:	90                   	nop

00003150 <strlen>:

uint
strlen(const char *s)
{
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
    3153:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3156:	80 3a 00             	cmpb   $0x0,(%edx)
    3159:	74 15                	je     3170 <strlen+0x20>
    315b:	31 c0                	xor    %eax,%eax
    315d:	8d 76 00             	lea    0x0(%esi),%esi
    3160:	83 c0 01             	add    $0x1,%eax
    3163:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3167:	89 c1                	mov    %eax,%ecx
    3169:	75 f5                	jne    3160 <strlen+0x10>
    ;
  return n;
}
    316b:	89 c8                	mov    %ecx,%eax
    316d:	5d                   	pop    %ebp
    316e:	c3                   	ret    
    316f:	90                   	nop
  for(n = 0; s[n]; n++)
    3170:	31 c9                	xor    %ecx,%ecx
}
    3172:	5d                   	pop    %ebp
    3173:	89 c8                	mov    %ecx,%eax
    3175:	c3                   	ret    
    3176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317d:	8d 76 00             	lea    0x0(%esi),%esi

00003180 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	57                   	push   %edi
    3184:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3187:	8b 4d 10             	mov    0x10(%ebp),%ecx
    318a:	8b 45 0c             	mov    0xc(%ebp),%eax
    318d:	89 d7                	mov    %edx,%edi
    318f:	fc                   	cld    
    3190:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3192:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3195:	89 d0                	mov    %edx,%eax
    3197:	c9                   	leave  
    3198:	c3                   	ret    
    3199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000031a0 <strchr>:

char*
strchr(const char *s, char c)
{
    31a0:	55                   	push   %ebp
    31a1:	89 e5                	mov    %esp,%ebp
    31a3:	8b 45 08             	mov    0x8(%ebp),%eax
    31a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    31aa:	0f b6 10             	movzbl (%eax),%edx
    31ad:	84 d2                	test   %dl,%dl
    31af:	75 12                	jne    31c3 <strchr+0x23>
    31b1:	eb 1d                	jmp    31d0 <strchr+0x30>
    31b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31b7:	90                   	nop
    31b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    31bc:	83 c0 01             	add    $0x1,%eax
    31bf:	84 d2                	test   %dl,%dl
    31c1:	74 0d                	je     31d0 <strchr+0x30>
    if(*s == c)
    31c3:	38 d1                	cmp    %dl,%cl
    31c5:	75 f1                	jne    31b8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    31c7:	5d                   	pop    %ebp
    31c8:	c3                   	ret    
    31c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    31d0:	31 c0                	xor    %eax,%eax
}
    31d2:	5d                   	pop    %ebp
    31d3:	c3                   	ret    
    31d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31df:	90                   	nop

000031e0 <gets>:

char*
gets(char *buf, int max)
{
    31e0:	55                   	push   %ebp
    31e1:	89 e5                	mov    %esp,%ebp
    31e3:	57                   	push   %edi
    31e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    31e5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    31e8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    31e9:	31 db                	xor    %ebx,%ebx
{
    31eb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    31ee:	eb 27                	jmp    3217 <gets+0x37>
    cc = read(0, &c, 1);
    31f0:	83 ec 04             	sub    $0x4,%esp
    31f3:	6a 01                	push   $0x1
    31f5:	57                   	push   %edi
    31f6:	6a 00                	push   $0x0
    31f8:	e8 2e 01 00 00       	call   332b <read>
    if(cc < 1)
    31fd:	83 c4 10             	add    $0x10,%esp
    3200:	85 c0                	test   %eax,%eax
    3202:	7e 1d                	jle    3221 <gets+0x41>
      break;
    buf[i++] = c;
    3204:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3208:	8b 55 08             	mov    0x8(%ebp),%edx
    320b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    320f:	3c 0a                	cmp    $0xa,%al
    3211:	74 1d                	je     3230 <gets+0x50>
    3213:	3c 0d                	cmp    $0xd,%al
    3215:	74 19                	je     3230 <gets+0x50>
  for(i=0; i+1 < max; ){
    3217:	89 de                	mov    %ebx,%esi
    3219:	83 c3 01             	add    $0x1,%ebx
    321c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    321f:	7c cf                	jl     31f0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3221:	8b 45 08             	mov    0x8(%ebp),%eax
    3224:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3228:	8d 65 f4             	lea    -0xc(%ebp),%esp
    322b:	5b                   	pop    %ebx
    322c:	5e                   	pop    %esi
    322d:	5f                   	pop    %edi
    322e:	5d                   	pop    %ebp
    322f:	c3                   	ret    
  buf[i] = '\0';
    3230:	8b 45 08             	mov    0x8(%ebp),%eax
    3233:	89 de                	mov    %ebx,%esi
    3235:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3239:	8d 65 f4             	lea    -0xc(%ebp),%esp
    323c:	5b                   	pop    %ebx
    323d:	5e                   	pop    %esi
    323e:	5f                   	pop    %edi
    323f:	5d                   	pop    %ebp
    3240:	c3                   	ret    
    3241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    324f:	90                   	nop

00003250 <stat>:

int
stat(const char *n, struct stat *st)
{
    3250:	55                   	push   %ebp
    3251:	89 e5                	mov    %esp,%ebp
    3253:	56                   	push   %esi
    3254:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3255:	83 ec 08             	sub    $0x8,%esp
    3258:	6a 00                	push   $0x0
    325a:	ff 75 08             	push   0x8(%ebp)
    325d:	e8 f1 00 00 00       	call   3353 <open>
  if(fd < 0)
    3262:	83 c4 10             	add    $0x10,%esp
    3265:	85 c0                	test   %eax,%eax
    3267:	78 27                	js     3290 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3269:	83 ec 08             	sub    $0x8,%esp
    326c:	ff 75 0c             	push   0xc(%ebp)
    326f:	89 c3                	mov    %eax,%ebx
    3271:	50                   	push   %eax
    3272:	e8 f4 00 00 00       	call   336b <fstat>
  close(fd);
    3277:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    327a:	89 c6                	mov    %eax,%esi
  close(fd);
    327c:	e8 ba 00 00 00       	call   333b <close>
  return r;
    3281:	83 c4 10             	add    $0x10,%esp
}
    3284:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3287:	89 f0                	mov    %esi,%eax
    3289:	5b                   	pop    %ebx
    328a:	5e                   	pop    %esi
    328b:	5d                   	pop    %ebp
    328c:	c3                   	ret    
    328d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3290:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3295:	eb ed                	jmp    3284 <stat+0x34>
    3297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329e:	66 90                	xchg   %ax,%ax

000032a0 <atoi>:

int
atoi(const char *s)
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	53                   	push   %ebx
    32a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32a7:	0f be 02             	movsbl (%edx),%eax
    32aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
    32ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    32b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    32b5:	77 1e                	ja     32d5 <atoi+0x35>
    32b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32be:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    32c0:	83 c2 01             	add    $0x1,%edx
    32c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    32c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    32ca:	0f be 02             	movsbl (%edx),%eax
    32cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
    32d0:	80 fb 09             	cmp    $0x9,%bl
    32d3:	76 eb                	jbe    32c0 <atoi+0x20>
  return n;
}
    32d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    32d8:	89 c8                	mov    %ecx,%eax
    32da:	c9                   	leave  
    32db:	c3                   	ret    
    32dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000032e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32e0:	55                   	push   %ebp
    32e1:	89 e5                	mov    %esp,%ebp
    32e3:	57                   	push   %edi
    32e4:	8b 45 10             	mov    0x10(%ebp),%eax
    32e7:	8b 55 08             	mov    0x8(%ebp),%edx
    32ea:	56                   	push   %esi
    32eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    32ee:	85 c0                	test   %eax,%eax
    32f0:	7e 13                	jle    3305 <memmove+0x25>
    32f2:	01 d0                	add    %edx,%eax
  dst = vdst;
    32f4:	89 d7                	mov    %edx,%edi
    32f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32fd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3300:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3301:	39 f8                	cmp    %edi,%eax
    3303:	75 fb                	jne    3300 <memmove+0x20>
  return vdst;
}
    3305:	5e                   	pop    %esi
    3306:	89 d0                	mov    %edx,%eax
    3308:	5f                   	pop    %edi
    3309:	5d                   	pop    %ebp
    330a:	c3                   	ret    

0000330b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    330b:	b8 01 00 00 00       	mov    $0x1,%eax
    3310:	cd 40                	int    $0x40
    3312:	c3                   	ret    

00003313 <exit>:
SYSCALL(exit)
    3313:	b8 02 00 00 00       	mov    $0x2,%eax
    3318:	cd 40                	int    $0x40
    331a:	c3                   	ret    

0000331b <wait>:
SYSCALL(wait)
    331b:	b8 03 00 00 00       	mov    $0x3,%eax
    3320:	cd 40                	int    $0x40
    3322:	c3                   	ret    

00003323 <pipe>:
SYSCALL(pipe)
    3323:	b8 04 00 00 00       	mov    $0x4,%eax
    3328:	cd 40                	int    $0x40
    332a:	c3                   	ret    

0000332b <read>:
SYSCALL(read)
    332b:	b8 05 00 00 00       	mov    $0x5,%eax
    3330:	cd 40                	int    $0x40
    3332:	c3                   	ret    

00003333 <write>:
SYSCALL(write)
    3333:	b8 10 00 00 00       	mov    $0x10,%eax
    3338:	cd 40                	int    $0x40
    333a:	c3                   	ret    

0000333b <close>:
SYSCALL(close)
    333b:	b8 15 00 00 00       	mov    $0x15,%eax
    3340:	cd 40                	int    $0x40
    3342:	c3                   	ret    

00003343 <kill>:
SYSCALL(kill)
    3343:	b8 06 00 00 00       	mov    $0x6,%eax
    3348:	cd 40                	int    $0x40
    334a:	c3                   	ret    

0000334b <exec>:
SYSCALL(exec)
    334b:	b8 07 00 00 00       	mov    $0x7,%eax
    3350:	cd 40                	int    $0x40
    3352:	c3                   	ret    

00003353 <open>:
SYSCALL(open)
    3353:	b8 0f 00 00 00       	mov    $0xf,%eax
    3358:	cd 40                	int    $0x40
    335a:	c3                   	ret    

0000335b <mknod>:
SYSCALL(mknod)
    335b:	b8 11 00 00 00       	mov    $0x11,%eax
    3360:	cd 40                	int    $0x40
    3362:	c3                   	ret    

00003363 <unlink>:
SYSCALL(unlink)
    3363:	b8 12 00 00 00       	mov    $0x12,%eax
    3368:	cd 40                	int    $0x40
    336a:	c3                   	ret    

0000336b <fstat>:
SYSCALL(fstat)
    336b:	b8 08 00 00 00       	mov    $0x8,%eax
    3370:	cd 40                	int    $0x40
    3372:	c3                   	ret    

00003373 <link>:
SYSCALL(link)
    3373:	b8 13 00 00 00       	mov    $0x13,%eax
    3378:	cd 40                	int    $0x40
    337a:	c3                   	ret    

0000337b <mkdir>:
SYSCALL(mkdir)
    337b:	b8 14 00 00 00       	mov    $0x14,%eax
    3380:	cd 40                	int    $0x40
    3382:	c3                   	ret    

00003383 <chdir>:
SYSCALL(chdir)
    3383:	b8 09 00 00 00       	mov    $0x9,%eax
    3388:	cd 40                	int    $0x40
    338a:	c3                   	ret    

0000338b <dup>:
SYSCALL(dup)
    338b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3390:	cd 40                	int    $0x40
    3392:	c3                   	ret    

00003393 <getpid>:
SYSCALL(getpid)
    3393:	b8 0b 00 00 00       	mov    $0xb,%eax
    3398:	cd 40                	int    $0x40
    339a:	c3                   	ret    

0000339b <sbrk>:
SYSCALL(sbrk)
    339b:	b8 0c 00 00 00       	mov    $0xc,%eax
    33a0:	cd 40                	int    $0x40
    33a2:	c3                   	ret    

000033a3 <sleep>:
SYSCALL(sleep)
    33a3:	b8 0d 00 00 00       	mov    $0xd,%eax
    33a8:	cd 40                	int    $0x40
    33aa:	c3                   	ret    

000033ab <uptime>:
SYSCALL(uptime)
    33ab:	b8 0e 00 00 00       	mov    $0xe,%eax
    33b0:	cd 40                	int    $0x40
    33b2:	c3                   	ret    

000033b3 <uniq>:
SYSCALL(uniq)
    33b3:	b8 16 00 00 00       	mov    $0x16,%eax
    33b8:	cd 40                	int    $0x40
    33ba:	c3                   	ret    

000033bb <head>:
SYSCALL(head)
    33bb:	b8 17 00 00 00       	mov    $0x17,%eax
    33c0:	cd 40                	int    $0x40
    33c2:	c3                   	ret    

000033c3 <ps>:
    33c3:	b8 18 00 00 00       	mov    $0x18,%eax
    33c8:	cd 40                	int    $0x40
    33ca:	c3                   	ret    
    33cb:	66 90                	xchg   %ax,%ax
    33cd:	66 90                	xchg   %ax,%ax
    33cf:	90                   	nop

000033d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    33d0:	55                   	push   %ebp
    33d1:	89 e5                	mov    %esp,%ebp
    33d3:	57                   	push   %edi
    33d4:	56                   	push   %esi
    33d5:	53                   	push   %ebx
    33d6:	83 ec 3c             	sub    $0x3c,%esp
    33d9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    33dc:	89 d1                	mov    %edx,%ecx
{
    33de:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    33e1:	85 d2                	test   %edx,%edx
    33e3:	0f 89 7f 00 00 00    	jns    3468 <printint+0x98>
    33e9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    33ed:	74 79                	je     3468 <printint+0x98>
    neg = 1;
    33ef:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    33f6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    33f8:	31 db                	xor    %ebx,%ebx
    33fa:	8d 75 d7             	lea    -0x29(%ebp),%esi
    33fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3400:	89 c8                	mov    %ecx,%eax
    3402:	31 d2                	xor    %edx,%edx
    3404:	89 cf                	mov    %ecx,%edi
    3406:	f7 75 c4             	divl   -0x3c(%ebp)
    3409:	0f b6 92 08 38 00 00 	movzbl 0x3808(%edx),%edx
    3410:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3413:	89 d8                	mov    %ebx,%eax
    3415:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3418:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    341b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    341e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3421:	76 dd                	jbe    3400 <printint+0x30>
  if(neg)
    3423:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3426:	85 c9                	test   %ecx,%ecx
    3428:	74 0c                	je     3436 <printint+0x66>
    buf[i++] = '-';
    342a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    342f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3431:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3436:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3439:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    343d:	eb 07                	jmp    3446 <printint+0x76>
    343f:	90                   	nop
    putc(fd, buf[i]);
    3440:	0f b6 13             	movzbl (%ebx),%edx
    3443:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3446:	83 ec 04             	sub    $0x4,%esp
    3449:	88 55 d7             	mov    %dl,-0x29(%ebp)
    344c:	6a 01                	push   $0x1
    344e:	56                   	push   %esi
    344f:	57                   	push   %edi
    3450:	e8 de fe ff ff       	call   3333 <write>
  while(--i >= 0)
    3455:	83 c4 10             	add    $0x10,%esp
    3458:	39 de                	cmp    %ebx,%esi
    345a:	75 e4                	jne    3440 <printint+0x70>
}
    345c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    345f:	5b                   	pop    %ebx
    3460:	5e                   	pop    %esi
    3461:	5f                   	pop    %edi
    3462:	5d                   	pop    %ebp
    3463:	c3                   	ret    
    3464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3468:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    346f:	eb 87                	jmp    33f8 <printint+0x28>
    3471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    347f:	90                   	nop

00003480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3480:	55                   	push   %ebp
    3481:	89 e5                	mov    %esp,%ebp
    3483:	57                   	push   %edi
    3484:	56                   	push   %esi
    3485:	53                   	push   %ebx
    3486:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3489:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    348c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    348f:	0f b6 13             	movzbl (%ebx),%edx
    3492:	84 d2                	test   %dl,%dl
    3494:	74 6a                	je     3500 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3496:	8d 45 10             	lea    0x10(%ebp),%eax
    3499:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    349c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    349f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    34a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    34a4:	eb 36                	jmp    34dc <printf+0x5c>
    34a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34ad:	8d 76 00             	lea    0x0(%esi),%esi
    34b0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    34b3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    34b8:	83 f8 25             	cmp    $0x25,%eax
    34bb:	74 15                	je     34d2 <printf+0x52>
  write(fd, &c, 1);
    34bd:	83 ec 04             	sub    $0x4,%esp
    34c0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    34c3:	6a 01                	push   $0x1
    34c5:	57                   	push   %edi
    34c6:	56                   	push   %esi
    34c7:	e8 67 fe ff ff       	call   3333 <write>
    34cc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    34cf:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    34d2:	0f b6 13             	movzbl (%ebx),%edx
    34d5:	83 c3 01             	add    $0x1,%ebx
    34d8:	84 d2                	test   %dl,%dl
    34da:	74 24                	je     3500 <printf+0x80>
    c = fmt[i] & 0xff;
    34dc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    34df:	85 c9                	test   %ecx,%ecx
    34e1:	74 cd                	je     34b0 <printf+0x30>
      }
    } else if(state == '%'){
    34e3:	83 f9 25             	cmp    $0x25,%ecx
    34e6:	75 ea                	jne    34d2 <printf+0x52>
      if(c == 'd'){
    34e8:	83 f8 25             	cmp    $0x25,%eax
    34eb:	0f 84 07 01 00 00    	je     35f8 <printf+0x178>
    34f1:	83 e8 63             	sub    $0x63,%eax
    34f4:	83 f8 15             	cmp    $0x15,%eax
    34f7:	77 17                	ja     3510 <printf+0x90>
    34f9:	ff 24 85 b0 37 00 00 	jmp    *0x37b0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3500:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3503:	5b                   	pop    %ebx
    3504:	5e                   	pop    %esi
    3505:	5f                   	pop    %edi
    3506:	5d                   	pop    %ebp
    3507:	c3                   	ret    
    3508:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    350f:	90                   	nop
  write(fd, &c, 1);
    3510:	83 ec 04             	sub    $0x4,%esp
    3513:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3516:	6a 01                	push   $0x1
    3518:	57                   	push   %edi
    3519:	56                   	push   %esi
    351a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    351e:	e8 10 fe ff ff       	call   3333 <write>
        putc(fd, c);
    3523:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3527:	83 c4 0c             	add    $0xc,%esp
    352a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    352d:	6a 01                	push   $0x1
    352f:	57                   	push   %edi
    3530:	56                   	push   %esi
    3531:	e8 fd fd ff ff       	call   3333 <write>
        putc(fd, c);
    3536:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3539:	31 c9                	xor    %ecx,%ecx
    353b:	eb 95                	jmp    34d2 <printf+0x52>
    353d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3540:	83 ec 0c             	sub    $0xc,%esp
    3543:	b9 10 00 00 00       	mov    $0x10,%ecx
    3548:	6a 00                	push   $0x0
    354a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    354d:	8b 10                	mov    (%eax),%edx
    354f:	89 f0                	mov    %esi,%eax
    3551:	e8 7a fe ff ff       	call   33d0 <printint>
        ap++;
    3556:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    355a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    355d:	31 c9                	xor    %ecx,%ecx
    355f:	e9 6e ff ff ff       	jmp    34d2 <printf+0x52>
    3564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3568:	8b 45 d0             	mov    -0x30(%ebp),%eax
    356b:	8b 10                	mov    (%eax),%edx
        ap++;
    356d:	83 c0 04             	add    $0x4,%eax
    3570:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3573:	85 d2                	test   %edx,%edx
    3575:	0f 84 8d 00 00 00    	je     3608 <printf+0x188>
        while(*s != 0){
    357b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    357e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3580:	84 c0                	test   %al,%al
    3582:	0f 84 4a ff ff ff    	je     34d2 <printf+0x52>
    3588:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    358b:	89 d3                	mov    %edx,%ebx
    358d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3590:	83 ec 04             	sub    $0x4,%esp
          s++;
    3593:	83 c3 01             	add    $0x1,%ebx
    3596:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3599:	6a 01                	push   $0x1
    359b:	57                   	push   %edi
    359c:	56                   	push   %esi
    359d:	e8 91 fd ff ff       	call   3333 <write>
        while(*s != 0){
    35a2:	0f b6 03             	movzbl (%ebx),%eax
    35a5:	83 c4 10             	add    $0x10,%esp
    35a8:	84 c0                	test   %al,%al
    35aa:	75 e4                	jne    3590 <printf+0x110>
      state = 0;
    35ac:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    35af:	31 c9                	xor    %ecx,%ecx
    35b1:	e9 1c ff ff ff       	jmp    34d2 <printf+0x52>
    35b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    35c0:	83 ec 0c             	sub    $0xc,%esp
    35c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    35c8:	6a 01                	push   $0x1
    35ca:	e9 7b ff ff ff       	jmp    354a <printf+0xca>
    35cf:	90                   	nop
        putc(fd, *ap);
    35d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    35d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    35d6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    35d8:	6a 01                	push   $0x1
    35da:	57                   	push   %edi
    35db:	56                   	push   %esi
        putc(fd, *ap);
    35dc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    35df:	e8 4f fd ff ff       	call   3333 <write>
        ap++;
    35e4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    35e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    35eb:	31 c9                	xor    %ecx,%ecx
    35ed:	e9 e0 fe ff ff       	jmp    34d2 <printf+0x52>
    35f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    35f8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    35fb:	83 ec 04             	sub    $0x4,%esp
    35fe:	e9 2a ff ff ff       	jmp    352d <printf+0xad>
    3603:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3607:	90                   	nop
          s = "(null)";
    3608:	ba a8 37 00 00       	mov    $0x37a8,%edx
        while(*s != 0){
    360d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3610:	b8 28 00 00 00       	mov    $0x28,%eax
    3615:	89 d3                	mov    %edx,%ebx
    3617:	e9 74 ff ff ff       	jmp    3590 <printf+0x110>
    361c:	66 90                	xchg   %ax,%ax
    361e:	66 90                	xchg   %ax,%ax

00003620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3621:	a1 bc 3a 00 00       	mov    0x3abc,%eax
{
    3626:	89 e5                	mov    %esp,%ebp
    3628:	57                   	push   %edi
    3629:	56                   	push   %esi
    362a:	53                   	push   %ebx
    362b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    362e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3638:	89 c2                	mov    %eax,%edx
    363a:	8b 00                	mov    (%eax),%eax
    363c:	39 ca                	cmp    %ecx,%edx
    363e:	73 30                	jae    3670 <free+0x50>
    3640:	39 c1                	cmp    %eax,%ecx
    3642:	72 04                	jb     3648 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3644:	39 c2                	cmp    %eax,%edx
    3646:	72 f0                	jb     3638 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3648:	8b 73 fc             	mov    -0x4(%ebx),%esi
    364b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    364e:	39 f8                	cmp    %edi,%eax
    3650:	74 30                	je     3682 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3652:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3655:	8b 42 04             	mov    0x4(%edx),%eax
    3658:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    365b:	39 f1                	cmp    %esi,%ecx
    365d:	74 3a                	je     3699 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    365f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3661:	5b                   	pop    %ebx
  freep = p;
    3662:	89 15 bc 3a 00 00    	mov    %edx,0x3abc
}
    3668:	5e                   	pop    %esi
    3669:	5f                   	pop    %edi
    366a:	5d                   	pop    %ebp
    366b:	c3                   	ret    
    366c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3670:	39 c2                	cmp    %eax,%edx
    3672:	72 c4                	jb     3638 <free+0x18>
    3674:	39 c1                	cmp    %eax,%ecx
    3676:	73 c0                	jae    3638 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3678:	8b 73 fc             	mov    -0x4(%ebx),%esi
    367b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    367e:	39 f8                	cmp    %edi,%eax
    3680:	75 d0                	jne    3652 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3682:	03 70 04             	add    0x4(%eax),%esi
    3685:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3688:	8b 02                	mov    (%edx),%eax
    368a:	8b 00                	mov    (%eax),%eax
    368c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    368f:	8b 42 04             	mov    0x4(%edx),%eax
    3692:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3695:	39 f1                	cmp    %esi,%ecx
    3697:	75 c6                	jne    365f <free+0x3f>
    p->s.size += bp->s.size;
    3699:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    369c:	89 15 bc 3a 00 00    	mov    %edx,0x3abc
    p->s.size += bp->s.size;
    36a2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    36a5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    36a8:	89 0a                	mov    %ecx,(%edx)
}
    36aa:	5b                   	pop    %ebx
    36ab:	5e                   	pop    %esi
    36ac:	5f                   	pop    %edi
    36ad:	5d                   	pop    %ebp
    36ae:	c3                   	ret    
    36af:	90                   	nop

000036b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	57                   	push   %edi
    36b4:	56                   	push   %esi
    36b5:	53                   	push   %ebx
    36b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    36b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    36bc:	8b 3d bc 3a 00 00    	mov    0x3abc,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    36c2:	8d 70 07             	lea    0x7(%eax),%esi
    36c5:	c1 ee 03             	shr    $0x3,%esi
    36c8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    36cb:	85 ff                	test   %edi,%edi
    36cd:	0f 84 9d 00 00 00    	je     3770 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    36d3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    36d5:	8b 4a 04             	mov    0x4(%edx),%ecx
    36d8:	39 f1                	cmp    %esi,%ecx
    36da:	73 6a                	jae    3746 <malloc+0x96>
    36dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    36e1:	39 de                	cmp    %ebx,%esi
    36e3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    36e6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    36ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    36f0:	eb 17                	jmp    3709 <malloc+0x59>
    36f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    36f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    36fa:	8b 48 04             	mov    0x4(%eax),%ecx
    36fd:	39 f1                	cmp    %esi,%ecx
    36ff:	73 4f                	jae    3750 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3701:	8b 3d bc 3a 00 00    	mov    0x3abc,%edi
    3707:	89 c2                	mov    %eax,%edx
    3709:	39 d7                	cmp    %edx,%edi
    370b:	75 eb                	jne    36f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    370d:	83 ec 0c             	sub    $0xc,%esp
    3710:	ff 75 e4             	push   -0x1c(%ebp)
    3713:	e8 83 fc ff ff       	call   339b <sbrk>
  if(p == (char*)-1)
    3718:	83 c4 10             	add    $0x10,%esp
    371b:	83 f8 ff             	cmp    $0xffffffff,%eax
    371e:	74 1c                	je     373c <malloc+0x8c>
  hp->s.size = nu;
    3720:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3723:	83 ec 0c             	sub    $0xc,%esp
    3726:	83 c0 08             	add    $0x8,%eax
    3729:	50                   	push   %eax
    372a:	e8 f1 fe ff ff       	call   3620 <free>
  return freep;
    372f:	8b 15 bc 3a 00 00    	mov    0x3abc,%edx
      if((p = morecore(nunits)) == 0)
    3735:	83 c4 10             	add    $0x10,%esp
    3738:	85 d2                	test   %edx,%edx
    373a:	75 bc                	jne    36f8 <malloc+0x48>
        return 0;
  }
}
    373c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    373f:	31 c0                	xor    %eax,%eax
}
    3741:	5b                   	pop    %ebx
    3742:	5e                   	pop    %esi
    3743:	5f                   	pop    %edi
    3744:	5d                   	pop    %ebp
    3745:	c3                   	ret    
    if(p->s.size >= nunits){
    3746:	89 d0                	mov    %edx,%eax
    3748:	89 fa                	mov    %edi,%edx
    374a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3750:	39 ce                	cmp    %ecx,%esi
    3752:	74 4c                	je     37a0 <malloc+0xf0>
        p->s.size -= nunits;
    3754:	29 f1                	sub    %esi,%ecx
    3756:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3759:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    375c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    375f:	89 15 bc 3a 00 00    	mov    %edx,0x3abc
}
    3765:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3768:	83 c0 08             	add    $0x8,%eax
}
    376b:	5b                   	pop    %ebx
    376c:	5e                   	pop    %esi
    376d:	5f                   	pop    %edi
    376e:	5d                   	pop    %ebp
    376f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3770:	c7 05 bc 3a 00 00 c0 	movl   $0x3ac0,0x3abc
    3777:	3a 00 00 
    base.s.size = 0;
    377a:	bf c0 3a 00 00       	mov    $0x3ac0,%edi
    base.s.ptr = freep = prevp = &base;
    377f:	c7 05 c0 3a 00 00 c0 	movl   $0x3ac0,0x3ac0
    3786:	3a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3789:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    378b:	c7 05 c4 3a 00 00 00 	movl   $0x0,0x3ac4
    3792:	00 00 00 
    if(p->s.size >= nunits){
    3795:	e9 42 ff ff ff       	jmp    36dc <malloc+0x2c>
    379a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    37a0:	8b 08                	mov    (%eax),%ecx
    37a2:	89 0a                	mov    %ecx,(%edx)
    37a4:	eb b9                	jmp    375f <malloc+0xaf>
