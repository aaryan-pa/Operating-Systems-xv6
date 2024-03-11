
_uniq:     file format elf32-i386


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
    3011:	81 ec a0 07 00 00    	sub    $0x7a0,%esp
    3017:	8b 39                	mov    (%ecx),%edi
    3019:	8b 59 04             	mov    0x4(%ecx),%ebx
    printf(1,"Uniq command is getting executed in user mode\n");
    301c:	68 a8 41 00 00       	push   $0x41a8
    3021:	6a 01                	push   $0x1
{
    3023:	89 bd 70 f8 ff ff    	mov    %edi,-0x790(%ebp)
    printf(1,"Uniq command is getting executed in user mode\n");
    3029:	e8 52 0e 00 00       	call   3e80 <printf>
    if (argc == 1)
    302e:	83 c4 10             	add    $0x10,%esp
    3031:	83 ff 01             	cmp    $0x1,%edi
    3034:	0f 84 8e 00 00 00    	je     30c8 <main+0xc8>
            }
        }
        exit();
    }

    else if (argc == 2)
    303a:	83 bd 70 f8 ff ff 02 	cmpl   $0x2,-0x790(%ebp)
    3041:	0f 84 58 03 00 00    	je     339f <main+0x39f>

        exit();
    }
    else
    { // options
        if (argv[1][1] == 'd')
    3047:	8b 43 04             	mov    0x4(%ebx),%eax
        {
            const char *filename = argv[2];
    304a:	8b 73 08             	mov    0x8(%ebx),%esi
        if (argv[1][1] == 'd')
    304d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    3051:	3c 64                	cmp    $0x64,%al
    3053:	0f 84 c4 01 00 00    	je     321d <main+0x21d>
                    i++;
                }
            }
            exit();
        }
        else if (argv[1][1] == 'c')
    3059:	3c 63                	cmp    $0x63,%al
    305b:	0f 84 dd 02 00 00    	je     333e <main+0x33e>
            exit();
        }
        else
        { //-i ignore case
            const char *filename = argv[2];
            int fd = open(filename, O_RDONLY); // Open the file for reading
    3061:	57                   	push   %edi
    3062:	57                   	push   %edi
            if (fd < 0)
            {
                printf(2, "Failed to open file: %s\n", filename);
                exit();
            }
            int sentences = 0;
    3063:	31 ff                	xor    %edi,%edi
            int fd = open(filename, O_RDONLY); // Open the file for reading
    3065:	6a 00                	push   $0x0
    3067:	56                   	push   %esi
    3068:	e8 e6 0c 00 00       	call   3d53 <open>
            if (fd < 0)
    306d:	83 c4 10             	add    $0x10,%esp
            int fd = open(filename, O_RDONLY); // Open the file for reading
    3070:	89 c3                	mov    %eax,%ebx
            if (fd < 0)
    3072:	85 c0                	test   %eax,%eax
    3074:	0f 88 b1 02 00 00    	js     332b <main+0x32b>
    307a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            while ((n = read(fd, buf, sizeof(buf))) > 0)
    3080:	83 ec 04             	sub    $0x4,%esp
    3083:	8d 85 a8 f9 ff ff    	lea    -0x658(%ebp),%eax
    3089:	6a 64                	push   $0x64
    308b:	50                   	push   %eax
    308c:	53                   	push   %ebx
    308d:	e8 99 0c 00 00       	call   3d2b <read>
    3092:	83 c4 10             	add    $0x10,%esp
    3095:	85 c0                	test   %eax,%eax
    3097:	0f 8e 38 01 00 00    	jle    31d5 <main+0x1d5>
    309d:	8d 95 a8 f9 ff ff    	lea    -0x658(%ebp),%edx
    30a3:	01 d0                	add    %edx,%eax
    30a5:	eb 10                	jmp    30b7 <main+0xb7>
    30a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    30ae:	66 90                	xchg   %ax,%ax
            {
                for (int i = 0; i < n; i++)
    30b0:	83 c2 01             	add    $0x1,%edx
    30b3:	39 c2                	cmp    %eax,%edx
    30b5:	74 c9                	je     3080 <main+0x80>
                {
                    if (buf[i] == '\n' || buf[i] == '\0')
    30b7:	0f b6 0a             	movzbl (%edx),%ecx
    30ba:	80 f9 0a             	cmp    $0xa,%cl
    30bd:	74 04                	je     30c3 <main+0xc3>
    30bf:	84 c9                	test   %cl,%cl
    30c1:	75 ed                	jne    30b0 <main+0xb0>
                    {
                        sentences++;
    30c3:	83 c7 01             	add    $0x1,%edi
    30c6:	eb e8                	jmp    30b0 <main+0xb0>
        int j = 0, k = 0;
    30c8:	31 db                	xor    %ebx,%ebx
    30ca:	31 ff                	xor    %edi,%edi
    30cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        while ((n = read(0, buf, sizeof(buf))) > 0)
    30d0:	83 ec 04             	sub    $0x4,%esp
    30d3:	8d 85 7c f8 ff ff    	lea    -0x784(%ebp),%eax
    30d9:	6a 64                	push   $0x64
    30db:	50                   	push   %eax
    30dc:	6a 00                	push   $0x0
    30de:	e8 48 0c 00 00       	call   3d2b <read>
    30e3:	83 c4 10             	add    $0x10,%esp
    30e6:	85 c0                	test   %eax,%eax
    30e8:	7e 48                	jle    3132 <main+0x132>
    30ea:	8d 95 7c f8 ff ff    	lea    -0x784(%ebp),%edx
    30f0:	89 de                	mov    %ebx,%esi
    30f2:	01 d0                	add    %edx,%eax
    30f4:	89 85 74 f8 ff ff    	mov    %eax,-0x78c(%ebp)
    30fa:	89 f8                	mov    %edi,%eax
    30fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                if (buf[i] != '\n')
    3100:	0f b6 0a             	movzbl (%edx),%ecx
                    curr_line[j][k++] = buf[i];
    3103:	83 c3 01             	add    $0x1,%ebx
                if (buf[i] != '\n')
    3106:	80 f9 0a             	cmp    $0xa,%cl
    3109:	75 07                	jne    3112 <main+0x112>
                    j++;
    310b:	83 c7 01             	add    $0x1,%edi
                    curr_line[j][k] = '\0';
    310e:	31 c9                	xor    %ecx,%ecx
                    k = 0;
    3110:	31 db                	xor    %ebx,%ebx
    3112:	6b c0 64             	imul   $0x64,%eax,%eax
            for (int i = 0; i < n; i++)
    3115:	83 c2 01             	add    $0x1,%edx
    3118:	83 e8 18             	sub    $0x18,%eax
    311b:	01 e8                	add    %ebp,%eax
    311d:	88 8c 06 24 fa ff ff 	mov    %cl,-0x5dc(%esi,%eax,1)
    3124:	39 95 74 f8 ff ff    	cmp    %edx,-0x78c(%ebp)
    312a:	74 a4                	je     30d0 <main+0xd0>
    312c:	89 de                	mov    %ebx,%esi
    312e:	89 f8                	mov    %edi,%eax
    3130:	eb ce                	jmp    3100 <main+0x100>
        write(1, curr_line[0], strlen(curr_line[0]));
    3132:	83 ec 0c             	sub    $0xc,%esp
    3135:	8d 9d 0c fa ff ff    	lea    -0x5f4(%ebp),%ebx
    313b:	53                   	push   %ebx
    313c:	e8 0f 0a 00 00       	call   3b50 <strlen>
    3141:	83 c4 0c             	add    $0xc,%esp
    3144:	50                   	push   %eax
    3145:	53                   	push   %ebx
    3146:	6a 01                	push   $0x1
    3148:	e8 e6 0b 00 00       	call   3d33 <write>
        printf(1,"\n");
    314d:	59                   	pop    %ecx
    314e:	5b                   	pop    %ebx
    314f:	68 ee 41 00 00       	push   $0x41ee
    3154:	6a 01                	push   $0x1
    3156:	8d 9d 70 fa ff ff    	lea    -0x590(%ebp),%ebx
    315c:	e8 1f 0d 00 00       	call   3e80 <printf>
        for (int i = 1; i < sentences ; i++)
    3161:	8b b5 70 f8 ff ff    	mov    -0x790(%ebp),%esi
    3167:	83 c4 10             	add    $0x10,%esp
    316a:	83 ff 01             	cmp    $0x1,%edi
    316d:	7f 13                	jg     3182 <main+0x182>
    316f:	eb 5f                	jmp    31d0 <main+0x1d0>
    3171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3178:	83 c6 01             	add    $0x1,%esi
    317b:	83 c3 64             	add    $0x64,%ebx
    317e:	39 f7                	cmp    %esi,%edi
    3180:	74 4e                	je     31d0 <main+0x1d0>
            if (strcmp(curr_line[i], curr_line[i - 1]) != 0)
    3182:	83 ec 08             	sub    $0x8,%esp
    3185:	8d 43 9c             	lea    -0x64(%ebx),%eax
    3188:	50                   	push   %eax
    3189:	53                   	push   %ebx
    318a:	e8 61 09 00 00       	call   3af0 <strcmp>
    318f:	83 c4 10             	add    $0x10,%esp
    3192:	85 c0                	test   %eax,%eax
    3194:	74 e2                	je     3178 <main+0x178>
                write(1, curr_line[i], strlen(curr_line[i]));
    3196:	83 ec 0c             	sub    $0xc,%esp
        for (int i = 1; i < sentences ; i++)
    3199:	83 c6 01             	add    $0x1,%esi
                write(1, curr_line[i], strlen(curr_line[i]));
    319c:	53                   	push   %ebx
    319d:	e8 ae 09 00 00       	call   3b50 <strlen>
    31a2:	83 c4 0c             	add    $0xc,%esp
    31a5:	50                   	push   %eax
    31a6:	53                   	push   %ebx
        for (int i = 1; i < sentences ; i++)
    31a7:	83 c3 64             	add    $0x64,%ebx
                write(1, curr_line[i], strlen(curr_line[i]));
    31aa:	6a 01                	push   $0x1
    31ac:	e8 82 0b 00 00       	call   3d33 <write>
                printf(1, "\n");
    31b1:	58                   	pop    %eax
    31b2:	5a                   	pop    %edx
    31b3:	68 ee 41 00 00       	push   $0x41ee
    31b8:	6a 01                	push   $0x1
    31ba:	e8 c1 0c 00 00       	call   3e80 <printf>
    31bf:	83 c4 10             	add    $0x10,%esp
        for (int i = 1; i < sentences ; i++)
    31c2:	39 f7                	cmp    %esi,%edi
    31c4:	75 bc                	jne    3182 <main+0x182>
    31c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31cd:	8d 76 00             	lea    0x0(%esi),%esi
        exit();
    31d0:	e8 3e 0b 00 00       	call   3d13 <exit>
                    }
                }
            }
            // more than 1 sentence
            fd = open(filename, O_RDONLY);
    31d5:	51                   	push   %ecx
    31d6:	51                   	push   %ecx
    31d7:	6a 00                	push   $0x0
    31d9:	56                   	push   %esi
    31da:	89 bd 6c f8 ff ff    	mov    %edi,-0x794(%ebp)
    31e0:	e8 6e 0b 00 00       	call   3d53 <open>
            char curr_line[sentences][100]; // prev_line[] = "";
    31e5:	83 c4 10             	add    $0x10,%esp
            fd = open(filename, O_RDONLY);
    31e8:	89 85 68 f8 ff ff    	mov    %eax,-0x798(%ebp)
            char curr_line[sentences][100]; // prev_line[] = "";
    31ee:	6b c7 64             	imul   $0x64,%edi,%eax
    31f1:	89 e2                	mov    %esp,%edx
    31f3:	8d 78 0f             	lea    0xf(%eax),%edi
    31f6:	89 f8                	mov    %edi,%eax
    31f8:	89 bd 64 f8 ff ff    	mov    %edi,-0x79c(%ebp)
    31fe:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    3204:	83 e0 f0             	and    $0xfffffff0,%eax
    3207:	29 fa                	sub    %edi,%edx
    3209:	39 d4                	cmp    %edx,%esp
    320b:	74 7a                	je     3287 <main+0x287>
    320d:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3213:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    321a:	00 
    321b:	eb ec                	jmp    3209 <main+0x209>
            int fd = open(filename, O_RDONLY); // Open the file for reading
    321d:	52                   	push   %edx
            int sentences = 0;
    321e:	31 ff                	xor    %edi,%edi
            int fd = open(filename, O_RDONLY); // Open the file for reading
    3220:	52                   	push   %edx
    3221:	6a 00                	push   $0x0
    3223:	56                   	push   %esi
    3224:	e8 2a 0b 00 00       	call   3d53 <open>
            if (fd < 0)
    3229:	83 c4 10             	add    $0x10,%esp
            int fd = open(filename, O_RDONLY); // Open the file for reading
    322c:	89 c3                	mov    %eax,%ebx
            if (fd < 0)
    322e:	85 c0                	test   %eax,%eax
    3230:	0f 88 f5 00 00 00    	js     332b <main+0x32b>
    3236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    323d:	8d 76 00             	lea    0x0(%esi),%esi
            while ((n = read(fd, buf, sizeof(buf))) > 0)
    3240:	83 ec 04             	sub    $0x4,%esp
    3243:	8d 85 44 f9 ff ff    	lea    -0x6bc(%ebp),%eax
    3249:	6a 64                	push   $0x64
    324b:	50                   	push   %eax
    324c:	53                   	push   %ebx
    324d:	e8 d9 0a 00 00       	call   3d2b <read>
    3252:	83 c4 10             	add    $0x10,%esp
    3255:	85 c0                	test   %eax,%eax
    3257:	0f 8e 3b 02 00 00    	jle    3498 <main+0x498>
    325d:	8d 95 44 f9 ff ff    	lea    -0x6bc(%ebp),%edx
    3263:	89 d1                	mov    %edx,%ecx
    3265:	01 c1                	add    %eax,%ecx
    3267:	eb 12                	jmp    327b <main+0x27b>
    3269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    if (buf[i] == '\n' || buf[i] == '\0')
    3270:	84 c0                	test   %al,%al
    3272:	74 0e                	je     3282 <main+0x282>
                for (int i = 0; i < n; i++)
    3274:	83 c2 01             	add    $0x1,%edx
    3277:	39 ca                	cmp    %ecx,%edx
    3279:	74 c5                	je     3240 <main+0x240>
                    if (buf[i] == '\n' || buf[i] == '\0')
    327b:	0f b6 02             	movzbl (%edx),%eax
    327e:	3c 0a                	cmp    $0xa,%al
    3280:	75 ee                	jne    3270 <main+0x270>
                        sentences++;
    3282:	83 c7 01             	add    $0x1,%edi
    3285:	eb ed                	jmp    3274 <main+0x274>
            char curr_line[sentences][100]; // prev_line[] = "";
    3287:	25 ff 0f 00 00       	and    $0xfff,%eax
    328c:	29 c4                	sub    %eax,%esp
    328e:	85 c0                	test   %eax,%eax
    3290:	0f 85 75 03 00 00    	jne    360b <main+0x60b>
    3296:	89 a5 70 f8 ff ff    	mov    %esp,-0x790(%ebp)
            int j = 0, k = 0;
    329c:	31 db                	xor    %ebx,%ebx
    329e:	31 ff                	xor    %edi,%edi

            while ((n = read(fd, buf, sizeof(buf))) > 0)
    32a0:	83 ec 04             	sub    $0x4,%esp
    32a3:	8d 85 a8 f9 ff ff    	lea    -0x658(%ebp),%eax
    32a9:	6a 64                	push   $0x64
    32ab:	50                   	push   %eax
    32ac:	ff b5 68 f8 ff ff    	push   -0x798(%ebp)
    32b2:	e8 74 0a 00 00       	call   3d2b <read>
    32b7:	83 c4 10             	add    $0x10,%esp
    32ba:	85 c0                	test   %eax,%eax
    32bc:	7e 41                	jle    32ff <main+0x2ff>
    32be:	8d 8d a8 f9 ff ff    	lea    -0x658(%ebp),%ecx
    32c4:	89 de                	mov    %ebx,%esi
    32c6:	01 c8                	add    %ecx,%eax
    32c8:	89 85 74 f8 ff ff    	mov    %eax,-0x78c(%ebp)
    32ce:	89 f8                	mov    %edi,%eax
            {
                for (int i = 0; i < n; i++)
                {
                    if (buf[i] != '\n')
    32d0:	0f b6 11             	movzbl (%ecx),%edx
                        curr_line[j][k++] = buf[i];
    32d3:	83 c3 01             	add    $0x1,%ebx
                    if (buf[i] != '\n')
    32d6:	80 fa 0a             	cmp    $0xa,%dl
    32d9:	75 07                	jne    32e2 <main+0x2e2>
                    else
                    {
                        curr_line[j][k] = '\0';
                        j++;
    32db:	83 c7 01             	add    $0x1,%edi
                        curr_line[j][k] = '\0';
    32de:	31 d2                	xor    %edx,%edx
                        k = 0;
    32e0:	31 db                	xor    %ebx,%ebx
    32e2:	6b c0 64             	imul   $0x64,%eax,%eax
    32e5:	03 85 70 f8 ff ff    	add    -0x790(%ebp),%eax
                for (int i = 0; i < n; i++)
    32eb:	83 c1 01             	add    $0x1,%ecx
    32ee:	88 14 30             	mov    %dl,(%eax,%esi,1)
    32f1:	3b 8d 74 f8 ff ff    	cmp    -0x78c(%ebp),%ecx
    32f7:	74 a7                	je     32a0 <main+0x2a0>
    32f9:	89 de                	mov    %ebx,%esi
    32fb:	89 f8                	mov    %edi,%eax
    32fd:	eb d1                	jmp    32d0 <main+0x2d0>
                    } // Print the character to stdout until whole sentence is printed
                }
            }
            char small_case[sentences][100];
    32ff:	8b 85 64 f8 ff ff    	mov    -0x79c(%ebp),%eax
    3305:	89 e1                	mov    %esp,%ecx
    3307:	89 c2                	mov    %eax,%edx
    3309:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    330e:	83 e2 f0             	and    $0xfffffff0,%edx
    3311:	29 c1                	sub    %eax,%ecx
    3313:	39 cc                	cmp    %ecx,%esp
    3315:	0f 84 c2 01 00 00    	je     34dd <main+0x4dd>
    331b:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3321:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    3328:	00 
    3329:	eb e8                	jmp    3313 <main+0x313>
                printf(2, "Failed to open file: %s\n", filename);
    332b:	53                   	push   %ebx
    332c:	56                   	push   %esi
    332d:	68 d7 41 00 00       	push   $0x41d7
    3332:	6a 02                	push   $0x2
    3334:	e8 47 0b 00 00       	call   3e80 <printf>
                exit();
    3339:	e8 d5 09 00 00       	call   3d13 <exit>
            int fd = open(filename, O_RDONLY); // Open the file for reading
    333e:	50                   	push   %eax
            int sentences = 0;
    333f:	31 ff                	xor    %edi,%edi
            int fd = open(filename, O_RDONLY); // Open the file for reading
    3341:	50                   	push   %eax
    3342:	6a 00                	push   $0x0
    3344:	56                   	push   %esi
    3345:	e8 09 0a 00 00       	call   3d53 <open>
            if (fd < 0)
    334a:	83 c4 10             	add    $0x10,%esp
            int fd = open(filename, O_RDONLY); // Open the file for reading
    334d:	89 c3                	mov    %eax,%ebx
            if (fd < 0)
    334f:	85 c0                	test   %eax,%eax
    3351:	78 d8                	js     332b <main+0x32b>
    3353:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3357:	90                   	nop
            while ((n = read(fd, buf, sizeof(buf))) > 0)
    3358:	83 ec 04             	sub    $0x4,%esp
    335b:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
    3361:	6a 64                	push   $0x64
    3363:	50                   	push   %eax
    3364:	53                   	push   %ebx
    3365:	e8 c1 09 00 00       	call   3d2b <read>
    336a:	83 c4 10             	add    $0x10,%esp
    336d:	85 c0                	test   %eax,%eax
    336f:	0f 8e 8a 00 00 00    	jle    33ff <main+0x3ff>
    3375:	8d 95 0c fa ff ff    	lea    -0x5f4(%ebp),%edx
    337b:	89 d1                	mov    %edx,%ecx
    337d:	01 c1                	add    %eax,%ecx
    337f:	eb 0e                	jmp    338f <main+0x38f>
    3381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                for (int i = 0; i < n; i++)
    3388:	83 c2 01             	add    $0x1,%edx
    338b:	39 d1                	cmp    %edx,%ecx
    338d:	74 c9                	je     3358 <main+0x358>
                    if (buf[i] == '\n' || buf[i] == '\0')
    338f:	0f b6 02             	movzbl (%edx),%eax
    3392:	3c 0a                	cmp    $0xa,%al
    3394:	74 04                	je     339a <main+0x39a>
    3396:	84 c0                	test   %al,%al
    3398:	75 ee                	jne    3388 <main+0x388>
                        sentences++;
    339a:	83 c7 01             	add    $0x1,%edi
    339d:	eb e9                	jmp    3388 <main+0x388>
        const char *filename = argv[1];
    339f:	8b 73 04             	mov    0x4(%ebx),%esi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    33a2:	53                   	push   %ebx
        int n,sentences=0;
    33a3:	31 ff                	xor    %edi,%edi
        int fd = open(filename, O_RDONLY); // Open the file for reading
    33a5:	53                   	push   %ebx
    33a6:	6a 00                	push   $0x0
    33a8:	56                   	push   %esi
    33a9:	e8 a5 09 00 00       	call   3d53 <open>
        if (fd < 0)
    33ae:	83 c4 10             	add    $0x10,%esp
        int fd = open(filename, O_RDONLY); // Open the file for reading
    33b1:	89 c3                	mov    %eax,%ebx
        if (fd < 0)
    33b3:	85 c0                	test   %eax,%eax
    33b5:	0f 88 70 ff ff ff    	js     332b <main+0x32b>
    33bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    33bf:	90                   	nop
        while ((n = read(fd, buf, sizeof(buf))) > 0)
    33c0:	83 ec 04             	sub    $0x4,%esp
    33c3:	8d 85 e0 f8 ff ff    	lea    -0x720(%ebp),%eax
    33c9:	6a 64                	push   $0x64
    33cb:	50                   	push   %eax
    33cc:	53                   	push   %ebx
    33cd:	e8 59 09 00 00       	call   3d2b <read>
    33d2:	83 c4 10             	add    $0x10,%esp
    33d5:	85 c0                	test   %eax,%eax
    33d7:	7e 7a                	jle    3453 <main+0x453>
    33d9:	8d 95 e0 f8 ff ff    	lea    -0x720(%ebp),%edx
    33df:	89 d1                	mov    %edx,%ecx
    33e1:	01 c1                	add    %eax,%ecx
    33e3:	eb 0e                	jmp    33f3 <main+0x3f3>
    33e5:	8d 76 00             	lea    0x0(%esi),%esi
                if (buf[i] == '\n' || buf[i] == '\0')
    33e8:	84 c0                	test   %al,%al
    33ea:	74 0e                	je     33fa <main+0x3fa>
            for (int i = 0; i < n; i++)
    33ec:	83 c2 01             	add    $0x1,%edx
    33ef:	39 d1                	cmp    %edx,%ecx
    33f1:	74 cd                	je     33c0 <main+0x3c0>
                if (buf[i] == '\n' || buf[i] == '\0')
    33f3:	0f b6 02             	movzbl (%edx),%eax
    33f6:	3c 0a                	cmp    $0xa,%al
    33f8:	75 ee                	jne    33e8 <main+0x3e8>
                    sentences++;
    33fa:	83 c7 01             	add    $0x1,%edi
    33fd:	eb ed                	jmp    33ec <main+0x3ec>
            fd = open(filename, O_RDONLY);
    33ff:	50                   	push   %eax
    3400:	50                   	push   %eax
    3401:	6a 00                	push   $0x0
    3403:	56                   	push   %esi
    3404:	89 bd 68 f8 ff ff    	mov    %edi,-0x798(%ebp)
    340a:	e8 44 09 00 00       	call   3d53 <open>
            char curr_line[sentences][100]; // prev_line[] = "";
    340f:	83 c4 10             	add    $0x10,%esp
            fd = open(filename, O_RDONLY);
    3412:	89 85 64 f8 ff ff    	mov    %eax,-0x79c(%ebp)
            char curr_line[sentences][100]; // prev_line[] = "";
    3418:	8d 47 ff             	lea    -0x1(%edi),%eax
    341b:	89 e2                	mov    %esp,%edx
    341d:	89 85 6c f8 ff ff    	mov    %eax,-0x794(%ebp)
    3423:	6b c7 64             	imul   $0x64,%edi,%eax
    3426:	89 85 60 f8 ff ff    	mov    %eax,-0x7a0(%ebp)
    342c:	83 c0 0f             	add    $0xf,%eax
    342f:	89 c1                	mov    %eax,%ecx
    3431:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    3436:	83 e1 f0             	and    $0xfffffff0,%ecx
    3439:	29 c2                	sub    %eax,%edx
    343b:	39 d4                	cmp    %edx,%esp
    343d:	0f 84 d2 01 00 00    	je     3615 <main+0x615>
    3443:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3449:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    3450:	00 
    3451:	eb e8                	jmp    343b <main+0x43b>
        fd = open(filename, O_RDONLY);
    3453:	51                   	push   %ecx
    3454:	51                   	push   %ecx
    3455:	6a 00                	push   $0x0
    3457:	56                   	push   %esi
    3458:	89 bd 68 f8 ff ff    	mov    %edi,-0x798(%ebp)
    345e:	e8 f0 08 00 00       	call   3d53 <open>
        char curr_line[sentences][100]; // prev_line[] = "";
    3463:	83 c4 10             	add    $0x10,%esp
        fd = open(filename, O_RDONLY);
    3466:	89 85 6c f8 ff ff    	mov    %eax,-0x794(%ebp)
        char curr_line[sentences][100]; // prev_line[] = "";
    346c:	6b c7 64             	imul   $0x64,%edi,%eax
    346f:	89 e1                	mov    %esp,%ecx
    3471:	83 c0 0f             	add    $0xf,%eax
    3474:	89 c2                	mov    %eax,%edx
    3476:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    347b:	83 e2 f0             	and    $0xfffffff0,%edx
    347e:	29 c1                	sub    %eax,%ecx
    3480:	39 cc                	cmp    %ecx,%esp
    3482:	0f 84 39 03 00 00    	je     37c1 <main+0x7c1>
    3488:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    348e:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    3495:	00 
    3496:	eb e8                	jmp    3480 <main+0x480>
            fd = open(filename, O_RDONLY);
    3498:	50                   	push   %eax
    3499:	50                   	push   %eax
    349a:	6a 00                	push   $0x0
    349c:	56                   	push   %esi
    349d:	89 bd 6c f8 ff ff    	mov    %edi,-0x794(%ebp)
    34a3:	e8 ab 08 00 00       	call   3d53 <open>
            char curr_line[sentences][100]; // prev_line[] = "";
    34a8:	83 c4 10             	add    $0x10,%esp
            fd = open(filename, O_RDONLY);
    34ab:	89 85 68 f8 ff ff    	mov    %eax,-0x798(%ebp)
            char curr_line[sentences][100]; // prev_line[] = "";
    34b1:	6b c7 64             	imul   $0x64,%edi,%eax
    34b4:	89 e1                	mov    %esp,%ecx
    34b6:	83 c0 0f             	add    $0xf,%eax
    34b9:	89 c2                	mov    %eax,%edx
    34bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    34c0:	83 e2 f0             	and    $0xfffffff0,%edx
    34c3:	29 c1                	sub    %eax,%ecx
    34c5:	39 cc                	cmp    %ecx,%esp
    34c7:	0f 84 1d 04 00 00    	je     38ea <main+0x8ea>
    34cd:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    34d3:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    34da:	00 
    34db:	eb e8                	jmp    34c5 <main+0x4c5>
            char small_case[sentences][100];
    34dd:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    34e3:	29 d4                	sub    %edx,%esp
    34e5:	85 d2                	test   %edx,%edx
    34e7:	0f 85 14 01 00 00    	jne    3601 <main+0x601>
            for (int i = 0; i < sentences; i++)
    34ed:	83 bd 6c f8 ff ff 00 	cmpl   $0x0,-0x794(%ebp)
            char small_case[sentences][100];
    34f4:	89 a5 68 f8 ff ff    	mov    %esp,-0x798(%ebp)
            for (int i = 0; i < sentences; i++)
    34fa:	0f 84 80 05 00 00    	je     3a80 <main+0xa80>
    3500:	c7 85 74 f8 ff ff 00 	movl   $0x0,-0x78c(%ebp)
    3507:	00 00 00 
    350a:	8b bd 70 f8 ff ff    	mov    -0x790(%ebp),%edi
    3510:	89 e6                	mov    %esp,%esi
    3512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            {
                for (int j = 0; j < strlen(curr_line[i]); j++)
    3518:	31 db                	xor    %ebx,%ebx
    351a:	eb 1a                	jmp    3536 <main+0x536>
    351c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                {
                    if (curr_line[i][j] >= 'A' && curr_line[i][j] <= 'Z')
    3520:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
    3524:	8d 48 bf             	lea    -0x41(%eax),%ecx
                        small_case[i][j] = curr_line[i][j] + 32;
    3527:	8d 50 20             	lea    0x20(%eax),%edx
    352a:	80 f9 1a             	cmp    $0x1a,%cl
    352d:	0f 42 c2             	cmovb  %edx,%eax
    3530:	88 04 1e             	mov    %al,(%esi,%ebx,1)
                for (int j = 0; j < strlen(curr_line[i]); j++)
    3533:	83 c3 01             	add    $0x1,%ebx
    3536:	83 ec 0c             	sub    $0xc,%esp
    3539:	57                   	push   %edi
    353a:	e8 11 06 00 00       	call   3b50 <strlen>
    353f:	83 c4 10             	add    $0x10,%esp
    3542:	39 d8                	cmp    %ebx,%eax
    3544:	77 da                	ja     3520 <main+0x520>
            for (int i = 0; i < sentences; i++)
    3546:	83 85 74 f8 ff ff 01 	addl   $0x1,-0x78c(%ebp)
    354d:	83 c7 64             	add    $0x64,%edi
    3550:	83 c6 64             	add    $0x64,%esi
    3553:	8b 85 74 f8 ff ff    	mov    -0x78c(%ebp),%eax
    3559:	39 85 6c f8 ff ff    	cmp    %eax,-0x794(%ebp)
    355f:	75 b7                	jne    3518 <main+0x518>
                    else
                        small_case[i][j] = curr_line[i][j];
                }
            }
            write(1, curr_line[1], strlen(curr_line[1]));
    3561:	8b b5 70 f8 ff ff    	mov    -0x790(%ebp),%esi
    3567:	83 ec 0c             	sub    $0xc,%esp
    356a:	83 c6 64             	add    $0x64,%esi
    356d:	56                   	push   %esi
    356e:	e8 dd 05 00 00       	call   3b50 <strlen>
    3573:	83 c4 0c             	add    $0xc,%esp
    3576:	50                   	push   %eax
    3577:	56                   	push   %esi
    3578:	6a 01                	push   $0x1
    357a:	e8 b4 07 00 00       	call   3d33 <write>
            printf(1, "\n");
    357f:	58                   	pop    %eax
    3580:	5a                   	pop    %edx
    3581:	68 ee 41 00 00       	push   $0x41ee
    3586:	6a 01                	push   $0x1
    3588:	e8 f3 08 00 00       	call   3e80 <printf>
            for (int i = 1; i < sentences; i++)
    358d:	83 c4 10             	add    $0x10,%esp
    3590:	83 bd 6c f8 ff ff 01 	cmpl   $0x1,-0x794(%ebp)
    3597:	0f 8e 33 fc ff ff    	jle    31d0 <main+0x1d0>
    359d:	8b bd 68 f8 ff ff    	mov    -0x798(%ebp),%edi
    35a3:	bb 01 00 00 00       	mov    $0x1,%ebx
    35a8:	83 c7 64             	add    $0x64,%edi
    35ab:	eb 18                	jmp    35c5 <main+0x5c5>
    35ad:	8d 76 00             	lea    0x0(%esi),%esi
    35b0:	83 c3 01             	add    $0x1,%ebx
    35b3:	83 c7 64             	add    $0x64,%edi
    35b6:	83 c6 64             	add    $0x64,%esi
    35b9:	39 9d 6c f8 ff ff    	cmp    %ebx,-0x794(%ebp)
    35bf:	0f 84 0b fc ff ff    	je     31d0 <main+0x1d0>
            {
                if (strcmp(small_case[i], small_case[i - 1]) != 0)
    35c5:	83 ec 08             	sub    $0x8,%esp
    35c8:	8d 47 9c             	lea    -0x64(%edi),%eax
    35cb:	50                   	push   %eax
    35cc:	57                   	push   %edi
    35cd:	e8 1e 05 00 00       	call   3af0 <strcmp>
    35d2:	83 c4 10             	add    $0x10,%esp
    35d5:	85 c0                	test   %eax,%eax
    35d7:	74 d7                	je     35b0 <main+0x5b0>
                {
                    write(1, curr_line[i], strlen(curr_line[i]));
    35d9:	83 ec 0c             	sub    $0xc,%esp
    35dc:	56                   	push   %esi
    35dd:	e8 6e 05 00 00       	call   3b50 <strlen>
    35e2:	83 c4 0c             	add    $0xc,%esp
    35e5:	50                   	push   %eax
    35e6:	56                   	push   %esi
    35e7:	6a 01                	push   $0x1
    35e9:	e8 45 07 00 00       	call   3d33 <write>
                    printf(1, "\n");
    35ee:	59                   	pop    %ecx
    35ef:	58                   	pop    %eax
    35f0:	68 ee 41 00 00       	push   $0x41ee
    35f5:	6a 01                	push   $0x1
    35f7:	e8 84 08 00 00       	call   3e80 <printf>
    35fc:	83 c4 10             	add    $0x10,%esp
    35ff:	eb af                	jmp    35b0 <main+0x5b0>
            char small_case[sentences][100];
    3601:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
    3606:	e9 e2 fe ff ff       	jmp    34ed <main+0x4ed>
            char curr_line[sentences][100]; // prev_line[] = "";
    360b:	83 4c 04 fc 00       	orl    $0x0,-0x4(%esp,%eax,1)
    3610:	e9 81 fc ff ff       	jmp    3296 <main+0x296>
            char curr_line[sentences][100]; // prev_line[] = "";
    3615:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
    361b:	29 cc                	sub    %ecx,%esp
    361d:	85 c9                	test   %ecx,%ecx
    361f:	74 05                	je     3626 <main+0x626>
    3621:	83 4c 0c fc 00       	orl    $0x0,-0x4(%esp,%ecx,1)
    3626:	89 a5 70 f8 ff ff    	mov    %esp,-0x790(%ebp)
            int j = 0, k = 0;
    362c:	31 db                	xor    %ebx,%ebx
    362e:	31 ff                	xor    %edi,%edi
            while ((n = read(fd, buf, sizeof(buf))) > 0)
    3630:	83 ec 04             	sub    $0x4,%esp
    3633:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
    3639:	6a 64                	push   $0x64
    363b:	50                   	push   %eax
    363c:	ff b5 64 f8 ff ff    	push   -0x79c(%ebp)
    3642:	e8 e4 06 00 00       	call   3d2b <read>
    3647:	83 c4 10             	add    $0x10,%esp
    364a:	85 c0                	test   %eax,%eax
    364c:	7e 41                	jle    368f <main+0x68f>
    364e:	8d 95 0c fa ff ff    	lea    -0x5f4(%ebp),%edx
    3654:	89 de                	mov    %ebx,%esi
    3656:	01 d0                	add    %edx,%eax
    3658:	89 85 74 f8 ff ff    	mov    %eax,-0x78c(%ebp)
    365e:	89 f8                	mov    %edi,%eax
                    if (buf[i] != '\n')
    3660:	0f b6 0a             	movzbl (%edx),%ecx
                        curr_line[j][k++] = buf[i];
    3663:	83 c3 01             	add    $0x1,%ebx
                    if (buf[i] != '\n')
    3666:	80 f9 0a             	cmp    $0xa,%cl
    3669:	75 07                	jne    3672 <main+0x672>
                        j++;
    366b:	83 c7 01             	add    $0x1,%edi
                        curr_line[j][k] = '\0';
    366e:	31 c9                	xor    %ecx,%ecx
                        k = 0;
    3670:	31 db                	xor    %ebx,%ebx
    3672:	6b c0 64             	imul   $0x64,%eax,%eax
    3675:	03 85 70 f8 ff ff    	add    -0x790(%ebp),%eax
                for (int i = 0; i < n; i++)
    367b:	83 c2 01             	add    $0x1,%edx
    367e:	88 0c 30             	mov    %cl,(%eax,%esi,1)
    3681:	39 95 74 f8 ff ff    	cmp    %edx,-0x78c(%ebp)
    3687:	74 a7                	je     3630 <main+0x630>
    3689:	89 de                	mov    %ebx,%esi
    368b:	89 f8                	mov    %edi,%eax
    368d:	eb d1                	jmp    3660 <main+0x660>
            int is_duplicate[sentences];
    368f:	8b 85 68 f8 ff ff    	mov    -0x798(%ebp),%eax
    3695:	89 e1                	mov    %esp,%ecx
    3697:	8d 04 85 0f 00 00 00 	lea    0xf(,%eax,4),%eax
    369e:	89 c2                	mov    %eax,%edx
    36a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    36a5:	83 e2 f0             	and    $0xfffffff0,%edx
    36a8:	29 c1                	sub    %eax,%ecx
    36aa:	39 cc                	cmp    %ecx,%esp
    36ac:	74 10                	je     36be <main+0x6be>
    36ae:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    36b4:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    36bb:	00 
    36bc:	eb ec                	jmp    36aa <main+0x6aa>
    36be:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    36c4:	29 d4                	sub    %edx,%esp
    36c6:	85 d2                	test   %edx,%edx
    36c8:	74 05                	je     36cf <main+0x6cf>
    36ca:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
    36cf:	8d 54 24 03          	lea    0x3(%esp),%edx
            for (int i = 1; i < sentences; i++)
    36d3:	bb 01 00 00 00       	mov    $0x1,%ebx
            int is_duplicate[sentences];
    36d8:	89 d0                	mov    %edx,%eax
    36da:	89 d7                	mov    %edx,%edi
    36dc:	c1 e8 02             	shr    $0x2,%eax
    36df:	83 e7 fc             	and    $0xfffffffc,%edi
            for (int i = 1; i < sentences; i++)
    36e2:	83 bd 68 f8 ff ff 01 	cmpl   $0x1,-0x798(%ebp)
            is_duplicate[0] = 1;
    36e9:	c7 04 85 00 00 00 00 	movl   $0x1,0x0(,%eax,4)
    36f0:	01 00 00 00 
            for (int i = 1; i < sentences; i++)
    36f4:	8b 85 70 f8 ff ff    	mov    -0x790(%ebp),%eax
    36fa:	8d 70 64             	lea    0x64(%eax),%esi
    36fd:	7f 1a                	jg     3719 <main+0x719>
    36ff:	eb 3c                	jmp    373d <main+0x73d>
    3701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3708:	89 04 9f             	mov    %eax,(%edi,%ebx,4)
    370b:	83 c6 64             	add    $0x64,%esi
    370e:	83 c3 01             	add    $0x1,%ebx
    3711:	39 9d 68 f8 ff ff    	cmp    %ebx,-0x798(%ebp)
    3717:	74 24                	je     373d <main+0x73d>
                if (strcmp(curr_line[i], curr_line[i - 1]) == 0)
    3719:	83 ec 08             	sub    $0x8,%esp
    371c:	8d 46 9c             	lea    -0x64(%esi),%eax
    371f:	50                   	push   %eax
    3720:	56                   	push   %esi
    3721:	e8 ca 03 00 00       	call   3af0 <strcmp>
    3726:	83 c4 10             	add    $0x10,%esp
    3729:	89 c1                	mov    %eax,%ecx
                    is_duplicate[i] = 1;
    372b:	b8 01 00 00 00       	mov    $0x1,%eax
                if (strcmp(curr_line[i], curr_line[i - 1]) == 0)
    3730:	85 c9                	test   %ecx,%ecx
    3732:	75 d4                	jne    3708 <main+0x708>
                    is_duplicate[i] = is_duplicate[i - 1] + 1;
    3734:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
    3738:	83 c0 01             	add    $0x1,%eax
                    continue;
    373b:	eb cb                	jmp    3708 <main+0x708>
            for (int i = 0; i < sentences - 1; i++)
    373d:	83 bd 6c f8 ff ff 00 	cmpl   $0x0,-0x794(%ebp)
    3744:	7e 50                	jle    3796 <main+0x796>
    3746:	8b 85 70 f8 ff ff    	mov    -0x790(%ebp),%eax
    374c:	89 f9                	mov    %edi,%ecx
    374e:	be 01 00 00 00       	mov    $0x1,%esi
    3753:	31 db                	xor    %ebx,%ebx
    3755:	89 c7                	mov    %eax,%edi
    3757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    375e:	66 90                	xchg   %ax,%ax
                if (is_duplicate[i] < is_duplicate[i + 1])
    3760:	83 c3 01             	add    $0x1,%ebx
    3763:	89 f2                	mov    %esi,%edx
    3765:	8b 34 99             	mov    (%ecx,%ebx,4),%esi
    3768:	39 d6                	cmp    %edx,%esi
    376a:	7f 1d                	jg     3789 <main+0x789>
                    printf(1, "%d %s\n", is_duplicate[i], curr_line[i]);
    376c:	57                   	push   %edi
    376d:	52                   	push   %edx
    376e:	68 f0 41 00 00       	push   $0x41f0
    3773:	6a 01                	push   $0x1
    3775:	89 8d 74 f8 ff ff    	mov    %ecx,-0x78c(%ebp)
    377b:	e8 00 07 00 00       	call   3e80 <printf>
    3780:	8b 8d 74 f8 ff ff    	mov    -0x78c(%ebp),%ecx
    3786:	83 c4 10             	add    $0x10,%esp
            for (int i = 0; i < sentences - 1; i++)
    3789:	83 c7 64             	add    $0x64,%edi
    378c:	39 9d 6c f8 ff ff    	cmp    %ebx,-0x794(%ebp)
    3792:	75 cc                	jne    3760 <main+0x760>
    3794:	89 cf                	mov    %ecx,%edi
            printf(1, "%d %s\n", is_duplicate[sentences - 1], curr_line[sentences - 1]);
    3796:	8b 85 70 f8 ff ff    	mov    -0x790(%ebp),%eax
    379c:	8b b5 60 f8 ff ff    	mov    -0x7a0(%ebp),%esi
    37a2:	8d 44 30 9c          	lea    -0x64(%eax,%esi,1),%eax
    37a6:	50                   	push   %eax
    37a7:	8b 85 6c f8 ff ff    	mov    -0x794(%ebp),%eax
    37ad:	ff 34 87             	push   (%edi,%eax,4)
    37b0:	68 f0 41 00 00       	push   $0x41f0
    37b5:	6a 01                	push   $0x1
    37b7:	e8 c4 06 00 00       	call   3e80 <printf>
            exit();
    37bc:	e8 52 05 00 00       	call   3d13 <exit>
        char curr_line[sentences][100]; // prev_line[] = "";
    37c1:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    37c7:	29 d4                	sub    %edx,%esp
    37c9:	85 d2                	test   %edx,%edx
    37cb:	74 05                	je     37d2 <main+0x7d2>
    37cd:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
    37d2:	89 e0                	mov    %esp,%eax
        if(strlen(curr_line[0]) > 0 ){}
    37d4:	83 ec 0c             	sub    $0xc,%esp
        int j = 0, k = 0;
    37d7:	31 db                	xor    %ebx,%ebx
    37d9:	31 ff                	xor    %edi,%edi
        if(strlen(curr_line[0]) > 0 ){}
    37db:	50                   	push   %eax
        char curr_line[sentences][100]; // prev_line[] = "";
    37dc:	89 85 70 f8 ff ff    	mov    %eax,-0x790(%ebp)
        if(strlen(curr_line[0]) > 0 ){}
    37e2:	e8 69 03 00 00       	call   3b50 <strlen>
        while ((n = read(fd, buf, sizeof(buf))) > 0)
    37e7:	83 c4 10             	add    $0x10,%esp
    37ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    37f0:	83 ec 04             	sub    $0x4,%esp
    37f3:	8d 85 e0 f8 ff ff    	lea    -0x720(%ebp),%eax
    37f9:	6a 64                	push   $0x64
    37fb:	50                   	push   %eax
    37fc:	ff b5 6c f8 ff ff    	push   -0x794(%ebp)
    3802:	e8 24 05 00 00       	call   3d2b <read>
    3807:	83 c4 10             	add    $0x10,%esp
    380a:	85 c0                	test   %eax,%eax
    380c:	7e 41                	jle    384f <main+0x84f>
    380e:	8d 95 e0 f8 ff ff    	lea    -0x720(%ebp),%edx
    3814:	89 de                	mov    %ebx,%esi
    3816:	01 d0                	add    %edx,%eax
    3818:	89 85 74 f8 ff ff    	mov    %eax,-0x78c(%ebp)
    381e:	89 f8                	mov    %edi,%eax
                if (buf[i] != '\n')
    3820:	0f b6 0a             	movzbl (%edx),%ecx
                    curr_line[j][k++] = buf[i];
    3823:	83 c3 01             	add    $0x1,%ebx
                if (buf[i] != '\n')
    3826:	80 f9 0a             	cmp    $0xa,%cl
    3829:	75 07                	jne    3832 <main+0x832>
                    j++;
    382b:	83 c7 01             	add    $0x1,%edi
                    curr_line[j][k] = '\0';
    382e:	31 c9                	xor    %ecx,%ecx
                    k = 0;
    3830:	31 db                	xor    %ebx,%ebx
    3832:	6b c0 64             	imul   $0x64,%eax,%eax
    3835:	03 85 70 f8 ff ff    	add    -0x790(%ebp),%eax
            for (int i = 0; i < n; i++)
    383b:	83 c2 01             	add    $0x1,%edx
    383e:	88 0c 30             	mov    %cl,(%eax,%esi,1)
    3841:	39 95 74 f8 ff ff    	cmp    %edx,-0x78c(%ebp)
    3847:	74 a7                	je     37f0 <main+0x7f0>
    3849:	89 de                	mov    %ebx,%esi
    384b:	89 f8                	mov    %edi,%eax
    384d:	eb d1                	jmp    3820 <main+0x820>
        write(1, curr_line[0], strlen(curr_line[0]));
    384f:	8b b5 70 f8 ff ff    	mov    -0x790(%ebp),%esi
    3855:	83 ec 0c             	sub    $0xc,%esp
    3858:	56                   	push   %esi
    3859:	e8 f2 02 00 00       	call   3b50 <strlen>
    385e:	83 c4 0c             	add    $0xc,%esp
    3861:	50                   	push   %eax
    3862:	56                   	push   %esi
    3863:	6a 01                	push   $0x1
    3865:	e8 c9 04 00 00       	call   3d33 <write>
        printf(1,"\n");
    386a:	58                   	pop    %eax
    386b:	5a                   	pop    %edx
    386c:	68 ee 41 00 00       	push   $0x41ee
    3871:	6a 01                	push   $0x1
    3873:	e8 08 06 00 00       	call   3e80 <printf>
        for (int i = 1; i < sentences; i++)
    3878:	8b bd 68 f8 ff ff    	mov    -0x798(%ebp),%edi
    387e:	83 c4 10             	add    $0x10,%esp
    3881:	83 ff 01             	cmp    $0x1,%edi
    3884:	0f 8e 46 f9 ff ff    	jle    31d0 <main+0x1d0>
    388a:	83 c6 64             	add    $0x64,%esi
    388d:	89 f3                	mov    %esi,%ebx
    388f:	be 01 00 00 00       	mov    $0x1,%esi
    3894:	eb 18                	jmp    38ae <main+0x8ae>
    3896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    389d:	8d 76 00             	lea    0x0(%esi),%esi
    38a0:	83 c6 01             	add    $0x1,%esi
    38a3:	83 c3 64             	add    $0x64,%ebx
    38a6:	39 f7                	cmp    %esi,%edi
    38a8:	0f 84 22 f9 ff ff    	je     31d0 <main+0x1d0>
            if (strcmp(curr_line[i], curr_line[i - 1]) != 0)
    38ae:	83 ec 08             	sub    $0x8,%esp
    38b1:	8d 43 9c             	lea    -0x64(%ebx),%eax
    38b4:	50                   	push   %eax
    38b5:	53                   	push   %ebx
    38b6:	e8 35 02 00 00       	call   3af0 <strcmp>
    38bb:	83 c4 10             	add    $0x10,%esp
    38be:	85 c0                	test   %eax,%eax
    38c0:	74 de                	je     38a0 <main+0x8a0>
                write(1, curr_line[i], strlen(curr_line[i]));
    38c2:	83 ec 0c             	sub    $0xc,%esp
    38c5:	53                   	push   %ebx
    38c6:	e8 85 02 00 00       	call   3b50 <strlen>
    38cb:	83 c4 0c             	add    $0xc,%esp
    38ce:	50                   	push   %eax
    38cf:	53                   	push   %ebx
    38d0:	6a 01                	push   $0x1
    38d2:	e8 5c 04 00 00       	call   3d33 <write>
                printf(1, "\n");
    38d7:	59                   	pop    %ecx
    38d8:	58                   	pop    %eax
    38d9:	68 ee 41 00 00       	push   $0x41ee
    38de:	6a 01                	push   $0x1
    38e0:	e8 9b 05 00 00       	call   3e80 <printf>
    38e5:	83 c4 10             	add    $0x10,%esp
    38e8:	eb b6                	jmp    38a0 <main+0x8a0>
            char curr_line[sentences][100]; // prev_line[] = "";
    38ea:	89 d0                	mov    %edx,%eax
    38ec:	25 ff 0f 00 00       	and    $0xfff,%eax
    38f1:	29 c4                	sub    %eax,%esp
    38f3:	85 c0                	test   %eax,%eax
    38f5:	74 05                	je     38fc <main+0x8fc>
    38f7:	83 4c 04 fc 00       	orl    $0x0,-0x4(%esp,%eax,1)
    38fc:	89 a5 70 f8 ff ff    	mov    %esp,-0x790(%ebp)
            int j = 0, k = 0;
    3902:	31 db                	xor    %ebx,%ebx
    3904:	31 ff                	xor    %edi,%edi
    3906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    390d:	8d 76 00             	lea    0x0(%esi),%esi
            while ((n = read(fd, buf, sizeof(buf))) > 0)
    3910:	83 ec 04             	sub    $0x4,%esp
    3913:	8d 85 44 f9 ff ff    	lea    -0x6bc(%ebp),%eax
    3919:	6a 64                	push   $0x64
    391b:	50                   	push   %eax
    391c:	ff b5 68 f8 ff ff    	push   -0x798(%ebp)
    3922:	e8 04 04 00 00       	call   3d2b <read>
    3927:	83 c4 10             	add    $0x10,%esp
    392a:	85 c0                	test   %eax,%eax
    392c:	7e 41                	jle    396f <main+0x96f>
    392e:	8d 95 44 f9 ff ff    	lea    -0x6bc(%ebp),%edx
    3934:	89 de                	mov    %ebx,%esi
    3936:	01 d0                	add    %edx,%eax
    3938:	89 85 74 f8 ff ff    	mov    %eax,-0x78c(%ebp)
    393e:	89 f8                	mov    %edi,%eax
                    if (buf[i] != '\n')
    3940:	0f b6 0a             	movzbl (%edx),%ecx
                        curr_line[j][k++] = buf[i];
    3943:	83 c3 01             	add    $0x1,%ebx
                    if (buf[i] != '\n')
    3946:	80 f9 0a             	cmp    $0xa,%cl
    3949:	75 07                	jne    3952 <main+0x952>
                        j++;
    394b:	83 c7 01             	add    $0x1,%edi
                        curr_line[j][k] = '\0';
    394e:	31 c9                	xor    %ecx,%ecx
                        k = 0;
    3950:	31 db                	xor    %ebx,%ebx
    3952:	6b c0 64             	imul   $0x64,%eax,%eax
    3955:	03 85 70 f8 ff ff    	add    -0x790(%ebp),%eax
                for (int i = 0; i < n; i++)
    395b:	83 c2 01             	add    $0x1,%edx
    395e:	88 0c 30             	mov    %cl,(%eax,%esi,1)
    3961:	39 95 74 f8 ff ff    	cmp    %edx,-0x78c(%ebp)
    3967:	74 a7                	je     3910 <main+0x910>
    3969:	89 de                	mov    %ebx,%esi
    396b:	89 f8                	mov    %edi,%eax
    396d:	eb d1                	jmp    3940 <main+0x940>
            int is_duplicate[sentences];
    396f:	8b 85 6c f8 ff ff    	mov    -0x794(%ebp),%eax
    3975:	89 e1                	mov    %esp,%ecx
    3977:	8d 04 85 0f 00 00 00 	lea    0xf(,%eax,4),%eax
    397e:	89 c2                	mov    %eax,%edx
    3980:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    3985:	83 e2 f0             	and    $0xfffffff0,%edx
    3988:	29 c1                	sub    %eax,%ecx
    398a:	39 cc                	cmp    %ecx,%esp
    398c:	74 10                	je     399e <main+0x99e>
    398e:	81 ec 00 10 00 00    	sub    $0x1000,%esp
    3994:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
    399b:	00 
    399c:	eb ec                	jmp    398a <main+0x98a>
    399e:	89 d0                	mov    %edx,%eax
    39a0:	25 ff 0f 00 00       	and    $0xfff,%eax
    39a5:	29 c4                	sub    %eax,%esp
    39a7:	85 c0                	test   %eax,%eax
    39a9:	74 05                	je     39b0 <main+0x9b0>
    39ab:	83 4c 04 fc 00       	orl    $0x0,-0x4(%esp,%eax,1)
    39b0:	8d 54 24 03          	lea    0x3(%esp),%edx
    39b4:	89 d0                	mov    %edx,%eax
    39b6:	83 e2 fc             	and    $0xfffffffc,%edx
    39b9:	c1 e8 02             	shr    $0x2,%eax
            for (int i = 1; i < sentences; i++)
    39bc:	83 bd 6c f8 ff ff 01 	cmpl   $0x1,-0x794(%ebp)
            is_duplicate[0] = 0;
    39c3:	c7 04 85 00 00 00 00 	movl   $0x0,0x0(,%eax,4)
    39ca:	00 00 00 00 
            for (int i = 1; i < sentences; i++)
    39ce:	0f 8e e0 00 00 00    	jle    3ab4 <main+0xab4>
    39d4:	8b 85 70 f8 ff ff    	mov    -0x790(%ebp),%eax
    39da:	bb 01 00 00 00       	mov    $0x1,%ebx
            int counter = 0;
    39df:	89 95 74 f8 ff ff    	mov    %edx,-0x78c(%ebp)
    39e5:	31 ff                	xor    %edi,%edi
    39e7:	8d 70 64             	lea    0x64(%eax),%esi
    39ea:	89 d8                	mov    %ebx,%eax
    39ec:	89 fb                	mov    %edi,%ebx
    39ee:	89 c7                	mov    %eax,%edi
                if (strcmp(curr_line[i], curr_line[i - 1]) == 0)
    39f0:	50                   	push   %eax
    39f1:	50                   	push   %eax
    39f2:	8d 46 9c             	lea    -0x64(%esi),%eax
    39f5:	50                   	push   %eax
    39f6:	56                   	push   %esi
    39f7:	e8 f4 00 00 00       	call   3af0 <strcmp>
    39fc:	83 c4 10             	add    $0x10,%esp
                    counter++;
    39ff:	83 f8 01             	cmp    $0x1,%eax
    3a02:	8b 85 74 f8 ff ff    	mov    -0x78c(%ebp),%eax
    3a08:	83 db ff             	sbb    $0xffffffff,%ebx
            for (int i = 1; i < sentences; i++)
    3a0b:	83 c6 64             	add    $0x64,%esi
    3a0e:	89 1c b8             	mov    %ebx,(%eax,%edi,4)
    3a11:	83 c7 01             	add    $0x1,%edi
    3a14:	39 bd 6c f8 ff ff    	cmp    %edi,-0x794(%ebp)
    3a1a:	75 d4                	jne    39f0 <main+0x9f0>
    3a1c:	89 c2                	mov    %eax,%edx
    3a1e:	89 d7                	mov    %edx,%edi
    3a20:	8b 95 6c f8 ff ff    	mov    -0x794(%ebp),%edx
            int counter = 0;
    3a26:	31 db                	xor    %ebx,%ebx
    3a28:	83 ce ff             	or     $0xffffffff,%esi
                if (var == is_duplicate[i])
    3a2b:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
    3a2e:	39 f0                	cmp    %esi,%eax
    3a30:	74 0f                	je     3a41 <main+0xa41>
                    i++;
    3a32:	83 c3 01             	add    $0x1,%ebx
            while (i < sentences)
    3a35:	39 da                	cmp    %ebx,%edx
    3a37:	0f 8e 93 f7 ff ff    	jle    31d0 <main+0x1d0>
            int counter = 0;
    3a3d:	89 c6                	mov    %eax,%esi
    3a3f:	eb ea                	jmp    3a2b <main+0xa2b>
                    printf(1, "%s\n", curr_line[i]);
    3a41:	50                   	push   %eax
    3a42:	6b c3 64             	imul   $0x64,%ebx,%eax
    3a45:	03 85 70 f8 ff ff    	add    -0x790(%ebp),%eax
    3a4b:	50                   	push   %eax
    3a4c:	68 ec 41 00 00       	push   $0x41ec
    3a51:	6a 01                	push   $0x1
    3a53:	89 95 74 f8 ff ff    	mov    %edx,-0x78c(%ebp)
    3a59:	e8 22 04 00 00       	call   3e80 <printf>
                    while (i < sentences && is_duplicate[i] == var)
    3a5e:	8b 95 74 f8 ff ff    	mov    -0x78c(%ebp),%edx
    3a64:	83 c4 10             	add    $0x10,%esp
    3a67:	eb 08                	jmp    3a71 <main+0xa71>
    3a69:	39 34 9f             	cmp    %esi,(%edi,%ebx,4)
    3a6c:	75 0c                	jne    3a7a <main+0xa7a>
                        i++;
    3a6e:	83 c3 01             	add    $0x1,%ebx
                    while (i < sentences && is_duplicate[i] == var)
    3a71:	39 da                	cmp    %ebx,%edx
    3a73:	7f f4                	jg     3a69 <main+0xa69>
    3a75:	e9 56 f7 ff ff       	jmp    31d0 <main+0x1d0>
    3a7a:	89 f0                	mov    %esi,%eax
            int counter = 0;
    3a7c:	89 c6                	mov    %eax,%esi
    3a7e:	eb ab                	jmp    3a2b <main+0xa2b>
            write(1, curr_line[1], strlen(curr_line[1]));
    3a80:	8b 9d 70 f8 ff ff    	mov    -0x790(%ebp),%ebx
    3a86:	83 ec 0c             	sub    $0xc,%esp
    3a89:	83 c3 64             	add    $0x64,%ebx
    3a8c:	53                   	push   %ebx
    3a8d:	e8 be 00 00 00       	call   3b50 <strlen>
    3a92:	83 c4 0c             	add    $0xc,%esp
    3a95:	50                   	push   %eax
    3a96:	53                   	push   %ebx
    3a97:	6a 01                	push   $0x1
    3a99:	e8 95 02 00 00       	call   3d33 <write>
            printf(1, "\n");
    3a9e:	58                   	pop    %eax
    3a9f:	5a                   	pop    %edx
    3aa0:	68 ee 41 00 00       	push   $0x41ee
    3aa5:	6a 01                	push   $0x1
    3aa7:	e8 d4 03 00 00       	call   3e80 <printf>
    3aac:	83 c4 10             	add    $0x10,%esp
    3aaf:	e9 1c f7 ff ff       	jmp    31d0 <main+0x1d0>
            while (i < sentences)
    3ab4:	0f 85 16 f7 ff ff    	jne    31d0 <main+0x1d0>
    3aba:	e9 5f ff ff ff       	jmp    3a1e <main+0xa1e>
    3abf:	90                   	nop

00003ac0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3ac0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3ac1:	31 c0                	xor    %eax,%eax
{
    3ac3:	89 e5                	mov    %esp,%ebp
    3ac5:	53                   	push   %ebx
    3ac6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3ac9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3ad0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3ad4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3ad7:	83 c0 01             	add    $0x1,%eax
    3ada:	84 d2                	test   %dl,%dl
    3adc:	75 f2                	jne    3ad0 <strcpy+0x10>
    ;
  return os;
}
    3ade:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3ae1:	89 c8                	mov    %ecx,%eax
    3ae3:	c9                   	leave  
    3ae4:	c3                   	ret    
    3ae5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003af0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3af0:	55                   	push   %ebp
    3af1:	89 e5                	mov    %esp,%ebp
    3af3:	53                   	push   %ebx
    3af4:	8b 55 08             	mov    0x8(%ebp),%edx
    3af7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    3afa:	0f b6 02             	movzbl (%edx),%eax
    3afd:	84 c0                	test   %al,%al
    3aff:	75 17                	jne    3b18 <strcmp+0x28>
    3b01:	eb 3a                	jmp    3b3d <strcmp+0x4d>
    3b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3b07:	90                   	nop
    3b08:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    3b0c:	83 c2 01             	add    $0x1,%edx
    3b0f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3b12:	84 c0                	test   %al,%al
    3b14:	74 1a                	je     3b30 <strcmp+0x40>
    p++, q++;
    3b16:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3b18:	0f b6 19             	movzbl (%ecx),%ebx
    3b1b:	38 c3                	cmp    %al,%bl
    3b1d:	74 e9                	je     3b08 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    3b1f:	29 d8                	sub    %ebx,%eax
}
    3b21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b24:	c9                   	leave  
    3b25:	c3                   	ret    
    3b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b2d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3b30:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3b34:	31 c0                	xor    %eax,%eax
    3b36:	29 d8                	sub    %ebx,%eax
}
    3b38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b3b:	c9                   	leave  
    3b3c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    3b3d:	0f b6 19             	movzbl (%ecx),%ebx
    3b40:	31 c0                	xor    %eax,%eax
    3b42:	eb db                	jmp    3b1f <strcmp+0x2f>
    3b44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3b4f:	90                   	nop

00003b50 <strlen>:

uint
strlen(const char *s)
{
    3b50:	55                   	push   %ebp
    3b51:	89 e5                	mov    %esp,%ebp
    3b53:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3b56:	80 3a 00             	cmpb   $0x0,(%edx)
    3b59:	74 15                	je     3b70 <strlen+0x20>
    3b5b:	31 c0                	xor    %eax,%eax
    3b5d:	8d 76 00             	lea    0x0(%esi),%esi
    3b60:	83 c0 01             	add    $0x1,%eax
    3b63:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3b67:	89 c1                	mov    %eax,%ecx
    3b69:	75 f5                	jne    3b60 <strlen+0x10>
    ;
  return n;
}
    3b6b:	89 c8                	mov    %ecx,%eax
    3b6d:	5d                   	pop    %ebp
    3b6e:	c3                   	ret    
    3b6f:	90                   	nop
  for(n = 0; s[n]; n++)
    3b70:	31 c9                	xor    %ecx,%ecx
}
    3b72:	5d                   	pop    %ebp
    3b73:	89 c8                	mov    %ecx,%eax
    3b75:	c3                   	ret    
    3b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b7d:	8d 76 00             	lea    0x0(%esi),%esi

00003b80 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3b80:	55                   	push   %ebp
    3b81:	89 e5                	mov    %esp,%ebp
    3b83:	57                   	push   %edi
    3b84:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3b87:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3b8d:	89 d7                	mov    %edx,%edi
    3b8f:	fc                   	cld    
    3b90:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3b92:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3b95:	89 d0                	mov    %edx,%eax
    3b97:	c9                   	leave  
    3b98:	c3                   	ret    
    3b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003ba0 <strchr>:

char*
strchr(const char *s, char c)
{
    3ba0:	55                   	push   %ebp
    3ba1:	89 e5                	mov    %esp,%ebp
    3ba3:	8b 45 08             	mov    0x8(%ebp),%eax
    3ba6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    3baa:	0f b6 10             	movzbl (%eax),%edx
    3bad:	84 d2                	test   %dl,%dl
    3baf:	75 12                	jne    3bc3 <strchr+0x23>
    3bb1:	eb 1d                	jmp    3bd0 <strchr+0x30>
    3bb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3bb7:	90                   	nop
    3bb8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    3bbc:	83 c0 01             	add    $0x1,%eax
    3bbf:	84 d2                	test   %dl,%dl
    3bc1:	74 0d                	je     3bd0 <strchr+0x30>
    if(*s == c)
    3bc3:	38 d1                	cmp    %dl,%cl
    3bc5:	75 f1                	jne    3bb8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3bc7:	5d                   	pop    %ebp
    3bc8:	c3                   	ret    
    3bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3bd0:	31 c0                	xor    %eax,%eax
}
    3bd2:	5d                   	pop    %ebp
    3bd3:	c3                   	ret    
    3bd4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3bdf:	90                   	nop

00003be0 <gets>:

char*
gets(char *buf, int max)
{
    3be0:	55                   	push   %ebp
    3be1:	89 e5                	mov    %esp,%ebp
    3be3:	57                   	push   %edi
    3be4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3be5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3be8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3be9:	31 db                	xor    %ebx,%ebx
{
    3beb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    3bee:	eb 27                	jmp    3c17 <gets+0x37>
    cc = read(0, &c, 1);
    3bf0:	83 ec 04             	sub    $0x4,%esp
    3bf3:	6a 01                	push   $0x1
    3bf5:	57                   	push   %edi
    3bf6:	6a 00                	push   $0x0
    3bf8:	e8 2e 01 00 00       	call   3d2b <read>
    if(cc < 1)
    3bfd:	83 c4 10             	add    $0x10,%esp
    3c00:	85 c0                	test   %eax,%eax
    3c02:	7e 1d                	jle    3c21 <gets+0x41>
      break;
    buf[i++] = c;
    3c04:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3c08:	8b 55 08             	mov    0x8(%ebp),%edx
    3c0b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    3c0f:	3c 0a                	cmp    $0xa,%al
    3c11:	74 1d                	je     3c30 <gets+0x50>
    3c13:	3c 0d                	cmp    $0xd,%al
    3c15:	74 19                	je     3c30 <gets+0x50>
  for(i=0; i+1 < max; ){
    3c17:	89 de                	mov    %ebx,%esi
    3c19:	83 c3 01             	add    $0x1,%ebx
    3c1c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3c1f:	7c cf                	jl     3bf0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3c21:	8b 45 08             	mov    0x8(%ebp),%eax
    3c24:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3c2b:	5b                   	pop    %ebx
    3c2c:	5e                   	pop    %esi
    3c2d:	5f                   	pop    %edi
    3c2e:	5d                   	pop    %ebp
    3c2f:	c3                   	ret    
  buf[i] = '\0';
    3c30:	8b 45 08             	mov    0x8(%ebp),%eax
    3c33:	89 de                	mov    %ebx,%esi
    3c35:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3c39:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3c3c:	5b                   	pop    %ebx
    3c3d:	5e                   	pop    %esi
    3c3e:	5f                   	pop    %edi
    3c3f:	5d                   	pop    %ebp
    3c40:	c3                   	ret    
    3c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c4f:	90                   	nop

00003c50 <stat>:

int
stat(const char *n, struct stat *st)
{
    3c50:	55                   	push   %ebp
    3c51:	89 e5                	mov    %esp,%ebp
    3c53:	56                   	push   %esi
    3c54:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3c55:	83 ec 08             	sub    $0x8,%esp
    3c58:	6a 00                	push   $0x0
    3c5a:	ff 75 08             	push   0x8(%ebp)
    3c5d:	e8 f1 00 00 00       	call   3d53 <open>
  if(fd < 0)
    3c62:	83 c4 10             	add    $0x10,%esp
    3c65:	85 c0                	test   %eax,%eax
    3c67:	78 27                	js     3c90 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3c69:	83 ec 08             	sub    $0x8,%esp
    3c6c:	ff 75 0c             	push   0xc(%ebp)
    3c6f:	89 c3                	mov    %eax,%ebx
    3c71:	50                   	push   %eax
    3c72:	e8 f4 00 00 00       	call   3d6b <fstat>
  close(fd);
    3c77:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    3c7a:	89 c6                	mov    %eax,%esi
  close(fd);
    3c7c:	e8 ba 00 00 00       	call   3d3b <close>
  return r;
    3c81:	83 c4 10             	add    $0x10,%esp
}
    3c84:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3c87:	89 f0                	mov    %esi,%eax
    3c89:	5b                   	pop    %ebx
    3c8a:	5e                   	pop    %esi
    3c8b:	5d                   	pop    %ebp
    3c8c:	c3                   	ret    
    3c8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3c90:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3c95:	eb ed                	jmp    3c84 <stat+0x34>
    3c97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c9e:	66 90                	xchg   %ax,%ax

00003ca0 <atoi>:

int
atoi(const char *s)
{
    3ca0:	55                   	push   %ebp
    3ca1:	89 e5                	mov    %esp,%ebp
    3ca3:	53                   	push   %ebx
    3ca4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3ca7:	0f be 02             	movsbl (%edx),%eax
    3caa:	8d 48 d0             	lea    -0x30(%eax),%ecx
    3cad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3cb0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3cb5:	77 1e                	ja     3cd5 <atoi+0x35>
    3cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3cbe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3cc0:	83 c2 01             	add    $0x1,%edx
    3cc3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3cc6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    3cca:	0f be 02             	movsbl (%edx),%eax
    3ccd:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3cd0:	80 fb 09             	cmp    $0x9,%bl
    3cd3:	76 eb                	jbe    3cc0 <atoi+0x20>
  return n;
}
    3cd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3cd8:	89 c8                	mov    %ecx,%eax
    3cda:	c9                   	leave  
    3cdb:	c3                   	ret    
    3cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003ce0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3ce0:	55                   	push   %ebp
    3ce1:	89 e5                	mov    %esp,%ebp
    3ce3:	57                   	push   %edi
    3ce4:	8b 45 10             	mov    0x10(%ebp),%eax
    3ce7:	8b 55 08             	mov    0x8(%ebp),%edx
    3cea:	56                   	push   %esi
    3ceb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3cee:	85 c0                	test   %eax,%eax
    3cf0:	7e 13                	jle    3d05 <memmove+0x25>
    3cf2:	01 d0                	add    %edx,%eax
  dst = vdst;
    3cf4:	89 d7                	mov    %edx,%edi
    3cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3cfd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3d00:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3d01:	39 f8                	cmp    %edi,%eax
    3d03:	75 fb                	jne    3d00 <memmove+0x20>
  return vdst;
}
    3d05:	5e                   	pop    %esi
    3d06:	89 d0                	mov    %edx,%eax
    3d08:	5f                   	pop    %edi
    3d09:	5d                   	pop    %ebp
    3d0a:	c3                   	ret    

00003d0b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3d0b:	b8 01 00 00 00       	mov    $0x1,%eax
    3d10:	cd 40                	int    $0x40
    3d12:	c3                   	ret    

00003d13 <exit>:
SYSCALL(exit)
    3d13:	b8 02 00 00 00       	mov    $0x2,%eax
    3d18:	cd 40                	int    $0x40
    3d1a:	c3                   	ret    

00003d1b <wait>:
SYSCALL(wait)
    3d1b:	b8 03 00 00 00       	mov    $0x3,%eax
    3d20:	cd 40                	int    $0x40
    3d22:	c3                   	ret    

00003d23 <pipe>:
SYSCALL(pipe)
    3d23:	b8 04 00 00 00       	mov    $0x4,%eax
    3d28:	cd 40                	int    $0x40
    3d2a:	c3                   	ret    

00003d2b <read>:
SYSCALL(read)
    3d2b:	b8 05 00 00 00       	mov    $0x5,%eax
    3d30:	cd 40                	int    $0x40
    3d32:	c3                   	ret    

00003d33 <write>:
SYSCALL(write)
    3d33:	b8 10 00 00 00       	mov    $0x10,%eax
    3d38:	cd 40                	int    $0x40
    3d3a:	c3                   	ret    

00003d3b <close>:
SYSCALL(close)
    3d3b:	b8 15 00 00 00       	mov    $0x15,%eax
    3d40:	cd 40                	int    $0x40
    3d42:	c3                   	ret    

00003d43 <kill>:
SYSCALL(kill)
    3d43:	b8 06 00 00 00       	mov    $0x6,%eax
    3d48:	cd 40                	int    $0x40
    3d4a:	c3                   	ret    

00003d4b <exec>:
SYSCALL(exec)
    3d4b:	b8 07 00 00 00       	mov    $0x7,%eax
    3d50:	cd 40                	int    $0x40
    3d52:	c3                   	ret    

00003d53 <open>:
SYSCALL(open)
    3d53:	b8 0f 00 00 00       	mov    $0xf,%eax
    3d58:	cd 40                	int    $0x40
    3d5a:	c3                   	ret    

00003d5b <mknod>:
SYSCALL(mknod)
    3d5b:	b8 11 00 00 00       	mov    $0x11,%eax
    3d60:	cd 40                	int    $0x40
    3d62:	c3                   	ret    

00003d63 <unlink>:
SYSCALL(unlink)
    3d63:	b8 12 00 00 00       	mov    $0x12,%eax
    3d68:	cd 40                	int    $0x40
    3d6a:	c3                   	ret    

00003d6b <fstat>:
SYSCALL(fstat)
    3d6b:	b8 08 00 00 00       	mov    $0x8,%eax
    3d70:	cd 40                	int    $0x40
    3d72:	c3                   	ret    

00003d73 <link>:
SYSCALL(link)
    3d73:	b8 13 00 00 00       	mov    $0x13,%eax
    3d78:	cd 40                	int    $0x40
    3d7a:	c3                   	ret    

00003d7b <mkdir>:
SYSCALL(mkdir)
    3d7b:	b8 14 00 00 00       	mov    $0x14,%eax
    3d80:	cd 40                	int    $0x40
    3d82:	c3                   	ret    

00003d83 <chdir>:
SYSCALL(chdir)
    3d83:	b8 09 00 00 00       	mov    $0x9,%eax
    3d88:	cd 40                	int    $0x40
    3d8a:	c3                   	ret    

00003d8b <dup>:
SYSCALL(dup)
    3d8b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3d90:	cd 40                	int    $0x40
    3d92:	c3                   	ret    

00003d93 <getpid>:
SYSCALL(getpid)
    3d93:	b8 0b 00 00 00       	mov    $0xb,%eax
    3d98:	cd 40                	int    $0x40
    3d9a:	c3                   	ret    

00003d9b <sbrk>:
SYSCALL(sbrk)
    3d9b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3da0:	cd 40                	int    $0x40
    3da2:	c3                   	ret    

00003da3 <sleep>:
SYSCALL(sleep)
    3da3:	b8 0d 00 00 00       	mov    $0xd,%eax
    3da8:	cd 40                	int    $0x40
    3daa:	c3                   	ret    

00003dab <uptime>:
SYSCALL(uptime)
    3dab:	b8 0e 00 00 00       	mov    $0xe,%eax
    3db0:	cd 40                	int    $0x40
    3db2:	c3                   	ret    

00003db3 <uniq>:
SYSCALL(uniq)
    3db3:	b8 16 00 00 00       	mov    $0x16,%eax
    3db8:	cd 40                	int    $0x40
    3dba:	c3                   	ret    

00003dbb <head>:
SYSCALL(head)
    3dbb:	b8 17 00 00 00       	mov    $0x17,%eax
    3dc0:	cd 40                	int    $0x40
    3dc2:	c3                   	ret    

00003dc3 <ps>:
    3dc3:	b8 18 00 00 00       	mov    $0x18,%eax
    3dc8:	cd 40                	int    $0x40
    3dca:	c3                   	ret    
    3dcb:	66 90                	xchg   %ax,%ax
    3dcd:	66 90                	xchg   %ax,%ax
    3dcf:	90                   	nop

00003dd0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3dd0:	55                   	push   %ebp
    3dd1:	89 e5                	mov    %esp,%ebp
    3dd3:	57                   	push   %edi
    3dd4:	56                   	push   %esi
    3dd5:	53                   	push   %ebx
    3dd6:	83 ec 3c             	sub    $0x3c,%esp
    3dd9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3ddc:	89 d1                	mov    %edx,%ecx
{
    3dde:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3de1:	85 d2                	test   %edx,%edx
    3de3:	0f 89 7f 00 00 00    	jns    3e68 <printint+0x98>
    3de9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3ded:	74 79                	je     3e68 <printint+0x98>
    neg = 1;
    3def:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3df6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3df8:	31 db                	xor    %ebx,%ebx
    3dfa:	8d 75 d7             	lea    -0x29(%ebp),%esi
    3dfd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3e00:	89 c8                	mov    %ecx,%eax
    3e02:	31 d2                	xor    %edx,%edx
    3e04:	89 cf                	mov    %ecx,%edi
    3e06:	f7 75 c4             	divl   -0x3c(%ebp)
    3e09:	0f b6 92 58 42 00 00 	movzbl 0x4258(%edx),%edx
    3e10:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3e13:	89 d8                	mov    %ebx,%eax
    3e15:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3e18:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    3e1b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    3e1e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3e21:	76 dd                	jbe    3e00 <printint+0x30>
  if(neg)
    3e23:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3e26:	85 c9                	test   %ecx,%ecx
    3e28:	74 0c                	je     3e36 <printint+0x66>
    buf[i++] = '-';
    3e2a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    3e2f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3e31:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3e36:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3e39:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3e3d:	eb 07                	jmp    3e46 <printint+0x76>
    3e3f:	90                   	nop
    putc(fd, buf[i]);
    3e40:	0f b6 13             	movzbl (%ebx),%edx
    3e43:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3e46:	83 ec 04             	sub    $0x4,%esp
    3e49:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3e4c:	6a 01                	push   $0x1
    3e4e:	56                   	push   %esi
    3e4f:	57                   	push   %edi
    3e50:	e8 de fe ff ff       	call   3d33 <write>
  while(--i >= 0)
    3e55:	83 c4 10             	add    $0x10,%esp
    3e58:	39 de                	cmp    %ebx,%esi
    3e5a:	75 e4                	jne    3e40 <printint+0x70>
}
    3e5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3e5f:	5b                   	pop    %ebx
    3e60:	5e                   	pop    %esi
    3e61:	5f                   	pop    %edi
    3e62:	5d                   	pop    %ebp
    3e63:	c3                   	ret    
    3e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3e68:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3e6f:	eb 87                	jmp    3df8 <printint+0x28>
    3e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3e7f:	90                   	nop

00003e80 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3e80:	55                   	push   %ebp
    3e81:	89 e5                	mov    %esp,%ebp
    3e83:	57                   	push   %edi
    3e84:	56                   	push   %esi
    3e85:	53                   	push   %ebx
    3e86:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3e89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    3e8c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    3e8f:	0f b6 13             	movzbl (%ebx),%edx
    3e92:	84 d2                	test   %dl,%dl
    3e94:	74 6a                	je     3f00 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3e96:	8d 45 10             	lea    0x10(%ebp),%eax
    3e99:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    3e9c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3e9f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3ea1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3ea4:	eb 36                	jmp    3edc <printf+0x5c>
    3ea6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3ead:	8d 76 00             	lea    0x0(%esi),%esi
    3eb0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3eb3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3eb8:	83 f8 25             	cmp    $0x25,%eax
    3ebb:	74 15                	je     3ed2 <printf+0x52>
  write(fd, &c, 1);
    3ebd:	83 ec 04             	sub    $0x4,%esp
    3ec0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3ec3:	6a 01                	push   $0x1
    3ec5:	57                   	push   %edi
    3ec6:	56                   	push   %esi
    3ec7:	e8 67 fe ff ff       	call   3d33 <write>
    3ecc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    3ecf:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3ed2:	0f b6 13             	movzbl (%ebx),%edx
    3ed5:	83 c3 01             	add    $0x1,%ebx
    3ed8:	84 d2                	test   %dl,%dl
    3eda:	74 24                	je     3f00 <printf+0x80>
    c = fmt[i] & 0xff;
    3edc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3edf:	85 c9                	test   %ecx,%ecx
    3ee1:	74 cd                	je     3eb0 <printf+0x30>
      }
    } else if(state == '%'){
    3ee3:	83 f9 25             	cmp    $0x25,%ecx
    3ee6:	75 ea                	jne    3ed2 <printf+0x52>
      if(c == 'd'){
    3ee8:	83 f8 25             	cmp    $0x25,%eax
    3eeb:	0f 84 07 01 00 00    	je     3ff8 <printf+0x178>
    3ef1:	83 e8 63             	sub    $0x63,%eax
    3ef4:	83 f8 15             	cmp    $0x15,%eax
    3ef7:	77 17                	ja     3f10 <printf+0x90>
    3ef9:	ff 24 85 00 42 00 00 	jmp    *0x4200(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3f00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3f03:	5b                   	pop    %ebx
    3f04:	5e                   	pop    %esi
    3f05:	5f                   	pop    %edi
    3f06:	5d                   	pop    %ebp
    3f07:	c3                   	ret    
    3f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3f0f:	90                   	nop
  write(fd, &c, 1);
    3f10:	83 ec 04             	sub    $0x4,%esp
    3f13:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3f16:	6a 01                	push   $0x1
    3f18:	57                   	push   %edi
    3f19:	56                   	push   %esi
    3f1a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3f1e:	e8 10 fe ff ff       	call   3d33 <write>
        putc(fd, c);
    3f23:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3f27:	83 c4 0c             	add    $0xc,%esp
    3f2a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3f2d:	6a 01                	push   $0x1
    3f2f:	57                   	push   %edi
    3f30:	56                   	push   %esi
    3f31:	e8 fd fd ff ff       	call   3d33 <write>
        putc(fd, c);
    3f36:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3f39:	31 c9                	xor    %ecx,%ecx
    3f3b:	eb 95                	jmp    3ed2 <printf+0x52>
    3f3d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3f40:	83 ec 0c             	sub    $0xc,%esp
    3f43:	b9 10 00 00 00       	mov    $0x10,%ecx
    3f48:	6a 00                	push   $0x0
    3f4a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3f4d:	8b 10                	mov    (%eax),%edx
    3f4f:	89 f0                	mov    %esi,%eax
    3f51:	e8 7a fe ff ff       	call   3dd0 <printint>
        ap++;
    3f56:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3f5a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3f5d:	31 c9                	xor    %ecx,%ecx
    3f5f:	e9 6e ff ff ff       	jmp    3ed2 <printf+0x52>
    3f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3f68:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3f6b:	8b 10                	mov    (%eax),%edx
        ap++;
    3f6d:	83 c0 04             	add    $0x4,%eax
    3f70:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3f73:	85 d2                	test   %edx,%edx
    3f75:	0f 84 8d 00 00 00    	je     4008 <printf+0x188>
        while(*s != 0){
    3f7b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    3f7e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3f80:	84 c0                	test   %al,%al
    3f82:	0f 84 4a ff ff ff    	je     3ed2 <printf+0x52>
    3f88:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3f8b:	89 d3                	mov    %edx,%ebx
    3f8d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3f90:	83 ec 04             	sub    $0x4,%esp
          s++;
    3f93:	83 c3 01             	add    $0x1,%ebx
    3f96:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3f99:	6a 01                	push   $0x1
    3f9b:	57                   	push   %edi
    3f9c:	56                   	push   %esi
    3f9d:	e8 91 fd ff ff       	call   3d33 <write>
        while(*s != 0){
    3fa2:	0f b6 03             	movzbl (%ebx),%eax
    3fa5:	83 c4 10             	add    $0x10,%esp
    3fa8:	84 c0                	test   %al,%al
    3faa:	75 e4                	jne    3f90 <printf+0x110>
      state = 0;
    3fac:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    3faf:	31 c9                	xor    %ecx,%ecx
    3fb1:	e9 1c ff ff ff       	jmp    3ed2 <printf+0x52>
    3fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3fbd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3fc0:	83 ec 0c             	sub    $0xc,%esp
    3fc3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3fc8:	6a 01                	push   $0x1
    3fca:	e9 7b ff ff ff       	jmp    3f4a <printf+0xca>
    3fcf:	90                   	nop
        putc(fd, *ap);
    3fd0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3fd3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3fd6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3fd8:	6a 01                	push   $0x1
    3fda:	57                   	push   %edi
    3fdb:	56                   	push   %esi
        putc(fd, *ap);
    3fdc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3fdf:	e8 4f fd ff ff       	call   3d33 <write>
        ap++;
    3fe4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3fe8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3feb:	31 c9                	xor    %ecx,%ecx
    3fed:	e9 e0 fe ff ff       	jmp    3ed2 <printf+0x52>
    3ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3ff8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3ffb:	83 ec 04             	sub    $0x4,%esp
    3ffe:	e9 2a ff ff ff       	jmp    3f2d <printf+0xad>
    4003:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4007:	90                   	nop
          s = "(null)";
    4008:	ba f7 41 00 00       	mov    $0x41f7,%edx
        while(*s != 0){
    400d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    4010:	b8 28 00 00 00       	mov    $0x28,%eax
    4015:	89 d3                	mov    %edx,%ebx
    4017:	e9 74 ff ff ff       	jmp    3f90 <printf+0x110>
    401c:	66 90                	xchg   %ax,%ax
    401e:	66 90                	xchg   %ax,%ax

00004020 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4020:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4021:	a1 0c 45 00 00       	mov    0x450c,%eax
{
    4026:	89 e5                	mov    %esp,%ebp
    4028:	57                   	push   %edi
    4029:	56                   	push   %esi
    402a:	53                   	push   %ebx
    402b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    402e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    4038:	89 c2                	mov    %eax,%edx
    403a:	8b 00                	mov    (%eax),%eax
    403c:	39 ca                	cmp    %ecx,%edx
    403e:	73 30                	jae    4070 <free+0x50>
    4040:	39 c1                	cmp    %eax,%ecx
    4042:	72 04                	jb     4048 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4044:	39 c2                	cmp    %eax,%edx
    4046:	72 f0                	jb     4038 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    4048:	8b 73 fc             	mov    -0x4(%ebx),%esi
    404b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    404e:	39 f8                	cmp    %edi,%eax
    4050:	74 30                	je     4082 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    4052:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    4055:	8b 42 04             	mov    0x4(%edx),%eax
    4058:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    405b:	39 f1                	cmp    %esi,%ecx
    405d:	74 3a                	je     4099 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    405f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    4061:	5b                   	pop    %ebx
  freep = p;
    4062:	89 15 0c 45 00 00    	mov    %edx,0x450c
}
    4068:	5e                   	pop    %esi
    4069:	5f                   	pop    %edi
    406a:	5d                   	pop    %ebp
    406b:	c3                   	ret    
    406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4070:	39 c2                	cmp    %eax,%edx
    4072:	72 c4                	jb     4038 <free+0x18>
    4074:	39 c1                	cmp    %eax,%ecx
    4076:	73 c0                	jae    4038 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    4078:	8b 73 fc             	mov    -0x4(%ebx),%esi
    407b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    407e:	39 f8                	cmp    %edi,%eax
    4080:	75 d0                	jne    4052 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    4082:	03 70 04             	add    0x4(%eax),%esi
    4085:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4088:	8b 02                	mov    (%edx),%eax
    408a:	8b 00                	mov    (%eax),%eax
    408c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    408f:	8b 42 04             	mov    0x4(%edx),%eax
    4092:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    4095:	39 f1                	cmp    %esi,%ecx
    4097:	75 c6                	jne    405f <free+0x3f>
    p->s.size += bp->s.size;
    4099:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    409c:	89 15 0c 45 00 00    	mov    %edx,0x450c
    p->s.size += bp->s.size;
    40a2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    40a5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    40a8:	89 0a                	mov    %ecx,(%edx)
}
    40aa:	5b                   	pop    %ebx
    40ab:	5e                   	pop    %esi
    40ac:	5f                   	pop    %edi
    40ad:	5d                   	pop    %ebp
    40ae:	c3                   	ret    
    40af:	90                   	nop

000040b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    40b0:	55                   	push   %ebp
    40b1:	89 e5                	mov    %esp,%ebp
    40b3:	57                   	push   %edi
    40b4:	56                   	push   %esi
    40b5:	53                   	push   %ebx
    40b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    40b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    40bc:	8b 3d 0c 45 00 00    	mov    0x450c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    40c2:	8d 70 07             	lea    0x7(%eax),%esi
    40c5:	c1 ee 03             	shr    $0x3,%esi
    40c8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    40cb:	85 ff                	test   %edi,%edi
    40cd:	0f 84 9d 00 00 00    	je     4170 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    40d3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    40d5:	8b 4a 04             	mov    0x4(%edx),%ecx
    40d8:	39 f1                	cmp    %esi,%ecx
    40da:	73 6a                	jae    4146 <malloc+0x96>
    40dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    40e1:	39 de                	cmp    %ebx,%esi
    40e3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    40e6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    40ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    40f0:	eb 17                	jmp    4109 <malloc+0x59>
    40f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    40f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    40fa:	8b 48 04             	mov    0x4(%eax),%ecx
    40fd:	39 f1                	cmp    %esi,%ecx
    40ff:	73 4f                	jae    4150 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4101:	8b 3d 0c 45 00 00    	mov    0x450c,%edi
    4107:	89 c2                	mov    %eax,%edx
    4109:	39 d7                	cmp    %edx,%edi
    410b:	75 eb                	jne    40f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    410d:	83 ec 0c             	sub    $0xc,%esp
    4110:	ff 75 e4             	push   -0x1c(%ebp)
    4113:	e8 83 fc ff ff       	call   3d9b <sbrk>
  if(p == (char*)-1)
    4118:	83 c4 10             	add    $0x10,%esp
    411b:	83 f8 ff             	cmp    $0xffffffff,%eax
    411e:	74 1c                	je     413c <malloc+0x8c>
  hp->s.size = nu;
    4120:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    4123:	83 ec 0c             	sub    $0xc,%esp
    4126:	83 c0 08             	add    $0x8,%eax
    4129:	50                   	push   %eax
    412a:	e8 f1 fe ff ff       	call   4020 <free>
  return freep;
    412f:	8b 15 0c 45 00 00    	mov    0x450c,%edx
      if((p = morecore(nunits)) == 0)
    4135:	83 c4 10             	add    $0x10,%esp
    4138:	85 d2                	test   %edx,%edx
    413a:	75 bc                	jne    40f8 <malloc+0x48>
        return 0;
  }
}
    413c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    413f:	31 c0                	xor    %eax,%eax
}
    4141:	5b                   	pop    %ebx
    4142:	5e                   	pop    %esi
    4143:	5f                   	pop    %edi
    4144:	5d                   	pop    %ebp
    4145:	c3                   	ret    
    if(p->s.size >= nunits){
    4146:	89 d0                	mov    %edx,%eax
    4148:	89 fa                	mov    %edi,%edx
    414a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    4150:	39 ce                	cmp    %ecx,%esi
    4152:	74 4c                	je     41a0 <malloc+0xf0>
        p->s.size -= nunits;
    4154:	29 f1                	sub    %esi,%ecx
    4156:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    4159:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    415c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    415f:	89 15 0c 45 00 00    	mov    %edx,0x450c
}
    4165:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    4168:	83 c0 08             	add    $0x8,%eax
}
    416b:	5b                   	pop    %ebx
    416c:	5e                   	pop    %esi
    416d:	5f                   	pop    %edi
    416e:	5d                   	pop    %ebp
    416f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    4170:	c7 05 0c 45 00 00 10 	movl   $0x4510,0x450c
    4177:	45 00 00 
    base.s.size = 0;
    417a:	bf 10 45 00 00       	mov    $0x4510,%edi
    base.s.ptr = freep = prevp = &base;
    417f:	c7 05 10 45 00 00 10 	movl   $0x4510,0x4510
    4186:	45 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4189:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    418b:	c7 05 14 45 00 00 00 	movl   $0x0,0x4514
    4192:	00 00 00 
    if(p->s.size >= nunits){
    4195:	e9 42 ff ff ff       	jmp    40dc <malloc+0x2c>
    419a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    41a0:	8b 08                	mov    (%eax),%ecx
    41a2:	89 0a                	mov    %ecx,(%edx)
    41a4:	eb b9                	jmp    415f <malloc+0xaf>
