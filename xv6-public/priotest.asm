
_priotest:     file format elf32-i386


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
    3011:	83 ec 28             	sub    $0x28,%esp
    3014:	8b 31                	mov    (%ecx),%esi
    3016:	8b 59 04             	mov    0x4(%ecx),%ebx
    // }
    // else
    // continue;
    // }
    // }
    int priorities[argc];
    3019:	89 e1                	mov    %esp,%ecx
    301b:	8d 46 ff             	lea    -0x1(%esi),%eax
    301e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3021:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
    3028:	89 45 cc             	mov    %eax,-0x34(%ebp)
    302b:	83 c0 0f             	add    $0xf,%eax
    302e:	89 c2                	mov    %eax,%edx
    3030:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    3035:	29 c1                	sub    %eax,%ecx
    3037:	83 e2 f0             	and    $0xfffffff0,%edx
    303a:	39 cc                	cmp    %ecx,%esp
    303c:	74 12                	je     3050 <main+0x50>
    303e:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3044:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    304b:	00 
    304c:	39 cc                	cmp    %ecx,%esp
    304e:	75 ee                	jne    303e <main+0x3e>
    3050:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    3056:	29 d4                	sub    %edx,%esp
    3058:	85 d2                	test   %edx,%edx
    305a:	0f 85 2f 02 00 00    	jne    328f <main+0x28f>
    3060:	89 e0                	mov    %esp,%eax
    memset(priorities, 0, argc);
    3062:	52                   	push   %edx
    3063:	56                   	push   %esi
    3064:	6a 00                	push   $0x0
    3066:	50                   	push   %eax
    int priorities[argc];
    3067:	89 45 d0             	mov    %eax,-0x30(%ebp)
    memset(priorities, 0, argc);
    306a:	e8 f1 02 00 00       	call   3360 <memset>

    for (int i = 0; i < argc; i++)
    306f:	83 c4 10             	add    $0x10,%esp
    3072:	85 f6                	test   %esi,%esi
    3074:	7e 25                	jle    309b <main+0x9b>
    3076:	31 ff                	xor    %edi,%edi
    3078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    307f:	90                   	nop
    {
        priorities[i] = atoi(argv[i]);
    3080:	83 ec 0c             	sub    $0xc,%esp
    3083:	ff 34 bb             	push   (%ebx,%edi,4)
    3086:	e8 f5 03 00 00       	call   3480 <atoi>
    308b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    for (int i = 0; i < argc; i++)
    308e:	83 c4 10             	add    $0x10,%esp
        priorities[i] = atoi(argv[i]);
    3091:	89 04 b9             	mov    %eax,(%ecx,%edi,4)
    for (int i = 0; i < argc; i++)
    3094:	83 c7 01             	add    $0x1,%edi
    3097:	39 fe                	cmp    %edi,%esi
    3099:	75 e5                	jne    3080 <main+0x80>
    }
    for (int i = 1; i < argc - 1; i++)
    309b:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    309f:	0f 8e be 00 00 00    	jle    3163 <main+0x163>
    30a5:	8b 45 d0             	mov    -0x30(%ebp),%eax
    30a8:	bf 01 00 00 00       	mov    $0x1,%edi
    30ad:	89 75 c8             	mov    %esi,-0x38(%ebp)
    30b0:	89 fe                	mov    %edi,%esi
    30b2:	8d 48 04             	lea    0x4(%eax),%ecx
    30b5:	89 cf                	mov    %ecx,%edi
    30b7:	eb 15                	jmp    30ce <main+0xce>
    30b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    {
        if (priorities[i + 1] != 0)
            priorities[i] = priorities[i + 1];
    30c0:	89 07                	mov    %eax,(%edi)
    for (int i = 1; i < argc - 1; i++)
    30c2:	83 c7 04             	add    $0x4,%edi
    30c5:	39 75 d4             	cmp    %esi,-0x2c(%ebp)
    30c8:	0f 84 92 00 00 00    	je     3160 <main+0x160>
        if (priorities[i + 1] != 0)
    30ce:	8b 47 04             	mov    0x4(%edi),%eax
    30d1:	83 c6 01             	add    $0x1,%esi
    30d4:	85 c0                	test   %eax,%eax
    30d6:	75 e8                	jne    30c0 <main+0xc0>
        else
        {
            if (strcmp(argv[i], "uniq_ker") == 0)
    30d8:	83 ec 08             	sub    $0x8,%esp
    30db:	68 88 39 00 00       	push   $0x3988
    30e0:	ff 74 b3 fc          	push   -0x4(%ebx,%esi,4)
    30e4:	e8 e7 01 00 00       	call   32d0 <strcmp>
    30e9:	83 c4 10             	add    $0x10,%esp
    30ec:	85 c0                	test   %eax,%eax
    30ee:	75 06                	jne    30f6 <main+0xf6>
                priorities[i] = 9;
    30f0:	c7 07 09 00 00 00    	movl   $0x9,(%edi)
            if (strcmp(argv[i], "head_ker") == 0)
    30f6:	83 ec 08             	sub    $0x8,%esp
    30f9:	68 91 39 00 00       	push   $0x3991
    30fe:	ff 74 b3 fc          	push   -0x4(%ebx,%esi,4)
    3102:	e8 c9 01 00 00       	call   32d0 <strcmp>
    3107:	83 c4 10             	add    $0x10,%esp
    310a:	85 c0                	test   %eax,%eax
    310c:	75 06                	jne    3114 <main+0x114>
                priorities[i] = 9;
    310e:	c7 07 09 00 00 00    	movl   $0x9,(%edi)
            if (strcmp(argv[i], "head") == 0)
    3114:	83 ec 08             	sub    $0x8,%esp
    3117:	68 9a 39 00 00       	push   $0x399a
    311c:	ff 74 b3 fc          	push   -0x4(%ebx,%esi,4)
    3120:	e8 ab 01 00 00       	call   32d0 <strcmp>
    3125:	83 c4 10             	add    $0x10,%esp
    3128:	85 c0                	test   %eax,%eax
    312a:	75 06                	jne    3132 <main+0x132>
                priorities[i] = 10;
    312c:	c7 07 0a 00 00 00    	movl   $0xa,(%edi)
            if (strcmp(argv[i], "uniq") == 0)
    3132:	83 ec 08             	sub    $0x8,%esp
    3135:	68 9f 39 00 00       	push   $0x399f
    313a:	ff 74 b3 fc          	push   -0x4(%ebx,%esi,4)
    313e:	e8 8d 01 00 00       	call   32d0 <strcmp>
    3143:	83 c4 10             	add    $0x10,%esp
    3146:	85 c0                	test   %eax,%eax
    3148:	0f 85 74 ff ff ff    	jne    30c2 <main+0xc2>
                priorities[i] = 10;
    314e:	c7 07 0a 00 00 00    	movl   $0xa,(%edi)
    for (int i = 1; i < argc - 1; i++)
    3154:	83 c7 04             	add    $0x4,%edi
    3157:	39 75 d4             	cmp    %esi,-0x2c(%ebp)
    315a:	0f 85 6e ff ff ff    	jne    30ce <main+0xce>
    3160:	8b 75 c8             	mov    -0x38(%ebp),%esi
        }
    }
    if (strcmp(argv[argc - 1], "uniq_ker") == 0)
    3163:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3166:	83 ec 08             	sub    $0x8,%esp
    3169:	68 88 39 00 00       	push   $0x3988
    316e:	8d 7c 03 fc          	lea    -0x4(%ebx,%eax,1),%edi
    3172:	ff 37                	push   (%edi)
    3174:	e8 57 01 00 00       	call   32d0 <strcmp>
    3179:	83 c4 10             	add    $0x10,%esp
    317c:	85 c0                	test   %eax,%eax
    317e:	75 0d                	jne    318d <main+0x18d>
        priorities[argc - 1] = 9;
    3180:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3183:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    3186:	c7 04 88 09 00 00 00 	movl   $0x9,(%eax,%ecx,4)
    if (strcmp(argv[argc - 1], "head_ker") == 0)
    318d:	83 ec 08             	sub    $0x8,%esp
    3190:	68 91 39 00 00       	push   $0x3991
    3195:	ff 37                	push   (%edi)
    3197:	e8 34 01 00 00       	call   32d0 <strcmp>
    319c:	83 c4 10             	add    $0x10,%esp
    319f:	85 c0                	test   %eax,%eax
    31a1:	75 0d                	jne    31b0 <main+0x1b0>
        priorities[argc - 1] = 9;
    31a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
    31a6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    31a9:	c7 04 88 09 00 00 00 	movl   $0x9,(%eax,%ecx,4)
    if (strcmp(argv[argc - 1], "head") == 0)
    31b0:	83 ec 08             	sub    $0x8,%esp
    31b3:	68 9a 39 00 00       	push   $0x399a
    31b8:	ff 37                	push   (%edi)
    31ba:	e8 11 01 00 00       	call   32d0 <strcmp>
    31bf:	83 c4 10             	add    $0x10,%esp
    31c2:	85 c0                	test   %eax,%eax
    31c4:	75 0d                	jne    31d3 <main+0x1d3>
        priorities[argc - 1] = 10;
    31c6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    31c9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    31cc:	c7 04 88 0a 00 00 00 	movl   $0xa,(%eax,%ecx,4)
    if (strcmp(argv[argc - 1], "uniq") == 0)
    31d3:	83 ec 08             	sub    $0x8,%esp
    31d6:	68 9f 39 00 00       	push   $0x399f
    31db:	ff 37                	push   (%edi)
    31dd:	e8 ee 00 00 00       	call   32d0 <strcmp>
    31e2:	83 c4 10             	add    $0x10,%esp
    31e5:	85 c0                	test   %eax,%eax
    31e7:	75 0d                	jne    31f6 <main+0x1f6>
        priorities[argc - 1] = 10;
    31e9:	8b 45 d0             	mov    -0x30(%ebp),%eax
    31ec:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    31ef:	c7 04 88 0a 00 00 00 	movl   $0xa,(%eax,%ecx,4)
    // for (int i = 0; i < argc; i++)
    //     printf(1, "%d %d\n", i, priorities[i]);
    for (int p = 1; p <= 10; p++)
    {
            for (int i = 1; i < argc; i++)
    31f6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    31fd:	8d 76 00             	lea    0x0(%esi),%esi
    3200:	bf 01 00 00 00       	mov    $0x1,%edi
    3205:	83 fe 01             	cmp    $0x1,%esi
    3208:	7f 0d                	jg     3217 <main+0x217>
    320a:	eb 64                	jmp    3270 <main+0x270>
    320c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3210:	83 c7 01             	add    $0x1,%edi
    3213:	39 fe                	cmp    %edi,%esi
    3215:	74 59                	je     3270 <main+0x270>
            {
                if (atoi(argv[i]) == 0)
    3217:	83 ec 0c             	sub    $0xc,%esp
    321a:	ff 34 bb             	push   (%ebx,%edi,4)
    321d:	e8 5e 02 00 00       	call   3480 <atoi>
    3222:	83 c4 10             	add    $0x10,%esp
    3225:	85 c0                	test   %eax,%eax
    3227:	75 e7                	jne    3210 <main+0x210>
                {
                    if (priorities[i] == p)
    3229:	8b 45 d0             	mov    -0x30(%ebp),%eax
    322c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    322f:	39 14 b8             	cmp    %edx,(%eax,%edi,4)
    3232:	75 dc                	jne    3210 <main+0x210>
                    {
                        int pid = fork();
    3234:	e8 b2 02 00 00       	call   34eb <fork>
                        if (pid == 0)
    3239:	85 c0                	test   %eax,%eax
    323b:	75 4b                	jne    3288 <main+0x288>
                        {
                        char *function = argv[i];
    323d:	8b 04 bb             	mov    (%ebx,%edi,4),%eax
                        char *args[] = {function, "input.txt", 0};
                        exec(function, args);
    3240:	83 ec 08             	sub    $0x8,%esp
    3243:	8d 4d dc             	lea    -0x24(%ebp),%ecx
            for (int i = 1; i < argc; i++)
    3246:	83 c7 01             	add    $0x1,%edi
                        exec(function, args);
    3249:	51                   	push   %ecx
    324a:	50                   	push   %eax
                        char *args[] = {function, "input.txt", 0};
    324b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    324e:	c7 45 e0 a4 39 00 00 	movl   $0x39a4,-0x20(%ebp)
    3255:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                        exec(function, args);
    325c:	e8 ca 02 00 00       	call   352b <exec>
    3261:	83 c4 10             	add    $0x10,%esp
            for (int i = 1; i < argc; i++)
    3264:	39 fe                	cmp    %edi,%esi
    3266:	75 af                	jne    3217 <main+0x217>
    3268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    326f:	90                   	nop
    for (int p = 1; p <= 10; p++)
    3270:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    3274:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3277:	83 f8 0b             	cmp    $0xb,%eax
    327a:	75 84                	jne    3200 <main+0x200>
                }
            }
        
        
    }
    exit();
    327c:	e8 72 02 00 00       	call   34f3 <exit>
    3281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                        wait();
    3288:	e8 6e 02 00 00       	call   34fb <wait>
    328d:	eb 81                	jmp    3210 <main+0x210>
    int priorities[argc];
    328f:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
    3294:	e9 c7 fd ff ff       	jmp    3060 <main+0x60>
    3299:	66 90                	xchg   %ax,%ax
    329b:	66 90                	xchg   %ax,%ax
    329d:	66 90                	xchg   %ax,%ax
    329f:	90                   	nop

000032a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    32a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    32a1:	31 c0                	xor    %eax,%eax
{
    32a3:	89 e5                	mov    %esp,%ebp
    32a5:	53                   	push   %ebx
    32a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    32a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    32ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    32b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    32b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    32b7:	83 c0 01             	add    $0x1,%eax
    32ba:	84 d2                	test   %dl,%dl
    32bc:	75 f2                	jne    32b0 <strcpy+0x10>
    ;
  return os;
}
    32be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    32c1:	89 c8                	mov    %ecx,%eax
    32c3:	c9                   	leave  
    32c4:	c3                   	ret    
    32c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000032d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    32d0:	55                   	push   %ebp
    32d1:	89 e5                	mov    %esp,%ebp
    32d3:	53                   	push   %ebx
    32d4:	8b 55 08             	mov    0x8(%ebp),%edx
    32d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    32da:	0f b6 02             	movzbl (%edx),%eax
    32dd:	84 c0                	test   %al,%al
    32df:	75 17                	jne    32f8 <strcmp+0x28>
    32e1:	eb 3a                	jmp    331d <strcmp+0x4d>
    32e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    32e7:	90                   	nop
    32e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    32ec:	83 c2 01             	add    $0x1,%edx
    32ef:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    32f2:	84 c0                	test   %al,%al
    32f4:	74 1a                	je     3310 <strcmp+0x40>
    p++, q++;
    32f6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    32f8:	0f b6 19             	movzbl (%ecx),%ebx
    32fb:	38 c3                	cmp    %al,%bl
    32fd:	74 e9                	je     32e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    32ff:	29 d8                	sub    %ebx,%eax
}
    3301:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3304:	c9                   	leave  
    3305:	c3                   	ret    
    3306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    330d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3310:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3314:	31 c0                	xor    %eax,%eax
    3316:	29 d8                	sub    %ebx,%eax
}
    3318:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    331b:	c9                   	leave  
    331c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    331d:	0f b6 19             	movzbl (%ecx),%ebx
    3320:	31 c0                	xor    %eax,%eax
    3322:	eb db                	jmp    32ff <strcmp+0x2f>
    3324:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    332b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    332f:	90                   	nop

00003330 <strlen>:

uint
strlen(const char *s)
{
    3330:	55                   	push   %ebp
    3331:	89 e5                	mov    %esp,%ebp
    3333:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3336:	80 3a 00             	cmpb   $0x0,(%edx)
    3339:	74 15                	je     3350 <strlen+0x20>
    333b:	31 c0                	xor    %eax,%eax
    333d:	8d 76 00             	lea    0x0(%esi),%esi
    3340:	83 c0 01             	add    $0x1,%eax
    3343:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3347:	89 c1                	mov    %eax,%ecx
    3349:	75 f5                	jne    3340 <strlen+0x10>
    ;
  return n;
}
    334b:	89 c8                	mov    %ecx,%eax
    334d:	5d                   	pop    %ebp
    334e:	c3                   	ret    
    334f:	90                   	nop
  for(n = 0; s[n]; n++)
    3350:	31 c9                	xor    %ecx,%ecx
}
    3352:	5d                   	pop    %ebp
    3353:	89 c8                	mov    %ecx,%eax
    3355:	c3                   	ret    
    3356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    335d:	8d 76 00             	lea    0x0(%esi),%esi

00003360 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3360:	55                   	push   %ebp
    3361:	89 e5                	mov    %esp,%ebp
    3363:	57                   	push   %edi
    3364:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3367:	8b 4d 10             	mov    0x10(%ebp),%ecx
    336a:	8b 45 0c             	mov    0xc(%ebp),%eax
    336d:	89 d7                	mov    %edx,%edi
    336f:	fc                   	cld    
    3370:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3372:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3375:	89 d0                	mov    %edx,%eax
    3377:	c9                   	leave  
    3378:	c3                   	ret    
    3379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003380 <strchr>:

char*
strchr(const char *s, char c)
{
    3380:	55                   	push   %ebp
    3381:	89 e5                	mov    %esp,%ebp
    3383:	8b 45 08             	mov    0x8(%ebp),%eax
    3386:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    338a:	0f b6 10             	movzbl (%eax),%edx
    338d:	84 d2                	test   %dl,%dl
    338f:	75 12                	jne    33a3 <strchr+0x23>
    3391:	eb 1d                	jmp    33b0 <strchr+0x30>
    3393:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3397:	90                   	nop
    3398:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    339c:	83 c0 01             	add    $0x1,%eax
    339f:	84 d2                	test   %dl,%dl
    33a1:	74 0d                	je     33b0 <strchr+0x30>
    if(*s == c)
    33a3:	38 d1                	cmp    %dl,%cl
    33a5:	75 f1                	jne    3398 <strchr+0x18>
      return (char*)s;
  return 0;
}
    33a7:	5d                   	pop    %ebp
    33a8:	c3                   	ret    
    33a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    33b0:	31 c0                	xor    %eax,%eax
}
    33b2:	5d                   	pop    %ebp
    33b3:	c3                   	ret    
    33b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    33bf:	90                   	nop

000033c0 <gets>:

char*
gets(char *buf, int max)
{
    33c0:	55                   	push   %ebp
    33c1:	89 e5                	mov    %esp,%ebp
    33c3:	57                   	push   %edi
    33c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    33c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    33c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    33c9:	31 db                	xor    %ebx,%ebx
{
    33cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    33ce:	eb 27                	jmp    33f7 <gets+0x37>
    cc = read(0, &c, 1);
    33d0:	83 ec 04             	sub    $0x4,%esp
    33d3:	6a 01                	push   $0x1
    33d5:	57                   	push   %edi
    33d6:	6a 00                	push   $0x0
    33d8:	e8 2e 01 00 00       	call   350b <read>
    if(cc < 1)
    33dd:	83 c4 10             	add    $0x10,%esp
    33e0:	85 c0                	test   %eax,%eax
    33e2:	7e 1d                	jle    3401 <gets+0x41>
      break;
    buf[i++] = c;
    33e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    33e8:	8b 55 08             	mov    0x8(%ebp),%edx
    33eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    33ef:	3c 0a                	cmp    $0xa,%al
    33f1:	74 1d                	je     3410 <gets+0x50>
    33f3:	3c 0d                	cmp    $0xd,%al
    33f5:	74 19                	je     3410 <gets+0x50>
  for(i=0; i+1 < max; ){
    33f7:	89 de                	mov    %ebx,%esi
    33f9:	83 c3 01             	add    $0x1,%ebx
    33fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    33ff:	7c cf                	jl     33d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3401:	8b 45 08             	mov    0x8(%ebp),%eax
    3404:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3408:	8d 65 f4             	lea    -0xc(%ebp),%esp
    340b:	5b                   	pop    %ebx
    340c:	5e                   	pop    %esi
    340d:	5f                   	pop    %edi
    340e:	5d                   	pop    %ebp
    340f:	c3                   	ret    
  buf[i] = '\0';
    3410:	8b 45 08             	mov    0x8(%ebp),%eax
    3413:	89 de                	mov    %ebx,%esi
    3415:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3419:	8d 65 f4             	lea    -0xc(%ebp),%esp
    341c:	5b                   	pop    %ebx
    341d:	5e                   	pop    %esi
    341e:	5f                   	pop    %edi
    341f:	5d                   	pop    %ebp
    3420:	c3                   	ret    
    3421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    342f:	90                   	nop

00003430 <stat>:

int
stat(const char *n, struct stat *st)
{
    3430:	55                   	push   %ebp
    3431:	89 e5                	mov    %esp,%ebp
    3433:	56                   	push   %esi
    3434:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3435:	83 ec 08             	sub    $0x8,%esp
    3438:	6a 00                	push   $0x0
    343a:	ff 75 08             	push   0x8(%ebp)
    343d:	e8 f1 00 00 00       	call   3533 <open>
  if(fd < 0)
    3442:	83 c4 10             	add    $0x10,%esp
    3445:	85 c0                	test   %eax,%eax
    3447:	78 27                	js     3470 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3449:	83 ec 08             	sub    $0x8,%esp
    344c:	ff 75 0c             	push   0xc(%ebp)
    344f:	89 c3                	mov    %eax,%ebx
    3451:	50                   	push   %eax
    3452:	e8 f4 00 00 00       	call   354b <fstat>
  close(fd);
    3457:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    345a:	89 c6                	mov    %eax,%esi
  close(fd);
    345c:	e8 ba 00 00 00       	call   351b <close>
  return r;
    3461:	83 c4 10             	add    $0x10,%esp
}
    3464:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3467:	89 f0                	mov    %esi,%eax
    3469:	5b                   	pop    %ebx
    346a:	5e                   	pop    %esi
    346b:	5d                   	pop    %ebp
    346c:	c3                   	ret    
    346d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3470:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3475:	eb ed                	jmp    3464 <stat+0x34>
    3477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    347e:	66 90                	xchg   %ax,%ax

00003480 <atoi>:

int
atoi(const char *s)
{
    3480:	55                   	push   %ebp
    3481:	89 e5                	mov    %esp,%ebp
    3483:	53                   	push   %ebx
    3484:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3487:	0f be 02             	movsbl (%edx),%eax
    348a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    348d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3490:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3495:	77 1e                	ja     34b5 <atoi+0x35>
    3497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    349e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    34a0:	83 c2 01             	add    $0x1,%edx
    34a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    34a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    34aa:	0f be 02             	movsbl (%edx),%eax
    34ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
    34b0:	80 fb 09             	cmp    $0x9,%bl
    34b3:	76 eb                	jbe    34a0 <atoi+0x20>
  return n;
}
    34b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    34b8:	89 c8                	mov    %ecx,%eax
    34ba:	c9                   	leave  
    34bb:	c3                   	ret    
    34bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000034c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    34c0:	55                   	push   %ebp
    34c1:	89 e5                	mov    %esp,%ebp
    34c3:	57                   	push   %edi
    34c4:	8b 45 10             	mov    0x10(%ebp),%eax
    34c7:	8b 55 08             	mov    0x8(%ebp),%edx
    34ca:	56                   	push   %esi
    34cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    34ce:	85 c0                	test   %eax,%eax
    34d0:	7e 13                	jle    34e5 <memmove+0x25>
    34d2:	01 d0                	add    %edx,%eax
  dst = vdst;
    34d4:	89 d7                	mov    %edx,%edi
    34d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    34e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    34e1:	39 f8                	cmp    %edi,%eax
    34e3:	75 fb                	jne    34e0 <memmove+0x20>
  return vdst;
}
    34e5:	5e                   	pop    %esi
    34e6:	89 d0                	mov    %edx,%eax
    34e8:	5f                   	pop    %edi
    34e9:	5d                   	pop    %ebp
    34ea:	c3                   	ret    

000034eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    34eb:	b8 01 00 00 00       	mov    $0x1,%eax
    34f0:	cd 40                	int    $0x40
    34f2:	c3                   	ret    

000034f3 <exit>:
SYSCALL(exit)
    34f3:	b8 02 00 00 00       	mov    $0x2,%eax
    34f8:	cd 40                	int    $0x40
    34fa:	c3                   	ret    

000034fb <wait>:
SYSCALL(wait)
    34fb:	b8 03 00 00 00       	mov    $0x3,%eax
    3500:	cd 40                	int    $0x40
    3502:	c3                   	ret    

00003503 <pipe>:
SYSCALL(pipe)
    3503:	b8 04 00 00 00       	mov    $0x4,%eax
    3508:	cd 40                	int    $0x40
    350a:	c3                   	ret    

0000350b <read>:
SYSCALL(read)
    350b:	b8 05 00 00 00       	mov    $0x5,%eax
    3510:	cd 40                	int    $0x40
    3512:	c3                   	ret    

00003513 <write>:
SYSCALL(write)
    3513:	b8 10 00 00 00       	mov    $0x10,%eax
    3518:	cd 40                	int    $0x40
    351a:	c3                   	ret    

0000351b <close>:
SYSCALL(close)
    351b:	b8 15 00 00 00       	mov    $0x15,%eax
    3520:	cd 40                	int    $0x40
    3522:	c3                   	ret    

00003523 <kill>:
SYSCALL(kill)
    3523:	b8 06 00 00 00       	mov    $0x6,%eax
    3528:	cd 40                	int    $0x40
    352a:	c3                   	ret    

0000352b <exec>:
SYSCALL(exec)
    352b:	b8 07 00 00 00       	mov    $0x7,%eax
    3530:	cd 40                	int    $0x40
    3532:	c3                   	ret    

00003533 <open>:
SYSCALL(open)
    3533:	b8 0f 00 00 00       	mov    $0xf,%eax
    3538:	cd 40                	int    $0x40
    353a:	c3                   	ret    

0000353b <mknod>:
SYSCALL(mknod)
    353b:	b8 11 00 00 00       	mov    $0x11,%eax
    3540:	cd 40                	int    $0x40
    3542:	c3                   	ret    

00003543 <unlink>:
SYSCALL(unlink)
    3543:	b8 12 00 00 00       	mov    $0x12,%eax
    3548:	cd 40                	int    $0x40
    354a:	c3                   	ret    

0000354b <fstat>:
SYSCALL(fstat)
    354b:	b8 08 00 00 00       	mov    $0x8,%eax
    3550:	cd 40                	int    $0x40
    3552:	c3                   	ret    

00003553 <link>:
SYSCALL(link)
    3553:	b8 13 00 00 00       	mov    $0x13,%eax
    3558:	cd 40                	int    $0x40
    355a:	c3                   	ret    

0000355b <mkdir>:
SYSCALL(mkdir)
    355b:	b8 14 00 00 00       	mov    $0x14,%eax
    3560:	cd 40                	int    $0x40
    3562:	c3                   	ret    

00003563 <chdir>:
SYSCALL(chdir)
    3563:	b8 09 00 00 00       	mov    $0x9,%eax
    3568:	cd 40                	int    $0x40
    356a:	c3                   	ret    

0000356b <dup>:
SYSCALL(dup)
    356b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3570:	cd 40                	int    $0x40
    3572:	c3                   	ret    

00003573 <getpid>:
SYSCALL(getpid)
    3573:	b8 0b 00 00 00       	mov    $0xb,%eax
    3578:	cd 40                	int    $0x40
    357a:	c3                   	ret    

0000357b <sbrk>:
SYSCALL(sbrk)
    357b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3580:	cd 40                	int    $0x40
    3582:	c3                   	ret    

00003583 <sleep>:
SYSCALL(sleep)
    3583:	b8 0d 00 00 00       	mov    $0xd,%eax
    3588:	cd 40                	int    $0x40
    358a:	c3                   	ret    

0000358b <uptime>:
SYSCALL(uptime)
    358b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3590:	cd 40                	int    $0x40
    3592:	c3                   	ret    

00003593 <uniq>:
SYSCALL(uniq)
    3593:	b8 16 00 00 00       	mov    $0x16,%eax
    3598:	cd 40                	int    $0x40
    359a:	c3                   	ret    

0000359b <head>:
SYSCALL(head)
    359b:	b8 17 00 00 00       	mov    $0x17,%eax
    35a0:	cd 40                	int    $0x40
    35a2:	c3                   	ret    

000035a3 <ps>:
    35a3:	b8 18 00 00 00       	mov    $0x18,%eax
    35a8:	cd 40                	int    $0x40
    35aa:	c3                   	ret    
    35ab:	66 90                	xchg   %ax,%ax
    35ad:	66 90                	xchg   %ax,%ax
    35af:	90                   	nop

000035b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    35b0:	55                   	push   %ebp
    35b1:	89 e5                	mov    %esp,%ebp
    35b3:	57                   	push   %edi
    35b4:	56                   	push   %esi
    35b5:	53                   	push   %ebx
    35b6:	83 ec 3c             	sub    $0x3c,%esp
    35b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    35bc:	89 d1                	mov    %edx,%ecx
{
    35be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    35c1:	85 d2                	test   %edx,%edx
    35c3:	0f 89 7f 00 00 00    	jns    3648 <printint+0x98>
    35c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    35cd:	74 79                	je     3648 <printint+0x98>
    neg = 1;
    35cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    35d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    35d8:	31 db                	xor    %ebx,%ebx
    35da:	8d 75 d7             	lea    -0x29(%ebp),%esi
    35dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    35e0:	89 c8                	mov    %ecx,%eax
    35e2:	31 d2                	xor    %edx,%edx
    35e4:	89 cf                	mov    %ecx,%edi
    35e6:	f7 75 c4             	divl   -0x3c(%ebp)
    35e9:	0f b6 92 10 3a 00 00 	movzbl 0x3a10(%edx),%edx
    35f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    35f3:	89 d8                	mov    %ebx,%eax
    35f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    35f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    35fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    35fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3601:	76 dd                	jbe    35e0 <printint+0x30>
  if(neg)
    3603:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3606:	85 c9                	test   %ecx,%ecx
    3608:	74 0c                	je     3616 <printint+0x66>
    buf[i++] = '-';
    360a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    360f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3611:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3616:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3619:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    361d:	eb 07                	jmp    3626 <printint+0x76>
    361f:	90                   	nop
    putc(fd, buf[i]);
    3620:	0f b6 13             	movzbl (%ebx),%edx
    3623:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3626:	83 ec 04             	sub    $0x4,%esp
    3629:	88 55 d7             	mov    %dl,-0x29(%ebp)
    362c:	6a 01                	push   $0x1
    362e:	56                   	push   %esi
    362f:	57                   	push   %edi
    3630:	e8 de fe ff ff       	call   3513 <write>
  while(--i >= 0)
    3635:	83 c4 10             	add    $0x10,%esp
    3638:	39 de                	cmp    %ebx,%esi
    363a:	75 e4                	jne    3620 <printint+0x70>
}
    363c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    363f:	5b                   	pop    %ebx
    3640:	5e                   	pop    %esi
    3641:	5f                   	pop    %edi
    3642:	5d                   	pop    %ebp
    3643:	c3                   	ret    
    3644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3648:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    364f:	eb 87                	jmp    35d8 <printint+0x28>
    3651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    365f:	90                   	nop

00003660 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3660:	55                   	push   %ebp
    3661:	89 e5                	mov    %esp,%ebp
    3663:	57                   	push   %edi
    3664:	56                   	push   %esi
    3665:	53                   	push   %ebx
    3666:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3669:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    366c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    366f:	0f b6 13             	movzbl (%ebx),%edx
    3672:	84 d2                	test   %dl,%dl
    3674:	74 6a                	je     36e0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3676:	8d 45 10             	lea    0x10(%ebp),%eax
    3679:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    367c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    367f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3681:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3684:	eb 36                	jmp    36bc <printf+0x5c>
    3686:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    368d:	8d 76 00             	lea    0x0(%esi),%esi
    3690:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3693:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3698:	83 f8 25             	cmp    $0x25,%eax
    369b:	74 15                	je     36b2 <printf+0x52>
  write(fd, &c, 1);
    369d:	83 ec 04             	sub    $0x4,%esp
    36a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    36a3:	6a 01                	push   $0x1
    36a5:	57                   	push   %edi
    36a6:	56                   	push   %esi
    36a7:	e8 67 fe ff ff       	call   3513 <write>
    36ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    36af:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    36b2:	0f b6 13             	movzbl (%ebx),%edx
    36b5:	83 c3 01             	add    $0x1,%ebx
    36b8:	84 d2                	test   %dl,%dl
    36ba:	74 24                	je     36e0 <printf+0x80>
    c = fmt[i] & 0xff;
    36bc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    36bf:	85 c9                	test   %ecx,%ecx
    36c1:	74 cd                	je     3690 <printf+0x30>
      }
    } else if(state == '%'){
    36c3:	83 f9 25             	cmp    $0x25,%ecx
    36c6:	75 ea                	jne    36b2 <printf+0x52>
      if(c == 'd'){
    36c8:	83 f8 25             	cmp    $0x25,%eax
    36cb:	0f 84 07 01 00 00    	je     37d8 <printf+0x178>
    36d1:	83 e8 63             	sub    $0x63,%eax
    36d4:	83 f8 15             	cmp    $0x15,%eax
    36d7:	77 17                	ja     36f0 <printf+0x90>
    36d9:	ff 24 85 b8 39 00 00 	jmp    *0x39b8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    36e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    36e3:	5b                   	pop    %ebx
    36e4:	5e                   	pop    %esi
    36e5:	5f                   	pop    %edi
    36e6:	5d                   	pop    %ebp
    36e7:	c3                   	ret    
    36e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36ef:	90                   	nop
  write(fd, &c, 1);
    36f0:	83 ec 04             	sub    $0x4,%esp
    36f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    36f6:	6a 01                	push   $0x1
    36f8:	57                   	push   %edi
    36f9:	56                   	push   %esi
    36fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    36fe:	e8 10 fe ff ff       	call   3513 <write>
        putc(fd, c);
    3703:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3707:	83 c4 0c             	add    $0xc,%esp
    370a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    370d:	6a 01                	push   $0x1
    370f:	57                   	push   %edi
    3710:	56                   	push   %esi
    3711:	e8 fd fd ff ff       	call   3513 <write>
        putc(fd, c);
    3716:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3719:	31 c9                	xor    %ecx,%ecx
    371b:	eb 95                	jmp    36b2 <printf+0x52>
    371d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3720:	83 ec 0c             	sub    $0xc,%esp
    3723:	b9 10 00 00 00       	mov    $0x10,%ecx
    3728:	6a 00                	push   $0x0
    372a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    372d:	8b 10                	mov    (%eax),%edx
    372f:	89 f0                	mov    %esi,%eax
    3731:	e8 7a fe ff ff       	call   35b0 <printint>
        ap++;
    3736:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    373a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    373d:	31 c9                	xor    %ecx,%ecx
    373f:	e9 6e ff ff ff       	jmp    36b2 <printf+0x52>
    3744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3748:	8b 45 d0             	mov    -0x30(%ebp),%eax
    374b:	8b 10                	mov    (%eax),%edx
        ap++;
    374d:	83 c0 04             	add    $0x4,%eax
    3750:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3753:	85 d2                	test   %edx,%edx
    3755:	0f 84 8d 00 00 00    	je     37e8 <printf+0x188>
        while(*s != 0){
    375b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    375e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3760:	84 c0                	test   %al,%al
    3762:	0f 84 4a ff ff ff    	je     36b2 <printf+0x52>
    3768:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    376b:	89 d3                	mov    %edx,%ebx
    376d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3770:	83 ec 04             	sub    $0x4,%esp
          s++;
    3773:	83 c3 01             	add    $0x1,%ebx
    3776:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3779:	6a 01                	push   $0x1
    377b:	57                   	push   %edi
    377c:	56                   	push   %esi
    377d:	e8 91 fd ff ff       	call   3513 <write>
        while(*s != 0){
    3782:	0f b6 03             	movzbl (%ebx),%eax
    3785:	83 c4 10             	add    $0x10,%esp
    3788:	84 c0                	test   %al,%al
    378a:	75 e4                	jne    3770 <printf+0x110>
      state = 0;
    378c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    378f:	31 c9                	xor    %ecx,%ecx
    3791:	e9 1c ff ff ff       	jmp    36b2 <printf+0x52>
    3796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    379d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    37a0:	83 ec 0c             	sub    $0xc,%esp
    37a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    37a8:	6a 01                	push   $0x1
    37aa:	e9 7b ff ff ff       	jmp    372a <printf+0xca>
    37af:	90                   	nop
        putc(fd, *ap);
    37b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    37b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    37b6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    37b8:	6a 01                	push   $0x1
    37ba:	57                   	push   %edi
    37bb:	56                   	push   %esi
        putc(fd, *ap);
    37bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    37bf:	e8 4f fd ff ff       	call   3513 <write>
        ap++;
    37c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    37c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    37cb:	31 c9                	xor    %ecx,%ecx
    37cd:	e9 e0 fe ff ff       	jmp    36b2 <printf+0x52>
    37d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    37d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    37db:	83 ec 04             	sub    $0x4,%esp
    37de:	e9 2a ff ff ff       	jmp    370d <printf+0xad>
    37e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37e7:	90                   	nop
          s = "(null)";
    37e8:	ba ae 39 00 00       	mov    $0x39ae,%edx
        while(*s != 0){
    37ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    37f0:	b8 28 00 00 00       	mov    $0x28,%eax
    37f5:	89 d3                	mov    %edx,%ebx
    37f7:	e9 74 ff ff ff       	jmp    3770 <printf+0x110>
    37fc:	66 90                	xchg   %ax,%ax
    37fe:	66 90                	xchg   %ax,%ax

00003800 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3800:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3801:	a1 c4 3c 00 00       	mov    0x3cc4,%eax
{
    3806:	89 e5                	mov    %esp,%ebp
    3808:	57                   	push   %edi
    3809:	56                   	push   %esi
    380a:	53                   	push   %ebx
    380b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    380e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3818:	89 c2                	mov    %eax,%edx
    381a:	8b 00                	mov    (%eax),%eax
    381c:	39 ca                	cmp    %ecx,%edx
    381e:	73 30                	jae    3850 <free+0x50>
    3820:	39 c1                	cmp    %eax,%ecx
    3822:	72 04                	jb     3828 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3824:	39 c2                	cmp    %eax,%edx
    3826:	72 f0                	jb     3818 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3828:	8b 73 fc             	mov    -0x4(%ebx),%esi
    382b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    382e:	39 f8                	cmp    %edi,%eax
    3830:	74 30                	je     3862 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3832:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3835:	8b 42 04             	mov    0x4(%edx),%eax
    3838:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    383b:	39 f1                	cmp    %esi,%ecx
    383d:	74 3a                	je     3879 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    383f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3841:	5b                   	pop    %ebx
  freep = p;
    3842:	89 15 c4 3c 00 00    	mov    %edx,0x3cc4
}
    3848:	5e                   	pop    %esi
    3849:	5f                   	pop    %edi
    384a:	5d                   	pop    %ebp
    384b:	c3                   	ret    
    384c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3850:	39 c2                	cmp    %eax,%edx
    3852:	72 c4                	jb     3818 <free+0x18>
    3854:	39 c1                	cmp    %eax,%ecx
    3856:	73 c0                	jae    3818 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3858:	8b 73 fc             	mov    -0x4(%ebx),%esi
    385b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    385e:	39 f8                	cmp    %edi,%eax
    3860:	75 d0                	jne    3832 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3862:	03 70 04             	add    0x4(%eax),%esi
    3865:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3868:	8b 02                	mov    (%edx),%eax
    386a:	8b 00                	mov    (%eax),%eax
    386c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    386f:	8b 42 04             	mov    0x4(%edx),%eax
    3872:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3875:	39 f1                	cmp    %esi,%ecx
    3877:	75 c6                	jne    383f <free+0x3f>
    p->s.size += bp->s.size;
    3879:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    387c:	89 15 c4 3c 00 00    	mov    %edx,0x3cc4
    p->s.size += bp->s.size;
    3882:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3885:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3888:	89 0a                	mov    %ecx,(%edx)
}
    388a:	5b                   	pop    %ebx
    388b:	5e                   	pop    %esi
    388c:	5f                   	pop    %edi
    388d:	5d                   	pop    %ebp
    388e:	c3                   	ret    
    388f:	90                   	nop

00003890 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3890:	55                   	push   %ebp
    3891:	89 e5                	mov    %esp,%ebp
    3893:	57                   	push   %edi
    3894:	56                   	push   %esi
    3895:	53                   	push   %ebx
    3896:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3899:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    389c:	8b 3d c4 3c 00 00    	mov    0x3cc4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    38a2:	8d 70 07             	lea    0x7(%eax),%esi
    38a5:	c1 ee 03             	shr    $0x3,%esi
    38a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    38ab:	85 ff                	test   %edi,%edi
    38ad:	0f 84 9d 00 00 00    	je     3950 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38b3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    38b5:	8b 4a 04             	mov    0x4(%edx),%ecx
    38b8:	39 f1                	cmp    %esi,%ecx
    38ba:	73 6a                	jae    3926 <malloc+0x96>
    38bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    38c1:	39 de                	cmp    %ebx,%esi
    38c3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    38c6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    38cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    38d0:	eb 17                	jmp    38e9 <malloc+0x59>
    38d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    38da:	8b 48 04             	mov    0x4(%eax),%ecx
    38dd:	39 f1                	cmp    %esi,%ecx
    38df:	73 4f                	jae    3930 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    38e1:	8b 3d c4 3c 00 00    	mov    0x3cc4,%edi
    38e7:	89 c2                	mov    %eax,%edx
    38e9:	39 d7                	cmp    %edx,%edi
    38eb:	75 eb                	jne    38d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    38ed:	83 ec 0c             	sub    $0xc,%esp
    38f0:	ff 75 e4             	push   -0x1c(%ebp)
    38f3:	e8 83 fc ff ff       	call   357b <sbrk>
  if(p == (char*)-1)
    38f8:	83 c4 10             	add    $0x10,%esp
    38fb:	83 f8 ff             	cmp    $0xffffffff,%eax
    38fe:	74 1c                	je     391c <malloc+0x8c>
  hp->s.size = nu;
    3900:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3903:	83 ec 0c             	sub    $0xc,%esp
    3906:	83 c0 08             	add    $0x8,%eax
    3909:	50                   	push   %eax
    390a:	e8 f1 fe ff ff       	call   3800 <free>
  return freep;
    390f:	8b 15 c4 3c 00 00    	mov    0x3cc4,%edx
      if((p = morecore(nunits)) == 0)
    3915:	83 c4 10             	add    $0x10,%esp
    3918:	85 d2                	test   %edx,%edx
    391a:	75 bc                	jne    38d8 <malloc+0x48>
        return 0;
  }
}
    391c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    391f:	31 c0                	xor    %eax,%eax
}
    3921:	5b                   	pop    %ebx
    3922:	5e                   	pop    %esi
    3923:	5f                   	pop    %edi
    3924:	5d                   	pop    %ebp
    3925:	c3                   	ret    
    if(p->s.size >= nunits){
    3926:	89 d0                	mov    %edx,%eax
    3928:	89 fa                	mov    %edi,%edx
    392a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3930:	39 ce                	cmp    %ecx,%esi
    3932:	74 4c                	je     3980 <malloc+0xf0>
        p->s.size -= nunits;
    3934:	29 f1                	sub    %esi,%ecx
    3936:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3939:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    393c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    393f:	89 15 c4 3c 00 00    	mov    %edx,0x3cc4
}
    3945:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3948:	83 c0 08             	add    $0x8,%eax
}
    394b:	5b                   	pop    %ebx
    394c:	5e                   	pop    %esi
    394d:	5f                   	pop    %edi
    394e:	5d                   	pop    %ebp
    394f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3950:	c7 05 c4 3c 00 00 c8 	movl   $0x3cc8,0x3cc4
    3957:	3c 00 00 
    base.s.size = 0;
    395a:	bf c8 3c 00 00       	mov    $0x3cc8,%edi
    base.s.ptr = freep = prevp = &base;
    395f:	c7 05 c8 3c 00 00 c8 	movl   $0x3cc8,0x3cc8
    3966:	3c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3969:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    396b:	c7 05 cc 3c 00 00 00 	movl   $0x0,0x3ccc
    3972:	00 00 00 
    if(p->s.size >= nunits){
    3975:	e9 42 ff ff ff       	jmp    38bc <malloc+0x2c>
    397a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3980:	8b 08                	mov    (%eax),%ecx
    3982:	89 0a                	mov    %ecx,(%edx)
    3984:	eb b9                	jmp    393f <malloc+0xaf>
