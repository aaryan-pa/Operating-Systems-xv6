
_wc:     file format elf32-i386


Disassembly of section .text:

00003000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
    3027:	7e 56                	jle    307f <main+0x7f>
    3029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    3030:	83 ec 08             	sub    $0x8,%esp
    3033:	6a 00                	push   $0x0
    3035:	ff 33                	push   (%ebx)
    3037:	e8 d7 03 00 00       	call   3413 <open>
    303c:	83 c4 10             	add    $0x10,%esp
    303f:	89 c7                	mov    %eax,%edi
    3041:	85 c0                	test   %eax,%eax
    3043:	78 26                	js     306b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
    3045:	83 ec 08             	sub    $0x8,%esp
    3048:	ff 33                	push   (%ebx)
  for(i = 1; i < argc; i++){
    304a:	83 c6 01             	add    $0x1,%esi
    304d:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
    3050:	50                   	push   %eax
    3051:	e8 4a 00 00 00       	call   30a0 <wc>
    close(fd);
    3056:	89 3c 24             	mov    %edi,(%esp)
    3059:	e8 9d 03 00 00       	call   33fb <close>
  for(i = 1; i < argc; i++){
    305e:	83 c4 10             	add    $0x10,%esp
    3061:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
    3064:	75 ca                	jne    3030 <main+0x30>
  }
  exit();
    3066:	e8 68 03 00 00       	call   33d3 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
    306b:	50                   	push   %eax
    306c:	ff 33                	push   (%ebx)
    306e:	68 8b 38 00 00       	push   $0x388b
    3073:	6a 01                	push   $0x1
    3075:	e8 c6 04 00 00       	call   3540 <printf>
      exit();
    307a:	e8 54 03 00 00       	call   33d3 <exit>
    wc(0, "");
    307f:	52                   	push   %edx
    3080:	52                   	push   %edx
    3081:	68 7d 38 00 00       	push   $0x387d
    3086:	6a 00                	push   $0x0
    3088:	e8 13 00 00 00       	call   30a0 <wc>
    exit();
    308d:	e8 41 03 00 00       	call   33d3 <exit>
    3092:	66 90                	xchg   %ax,%ax
    3094:	66 90                	xchg   %ax,%ax
    3096:	66 90                	xchg   %ax,%ax
    3098:	66 90                	xchg   %ax,%ax
    309a:	66 90                	xchg   %ax,%ax
    309c:	66 90                	xchg   %ax,%ax
    309e:	66 90                	xchg   %ax,%ax

000030a0 <wc>:
{
    30a0:	55                   	push   %ebp
    30a1:	89 e5                	mov    %esp,%ebp
    30a3:	57                   	push   %edi
    30a4:	56                   	push   %esi
    30a5:	53                   	push   %ebx
  l = w = c = 0;
    30a6:	31 db                	xor    %ebx,%ebx
{
    30a8:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
    30ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
    30b2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    30b9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    30c0:	83 ec 04             	sub    $0x4,%esp
    30c3:	68 00 02 00 00       	push   $0x200
    30c8:	68 00 3c 00 00       	push   $0x3c00
    30cd:	ff 75 08             	push   0x8(%ebp)
    30d0:	e8 16 03 00 00       	call   33eb <read>
    30d5:	83 c4 10             	add    $0x10,%esp
    30d8:	89 c6                	mov    %eax,%esi
    30da:	85 c0                	test   %eax,%eax
    30dc:	7e 62                	jle    3140 <wc+0xa0>
    for(i=0; i<n; i++){
    30de:	31 ff                	xor    %edi,%edi
    30e0:	eb 14                	jmp    30f6 <wc+0x56>
    30e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        inword = 0;
    30e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
    30ef:	83 c7 01             	add    $0x1,%edi
    30f2:	39 fe                	cmp    %edi,%esi
    30f4:	74 42                	je     3138 <wc+0x98>
      if(buf[i] == '\n')
    30f6:	0f be 87 00 3c 00 00 	movsbl 0x3c00(%edi),%eax
        l++;
    30fd:	31 c9                	xor    %ecx,%ecx
    30ff:	3c 0a                	cmp    $0xa,%al
    3101:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
    3104:	83 ec 08             	sub    $0x8,%esp
    3107:	50                   	push   %eax
        l++;
    3108:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
    310a:	68 68 38 00 00       	push   $0x3868
    310f:	e8 4c 01 00 00       	call   3260 <strchr>
    3114:	83 c4 10             	add    $0x10,%esp
    3117:	85 c0                	test   %eax,%eax
    3119:	75 cd                	jne    30e8 <wc+0x48>
      else if(!inword){
    311b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    311e:	85 d2                	test   %edx,%edx
    3120:	75 cd                	jne    30ef <wc+0x4f>
    for(i=0; i<n; i++){
    3122:	83 c7 01             	add    $0x1,%edi
        w++;
    3125:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
    3129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
    3130:	39 fe                	cmp    %edi,%esi
    3132:	75 c2                	jne    30f6 <wc+0x56>
    3134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      c++;
    3138:	01 75 dc             	add    %esi,-0x24(%ebp)
    313b:	eb 83                	jmp    30c0 <wc+0x20>
    313d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
    3140:	75 24                	jne    3166 <wc+0xc6>
  printf(1, "%d %d %d %s\n", l, w, c, name);
    3142:	83 ec 08             	sub    $0x8,%esp
    3145:	ff 75 0c             	push   0xc(%ebp)
    3148:	ff 75 dc             	push   -0x24(%ebp)
    314b:	ff 75 e0             	push   -0x20(%ebp)
    314e:	53                   	push   %ebx
    314f:	68 7e 38 00 00       	push   $0x387e
    3154:	6a 01                	push   $0x1
    3156:	e8 e5 03 00 00       	call   3540 <printf>
}
    315b:	83 c4 20             	add    $0x20,%esp
    315e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3161:	5b                   	pop    %ebx
    3162:	5e                   	pop    %esi
    3163:	5f                   	pop    %edi
    3164:	5d                   	pop    %ebp
    3165:	c3                   	ret    
    printf(1, "wc: read error\n");
    3166:	50                   	push   %eax
    3167:	50                   	push   %eax
    3168:	68 6e 38 00 00       	push   $0x386e
    316d:	6a 01                	push   $0x1
    316f:	e8 cc 03 00 00       	call   3540 <printf>
    exit();
    3174:	e8 5a 02 00 00       	call   33d3 <exit>
    3179:	66 90                	xchg   %ax,%ax
    317b:	66 90                	xchg   %ax,%ax
    317d:	66 90                	xchg   %ax,%ax
    317f:	90                   	nop

00003180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3181:	31 c0                	xor    %eax,%eax
{
    3183:	89 e5                	mov    %esp,%ebp
    3185:	53                   	push   %ebx
    3186:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    318c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3197:	83 c0 01             	add    $0x1,%eax
    319a:	84 d2                	test   %dl,%dl
    319c:	75 f2                	jne    3190 <strcpy+0x10>
    ;
  return os;
}
    319e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    31a1:	89 c8                	mov    %ecx,%eax
    31a3:	c9                   	leave  
    31a4:	c3                   	ret    
    31a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000031b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    31b0:	55                   	push   %ebp
    31b1:	89 e5                	mov    %esp,%ebp
    31b3:	53                   	push   %ebx
    31b4:	8b 55 08             	mov    0x8(%ebp),%edx
    31b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    31ba:	0f b6 02             	movzbl (%edx),%eax
    31bd:	84 c0                	test   %al,%al
    31bf:	75 17                	jne    31d8 <strcmp+0x28>
    31c1:	eb 3a                	jmp    31fd <strcmp+0x4d>
    31c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31c7:	90                   	nop
    31c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    31cc:	83 c2 01             	add    $0x1,%edx
    31cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    31d2:	84 c0                	test   %al,%al
    31d4:	74 1a                	je     31f0 <strcmp+0x40>
    p++, q++;
    31d6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    31d8:	0f b6 19             	movzbl (%ecx),%ebx
    31db:	38 c3                	cmp    %al,%bl
    31dd:	74 e9                	je     31c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    31df:	29 d8                	sub    %ebx,%eax
}
    31e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    31e4:	c9                   	leave  
    31e5:	c3                   	ret    
    31e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31ed:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    31f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    31f4:	31 c0                	xor    %eax,%eax
    31f6:	29 d8                	sub    %ebx,%eax
}
    31f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    31fb:	c9                   	leave  
    31fc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    31fd:	0f b6 19             	movzbl (%ecx),%ebx
    3200:	31 c0                	xor    %eax,%eax
    3202:	eb db                	jmp    31df <strcmp+0x2f>
    3204:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    320f:	90                   	nop

00003210 <strlen>:

uint
strlen(const char *s)
{
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3216:	80 3a 00             	cmpb   $0x0,(%edx)
    3219:	74 15                	je     3230 <strlen+0x20>
    321b:	31 c0                	xor    %eax,%eax
    321d:	8d 76 00             	lea    0x0(%esi),%esi
    3220:	83 c0 01             	add    $0x1,%eax
    3223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3227:	89 c1                	mov    %eax,%ecx
    3229:	75 f5                	jne    3220 <strlen+0x10>
    ;
  return n;
}
    322b:	89 c8                	mov    %ecx,%eax
    322d:	5d                   	pop    %ebp
    322e:	c3                   	ret    
    322f:	90                   	nop
  for(n = 0; s[n]; n++)
    3230:	31 c9                	xor    %ecx,%ecx
}
    3232:	5d                   	pop    %ebp
    3233:	89 c8                	mov    %ecx,%eax
    3235:	c3                   	ret    
    3236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    323d:	8d 76 00             	lea    0x0(%esi),%esi

00003240 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3240:	55                   	push   %ebp
    3241:	89 e5                	mov    %esp,%ebp
    3243:	57                   	push   %edi
    3244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3247:	8b 4d 10             	mov    0x10(%ebp),%ecx
    324a:	8b 45 0c             	mov    0xc(%ebp),%eax
    324d:	89 d7                	mov    %edx,%edi
    324f:	fc                   	cld    
    3250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3252:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3255:	89 d0                	mov    %edx,%eax
    3257:	c9                   	leave  
    3258:	c3                   	ret    
    3259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003260 <strchr>:

char*
strchr(const char *s, char c)
{
    3260:	55                   	push   %ebp
    3261:	89 e5                	mov    %esp,%ebp
    3263:	8b 45 08             	mov    0x8(%ebp),%eax
    3266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    326a:	0f b6 10             	movzbl (%eax),%edx
    326d:	84 d2                	test   %dl,%dl
    326f:	75 12                	jne    3283 <strchr+0x23>
    3271:	eb 1d                	jmp    3290 <strchr+0x30>
    3273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3277:	90                   	nop
    3278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    327c:	83 c0 01             	add    $0x1,%eax
    327f:	84 d2                	test   %dl,%dl
    3281:	74 0d                	je     3290 <strchr+0x30>
    if(*s == c)
    3283:	38 d1                	cmp    %dl,%cl
    3285:	75 f1                	jne    3278 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3287:	5d                   	pop    %ebp
    3288:	c3                   	ret    
    3289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3290:	31 c0                	xor    %eax,%eax
}
    3292:	5d                   	pop    %ebp
    3293:	c3                   	ret    
    3294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    329f:	90                   	nop

000032a0 <gets>:

char*
gets(char *buf, int max)
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	57                   	push   %edi
    32a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    32a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    32a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    32a9:	31 db                	xor    %ebx,%ebx
{
    32ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    32ae:	eb 27                	jmp    32d7 <gets+0x37>
    cc = read(0, &c, 1);
    32b0:	83 ec 04             	sub    $0x4,%esp
    32b3:	6a 01                	push   $0x1
    32b5:	57                   	push   %edi
    32b6:	6a 00                	push   $0x0
    32b8:	e8 2e 01 00 00       	call   33eb <read>
    if(cc < 1)
    32bd:	83 c4 10             	add    $0x10,%esp
    32c0:	85 c0                	test   %eax,%eax
    32c2:	7e 1d                	jle    32e1 <gets+0x41>
      break;
    buf[i++] = c;
    32c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    32c8:	8b 55 08             	mov    0x8(%ebp),%edx
    32cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    32cf:	3c 0a                	cmp    $0xa,%al
    32d1:	74 1d                	je     32f0 <gets+0x50>
    32d3:	3c 0d                	cmp    $0xd,%al
    32d5:	74 19                	je     32f0 <gets+0x50>
  for(i=0; i+1 < max; ){
    32d7:	89 de                	mov    %ebx,%esi
    32d9:	83 c3 01             	add    $0x1,%ebx
    32dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    32df:	7c cf                	jl     32b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    32e1:	8b 45 08             	mov    0x8(%ebp),%eax
    32e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    32e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    32eb:	5b                   	pop    %ebx
    32ec:	5e                   	pop    %esi
    32ed:	5f                   	pop    %edi
    32ee:	5d                   	pop    %ebp
    32ef:	c3                   	ret    
  buf[i] = '\0';
    32f0:	8b 45 08             	mov    0x8(%ebp),%eax
    32f3:	89 de                	mov    %ebx,%esi
    32f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    32f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    32fc:	5b                   	pop    %ebx
    32fd:	5e                   	pop    %esi
    32fe:	5f                   	pop    %edi
    32ff:	5d                   	pop    %ebp
    3300:	c3                   	ret    
    3301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    330f:	90                   	nop

00003310 <stat>:

int
stat(const char *n, struct stat *st)
{
    3310:	55                   	push   %ebp
    3311:	89 e5                	mov    %esp,%ebp
    3313:	56                   	push   %esi
    3314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3315:	83 ec 08             	sub    $0x8,%esp
    3318:	6a 00                	push   $0x0
    331a:	ff 75 08             	push   0x8(%ebp)
    331d:	e8 f1 00 00 00       	call   3413 <open>
  if(fd < 0)
    3322:	83 c4 10             	add    $0x10,%esp
    3325:	85 c0                	test   %eax,%eax
    3327:	78 27                	js     3350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3329:	83 ec 08             	sub    $0x8,%esp
    332c:	ff 75 0c             	push   0xc(%ebp)
    332f:	89 c3                	mov    %eax,%ebx
    3331:	50                   	push   %eax
    3332:	e8 f4 00 00 00       	call   342b <fstat>
  close(fd);
    3337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    333a:	89 c6                	mov    %eax,%esi
  close(fd);
    333c:	e8 ba 00 00 00       	call   33fb <close>
  return r;
    3341:	83 c4 10             	add    $0x10,%esp
}
    3344:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3347:	89 f0                	mov    %esi,%eax
    3349:	5b                   	pop    %ebx
    334a:	5e                   	pop    %esi
    334b:	5d                   	pop    %ebp
    334c:	c3                   	ret    
    334d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3350:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3355:	eb ed                	jmp    3344 <stat+0x34>
    3357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    335e:	66 90                	xchg   %ax,%ax

00003360 <atoi>:

int
atoi(const char *s)
{
    3360:	55                   	push   %ebp
    3361:	89 e5                	mov    %esp,%ebp
    3363:	53                   	push   %ebx
    3364:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3367:	0f be 02             	movsbl (%edx),%eax
    336a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    336d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3370:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3375:	77 1e                	ja     3395 <atoi+0x35>
    3377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    337e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3380:	83 c2 01             	add    $0x1,%edx
    3383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    338a:	0f be 02             	movsbl (%edx),%eax
    338d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3390:	80 fb 09             	cmp    $0x9,%bl
    3393:	76 eb                	jbe    3380 <atoi+0x20>
  return n;
}
    3395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3398:	89 c8                	mov    %ecx,%eax
    339a:	c9                   	leave  
    339b:	c3                   	ret    
    339c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000033a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    33a0:	55                   	push   %ebp
    33a1:	89 e5                	mov    %esp,%ebp
    33a3:	57                   	push   %edi
    33a4:	8b 45 10             	mov    0x10(%ebp),%eax
    33a7:	8b 55 08             	mov    0x8(%ebp),%edx
    33aa:	56                   	push   %esi
    33ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    33ae:	85 c0                	test   %eax,%eax
    33b0:	7e 13                	jle    33c5 <memmove+0x25>
    33b2:	01 d0                	add    %edx,%eax
  dst = vdst;
    33b4:	89 d7                	mov    %edx,%edi
    33b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    33c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    33c1:	39 f8                	cmp    %edi,%eax
    33c3:	75 fb                	jne    33c0 <memmove+0x20>
  return vdst;
}
    33c5:	5e                   	pop    %esi
    33c6:	89 d0                	mov    %edx,%eax
    33c8:	5f                   	pop    %edi
    33c9:	5d                   	pop    %ebp
    33ca:	c3                   	ret    

000033cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    33cb:	b8 01 00 00 00       	mov    $0x1,%eax
    33d0:	cd 40                	int    $0x40
    33d2:	c3                   	ret    

000033d3 <exit>:
SYSCALL(exit)
    33d3:	b8 02 00 00 00       	mov    $0x2,%eax
    33d8:	cd 40                	int    $0x40
    33da:	c3                   	ret    

000033db <wait>:
SYSCALL(wait)
    33db:	b8 03 00 00 00       	mov    $0x3,%eax
    33e0:	cd 40                	int    $0x40
    33e2:	c3                   	ret    

000033e3 <pipe>:
SYSCALL(pipe)
    33e3:	b8 04 00 00 00       	mov    $0x4,%eax
    33e8:	cd 40                	int    $0x40
    33ea:	c3                   	ret    

000033eb <read>:
SYSCALL(read)
    33eb:	b8 05 00 00 00       	mov    $0x5,%eax
    33f0:	cd 40                	int    $0x40
    33f2:	c3                   	ret    

000033f3 <write>:
SYSCALL(write)
    33f3:	b8 10 00 00 00       	mov    $0x10,%eax
    33f8:	cd 40                	int    $0x40
    33fa:	c3                   	ret    

000033fb <close>:
SYSCALL(close)
    33fb:	b8 15 00 00 00       	mov    $0x15,%eax
    3400:	cd 40                	int    $0x40
    3402:	c3                   	ret    

00003403 <kill>:
SYSCALL(kill)
    3403:	b8 06 00 00 00       	mov    $0x6,%eax
    3408:	cd 40                	int    $0x40
    340a:	c3                   	ret    

0000340b <exec>:
SYSCALL(exec)
    340b:	b8 07 00 00 00       	mov    $0x7,%eax
    3410:	cd 40                	int    $0x40
    3412:	c3                   	ret    

00003413 <open>:
SYSCALL(open)
    3413:	b8 0f 00 00 00       	mov    $0xf,%eax
    3418:	cd 40                	int    $0x40
    341a:	c3                   	ret    

0000341b <mknod>:
SYSCALL(mknod)
    341b:	b8 11 00 00 00       	mov    $0x11,%eax
    3420:	cd 40                	int    $0x40
    3422:	c3                   	ret    

00003423 <unlink>:
SYSCALL(unlink)
    3423:	b8 12 00 00 00       	mov    $0x12,%eax
    3428:	cd 40                	int    $0x40
    342a:	c3                   	ret    

0000342b <fstat>:
SYSCALL(fstat)
    342b:	b8 08 00 00 00       	mov    $0x8,%eax
    3430:	cd 40                	int    $0x40
    3432:	c3                   	ret    

00003433 <link>:
SYSCALL(link)
    3433:	b8 13 00 00 00       	mov    $0x13,%eax
    3438:	cd 40                	int    $0x40
    343a:	c3                   	ret    

0000343b <mkdir>:
SYSCALL(mkdir)
    343b:	b8 14 00 00 00       	mov    $0x14,%eax
    3440:	cd 40                	int    $0x40
    3442:	c3                   	ret    

00003443 <chdir>:
SYSCALL(chdir)
    3443:	b8 09 00 00 00       	mov    $0x9,%eax
    3448:	cd 40                	int    $0x40
    344a:	c3                   	ret    

0000344b <dup>:
SYSCALL(dup)
    344b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3450:	cd 40                	int    $0x40
    3452:	c3                   	ret    

00003453 <getpid>:
SYSCALL(getpid)
    3453:	b8 0b 00 00 00       	mov    $0xb,%eax
    3458:	cd 40                	int    $0x40
    345a:	c3                   	ret    

0000345b <sbrk>:
SYSCALL(sbrk)
    345b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3460:	cd 40                	int    $0x40
    3462:	c3                   	ret    

00003463 <sleep>:
SYSCALL(sleep)
    3463:	b8 0d 00 00 00       	mov    $0xd,%eax
    3468:	cd 40                	int    $0x40
    346a:	c3                   	ret    

0000346b <uptime>:
SYSCALL(uptime)
    346b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3470:	cd 40                	int    $0x40
    3472:	c3                   	ret    

00003473 <uniq>:
SYSCALL(uniq)
    3473:	b8 16 00 00 00       	mov    $0x16,%eax
    3478:	cd 40                	int    $0x40
    347a:	c3                   	ret    

0000347b <head>:
SYSCALL(head)
    347b:	b8 17 00 00 00       	mov    $0x17,%eax
    3480:	cd 40                	int    $0x40
    3482:	c3                   	ret    

00003483 <ps>:
    3483:	b8 18 00 00 00       	mov    $0x18,%eax
    3488:	cd 40                	int    $0x40
    348a:	c3                   	ret    
    348b:	66 90                	xchg   %ax,%ax
    348d:	66 90                	xchg   %ax,%ax
    348f:	90                   	nop

00003490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3490:	55                   	push   %ebp
    3491:	89 e5                	mov    %esp,%ebp
    3493:	57                   	push   %edi
    3494:	56                   	push   %esi
    3495:	53                   	push   %ebx
    3496:	83 ec 3c             	sub    $0x3c,%esp
    3499:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    349c:	89 d1                	mov    %edx,%ecx
{
    349e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    34a1:	85 d2                	test   %edx,%edx
    34a3:	0f 89 7f 00 00 00    	jns    3528 <printint+0x98>
    34a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    34ad:	74 79                	je     3528 <printint+0x98>
    neg = 1;
    34af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    34b6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    34b8:	31 db                	xor    %ebx,%ebx
    34ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
    34bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    34c0:	89 c8                	mov    %ecx,%eax
    34c2:	31 d2                	xor    %edx,%edx
    34c4:	89 cf                	mov    %ecx,%edi
    34c6:	f7 75 c4             	divl   -0x3c(%ebp)
    34c9:	0f b6 92 00 39 00 00 	movzbl 0x3900(%edx),%edx
    34d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    34d3:	89 d8                	mov    %ebx,%eax
    34d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    34d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    34db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    34de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    34e1:	76 dd                	jbe    34c0 <printint+0x30>
  if(neg)
    34e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    34e6:	85 c9                	test   %ecx,%ecx
    34e8:	74 0c                	je     34f6 <printint+0x66>
    buf[i++] = '-';
    34ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    34ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    34f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    34f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    34f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    34fd:	eb 07                	jmp    3506 <printint+0x76>
    34ff:	90                   	nop
    putc(fd, buf[i]);
    3500:	0f b6 13             	movzbl (%ebx),%edx
    3503:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3506:	83 ec 04             	sub    $0x4,%esp
    3509:	88 55 d7             	mov    %dl,-0x29(%ebp)
    350c:	6a 01                	push   $0x1
    350e:	56                   	push   %esi
    350f:	57                   	push   %edi
    3510:	e8 de fe ff ff       	call   33f3 <write>
  while(--i >= 0)
    3515:	83 c4 10             	add    $0x10,%esp
    3518:	39 de                	cmp    %ebx,%esi
    351a:	75 e4                	jne    3500 <printint+0x70>
}
    351c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    351f:	5b                   	pop    %ebx
    3520:	5e                   	pop    %esi
    3521:	5f                   	pop    %edi
    3522:	5d                   	pop    %ebp
    3523:	c3                   	ret    
    3524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3528:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    352f:	eb 87                	jmp    34b8 <printint+0x28>
    3531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    353f:	90                   	nop

00003540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3540:	55                   	push   %ebp
    3541:	89 e5                	mov    %esp,%ebp
    3543:	57                   	push   %edi
    3544:	56                   	push   %esi
    3545:	53                   	push   %ebx
    3546:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3549:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    354c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    354f:	0f b6 13             	movzbl (%ebx),%edx
    3552:	84 d2                	test   %dl,%dl
    3554:	74 6a                	je     35c0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3556:	8d 45 10             	lea    0x10(%ebp),%eax
    3559:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    355c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    355f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3561:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3564:	eb 36                	jmp    359c <printf+0x5c>
    3566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    356d:	8d 76 00             	lea    0x0(%esi),%esi
    3570:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3573:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3578:	83 f8 25             	cmp    $0x25,%eax
    357b:	74 15                	je     3592 <printf+0x52>
  write(fd, &c, 1);
    357d:	83 ec 04             	sub    $0x4,%esp
    3580:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3583:	6a 01                	push   $0x1
    3585:	57                   	push   %edi
    3586:	56                   	push   %esi
    3587:	e8 67 fe ff ff       	call   33f3 <write>
    358c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    358f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3592:	0f b6 13             	movzbl (%ebx),%edx
    3595:	83 c3 01             	add    $0x1,%ebx
    3598:	84 d2                	test   %dl,%dl
    359a:	74 24                	je     35c0 <printf+0x80>
    c = fmt[i] & 0xff;
    359c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    359f:	85 c9                	test   %ecx,%ecx
    35a1:	74 cd                	je     3570 <printf+0x30>
      }
    } else if(state == '%'){
    35a3:	83 f9 25             	cmp    $0x25,%ecx
    35a6:	75 ea                	jne    3592 <printf+0x52>
      if(c == 'd'){
    35a8:	83 f8 25             	cmp    $0x25,%eax
    35ab:	0f 84 07 01 00 00    	je     36b8 <printf+0x178>
    35b1:	83 e8 63             	sub    $0x63,%eax
    35b4:	83 f8 15             	cmp    $0x15,%eax
    35b7:	77 17                	ja     35d0 <printf+0x90>
    35b9:	ff 24 85 a8 38 00 00 	jmp    *0x38a8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    35c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    35c3:	5b                   	pop    %ebx
    35c4:	5e                   	pop    %esi
    35c5:	5f                   	pop    %edi
    35c6:	5d                   	pop    %ebp
    35c7:	c3                   	ret    
    35c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35cf:	90                   	nop
  write(fd, &c, 1);
    35d0:	83 ec 04             	sub    $0x4,%esp
    35d3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    35d6:	6a 01                	push   $0x1
    35d8:	57                   	push   %edi
    35d9:	56                   	push   %esi
    35da:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    35de:	e8 10 fe ff ff       	call   33f3 <write>
        putc(fd, c);
    35e3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    35e7:	83 c4 0c             	add    $0xc,%esp
    35ea:	88 55 e7             	mov    %dl,-0x19(%ebp)
    35ed:	6a 01                	push   $0x1
    35ef:	57                   	push   %edi
    35f0:	56                   	push   %esi
    35f1:	e8 fd fd ff ff       	call   33f3 <write>
        putc(fd, c);
    35f6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    35f9:	31 c9                	xor    %ecx,%ecx
    35fb:	eb 95                	jmp    3592 <printf+0x52>
    35fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3600:	83 ec 0c             	sub    $0xc,%esp
    3603:	b9 10 00 00 00       	mov    $0x10,%ecx
    3608:	6a 00                	push   $0x0
    360a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    360d:	8b 10                	mov    (%eax),%edx
    360f:	89 f0                	mov    %esi,%eax
    3611:	e8 7a fe ff ff       	call   3490 <printint>
        ap++;
    3616:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    361a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    361d:	31 c9                	xor    %ecx,%ecx
    361f:	e9 6e ff ff ff       	jmp    3592 <printf+0x52>
    3624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3628:	8b 45 d0             	mov    -0x30(%ebp),%eax
    362b:	8b 10                	mov    (%eax),%edx
        ap++;
    362d:	83 c0 04             	add    $0x4,%eax
    3630:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3633:	85 d2                	test   %edx,%edx
    3635:	0f 84 8d 00 00 00    	je     36c8 <printf+0x188>
        while(*s != 0){
    363b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    363e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3640:	84 c0                	test   %al,%al
    3642:	0f 84 4a ff ff ff    	je     3592 <printf+0x52>
    3648:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    364b:	89 d3                	mov    %edx,%ebx
    364d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3650:	83 ec 04             	sub    $0x4,%esp
          s++;
    3653:	83 c3 01             	add    $0x1,%ebx
    3656:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3659:	6a 01                	push   $0x1
    365b:	57                   	push   %edi
    365c:	56                   	push   %esi
    365d:	e8 91 fd ff ff       	call   33f3 <write>
        while(*s != 0){
    3662:	0f b6 03             	movzbl (%ebx),%eax
    3665:	83 c4 10             	add    $0x10,%esp
    3668:	84 c0                	test   %al,%al
    366a:	75 e4                	jne    3650 <printf+0x110>
      state = 0;
    366c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    366f:	31 c9                	xor    %ecx,%ecx
    3671:	e9 1c ff ff ff       	jmp    3592 <printf+0x52>
    3676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    367d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3680:	83 ec 0c             	sub    $0xc,%esp
    3683:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3688:	6a 01                	push   $0x1
    368a:	e9 7b ff ff ff       	jmp    360a <printf+0xca>
    368f:	90                   	nop
        putc(fd, *ap);
    3690:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3693:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3696:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3698:	6a 01                	push   $0x1
    369a:	57                   	push   %edi
    369b:	56                   	push   %esi
        putc(fd, *ap);
    369c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    369f:	e8 4f fd ff ff       	call   33f3 <write>
        ap++;
    36a4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    36a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    36ab:	31 c9                	xor    %ecx,%ecx
    36ad:	e9 e0 fe ff ff       	jmp    3592 <printf+0x52>
    36b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    36b8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    36bb:	83 ec 04             	sub    $0x4,%esp
    36be:	e9 2a ff ff ff       	jmp    35ed <printf+0xad>
    36c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36c7:	90                   	nop
          s = "(null)";
    36c8:	ba 9f 38 00 00       	mov    $0x389f,%edx
        while(*s != 0){
    36cd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    36d0:	b8 28 00 00 00       	mov    $0x28,%eax
    36d5:	89 d3                	mov    %edx,%ebx
    36d7:	e9 74 ff ff ff       	jmp    3650 <printf+0x110>
    36dc:	66 90                	xchg   %ax,%ax
    36de:	66 90                	xchg   %ax,%ax

000036e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    36e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    36e1:	a1 00 3e 00 00       	mov    0x3e00,%eax
{
    36e6:	89 e5                	mov    %esp,%ebp
    36e8:	57                   	push   %edi
    36e9:	56                   	push   %esi
    36ea:	53                   	push   %ebx
    36eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    36ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    36f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36f8:	89 c2                	mov    %eax,%edx
    36fa:	8b 00                	mov    (%eax),%eax
    36fc:	39 ca                	cmp    %ecx,%edx
    36fe:	73 30                	jae    3730 <free+0x50>
    3700:	39 c1                	cmp    %eax,%ecx
    3702:	72 04                	jb     3708 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3704:	39 c2                	cmp    %eax,%edx
    3706:	72 f0                	jb     36f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3708:	8b 73 fc             	mov    -0x4(%ebx),%esi
    370b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    370e:	39 f8                	cmp    %edi,%eax
    3710:	74 30                	je     3742 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3712:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3715:	8b 42 04             	mov    0x4(%edx),%eax
    3718:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    371b:	39 f1                	cmp    %esi,%ecx
    371d:	74 3a                	je     3759 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    371f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3721:	5b                   	pop    %ebx
  freep = p;
    3722:	89 15 00 3e 00 00    	mov    %edx,0x3e00
}
    3728:	5e                   	pop    %esi
    3729:	5f                   	pop    %edi
    372a:	5d                   	pop    %ebp
    372b:	c3                   	ret    
    372c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3730:	39 c2                	cmp    %eax,%edx
    3732:	72 c4                	jb     36f8 <free+0x18>
    3734:	39 c1                	cmp    %eax,%ecx
    3736:	73 c0                	jae    36f8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3738:	8b 73 fc             	mov    -0x4(%ebx),%esi
    373b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    373e:	39 f8                	cmp    %edi,%eax
    3740:	75 d0                	jne    3712 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3742:	03 70 04             	add    0x4(%eax),%esi
    3745:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3748:	8b 02                	mov    (%edx),%eax
    374a:	8b 00                	mov    (%eax),%eax
    374c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    374f:	8b 42 04             	mov    0x4(%edx),%eax
    3752:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3755:	39 f1                	cmp    %esi,%ecx
    3757:	75 c6                	jne    371f <free+0x3f>
    p->s.size += bp->s.size;
    3759:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    375c:	89 15 00 3e 00 00    	mov    %edx,0x3e00
    p->s.size += bp->s.size;
    3762:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3765:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3768:	89 0a                	mov    %ecx,(%edx)
}
    376a:	5b                   	pop    %ebx
    376b:	5e                   	pop    %esi
    376c:	5f                   	pop    %edi
    376d:	5d                   	pop    %ebp
    376e:	c3                   	ret    
    376f:	90                   	nop

00003770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3770:	55                   	push   %ebp
    3771:	89 e5                	mov    %esp,%ebp
    3773:	57                   	push   %edi
    3774:	56                   	push   %esi
    3775:	53                   	push   %ebx
    3776:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    377c:	8b 3d 00 3e 00 00    	mov    0x3e00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3782:	8d 70 07             	lea    0x7(%eax),%esi
    3785:	c1 ee 03             	shr    $0x3,%esi
    3788:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    378b:	85 ff                	test   %edi,%edi
    378d:	0f 84 9d 00 00 00    	je     3830 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3793:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3795:	8b 4a 04             	mov    0x4(%edx),%ecx
    3798:	39 f1                	cmp    %esi,%ecx
    379a:	73 6a                	jae    3806 <malloc+0x96>
    379c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    37a1:	39 de                	cmp    %ebx,%esi
    37a3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    37a6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    37ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    37b0:	eb 17                	jmp    37c9 <malloc+0x59>
    37b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    37ba:	8b 48 04             	mov    0x4(%eax),%ecx
    37bd:	39 f1                	cmp    %esi,%ecx
    37bf:	73 4f                	jae    3810 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    37c1:	8b 3d 00 3e 00 00    	mov    0x3e00,%edi
    37c7:	89 c2                	mov    %eax,%edx
    37c9:	39 d7                	cmp    %edx,%edi
    37cb:	75 eb                	jne    37b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    37cd:	83 ec 0c             	sub    $0xc,%esp
    37d0:	ff 75 e4             	push   -0x1c(%ebp)
    37d3:	e8 83 fc ff ff       	call   345b <sbrk>
  if(p == (char*)-1)
    37d8:	83 c4 10             	add    $0x10,%esp
    37db:	83 f8 ff             	cmp    $0xffffffff,%eax
    37de:	74 1c                	je     37fc <malloc+0x8c>
  hp->s.size = nu;
    37e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    37e3:	83 ec 0c             	sub    $0xc,%esp
    37e6:	83 c0 08             	add    $0x8,%eax
    37e9:	50                   	push   %eax
    37ea:	e8 f1 fe ff ff       	call   36e0 <free>
  return freep;
    37ef:	8b 15 00 3e 00 00    	mov    0x3e00,%edx
      if((p = morecore(nunits)) == 0)
    37f5:	83 c4 10             	add    $0x10,%esp
    37f8:	85 d2                	test   %edx,%edx
    37fa:	75 bc                	jne    37b8 <malloc+0x48>
        return 0;
  }
}
    37fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    37ff:	31 c0                	xor    %eax,%eax
}
    3801:	5b                   	pop    %ebx
    3802:	5e                   	pop    %esi
    3803:	5f                   	pop    %edi
    3804:	5d                   	pop    %ebp
    3805:	c3                   	ret    
    if(p->s.size >= nunits){
    3806:	89 d0                	mov    %edx,%eax
    3808:	89 fa                	mov    %edi,%edx
    380a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3810:	39 ce                	cmp    %ecx,%esi
    3812:	74 4c                	je     3860 <malloc+0xf0>
        p->s.size -= nunits;
    3814:	29 f1                	sub    %esi,%ecx
    3816:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3819:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    381c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    381f:	89 15 00 3e 00 00    	mov    %edx,0x3e00
}
    3825:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3828:	83 c0 08             	add    $0x8,%eax
}
    382b:	5b                   	pop    %ebx
    382c:	5e                   	pop    %esi
    382d:	5f                   	pop    %edi
    382e:	5d                   	pop    %ebp
    382f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3830:	c7 05 00 3e 00 00 04 	movl   $0x3e04,0x3e00
    3837:	3e 00 00 
    base.s.size = 0;
    383a:	bf 04 3e 00 00       	mov    $0x3e04,%edi
    base.s.ptr = freep = prevp = &base;
    383f:	c7 05 04 3e 00 00 04 	movl   $0x3e04,0x3e04
    3846:	3e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3849:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    384b:	c7 05 08 3e 00 00 00 	movl   $0x0,0x3e08
    3852:	00 00 00 
    if(p->s.size >= nunits){
    3855:	e9 42 ff ff ff       	jmp    379c <malloc+0x2c>
    385a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3860:	8b 08                	mov    (%eax),%ecx
    3862:	89 0a                	mov    %ecx,(%edx)
    3864:	eb b9                	jmp    381f <malloc+0xaf>
