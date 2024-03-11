
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 6a 11 80       	mov    $0x80116ad0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 40 30 10 80       	mov    $0x80103040,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 7f 10 80       	push   $0x80107fe0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 65 46 00 00       	call   801046c0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 7f 10 80       	push   $0x80107fe7
80100097:	50                   	push   %eax
80100098:	e8 f3 44 00 00       	call   80104590 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 a7 47 00 00       	call   80104890 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 c9 46 00 00       	call   80104830 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 44 00 00       	call   801045d0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 2f 21 00 00       	call   801022c0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ee 7f 10 80       	push   $0x80107fee
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 ad 44 00 00       	call   80104670 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 e7 20 00 00       	jmp    801022c0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 7f 10 80       	push   $0x80107fff
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 6c 44 00 00       	call   80104670 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 1c 44 00 00       	call   80104630 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 70 46 00 00       	call   80104890 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 bf 45 00 00       	jmp    80104830 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 80 10 80       	push   $0x80108006
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 a7 15 00 00       	call   80101840 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 eb 45 00 00       	call   80104890 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 fe 3e 00 00       	call   801041d0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 09 37 00 00       	call   801039f0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 35 45 00 00       	call   80104830 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 5c 14 00 00       	call   80101760 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 df 44 00 00       	call   80104830 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 06 14 00 00       	call   80101760 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 32 25 00 00       	call   801028d0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 80 10 80       	push   $0x8010800d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 13 43 00 00       	call   801046e0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 21 80 10 80       	push   $0x80108021
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 31 64 00 00       	call   80106850 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
  if(pos < 0 || pos > 25*80)
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
  outb(CRTPORT+1, pos>>8);
80100487:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100493:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100496:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049b:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a0:	89 da                	mov    %ebx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a8:	89 f8                	mov    %edi,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
}
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 46 63 00 00       	call   80106850 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 3a 63 00 00       	call   80106850 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 2e 63 00 00       	call   80106850 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 9a 44 00 00       	call   801049f0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 e5 43 00 00       	call   80104950 <memset>
  outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 25 80 10 80       	push   $0x80108025
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100599:	ff 75 08             	push   0x8(%ebp)
{
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010059f:	e8 9c 12 00 00       	call   80101840 <iunlock>
  acquire(&cons.lock);
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 e0 42 00 00       	call   80104890 <acquire>
  for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005c3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
  asm volatile("cli");
801005ca:	fa                   	cli    
    for(;;)
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
  release(&cons.lock);
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 47 42 00 00       	call   80104830 <release>
  ilock(ip);
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	push   0x8(%ebp)
801005ed:	e8 6e 11 00 00       	call   80101760 <ilock>

  return n;
}
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
    x = xx;
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 50 80 10 80 	movzbl -0x7fef7fb0(%edx),%edx
  }while((x /= base) != 0);
8010063d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
  if(sign)
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
    buf[i++] = '-';
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100654:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
    for(;;)
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
    consputc(buf[i]);
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
    x = -xx;
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
}
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
  if (fmt == 0)
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
    switch(c){
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
  if(locking)
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
}
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
      for(; *s; s++)
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
  if(panicked){
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
    for(;;)
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 16, 0);
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100787:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
    for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 a3 40 00 00       	call   80104890 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
  if(panicked){
801007f5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100812:	85 d2                	test   %edx,%edx
80100814:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100817:	74 2e                	je     80100847 <cprintf+0x1a7>
80100819:	fa                   	cli    
    for(;;)
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
    for(;;)
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
        s = "(null)";
80100838:	bf 38 80 10 80       	mov    $0x80108038,%edi
      for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
    release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 d0 3f 00 00       	call   80104830 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
    panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 3f 80 10 80       	push   $0x8010803f
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
  int c, doprocdump = 0;
80100885:	31 f6                	xor    %esi,%esi
{
80100887:	53                   	push   %ebx
80100888:	83 ec 18             	sub    $0x18,%esp
8010088b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010088e:	68 20 ff 10 80       	push   $0x8010ff20
80100893:	e8 f8 3f 00 00       	call   80104890 <acquire>
  while((c = getc()) >= 0){
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb 1a                	jmp    801008b7 <consoleintr+0x37>
8010089d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008a0:	83 fb 08             	cmp    $0x8,%ebx
801008a3:	0f 84 d7 00 00 00    	je     80100980 <consoleintr+0x100>
801008a9:	83 fb 10             	cmp    $0x10,%ebx
801008ac:	0f 85 32 01 00 00    	jne    801009e4 <consoleintr+0x164>
801008b2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008b7:	ff d7                	call   *%edi
801008b9:	89 c3                	mov    %eax,%ebx
801008bb:	85 c0                	test   %eax,%eax
801008bd:	0f 88 05 01 00 00    	js     801009c8 <consoleintr+0x148>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 78                	je     80100940 <consoleintr+0xc0>
801008c8:	7e d6                	jle    801008a0 <consoleintr+0x20>
801008ca:	83 fb 7f             	cmp    $0x7f,%ebx
801008cd:	0f 84 ad 00 00 00    	je     80100980 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d3:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
801008e8:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
        c = (c == '\r') ? '\n' : c;
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
        input.buf[input.e++ % INPUT_BUF] = c;
80100900:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
80100906:	85 d2                	test   %edx,%edx
80100908:	0f 85 10 01 00 00    	jne    80100a1e <consoleintr+0x19e>
8010090e:	89 d8                	mov    %ebx,%eax
80100910:	e8 eb fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100915:	83 fb 0a             	cmp    $0xa,%ebx
80100918:	0f 84 14 01 00 00    	je     80100a32 <consoleintr+0x1b2>
8010091e:	83 fb 04             	cmp    $0x4,%ebx
80100921:	0f 84 0b 01 00 00    	je     80100a32 <consoleintr+0x1b2>
80100927:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010092c:	83 e8 80             	sub    $0xffffff80,%eax
8010092f:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100935:	75 80                	jne    801008b7 <consoleintr+0x37>
80100937:	e9 fb 00 00 00       	jmp    80100a37 <consoleintr+0x1b7>
8010093c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100940:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100945:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100959:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
  if(panicked){
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010096c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
    for(;;)
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(input.e != input.w){
80100980:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100985:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100999:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801009b2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b7:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 ff 10 80       	push   $0x8010ff20
801009d0:	e8 5b 3e 00 00       	call   80104830 <release>
  if(doprocdump) {
801009d5:	83 c4 10             	add    $0x10,%esp
801009d8:	85 f6                	test   %esi,%esi
801009da:	75 2b                	jne    80100a07 <consoleintr+0x187>
}
801009dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009df:	5b                   	pop    %ebx
801009e0:	5e                   	pop    %esi
801009e1:	5f                   	pop    %edi
801009e2:	5d                   	pop    %ebp
801009e3:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009e4:	85 db                	test   %ebx,%ebx
801009e6:	0f 84 cb fe ff ff    	je     801008b7 <consoleintr+0x37>
801009ec:	e9 e2 fe ff ff       	jmp    801008d3 <consoleintr+0x53>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f8:	b8 00 01 00 00       	mov    $0x100,%eax
801009fd:	e8 fe f9 ff ff       	call   80100400 <consputc.part.0>
80100a02:	e9 b0 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
}
80100a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a0a:	5b                   	pop    %ebx
80100a0b:	5e                   	pop    %esi
80100a0c:	5f                   	pop    %edi
80100a0d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a0e:	e9 5d 39 00 00       	jmp    80104370 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a13:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100a1a:	85 d2                	test   %edx,%edx
80100a1c:	74 0a                	je     80100a28 <consoleintr+0x1a8>
80100a1e:	fa                   	cli    
    for(;;)
80100a1f:	eb fe                	jmp    80100a1f <consoleintr+0x19f>
80100a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a28:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a2d:	e8 ce f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a37:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a3a:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a3f:	68 00 ff 10 80       	push   $0x8010ff00
80100a44:	e8 47 38 00 00       	call   80104290 <wakeup>
80100a49:	83 c4 10             	add    $0x10,%esp
80100a4c:	e9 66 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 48 80 10 80       	push   $0x80108048
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 4b 3c 00 00       	call   801046c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 c2 19 00 00       	call   80102460 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave  
80100aa2:	c3                   	ret    
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, stacktop,ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 2f 2f 00 00       	call   801039f0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 74 22 00 00       	call   80102d40 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 a9 15 00 00       	call   80102080 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 ee 02 00 00    	je     80100dd0 <exec+0x320>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c3                	mov    %eax,%ebx
80100ae7:	50                   	push   %eax
80100ae8:	e8 73 0c 00 00       	call   80101760 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	53                   	push   %ebx
80100af9:	e8 72 0f 00 00       	call   80101a70 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	74 22                	je     80100b28 <exec+0x78>
curproc->priority=7;
 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b06:	83 ec 0c             	sub    $0xc,%esp
80100b09:	53                   	push   %ebx
80100b0a:	e8 e1 0e 00 00       	call   801019f0 <iunlockput>
    end_op();
80100b0f:	e8 9c 22 00 00       	call   80102db0 <end_op>
80100b14:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b1f:	5b                   	pop    %ebx
80100b20:	5e                   	pop    %esi
80100b21:	5f                   	pop    %edi
80100b22:	5d                   	pop    %ebp
80100b23:	c3                   	ret    
80100b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b2f:	45 4c 46 
80100b32:	75 d2                	jne    80100b06 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b34:	e8 27 6f 00 00       	call   80107a60 <setupkvm>
80100b39:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b3f:	85 c0                	test   %eax,%eax
80100b41:	74 c3                	je     80100b06 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b4a:	00 
80100b4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
  sz = PGSIZE;
80100b51:	c7 85 f0 fe ff ff 00 	movl   $0x1000,-0x110(%ebp)
80100b58:	10 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b5b:	0f 84 cf 00 00 00    	je     80100c30 <exec+0x180>
80100b61:	31 ff                	xor    %edi,%edi
80100b63:	e9 8e 00 00 00       	jmp    80100bf6 <exec+0x146>
80100b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b77:	75 6c                	jne    80100be5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b85:	0f 82 87 00 00 00    	jb     80100c12 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b91:	72 7f                	jb     80100c12 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b93:	83 ec 04             	sub    $0x4,%esp
80100b96:	50                   	push   %eax
80100b97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ba3:	e8 d8 6c 00 00       	call   80107880 <allocuvm>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	74 5d                	je     80100c12 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100bb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc0:	75 50                	jne    80100c12 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bcb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bd1:	53                   	push   %ebx
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bd9:	e8 b2 6b 00 00       	call   80107790 <loaduvm>
80100bde:	83 c4 20             	add    $0x20,%esp
80100be1:	85 c0                	test   %eax,%eax
80100be3:	78 2d                	js     80100c12 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bec:	83 c7 01             	add    $0x1,%edi
80100bef:	83 c6 20             	add    $0x20,%esi
80100bf2:	39 f8                	cmp    %edi,%eax
80100bf4:	7e 3a                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	56                   	push   %esi
80100bff:	50                   	push   %eax
80100c00:	53                   	push   %ebx
80100c01:	e8 6a 0e 00 00       	call   80101a70 <readi>
80100c06:	83 c4 10             	add    $0x10,%esp
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	0f 84 5e ff ff ff    	je     80100b70 <exec+0xc0>
    freevm(pgdir);
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c1b:	e8 c0 6d 00 00       	call   801079e0 <freevm>
  if(ip){
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	e9 de fe ff ff       	jmp    80100b06 <exec+0x56>
80100c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
  iunlockput(ip);
80100c30:	83 ec 0c             	sub    $0xc,%esp
80100c33:	53                   	push   %ebx
80100c34:	e8 b7 0d 00 00       	call   801019f0 <iunlockput>
  end_op();
80100c39:	e8 72 21 00 00       	call   80102db0 <end_op>
	if((sp = allocuvm(pgdir, stacktop, USERTOP)) == 0)
80100c3e:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c44:	83 c4 0c             	add    $0xc,%esp
80100c47:	68 00 e0 d4 0d       	push   $0xdd4e000
80100c4c:	68 00 c0 d4 0d       	push   $0xdd4c000
80100c51:	57                   	push   %edi
80100c52:	e8 29 6c 00 00       	call   80107880 <allocuvm>
80100c57:	83 c4 10             	add    $0x10,%esp
80100c5a:	89 c3                	mov    %eax,%ebx
80100c5c:	85 c0                	test   %eax,%eax
80100c5e:	0f 84 84 00 00 00    	je     80100ce8 <exec+0x238>
	clearpteu(pgdir, (char*)stacktop);
80100c64:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100c67:	31 f6                	xor    %esi,%esi
	clearpteu(pgdir, (char*)stacktop);
80100c69:	68 00 c0 d4 0d       	push   $0xdd4c000
80100c6e:	57                   	push   %edi
80100c6f:	e8 8c 6e 00 00       	call   80107b00 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c77:	83 c4 10             	add    $0x10,%esp
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c80:	8b 00                	mov    (%eax),%eax
80100c82:	85 c0                	test   %eax,%eax
80100c84:	74 7d                	je     80100d03 <exec+0x253>
80100c86:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c8c:	eb 21                	jmp    80100caf <exec+0x1ff>
80100c8e:	66 90                	xchg   %ax,%ax
80100c90:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c93:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c9a:	83 c6 01             	add    $0x1,%esi
    ustack[3+argc] = sp;
80100c9d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100ca3:	8b 04 b0             	mov    (%eax,%esi,4),%eax
80100ca6:	85 c0                	test   %eax,%eax
80100ca8:	74 59                	je     80100d03 <exec+0x253>
    if(argc >= MAXARG)
80100caa:	83 fe 20             	cmp    $0x20,%esi
80100cad:	74 39                	je     80100ce8 <exec+0x238>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100caf:	83 ec 0c             	sub    $0xc,%esp
80100cb2:	50                   	push   %eax
80100cb3:	e8 98 3e 00 00       	call   80104b50 <strlen>
80100cb8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cba:	58                   	pop    %eax
80100cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cbe:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cc1:	ff 34 b0             	push   (%eax,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cc4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cc7:	e8 84 3e 00 00       	call   80104b50 <strlen>
80100ccc:	83 c0 01             	add    $0x1,%eax
80100ccf:	50                   	push   %eax
80100cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cd3:	ff 34 b0             	push   (%eax,%esi,4)
80100cd6:	53                   	push   %ebx
80100cd7:	57                   	push   %edi
80100cd8:	e8 13 72 00 00       	call   80107ef0 <copyout>
80100cdd:	83 c4 20             	add    $0x20,%esp
80100ce0:	85 c0                	test   %eax,%eax
80100ce2:	79 ac                	jns    80100c90 <exec+0x1e0>
80100ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100ce8:	83 ec 0c             	sub    $0xc,%esp
80100ceb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cf1:	e8 ea 6c 00 00       	call   801079e0 <freevm>
80100cf6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100cf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cfe:	e9 19 fe ff ff       	jmp    80100b1c <exec+0x6c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d03:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100d0a:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d0c:	c7 84 b5 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%esi,4)
80100d13:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d17:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d19:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d1c:	89 b5 5c ff ff ff    	mov    %esi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d22:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d24:	50                   	push   %eax
80100d25:	52                   	push   %edx
80100d26:	53                   	push   %ebx
80100d27:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d2d:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d34:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d37:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d3d:	e8 ae 71 00 00       	call   80107ef0 <copyout>
80100d42:	83 c4 10             	add    $0x10,%esp
80100d45:	85 c0                	test   %eax,%eax
80100d47:	78 9f                	js     80100ce8 <exec+0x238>
  for(last=s=path; *s; s++)
80100d49:	8b 45 08             	mov    0x8(%ebp),%eax
80100d4c:	8b 55 08             	mov    0x8(%ebp),%edx
80100d4f:	0f b6 00             	movzbl (%eax),%eax
80100d52:	84 c0                	test   %al,%al
80100d54:	74 19                	je     80100d6f <exec+0x2bf>
80100d56:	89 d1                	mov    %edx,%ecx
80100d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d5f:	90                   	nop
      last = s+1;
80100d60:	83 c1 01             	add    $0x1,%ecx
80100d63:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d65:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d68:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d6b:	84 c0                	test   %al,%al
80100d6d:	75 f1                	jne    80100d60 <exec+0x2b0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d6f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d75:	83 ec 04             	sub    $0x4,%esp
80100d78:	6a 10                	push   $0x10
80100d7a:	89 f8                	mov    %edi,%eax
80100d7c:	52                   	push   %edx
80100d7d:	83 c0 6c             	add    $0x6c,%eax
80100d80:	50                   	push   %eax
80100d81:	e8 8a 3d 00 00       	call   80104b10 <safestrcpy>
  curproc->pgdir = pgdir;
80100d86:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d8c:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->stacktop = stacktop;
80100d8f:	c7 87 8c 00 00 00 00 	movl   $0xdd4c000,0x8c(%edi)
80100d96:	c0 d4 0d 
  curproc->tf->eip = elf.entry;  // main
80100d99:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100d9c:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100d9f:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100da5:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100da7:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dad:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100db0:	8b 47 18             	mov    0x18(%edi),%eax
80100db3:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100db6:	89 3c 24             	mov    %edi,(%esp)
80100db9:	e8 42 68 00 00       	call   80107600 <switchuvm>
  freevm(oldpgdir);
80100dbe:	89 34 24             	mov    %esi,(%esp)
80100dc1:	e8 1a 6c 00 00       	call   801079e0 <freevm>
  return 0;
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	31 c0                	xor    %eax,%eax
80100dcb:	e9 4c fd ff ff       	jmp    80100b1c <exec+0x6c>
    end_op();
80100dd0:	e8 db 1f 00 00       	call   80102db0 <end_op>
    cprintf("exec: fail\n");
80100dd5:	83 ec 0c             	sub    $0xc,%esp
80100dd8:	68 61 80 10 80       	push   $0x80108061
80100ddd:	e8 be f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100de2:	83 c4 10             	add    $0x10,%esp
80100de5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dea:	e9 2d fd ff ff       	jmp    80100b1c <exec+0x6c>
80100def:	90                   	nop

80100df0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100df6:	68 6d 80 10 80       	push   $0x8010806d
80100dfb:	68 60 ff 10 80       	push   $0x8010ff60
80100e00:	e8 bb 38 00 00       	call   801046c0 <initlock>
}
80100e05:	83 c4 10             	add    $0x10,%esp
80100e08:	c9                   	leave  
80100e09:	c3                   	ret    
80100e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e10 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e14:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100e19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e1c:	68 60 ff 10 80       	push   $0x8010ff60
80100e21:	e8 6a 3a 00 00       	call   80104890 <acquire>
80100e26:	83 c4 10             	add    $0x10,%esp
80100e29:	eb 10                	jmp    80100e3b <filealloc+0x2b>
80100e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e2f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e30:	83 c3 18             	add    $0x18,%ebx
80100e33:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e39:	74 25                	je     80100e60 <filealloc+0x50>
    if(f->ref == 0){
80100e3b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e3e:	85 c0                	test   %eax,%eax
80100e40:	75 ee                	jne    80100e30 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e42:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e45:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e4c:	68 60 ff 10 80       	push   $0x8010ff60
80100e51:	e8 da 39 00 00       	call   80104830 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e56:	89 d8                	mov    %ebx,%eax
      return f;
80100e58:	83 c4 10             	add    $0x10,%esp
}
80100e5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e5e:	c9                   	leave  
80100e5f:	c3                   	ret    
  release(&ftable.lock);
80100e60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e63:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e65:	68 60 ff 10 80       	push   $0x8010ff60
80100e6a:	e8 c1 39 00 00       	call   80104830 <release>
}
80100e6f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e71:	83 c4 10             	add    $0x10,%esp
}
80100e74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e77:	c9                   	leave  
80100e78:	c3                   	ret    
80100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e80 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	53                   	push   %ebx
80100e84:	83 ec 10             	sub    $0x10,%esp
80100e87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e8a:	68 60 ff 10 80       	push   $0x8010ff60
80100e8f:	e8 fc 39 00 00       	call   80104890 <acquire>
  if(f->ref < 1)
80100e94:	8b 43 04             	mov    0x4(%ebx),%eax
80100e97:	83 c4 10             	add    $0x10,%esp
80100e9a:	85 c0                	test   %eax,%eax
80100e9c:	7e 1a                	jle    80100eb8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e9e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ea1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ea4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ea7:	68 60 ff 10 80       	push   $0x8010ff60
80100eac:	e8 7f 39 00 00       	call   80104830 <release>
  return f;
}
80100eb1:	89 d8                	mov    %ebx,%eax
80100eb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eb6:	c9                   	leave  
80100eb7:	c3                   	ret    
    panic("filedup");
80100eb8:	83 ec 0c             	sub    $0xc,%esp
80100ebb:	68 74 80 10 80       	push   $0x80108074
80100ec0:	e8 bb f4 ff ff       	call   80100380 <panic>
80100ec5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ed0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ed0:	55                   	push   %ebp
80100ed1:	89 e5                	mov    %esp,%ebp
80100ed3:	57                   	push   %edi
80100ed4:	56                   	push   %esi
80100ed5:	53                   	push   %ebx
80100ed6:	83 ec 28             	sub    $0x28,%esp
80100ed9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100edc:	68 60 ff 10 80       	push   $0x8010ff60
80100ee1:	e8 aa 39 00 00       	call   80104890 <acquire>
  if(f->ref < 1)
80100ee6:	8b 53 04             	mov    0x4(%ebx),%edx
80100ee9:	83 c4 10             	add    $0x10,%esp
80100eec:	85 d2                	test   %edx,%edx
80100eee:	0f 8e a5 00 00 00    	jle    80100f99 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100ef4:	83 ea 01             	sub    $0x1,%edx
80100ef7:	89 53 04             	mov    %edx,0x4(%ebx)
80100efa:	75 44                	jne    80100f40 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100efc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f00:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f03:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f05:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f0b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f0e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f11:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f14:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80100f19:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f1c:	e8 0f 39 00 00       	call   80104830 <release>

  if(ff.type == FD_PIPE)
80100f21:	83 c4 10             	add    $0x10,%esp
80100f24:	83 ff 01             	cmp    $0x1,%edi
80100f27:	74 57                	je     80100f80 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f29:	83 ff 02             	cmp    $0x2,%edi
80100f2c:	74 2a                	je     80100f58 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f31:	5b                   	pop    %ebx
80100f32:	5e                   	pop    %esi
80100f33:	5f                   	pop    %edi
80100f34:	5d                   	pop    %ebp
80100f35:	c3                   	ret    
80100f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f3d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f40:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100f47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f4a:	5b                   	pop    %ebx
80100f4b:	5e                   	pop    %esi
80100f4c:	5f                   	pop    %edi
80100f4d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f4e:	e9 dd 38 00 00       	jmp    80104830 <release>
80100f53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f57:	90                   	nop
    begin_op();
80100f58:	e8 e3 1d 00 00       	call   80102d40 <begin_op>
    iput(ff.ip);
80100f5d:	83 ec 0c             	sub    $0xc,%esp
80100f60:	ff 75 e0             	push   -0x20(%ebp)
80100f63:	e8 28 09 00 00       	call   80101890 <iput>
    end_op();
80100f68:	83 c4 10             	add    $0x10,%esp
}
80100f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6e:	5b                   	pop    %ebx
80100f6f:	5e                   	pop    %esi
80100f70:	5f                   	pop    %edi
80100f71:	5d                   	pop    %ebp
    end_op();
80100f72:	e9 39 1e 00 00       	jmp    80102db0 <end_op>
80100f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f7e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100f80:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f84:	83 ec 08             	sub    $0x8,%esp
80100f87:	53                   	push   %ebx
80100f88:	56                   	push   %esi
80100f89:	e8 82 25 00 00       	call   80103510 <pipeclose>
80100f8e:	83 c4 10             	add    $0x10,%esp
}
80100f91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f94:	5b                   	pop    %ebx
80100f95:	5e                   	pop    %esi
80100f96:	5f                   	pop    %edi
80100f97:	5d                   	pop    %ebp
80100f98:	c3                   	ret    
    panic("fileclose");
80100f99:	83 ec 0c             	sub    $0xc,%esp
80100f9c:	68 7c 80 10 80       	push   $0x8010807c
80100fa1:	e8 da f3 ff ff       	call   80100380 <panic>
80100fa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fad:	8d 76 00             	lea    0x0(%esi),%esi

80100fb0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	53                   	push   %ebx
80100fb4:	83 ec 04             	sub    $0x4,%esp
80100fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fba:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fbd:	75 31                	jne    80100ff0 <filestat+0x40>
    ilock(f->ip);
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	ff 73 10             	push   0x10(%ebx)
80100fc5:	e8 96 07 00 00       	call   80101760 <ilock>
    stati(f->ip, st);
80100fca:	58                   	pop    %eax
80100fcb:	5a                   	pop    %edx
80100fcc:	ff 75 0c             	push   0xc(%ebp)
80100fcf:	ff 73 10             	push   0x10(%ebx)
80100fd2:	e8 69 0a 00 00       	call   80101a40 <stati>
    iunlock(f->ip);
80100fd7:	59                   	pop    %ecx
80100fd8:	ff 73 10             	push   0x10(%ebx)
80100fdb:	e8 60 08 00 00       	call   80101840 <iunlock>
    return 0;
  }
  return -1;
}
80100fe0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80100fe3:	83 c4 10             	add    $0x10,%esp
80100fe6:	31 c0                	xor    %eax,%eax
}
80100fe8:	c9                   	leave  
80100fe9:	c3                   	ret    
80100fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ff0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80100ff3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ff8:	c9                   	leave  
80100ff9:	c3                   	ret    
80100ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101000 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 0c             	sub    $0xc,%esp
80101009:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010100c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010100f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101012:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101016:	74 60                	je     80101078 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101018:	8b 03                	mov    (%ebx),%eax
8010101a:	83 f8 01             	cmp    $0x1,%eax
8010101d:	74 41                	je     80101060 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101f:	83 f8 02             	cmp    $0x2,%eax
80101022:	75 5b                	jne    8010107f <fileread+0x7f>
    ilock(f->ip);
80101024:	83 ec 0c             	sub    $0xc,%esp
80101027:	ff 73 10             	push   0x10(%ebx)
8010102a:	e8 31 07 00 00       	call   80101760 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010102f:	57                   	push   %edi
80101030:	ff 73 14             	push   0x14(%ebx)
80101033:	56                   	push   %esi
80101034:	ff 73 10             	push   0x10(%ebx)
80101037:	e8 34 0a 00 00       	call   80101a70 <readi>
8010103c:	83 c4 20             	add    $0x20,%esp
8010103f:	89 c6                	mov    %eax,%esi
80101041:	85 c0                	test   %eax,%eax
80101043:	7e 03                	jle    80101048 <fileread+0x48>
      f->off += r;
80101045:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101048:	83 ec 0c             	sub    $0xc,%esp
8010104b:	ff 73 10             	push   0x10(%ebx)
8010104e:	e8 ed 07 00 00       	call   80101840 <iunlock>
    return r;
80101053:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101056:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101059:	89 f0                	mov    %esi,%eax
8010105b:	5b                   	pop    %ebx
8010105c:	5e                   	pop    %esi
8010105d:	5f                   	pop    %edi
8010105e:	5d                   	pop    %ebp
8010105f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101060:	8b 43 0c             	mov    0xc(%ebx),%eax
80101063:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101066:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101069:	5b                   	pop    %ebx
8010106a:	5e                   	pop    %esi
8010106b:	5f                   	pop    %edi
8010106c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010106d:	e9 3e 26 00 00       	jmp    801036b0 <piperead>
80101072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101078:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010107d:	eb d7                	jmp    80101056 <fileread+0x56>
  panic("fileread");
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	68 86 80 10 80       	push   $0x80108086
80101087:	e8 f4 f2 ff ff       	call   80100380 <panic>
8010108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101090 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101090:	55                   	push   %ebp
80101091:	89 e5                	mov    %esp,%ebp
80101093:	57                   	push   %edi
80101094:	56                   	push   %esi
80101095:	53                   	push   %ebx
80101096:	83 ec 1c             	sub    $0x1c,%esp
80101099:	8b 45 0c             	mov    0xc(%ebp),%eax
8010109c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010109f:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010a2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010a5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801010a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010ac:	0f 84 bd 00 00 00    	je     8010116f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801010b2:	8b 03                	mov    (%ebx),%eax
801010b4:	83 f8 01             	cmp    $0x1,%eax
801010b7:	0f 84 bf 00 00 00    	je     8010117c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010bd:	83 f8 02             	cmp    $0x2,%eax
801010c0:	0f 85 c8 00 00 00    	jne    8010118e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010c9:	31 f6                	xor    %esi,%esi
    while(i < n){
801010cb:	85 c0                	test   %eax,%eax
801010cd:	7f 30                	jg     801010ff <filewrite+0x6f>
801010cf:	e9 94 00 00 00       	jmp    80101168 <filewrite+0xd8>
801010d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010d8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801010db:	83 ec 0c             	sub    $0xc,%esp
801010de:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
801010e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010e4:	e8 57 07 00 00       	call   80101840 <iunlock>
      end_op();
801010e9:	e8 c2 1c 00 00       	call   80102db0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801010ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f1:	83 c4 10             	add    $0x10,%esp
801010f4:	39 c7                	cmp    %eax,%edi
801010f6:	75 5c                	jne    80101154 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801010f8:	01 fe                	add    %edi,%esi
    while(i < n){
801010fa:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801010fd:	7e 69                	jle    80101168 <filewrite+0xd8>
      int n1 = n - i;
801010ff:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101102:	b8 00 06 00 00       	mov    $0x600,%eax
80101107:	29 f7                	sub    %esi,%edi
80101109:	39 c7                	cmp    %eax,%edi
8010110b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010110e:	e8 2d 1c 00 00       	call   80102d40 <begin_op>
      ilock(f->ip);
80101113:	83 ec 0c             	sub    $0xc,%esp
80101116:	ff 73 10             	push   0x10(%ebx)
80101119:	e8 42 06 00 00       	call   80101760 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010111e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101121:	57                   	push   %edi
80101122:	ff 73 14             	push   0x14(%ebx)
80101125:	01 f0                	add    %esi,%eax
80101127:	50                   	push   %eax
80101128:	ff 73 10             	push   0x10(%ebx)
8010112b:	e8 40 0a 00 00       	call   80101b70 <writei>
80101130:	83 c4 20             	add    $0x20,%esp
80101133:	85 c0                	test   %eax,%eax
80101135:	7f a1                	jg     801010d8 <filewrite+0x48>
      iunlock(f->ip);
80101137:	83 ec 0c             	sub    $0xc,%esp
8010113a:	ff 73 10             	push   0x10(%ebx)
8010113d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101140:	e8 fb 06 00 00       	call   80101840 <iunlock>
      end_op();
80101145:	e8 66 1c 00 00       	call   80102db0 <end_op>
      if(r < 0)
8010114a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010114d:	83 c4 10             	add    $0x10,%esp
80101150:	85 c0                	test   %eax,%eax
80101152:	75 1b                	jne    8010116f <filewrite+0xdf>
        panic("short filewrite");
80101154:	83 ec 0c             	sub    $0xc,%esp
80101157:	68 8f 80 10 80       	push   $0x8010808f
8010115c:	e8 1f f2 ff ff       	call   80100380 <panic>
80101161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101168:	89 f0                	mov    %esi,%eax
8010116a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010116d:	74 05                	je     80101174 <filewrite+0xe4>
8010116f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101174:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101177:	5b                   	pop    %ebx
80101178:	5e                   	pop    %esi
80101179:	5f                   	pop    %edi
8010117a:	5d                   	pop    %ebp
8010117b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010117c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010117f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101182:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101185:	5b                   	pop    %ebx
80101186:	5e                   	pop    %esi
80101187:	5f                   	pop    %edi
80101188:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101189:	e9 22 24 00 00       	jmp    801035b0 <pipewrite>
  panic("filewrite");
8010118e:	83 ec 0c             	sub    $0xc,%esp
80101191:	68 95 80 10 80       	push   $0x80108095
80101196:	e8 e5 f1 ff ff       	call   80100380 <panic>
8010119b:	66 90                	xchg   %ax,%ax
8010119d:	66 90                	xchg   %ax,%ax
8010119f:	90                   	nop

801011a0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801011a0:	55                   	push   %ebp
801011a1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801011a3:	89 d0                	mov    %edx,%eax
801011a5:	c1 e8 0c             	shr    $0xc,%eax
801011a8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801011ae:	89 e5                	mov    %esp,%ebp
801011b0:	56                   	push   %esi
801011b1:	53                   	push   %ebx
801011b2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801011b4:	83 ec 08             	sub    $0x8,%esp
801011b7:	50                   	push   %eax
801011b8:	51                   	push   %ecx
801011b9:	e8 12 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011be:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011c0:	c1 fb 03             	sar    $0x3,%ebx
801011c3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801011c6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801011c8:	83 e1 07             	and    $0x7,%ecx
801011cb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801011d0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801011d6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801011d8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801011dd:	85 c1                	test   %eax,%ecx
801011df:	74 23                	je     80101204 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801011e1:	f7 d0                	not    %eax
  log_write(bp);
801011e3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801011e6:	21 c8                	and    %ecx,%eax
801011e8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801011ec:	56                   	push   %esi
801011ed:	e8 2e 1d 00 00       	call   80102f20 <log_write>
  brelse(bp);
801011f2:	89 34 24             	mov    %esi,(%esp)
801011f5:	e8 f6 ef ff ff       	call   801001f0 <brelse>
}
801011fa:	83 c4 10             	add    $0x10,%esp
801011fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101200:	5b                   	pop    %ebx
80101201:	5e                   	pop    %esi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
    panic("freeing free block");
80101204:	83 ec 0c             	sub    $0xc,%esp
80101207:	68 9f 80 10 80       	push   $0x8010809f
8010120c:	e8 6f f1 ff ff       	call   80100380 <panic>
80101211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010121f:	90                   	nop

80101220 <balloc>:
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101229:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010122f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101232:	85 c9                	test   %ecx,%ecx
80101234:	0f 84 87 00 00 00    	je     801012c1 <balloc+0xa1>
8010123a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101241:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101244:	83 ec 08             	sub    $0x8,%esp
80101247:	89 f0                	mov    %esi,%eax
80101249:	c1 f8 0c             	sar    $0xc,%eax
8010124c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101252:	50                   	push   %eax
80101253:	ff 75 d8             	push   -0x28(%ebp)
80101256:	e8 75 ee ff ff       	call   801000d0 <bread>
8010125b:	83 c4 10             	add    $0x10,%esp
8010125e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101261:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101266:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101269:	31 c0                	xor    %eax,%eax
8010126b:	eb 2f                	jmp    8010129c <balloc+0x7c>
8010126d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101270:	89 c1                	mov    %eax,%ecx
80101272:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101277:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010127a:	83 e1 07             	and    $0x7,%ecx
8010127d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010127f:	89 c1                	mov    %eax,%ecx
80101281:	c1 f9 03             	sar    $0x3,%ecx
80101284:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101289:	89 fa                	mov    %edi,%edx
8010128b:	85 df                	test   %ebx,%edi
8010128d:	74 41                	je     801012d0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010128f:	83 c0 01             	add    $0x1,%eax
80101292:	83 c6 01             	add    $0x1,%esi
80101295:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010129a:	74 05                	je     801012a1 <balloc+0x81>
8010129c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010129f:	77 cf                	ja     80101270 <balloc+0x50>
    brelse(bp);
801012a1:	83 ec 0c             	sub    $0xc,%esp
801012a4:	ff 75 e4             	push   -0x1c(%ebp)
801012a7:	e8 44 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012ac:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012b3:	83 c4 10             	add    $0x10,%esp
801012b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012b9:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
801012bf:	77 80                	ja     80101241 <balloc+0x21>
  panic("balloc: out of blocks");
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	68 b2 80 10 80       	push   $0x801080b2
801012c9:	e8 b2 f0 ff ff       	call   80100380 <panic>
801012ce:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801012d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012d3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012d6:	09 da                	or     %ebx,%edx
801012d8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012dc:	57                   	push   %edi
801012dd:	e8 3e 1c 00 00       	call   80102f20 <log_write>
        brelse(bp);
801012e2:	89 3c 24             	mov    %edi,(%esp)
801012e5:	e8 06 ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801012ea:	58                   	pop    %eax
801012eb:	5a                   	pop    %edx
801012ec:	56                   	push   %esi
801012ed:	ff 75 d8             	push   -0x28(%ebp)
801012f0:	e8 db ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012f5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801012f8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012fa:	8d 40 5c             	lea    0x5c(%eax),%eax
801012fd:	68 00 02 00 00       	push   $0x200
80101302:	6a 00                	push   $0x0
80101304:	50                   	push   %eax
80101305:	e8 46 36 00 00       	call   80104950 <memset>
  log_write(bp);
8010130a:	89 1c 24             	mov    %ebx,(%esp)
8010130d:	e8 0e 1c 00 00       	call   80102f20 <log_write>
  brelse(bp);
80101312:	89 1c 24             	mov    %ebx,(%esp)
80101315:	e8 d6 ee ff ff       	call   801001f0 <brelse>
}
8010131a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131d:	89 f0                	mov    %esi,%eax
8010131f:	5b                   	pop    %ebx
80101320:	5e                   	pop    %esi
80101321:	5f                   	pop    %edi
80101322:	5d                   	pop    %ebp
80101323:	c3                   	ret    
80101324:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010132b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010132f:	90                   	nop

80101330 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	57                   	push   %edi
80101334:	89 c7                	mov    %eax,%edi
80101336:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101337:	31 f6                	xor    %esi,%esi
{
80101339:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010133a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010133f:	83 ec 28             	sub    $0x28,%esp
80101342:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101345:	68 60 09 11 80       	push   $0x80110960
8010134a:	e8 41 35 00 00       	call   80104890 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010134f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101352:	83 c4 10             	add    $0x10,%esp
80101355:	eb 1b                	jmp    80101372 <iget+0x42>
80101357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010135e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101360:	39 3b                	cmp    %edi,(%ebx)
80101362:	74 6c                	je     801013d0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101364:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010136a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101370:	73 26                	jae    80101398 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101372:	8b 43 08             	mov    0x8(%ebx),%eax
80101375:	85 c0                	test   %eax,%eax
80101377:	7f e7                	jg     80101360 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101379:	85 f6                	test   %esi,%esi
8010137b:	75 e7                	jne    80101364 <iget+0x34>
8010137d:	85 c0                	test   %eax,%eax
8010137f:	75 76                	jne    801013f7 <iget+0xc7>
80101381:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101383:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101389:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010138f:	72 e1                	jb     80101372 <iget+0x42>
80101391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101398:	85 f6                	test   %esi,%esi
8010139a:	74 79                	je     80101415 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010139c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010139f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013a1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013a4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013ab:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013b2:	68 60 09 11 80       	push   $0x80110960
801013b7:	e8 74 34 00 00       	call   80104830 <release>

  return ip;
801013bc:	83 c4 10             	add    $0x10,%esp
}
801013bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013c2:	89 f0                	mov    %esi,%eax
801013c4:	5b                   	pop    %ebx
801013c5:	5e                   	pop    %esi
801013c6:	5f                   	pop    %edi
801013c7:	5d                   	pop    %ebp
801013c8:	c3                   	ret    
801013c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013d0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013d3:	75 8f                	jne    80101364 <iget+0x34>
      release(&icache.lock);
801013d5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801013d8:	83 c0 01             	add    $0x1,%eax
      return ip;
801013db:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801013dd:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
801013e2:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801013e5:	e8 46 34 00 00       	call   80104830 <release>
      return ip;
801013ea:	83 c4 10             	add    $0x10,%esp
}
801013ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f0:	89 f0                	mov    %esi,%eax
801013f2:	5b                   	pop    %ebx
801013f3:	5e                   	pop    %esi
801013f4:	5f                   	pop    %edi
801013f5:	5d                   	pop    %ebp
801013f6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013f7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013fd:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101403:	73 10                	jae    80101415 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101405:	8b 43 08             	mov    0x8(%ebx),%eax
80101408:	85 c0                	test   %eax,%eax
8010140a:	0f 8f 50 ff ff ff    	jg     80101360 <iget+0x30>
80101410:	e9 68 ff ff ff       	jmp    8010137d <iget+0x4d>
    panic("iget: no inodes");
80101415:	83 ec 0c             	sub    $0xc,%esp
80101418:	68 c8 80 10 80       	push   $0x801080c8
8010141d:	e8 5e ef ff ff       	call   80100380 <panic>
80101422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101430 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	57                   	push   %edi
80101434:	56                   	push   %esi
80101435:	89 c6                	mov    %eax,%esi
80101437:	53                   	push   %ebx
80101438:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010143b:	83 fa 0b             	cmp    $0xb,%edx
8010143e:	0f 86 8c 00 00 00    	jbe    801014d0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101444:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101447:	83 fb 7f             	cmp    $0x7f,%ebx
8010144a:	0f 87 a2 00 00 00    	ja     801014f2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101450:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101456:	85 c0                	test   %eax,%eax
80101458:	74 5e                	je     801014b8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010145a:	83 ec 08             	sub    $0x8,%esp
8010145d:	50                   	push   %eax
8010145e:	ff 36                	push   (%esi)
80101460:	e8 6b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101465:	83 c4 10             	add    $0x10,%esp
80101468:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010146c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010146e:	8b 3b                	mov    (%ebx),%edi
80101470:	85 ff                	test   %edi,%edi
80101472:	74 1c                	je     80101490 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101474:	83 ec 0c             	sub    $0xc,%esp
80101477:	52                   	push   %edx
80101478:	e8 73 ed ff ff       	call   801001f0 <brelse>
8010147d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101480:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101483:	89 f8                	mov    %edi,%eax
80101485:	5b                   	pop    %ebx
80101486:	5e                   	pop    %esi
80101487:	5f                   	pop    %edi
80101488:	5d                   	pop    %ebp
80101489:	c3                   	ret    
8010148a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101490:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101493:	8b 06                	mov    (%esi),%eax
80101495:	e8 86 fd ff ff       	call   80101220 <balloc>
      log_write(bp);
8010149a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010149d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014a0:	89 03                	mov    %eax,(%ebx)
801014a2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014a4:	52                   	push   %edx
801014a5:	e8 76 1a 00 00       	call   80102f20 <log_write>
801014aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014ad:	83 c4 10             	add    $0x10,%esp
801014b0:	eb c2                	jmp    80101474 <bmap+0x44>
801014b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014b8:	8b 06                	mov    (%esi),%eax
801014ba:	e8 61 fd ff ff       	call   80101220 <balloc>
801014bf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014c5:	eb 93                	jmp    8010145a <bmap+0x2a>
801014c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ce:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801014d0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014d3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014d7:	85 ff                	test   %edi,%edi
801014d9:	75 a5                	jne    80101480 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014db:	8b 00                	mov    (%eax),%eax
801014dd:	e8 3e fd ff ff       	call   80101220 <balloc>
801014e2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801014e6:	89 c7                	mov    %eax,%edi
}
801014e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014eb:	5b                   	pop    %ebx
801014ec:	89 f8                	mov    %edi,%eax
801014ee:	5e                   	pop    %esi
801014ef:	5f                   	pop    %edi
801014f0:	5d                   	pop    %ebp
801014f1:	c3                   	ret    
  panic("bmap: out of range");
801014f2:	83 ec 0c             	sub    $0xc,%esp
801014f5:	68 d8 80 10 80       	push   $0x801080d8
801014fa:	e8 81 ee ff ff       	call   80100380 <panic>
801014ff:	90                   	nop

80101500 <readsb>:
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	56                   	push   %esi
80101504:	53                   	push   %ebx
80101505:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101508:	83 ec 08             	sub    $0x8,%esp
8010150b:	6a 01                	push   $0x1
8010150d:	ff 75 08             	push   0x8(%ebp)
80101510:	e8 bb eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101515:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101518:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010151a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010151d:	6a 1c                	push   $0x1c
8010151f:	50                   	push   %eax
80101520:	56                   	push   %esi
80101521:	e8 ca 34 00 00       	call   801049f0 <memmove>
  brelse(bp);
80101526:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101529:	83 c4 10             	add    $0x10,%esp
}
8010152c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010152f:	5b                   	pop    %ebx
80101530:	5e                   	pop    %esi
80101531:	5d                   	pop    %ebp
  brelse(bp);
80101532:	e9 b9 ec ff ff       	jmp    801001f0 <brelse>
80101537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010153e:	66 90                	xchg   %ax,%ax

80101540 <iinit>:
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	53                   	push   %ebx
80101544:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101549:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010154c:	68 eb 80 10 80       	push   $0x801080eb
80101551:	68 60 09 11 80       	push   $0x80110960
80101556:	e8 65 31 00 00       	call   801046c0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010155b:	83 c4 10             	add    $0x10,%esp
8010155e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101560:	83 ec 08             	sub    $0x8,%esp
80101563:	68 f2 80 10 80       	push   $0x801080f2
80101568:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101569:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010156f:	e8 1c 30 00 00       	call   80104590 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101574:	83 c4 10             	add    $0x10,%esp
80101577:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010157d:	75 e1                	jne    80101560 <iinit+0x20>
  bp = bread(dev, 1);
8010157f:	83 ec 08             	sub    $0x8,%esp
80101582:	6a 01                	push   $0x1
80101584:	ff 75 08             	push   0x8(%ebp)
80101587:	e8 44 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010158c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010158f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101591:	8d 40 5c             	lea    0x5c(%eax),%eax
80101594:	6a 1c                	push   $0x1c
80101596:	50                   	push   %eax
80101597:	68 b4 25 11 80       	push   $0x801125b4
8010159c:	e8 4f 34 00 00       	call   801049f0 <memmove>
  brelse(bp);
801015a1:	89 1c 24             	mov    %ebx,(%esp)
801015a4:	e8 47 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015a9:	ff 35 cc 25 11 80    	push   0x801125cc
801015af:	ff 35 c8 25 11 80    	push   0x801125c8
801015b5:	ff 35 c4 25 11 80    	push   0x801125c4
801015bb:	ff 35 c0 25 11 80    	push   0x801125c0
801015c1:	ff 35 bc 25 11 80    	push   0x801125bc
801015c7:	ff 35 b8 25 11 80    	push   0x801125b8
801015cd:	ff 35 b4 25 11 80    	push   0x801125b4
801015d3:	68 58 81 10 80       	push   $0x80108158
801015d8:	e8 c3 f0 ff ff       	call   801006a0 <cprintf>
}
801015dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015e0:	83 c4 30             	add    $0x30,%esp
801015e3:	c9                   	leave  
801015e4:	c3                   	ret    
801015e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015f0 <ialloc>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	57                   	push   %edi
801015f4:	56                   	push   %esi
801015f5:	53                   	push   %ebx
801015f6:	83 ec 1c             	sub    $0x1c,%esp
801015f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801015fc:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101603:	8b 75 08             	mov    0x8(%ebp),%esi
80101606:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101609:	0f 86 91 00 00 00    	jbe    801016a0 <ialloc+0xb0>
8010160f:	bf 01 00 00 00       	mov    $0x1,%edi
80101614:	eb 21                	jmp    80101637 <ialloc+0x47>
80101616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010161d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101620:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101623:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101626:	53                   	push   %ebx
80101627:	e8 c4 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010162c:	83 c4 10             	add    $0x10,%esp
8010162f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101635:	73 69                	jae    801016a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101637:	89 f8                	mov    %edi,%eax
80101639:	83 ec 08             	sub    $0x8,%esp
8010163c:	c1 e8 03             	shr    $0x3,%eax
8010163f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101645:	50                   	push   %eax
80101646:	56                   	push   %esi
80101647:	e8 84 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010164c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010164f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101651:	89 f8                	mov    %edi,%eax
80101653:	83 e0 07             	and    $0x7,%eax
80101656:	c1 e0 06             	shl    $0x6,%eax
80101659:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010165d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101661:	75 bd                	jne    80101620 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101663:	83 ec 04             	sub    $0x4,%esp
80101666:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101669:	6a 40                	push   $0x40
8010166b:	6a 00                	push   $0x0
8010166d:	51                   	push   %ecx
8010166e:	e8 dd 32 00 00       	call   80104950 <memset>
      dip->type = type;
80101673:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101677:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010167a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010167d:	89 1c 24             	mov    %ebx,(%esp)
80101680:	e8 9b 18 00 00       	call   80102f20 <log_write>
      brelse(bp);
80101685:	89 1c 24             	mov    %ebx,(%esp)
80101688:	e8 63 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010168d:	83 c4 10             	add    $0x10,%esp
}
80101690:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101693:	89 fa                	mov    %edi,%edx
}
80101695:	5b                   	pop    %ebx
      return iget(dev, inum);
80101696:	89 f0                	mov    %esi,%eax
}
80101698:	5e                   	pop    %esi
80101699:	5f                   	pop    %edi
8010169a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010169b:	e9 90 fc ff ff       	jmp    80101330 <iget>
  panic("ialloc: no inodes");
801016a0:	83 ec 0c             	sub    $0xc,%esp
801016a3:	68 f8 80 10 80       	push   $0x801080f8
801016a8:	e8 d3 ec ff ff       	call   80100380 <panic>
801016ad:	8d 76 00             	lea    0x0(%esi),%esi

801016b0 <iupdate>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016bb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016be:	83 ec 08             	sub    $0x8,%esp
801016c1:	c1 e8 03             	shr    $0x3,%eax
801016c4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801016ca:	50                   	push   %eax
801016cb:	ff 73 a4             	push   -0x5c(%ebx)
801016ce:	e8 fd e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801016d3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016d7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016da:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016dc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016f0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101703:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101707:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010170a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010170d:	6a 34                	push   $0x34
8010170f:	53                   	push   %ebx
80101710:	50                   	push   %eax
80101711:	e8 da 32 00 00       	call   801049f0 <memmove>
  log_write(bp);
80101716:	89 34 24             	mov    %esi,(%esp)
80101719:	e8 02 18 00 00       	call   80102f20 <log_write>
  brelse(bp);
8010171e:	89 75 08             	mov    %esi,0x8(%ebp)
80101721:	83 c4 10             	add    $0x10,%esp
}
80101724:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101727:	5b                   	pop    %ebx
80101728:	5e                   	pop    %esi
80101729:	5d                   	pop    %ebp
  brelse(bp);
8010172a:	e9 c1 ea ff ff       	jmp    801001f0 <brelse>
8010172f:	90                   	nop

80101730 <idup>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	53                   	push   %ebx
80101734:	83 ec 10             	sub    $0x10,%esp
80101737:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010173a:	68 60 09 11 80       	push   $0x80110960
8010173f:	e8 4c 31 00 00       	call   80104890 <acquire>
  ip->ref++;
80101744:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101748:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010174f:	e8 dc 30 00 00       	call   80104830 <release>
}
80101754:	89 d8                	mov    %ebx,%eax
80101756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101759:	c9                   	leave  
8010175a:	c3                   	ret    
8010175b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010175f:	90                   	nop

80101760 <ilock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	0f 84 b7 00 00 00    	je     80101827 <ilock+0xc7>
80101770:	8b 53 08             	mov    0x8(%ebx),%edx
80101773:	85 d2                	test   %edx,%edx
80101775:	0f 8e ac 00 00 00    	jle    80101827 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010177b:	83 ec 0c             	sub    $0xc,%esp
8010177e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101781:	50                   	push   %eax
80101782:	e8 49 2e 00 00       	call   801045d0 <acquiresleep>
  if(ip->valid == 0){
80101787:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010178a:	83 c4 10             	add    $0x10,%esp
8010178d:	85 c0                	test   %eax,%eax
8010178f:	74 0f                	je     801017a0 <ilock+0x40>
}
80101791:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101794:	5b                   	pop    %ebx
80101795:	5e                   	pop    %esi
80101796:	5d                   	pop    %ebp
80101797:	c3                   	ret    
80101798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010179f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017a0:	8b 43 04             	mov    0x4(%ebx),%eax
801017a3:	83 ec 08             	sub    $0x8,%esp
801017a6:	c1 e8 03             	shr    $0x3,%eax
801017a9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017af:	50                   	push   %eax
801017b0:	ff 33                	push   (%ebx)
801017b2:	e8 19 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017b7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ba:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017bc:	8b 43 04             	mov    0x4(%ebx),%eax
801017bf:	83 e0 07             	and    $0x7,%eax
801017c2:	c1 e0 06             	shl    $0x6,%eax
801017c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017c9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017cc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017f1:	6a 34                	push   $0x34
801017f3:	50                   	push   %eax
801017f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017f7:	50                   	push   %eax
801017f8:	e8 f3 31 00 00       	call   801049f0 <memmove>
    brelse(bp);
801017fd:	89 34 24             	mov    %esi,(%esp)
80101800:	e8 eb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101805:	83 c4 10             	add    $0x10,%esp
80101808:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010180d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101814:	0f 85 77 ff ff ff    	jne    80101791 <ilock+0x31>
      panic("ilock: no type");
8010181a:	83 ec 0c             	sub    $0xc,%esp
8010181d:	68 10 81 10 80       	push   $0x80108110
80101822:	e8 59 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101827:	83 ec 0c             	sub    $0xc,%esp
8010182a:	68 0a 81 10 80       	push   $0x8010810a
8010182f:	e8 4c eb ff ff       	call   80100380 <panic>
80101834:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010183b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010183f:	90                   	nop

80101840 <iunlock>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	56                   	push   %esi
80101844:	53                   	push   %ebx
80101845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101848:	85 db                	test   %ebx,%ebx
8010184a:	74 28                	je     80101874 <iunlock+0x34>
8010184c:	83 ec 0c             	sub    $0xc,%esp
8010184f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101852:	56                   	push   %esi
80101853:	e8 18 2e 00 00       	call   80104670 <holdingsleep>
80101858:	83 c4 10             	add    $0x10,%esp
8010185b:	85 c0                	test   %eax,%eax
8010185d:	74 15                	je     80101874 <iunlock+0x34>
8010185f:	8b 43 08             	mov    0x8(%ebx),%eax
80101862:	85 c0                	test   %eax,%eax
80101864:	7e 0e                	jle    80101874 <iunlock+0x34>
  releasesleep(&ip->lock);
80101866:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101869:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010186c:	5b                   	pop    %ebx
8010186d:	5e                   	pop    %esi
8010186e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010186f:	e9 bc 2d 00 00       	jmp    80104630 <releasesleep>
    panic("iunlock");
80101874:	83 ec 0c             	sub    $0xc,%esp
80101877:	68 1f 81 10 80       	push   $0x8010811f
8010187c:	e8 ff ea ff ff       	call   80100380 <panic>
80101881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010188f:	90                   	nop

80101890 <iput>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	57                   	push   %edi
80101894:	56                   	push   %esi
80101895:	53                   	push   %ebx
80101896:	83 ec 28             	sub    $0x28,%esp
80101899:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010189c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010189f:	57                   	push   %edi
801018a0:	e8 2b 2d 00 00       	call   801045d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018a5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018a8:	83 c4 10             	add    $0x10,%esp
801018ab:	85 d2                	test   %edx,%edx
801018ad:	74 07                	je     801018b6 <iput+0x26>
801018af:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018b4:	74 32                	je     801018e8 <iput+0x58>
  releasesleep(&ip->lock);
801018b6:	83 ec 0c             	sub    $0xc,%esp
801018b9:	57                   	push   %edi
801018ba:	e8 71 2d 00 00       	call   80104630 <releasesleep>
  acquire(&icache.lock);
801018bf:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018c6:	e8 c5 2f 00 00       	call   80104890 <acquire>
  ip->ref--;
801018cb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018cf:	83 c4 10             	add    $0x10,%esp
801018d2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801018d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018dc:	5b                   	pop    %ebx
801018dd:	5e                   	pop    %esi
801018de:	5f                   	pop    %edi
801018df:	5d                   	pop    %ebp
  release(&icache.lock);
801018e0:	e9 4b 2f 00 00       	jmp    80104830 <release>
801018e5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018e8:	83 ec 0c             	sub    $0xc,%esp
801018eb:	68 60 09 11 80       	push   $0x80110960
801018f0:	e8 9b 2f 00 00       	call   80104890 <acquire>
    int r = ip->ref;
801018f5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018f8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018ff:	e8 2c 2f 00 00       	call   80104830 <release>
    if(r == 1){
80101904:	83 c4 10             	add    $0x10,%esp
80101907:	83 fe 01             	cmp    $0x1,%esi
8010190a:	75 aa                	jne    801018b6 <iput+0x26>
8010190c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101912:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101915:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101918:	89 cf                	mov    %ecx,%edi
8010191a:	eb 0b                	jmp    80101927 <iput+0x97>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101920:	83 c6 04             	add    $0x4,%esi
80101923:	39 fe                	cmp    %edi,%esi
80101925:	74 19                	je     80101940 <iput+0xb0>
    if(ip->addrs[i]){
80101927:	8b 16                	mov    (%esi),%edx
80101929:	85 d2                	test   %edx,%edx
8010192b:	74 f3                	je     80101920 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010192d:	8b 03                	mov    (%ebx),%eax
8010192f:	e8 6c f8 ff ff       	call   801011a0 <bfree>
      ip->addrs[i] = 0;
80101934:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010193a:	eb e4                	jmp    80101920 <iput+0x90>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101940:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101946:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101949:	85 c0                	test   %eax,%eax
8010194b:	75 2d                	jne    8010197a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010194d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101950:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101957:	53                   	push   %ebx
80101958:	e8 53 fd ff ff       	call   801016b0 <iupdate>
      ip->type = 0;
8010195d:	31 c0                	xor    %eax,%eax
8010195f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101963:	89 1c 24             	mov    %ebx,(%esp)
80101966:	e8 45 fd ff ff       	call   801016b0 <iupdate>
      ip->valid = 0;
8010196b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101972:	83 c4 10             	add    $0x10,%esp
80101975:	e9 3c ff ff ff       	jmp    801018b6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010197a:	83 ec 08             	sub    $0x8,%esp
8010197d:	50                   	push   %eax
8010197e:	ff 33                	push   (%ebx)
80101980:	e8 4b e7 ff ff       	call   801000d0 <bread>
80101985:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101988:	83 c4 10             	add    $0x10,%esp
8010198b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101991:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101994:	8d 70 5c             	lea    0x5c(%eax),%esi
80101997:	89 cf                	mov    %ecx,%edi
80101999:	eb 0c                	jmp    801019a7 <iput+0x117>
8010199b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010199f:	90                   	nop
801019a0:	83 c6 04             	add    $0x4,%esi
801019a3:	39 f7                	cmp    %esi,%edi
801019a5:	74 0f                	je     801019b6 <iput+0x126>
      if(a[j])
801019a7:	8b 16                	mov    (%esi),%edx
801019a9:	85 d2                	test   %edx,%edx
801019ab:	74 f3                	je     801019a0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019ad:	8b 03                	mov    (%ebx),%eax
801019af:	e8 ec f7 ff ff       	call   801011a0 <bfree>
801019b4:	eb ea                	jmp    801019a0 <iput+0x110>
    brelse(bp);
801019b6:	83 ec 0c             	sub    $0xc,%esp
801019b9:	ff 75 e4             	push   -0x1c(%ebp)
801019bc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019bf:	e8 2c e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019c4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019ca:	8b 03                	mov    (%ebx),%eax
801019cc:	e8 cf f7 ff ff       	call   801011a0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019d1:	83 c4 10             	add    $0x10,%esp
801019d4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019db:	00 00 00 
801019de:	e9 6a ff ff ff       	jmp    8010194d <iput+0xbd>
801019e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801019f0 <iunlockput>:
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	56                   	push   %esi
801019f4:	53                   	push   %ebx
801019f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801019f8:	85 db                	test   %ebx,%ebx
801019fa:	74 34                	je     80101a30 <iunlockput+0x40>
801019fc:	83 ec 0c             	sub    $0xc,%esp
801019ff:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a02:	56                   	push   %esi
80101a03:	e8 68 2c 00 00       	call   80104670 <holdingsleep>
80101a08:	83 c4 10             	add    $0x10,%esp
80101a0b:	85 c0                	test   %eax,%eax
80101a0d:	74 21                	je     80101a30 <iunlockput+0x40>
80101a0f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a12:	85 c0                	test   %eax,%eax
80101a14:	7e 1a                	jle    80101a30 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a16:	83 ec 0c             	sub    $0xc,%esp
80101a19:	56                   	push   %esi
80101a1a:	e8 11 2c 00 00       	call   80104630 <releasesleep>
  iput(ip);
80101a1f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a22:	83 c4 10             	add    $0x10,%esp
}
80101a25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a28:	5b                   	pop    %ebx
80101a29:	5e                   	pop    %esi
80101a2a:	5d                   	pop    %ebp
  iput(ip);
80101a2b:	e9 60 fe ff ff       	jmp    80101890 <iput>
    panic("iunlock");
80101a30:	83 ec 0c             	sub    $0xc,%esp
80101a33:	68 1f 81 10 80       	push   $0x8010811f
80101a38:	e8 43 e9 ff ff       	call   80100380 <panic>
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi

80101a40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	8b 55 08             	mov    0x8(%ebp),%edx
80101a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a49:	8b 0a                	mov    (%edx),%ecx
80101a4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a54:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a5b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a63:	8b 52 58             	mov    0x58(%edx),%edx
80101a66:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a69:	5d                   	pop    %ebp
80101a6a:	c3                   	ret    
80101a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a6f:	90                   	nop

80101a70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a7c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a82:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a85:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a88:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a8d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a90:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 a7 00 00 00    	je     80101b40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	8b 40 58             	mov    0x58(%eax),%eax
80101a9f:	39 c6                	cmp    %eax,%esi
80101aa1:	0f 87 ba 00 00 00    	ja     80101b61 <readi+0xf1>
80101aa7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101aaa:	31 c9                	xor    %ecx,%ecx
80101aac:	89 da                	mov    %ebx,%edx
80101aae:	01 f2                	add    %esi,%edx
80101ab0:	0f 92 c1             	setb   %cl
80101ab3:	89 cf                	mov    %ecx,%edi
80101ab5:	0f 82 a6 00 00 00    	jb     80101b61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101abb:	89 c1                	mov    %eax,%ecx
80101abd:	29 f1                	sub    %esi,%ecx
80101abf:	39 d0                	cmp    %edx,%eax
80101ac1:	0f 43 cb             	cmovae %ebx,%ecx
80101ac4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac7:	85 c9                	test   %ecx,%ecx
80101ac9:	74 67                	je     80101b32 <readi+0xc2>
80101acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101acf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 d8                	mov    %ebx,%eax
80101ada:	e8 51 f9 ff ff       	call   80101430 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 33                	push   (%ebx)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101aed:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101af4:	89 f0                	mov    %esi,%eax
80101af6:	25 ff 01 00 00       	and    $0x1ff,%eax
80101afb:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101afd:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b00:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b02:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b06:	39 d9                	cmp    %ebx,%ecx
80101b08:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b0b:	83 c4 0c             	add    $0xc,%esp
80101b0e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b0f:	01 df                	add    %ebx,%edi
80101b11:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b13:	50                   	push   %eax
80101b14:	ff 75 e0             	push   -0x20(%ebp)
80101b17:	e8 d4 2e 00 00       	call   801049f0 <memmove>
    brelse(bp);
80101b1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b1f:	89 14 24             	mov    %edx,(%esp)
80101b22:	e8 c9 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b2a:	83 c4 10             	add    $0x10,%esp
80101b2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b30:	77 9e                	ja     80101ad0 <readi+0x60>
  }
  return n;
80101b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b38:	5b                   	pop    %ebx
80101b39:	5e                   	pop    %esi
80101b3a:	5f                   	pop    %edi
80101b3b:	5d                   	pop    %ebp
80101b3c:	c3                   	ret    
80101b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 17                	ja     80101b61 <readi+0xf1>
80101b4a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 0c                	je     80101b61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b5f:	ff e0                	jmp    *%eax
      return -1;
80101b61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b66:	eb cd                	jmp    80101b35 <readi+0xc5>
80101b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b6f:	90                   	nop

80101b70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b7f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b93:	0f 84 b7 00 00 00    	je     80101c50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b9c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b9f:	0f 87 e7 00 00 00    	ja     80101c8c <writei+0x11c>
80101ba5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ba8:	31 d2                	xor    %edx,%edx
80101baa:	89 f8                	mov    %edi,%eax
80101bac:	01 f0                	add    %esi,%eax
80101bae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bb1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bb6:	0f 87 d0 00 00 00    	ja     80101c8c <writei+0x11c>
80101bbc:	85 d2                	test   %edx,%edx
80101bbe:	0f 85 c8 00 00 00    	jne    80101c8c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101bcb:	85 ff                	test   %edi,%edi
80101bcd:	74 72                	je     80101c41 <writei+0xd1>
80101bcf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bd3:	89 f2                	mov    %esi,%edx
80101bd5:	c1 ea 09             	shr    $0x9,%edx
80101bd8:	89 f8                	mov    %edi,%eax
80101bda:	e8 51 f8 ff ff       	call   80101430 <bmap>
80101bdf:	83 ec 08             	sub    $0x8,%esp
80101be2:	50                   	push   %eax
80101be3:	ff 37                	push   (%edi)
80101be5:	e8 e6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bea:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bef:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101bf2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bf7:	89 f0                	mov    %esi,%eax
80101bf9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bfe:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c00:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c04:	39 d9                	cmp    %ebx,%ecx
80101c06:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c09:	83 c4 0c             	add    $0xc,%esp
80101c0c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c0d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c0f:	ff 75 dc             	push   -0x24(%ebp)
80101c12:	50                   	push   %eax
80101c13:	e8 d8 2d 00 00       	call   801049f0 <memmove>
    log_write(bp);
80101c18:	89 3c 24             	mov    %edi,(%esp)
80101c1b:	e8 00 13 00 00       	call   80102f20 <log_write>
    brelse(bp);
80101c20:	89 3c 24             	mov    %edi,(%esp)
80101c23:	e8 c8 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c2b:	83 c4 10             	add    $0x10,%esp
80101c2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c31:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c37:	77 97                	ja     80101bd0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c3f:	77 37                	ja     80101c78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c47:	5b                   	pop    %ebx
80101c48:	5e                   	pop    %esi
80101c49:	5f                   	pop    %edi
80101c4a:	5d                   	pop    %ebp
80101c4b:	c3                   	ret    
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c54:	66 83 f8 09          	cmp    $0x9,%ax
80101c58:	77 32                	ja     80101c8c <writei+0x11c>
80101c5a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101c61:	85 c0                	test   %eax,%eax
80101c63:	74 27                	je     80101c8c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c65:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6b:	5b                   	pop    %ebx
80101c6c:	5e                   	pop    %esi
80101c6d:	5f                   	pop    %edi
80101c6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c6f:	ff e0                	jmp    *%eax
80101c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c81:	50                   	push   %eax
80101c82:	e8 29 fa ff ff       	call   801016b0 <iupdate>
80101c87:	83 c4 10             	add    $0x10,%esp
80101c8a:	eb b5                	jmp    80101c41 <writei+0xd1>
      return -1;
80101c8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c91:	eb b1                	jmp    80101c44 <writei+0xd4>
80101c93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ca0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ca6:	6a 0e                	push   $0xe
80101ca8:	ff 75 0c             	push   0xc(%ebp)
80101cab:	ff 75 08             	push   0x8(%ebp)
80101cae:	e8 ad 2d 00 00       	call   80104a60 <strncmp>
}
80101cb3:	c9                   	leave  
80101cb4:	c3                   	ret    
80101cb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	57                   	push   %edi
80101cc4:	56                   	push   %esi
80101cc5:	53                   	push   %ebx
80101cc6:	83 ec 1c             	sub    $0x1c,%esp
80101cc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101ccc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cd1:	0f 85 85 00 00 00    	jne    80101d5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cda:	31 ff                	xor    %edi,%edi
80101cdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cdf:	85 d2                	test   %edx,%edx
80101ce1:	74 3e                	je     80101d21 <dirlookup+0x61>
80101ce3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ce7:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ce8:	6a 10                	push   $0x10
80101cea:	57                   	push   %edi
80101ceb:	56                   	push   %esi
80101cec:	53                   	push   %ebx
80101ced:	e8 7e fd ff ff       	call   80101a70 <readi>
80101cf2:	83 c4 10             	add    $0x10,%esp
80101cf5:	83 f8 10             	cmp    $0x10,%eax
80101cf8:	75 55                	jne    80101d4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101cfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cff:	74 18                	je     80101d19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d01:	83 ec 04             	sub    $0x4,%esp
80101d04:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d07:	6a 0e                	push   $0xe
80101d09:	50                   	push   %eax
80101d0a:	ff 75 0c             	push   0xc(%ebp)
80101d0d:	e8 4e 2d 00 00       	call   80104a60 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	85 c0                	test   %eax,%eax
80101d17:	74 17                	je     80101d30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d19:	83 c7 10             	add    $0x10,%edi
80101d1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d1f:	72 c7                	jb     80101ce8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d24:	31 c0                	xor    %eax,%eax
}
80101d26:	5b                   	pop    %ebx
80101d27:	5e                   	pop    %esi
80101d28:	5f                   	pop    %edi
80101d29:	5d                   	pop    %ebp
80101d2a:	c3                   	ret    
80101d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d2f:	90                   	nop
      if(poff)
80101d30:	8b 45 10             	mov    0x10(%ebp),%eax
80101d33:	85 c0                	test   %eax,%eax
80101d35:	74 05                	je     80101d3c <dirlookup+0x7c>
        *poff = off;
80101d37:	8b 45 10             	mov    0x10(%ebp),%eax
80101d3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d40:	8b 03                	mov    (%ebx),%eax
80101d42:	e8 e9 f5 ff ff       	call   80101330 <iget>
}
80101d47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d4a:	5b                   	pop    %ebx
80101d4b:	5e                   	pop    %esi
80101d4c:	5f                   	pop    %edi
80101d4d:	5d                   	pop    %ebp
80101d4e:	c3                   	ret    
      panic("dirlookup read");
80101d4f:	83 ec 0c             	sub    $0xc,%esp
80101d52:	68 39 81 10 80       	push   $0x80108139
80101d57:	e8 24 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d5c:	83 ec 0c             	sub    $0xc,%esp
80101d5f:	68 27 81 10 80       	push   $0x80108127
80101d64:	e8 17 e6 ff ff       	call   80100380 <panic>
80101d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	57                   	push   %edi
80101d74:	56                   	push   %esi
80101d75:	53                   	push   %ebx
80101d76:	89 c3                	mov    %eax,%ebx
80101d78:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d7b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d7e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d81:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101d84:	0f 84 64 01 00 00    	je     80101eee <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d8a:	e8 61 1c 00 00       	call   801039f0 <myproc>
  acquire(&icache.lock);
80101d8f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d92:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d95:	68 60 09 11 80       	push   $0x80110960
80101d9a:	e8 f1 2a 00 00       	call   80104890 <acquire>
  ip->ref++;
80101d9f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101da3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101daa:	e8 81 2a 00 00       	call   80104830 <release>
80101daf:	83 c4 10             	add    $0x10,%esp
80101db2:	eb 07                	jmp    80101dbb <namex+0x4b>
80101db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101db8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101dbb:	0f b6 03             	movzbl (%ebx),%eax
80101dbe:	3c 2f                	cmp    $0x2f,%al
80101dc0:	74 f6                	je     80101db8 <namex+0x48>
  if(*path == 0)
80101dc2:	84 c0                	test   %al,%al
80101dc4:	0f 84 06 01 00 00    	je     80101ed0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101dca:	0f b6 03             	movzbl (%ebx),%eax
80101dcd:	84 c0                	test   %al,%al
80101dcf:	0f 84 10 01 00 00    	je     80101ee5 <namex+0x175>
80101dd5:	89 df                	mov    %ebx,%edi
80101dd7:	3c 2f                	cmp    $0x2f,%al
80101dd9:	0f 84 06 01 00 00    	je     80101ee5 <namex+0x175>
80101ddf:	90                   	nop
80101de0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101de4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101de7:	3c 2f                	cmp    $0x2f,%al
80101de9:	74 04                	je     80101def <namex+0x7f>
80101deb:	84 c0                	test   %al,%al
80101ded:	75 f1                	jne    80101de0 <namex+0x70>
  len = path - s;
80101def:	89 f8                	mov    %edi,%eax
80101df1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101df3:	83 f8 0d             	cmp    $0xd,%eax
80101df6:	0f 8e ac 00 00 00    	jle    80101ea8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101dfc:	83 ec 04             	sub    $0x4,%esp
80101dff:	6a 0e                	push   $0xe
80101e01:	53                   	push   %ebx
    path++;
80101e02:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e04:	ff 75 e4             	push   -0x1c(%ebp)
80101e07:	e8 e4 2b 00 00       	call   801049f0 <memmove>
80101e0c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e0f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e12:	75 0c                	jne    80101e20 <namex+0xb0>
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e18:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e1b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e1e:	74 f8                	je     80101e18 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e20:	83 ec 0c             	sub    $0xc,%esp
80101e23:	56                   	push   %esi
80101e24:	e8 37 f9 ff ff       	call   80101760 <ilock>
    if(ip->type != T_DIR){
80101e29:	83 c4 10             	add    $0x10,%esp
80101e2c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e31:	0f 85 cd 00 00 00    	jne    80101f04 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e37:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e3a:	85 c0                	test   %eax,%eax
80101e3c:	74 09                	je     80101e47 <namex+0xd7>
80101e3e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e41:	0f 84 22 01 00 00    	je     80101f69 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e47:	83 ec 04             	sub    $0x4,%esp
80101e4a:	6a 00                	push   $0x0
80101e4c:	ff 75 e4             	push   -0x1c(%ebp)
80101e4f:	56                   	push   %esi
80101e50:	e8 6b fe ff ff       	call   80101cc0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e55:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101e58:	83 c4 10             	add    $0x10,%esp
80101e5b:	89 c7                	mov    %eax,%edi
80101e5d:	85 c0                	test   %eax,%eax
80101e5f:	0f 84 e1 00 00 00    	je     80101f46 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e65:	83 ec 0c             	sub    $0xc,%esp
80101e68:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e6b:	52                   	push   %edx
80101e6c:	e8 ff 27 00 00       	call   80104670 <holdingsleep>
80101e71:	83 c4 10             	add    $0x10,%esp
80101e74:	85 c0                	test   %eax,%eax
80101e76:	0f 84 30 01 00 00    	je     80101fac <namex+0x23c>
80101e7c:	8b 56 08             	mov    0x8(%esi),%edx
80101e7f:	85 d2                	test   %edx,%edx
80101e81:	0f 8e 25 01 00 00    	jle    80101fac <namex+0x23c>
  releasesleep(&ip->lock);
80101e87:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e8a:	83 ec 0c             	sub    $0xc,%esp
80101e8d:	52                   	push   %edx
80101e8e:	e8 9d 27 00 00       	call   80104630 <releasesleep>
  iput(ip);
80101e93:	89 34 24             	mov    %esi,(%esp)
80101e96:	89 fe                	mov    %edi,%esi
80101e98:	e8 f3 f9 ff ff       	call   80101890 <iput>
80101e9d:	83 c4 10             	add    $0x10,%esp
80101ea0:	e9 16 ff ff ff       	jmp    80101dbb <namex+0x4b>
80101ea5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ea8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101eab:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101eae:	83 ec 04             	sub    $0x4,%esp
80101eb1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101eb4:	50                   	push   %eax
80101eb5:	53                   	push   %ebx
    name[len] = 0;
80101eb6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101eb8:	ff 75 e4             	push   -0x1c(%ebp)
80101ebb:	e8 30 2b 00 00       	call   801049f0 <memmove>
    name[len] = 0;
80101ec0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ec3:	83 c4 10             	add    $0x10,%esp
80101ec6:	c6 02 00             	movb   $0x0,(%edx)
80101ec9:	e9 41 ff ff ff       	jmp    80101e0f <namex+0x9f>
80101ece:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ed0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ed3:	85 c0                	test   %eax,%eax
80101ed5:	0f 85 be 00 00 00    	jne    80101f99 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80101edb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ede:	89 f0                	mov    %esi,%eax
80101ee0:	5b                   	pop    %ebx
80101ee1:	5e                   	pop    %esi
80101ee2:	5f                   	pop    %edi
80101ee3:	5d                   	pop    %ebp
80101ee4:	c3                   	ret    
  while(*path != '/' && *path != 0)
80101ee5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ee8:	89 df                	mov    %ebx,%edi
80101eea:	31 c0                	xor    %eax,%eax
80101eec:	eb c0                	jmp    80101eae <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101eee:	ba 01 00 00 00       	mov    $0x1,%edx
80101ef3:	b8 01 00 00 00       	mov    $0x1,%eax
80101ef8:	e8 33 f4 ff ff       	call   80101330 <iget>
80101efd:	89 c6                	mov    %eax,%esi
80101eff:	e9 b7 fe ff ff       	jmp    80101dbb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f04:	83 ec 0c             	sub    $0xc,%esp
80101f07:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f0a:	53                   	push   %ebx
80101f0b:	e8 60 27 00 00       	call   80104670 <holdingsleep>
80101f10:	83 c4 10             	add    $0x10,%esp
80101f13:	85 c0                	test   %eax,%eax
80101f15:	0f 84 91 00 00 00    	je     80101fac <namex+0x23c>
80101f1b:	8b 46 08             	mov    0x8(%esi),%eax
80101f1e:	85 c0                	test   %eax,%eax
80101f20:	0f 8e 86 00 00 00    	jle    80101fac <namex+0x23c>
  releasesleep(&ip->lock);
80101f26:	83 ec 0c             	sub    $0xc,%esp
80101f29:	53                   	push   %ebx
80101f2a:	e8 01 27 00 00       	call   80104630 <releasesleep>
  iput(ip);
80101f2f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f32:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f34:	e8 57 f9 ff ff       	call   80101890 <iput>
      return 0;
80101f39:	83 c4 10             	add    $0x10,%esp
}
80101f3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f3f:	89 f0                	mov    %esi,%eax
80101f41:	5b                   	pop    %ebx
80101f42:	5e                   	pop    %esi
80101f43:	5f                   	pop    %edi
80101f44:	5d                   	pop    %ebp
80101f45:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f4c:	52                   	push   %edx
80101f4d:	e8 1e 27 00 00       	call   80104670 <holdingsleep>
80101f52:	83 c4 10             	add    $0x10,%esp
80101f55:	85 c0                	test   %eax,%eax
80101f57:	74 53                	je     80101fac <namex+0x23c>
80101f59:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f5c:	85 c9                	test   %ecx,%ecx
80101f5e:	7e 4c                	jle    80101fac <namex+0x23c>
  releasesleep(&ip->lock);
80101f60:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f63:	83 ec 0c             	sub    $0xc,%esp
80101f66:	52                   	push   %edx
80101f67:	eb c1                	jmp    80101f2a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f69:	83 ec 0c             	sub    $0xc,%esp
80101f6c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f6f:	53                   	push   %ebx
80101f70:	e8 fb 26 00 00       	call   80104670 <holdingsleep>
80101f75:	83 c4 10             	add    $0x10,%esp
80101f78:	85 c0                	test   %eax,%eax
80101f7a:	74 30                	je     80101fac <namex+0x23c>
80101f7c:	8b 7e 08             	mov    0x8(%esi),%edi
80101f7f:	85 ff                	test   %edi,%edi
80101f81:	7e 29                	jle    80101fac <namex+0x23c>
  releasesleep(&ip->lock);
80101f83:	83 ec 0c             	sub    $0xc,%esp
80101f86:	53                   	push   %ebx
80101f87:	e8 a4 26 00 00       	call   80104630 <releasesleep>
}
80101f8c:	83 c4 10             	add    $0x10,%esp
}
80101f8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f92:	89 f0                	mov    %esi,%eax
80101f94:	5b                   	pop    %ebx
80101f95:	5e                   	pop    %esi
80101f96:	5f                   	pop    %edi
80101f97:	5d                   	pop    %ebp
80101f98:	c3                   	ret    
    iput(ip);
80101f99:	83 ec 0c             	sub    $0xc,%esp
80101f9c:	56                   	push   %esi
    return 0;
80101f9d:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f9f:	e8 ec f8 ff ff       	call   80101890 <iput>
    return 0;
80101fa4:	83 c4 10             	add    $0x10,%esp
80101fa7:	e9 2f ff ff ff       	jmp    80101edb <namex+0x16b>
    panic("iunlock");
80101fac:	83 ec 0c             	sub    $0xc,%esp
80101faf:	68 1f 81 10 80       	push   $0x8010811f
80101fb4:	e8 c7 e3 ff ff       	call   80100380 <panic>
80101fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fc0 <dirlink>:
{
80101fc0:	55                   	push   %ebp
80101fc1:	89 e5                	mov    %esp,%ebp
80101fc3:	57                   	push   %edi
80101fc4:	56                   	push   %esi
80101fc5:	53                   	push   %ebx
80101fc6:	83 ec 20             	sub    $0x20,%esp
80101fc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fcc:	6a 00                	push   $0x0
80101fce:	ff 75 0c             	push   0xc(%ebp)
80101fd1:	53                   	push   %ebx
80101fd2:	e8 e9 fc ff ff       	call   80101cc0 <dirlookup>
80101fd7:	83 c4 10             	add    $0x10,%esp
80101fda:	85 c0                	test   %eax,%eax
80101fdc:	75 67                	jne    80102045 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fde:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fe1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fe4:	85 ff                	test   %edi,%edi
80101fe6:	74 29                	je     80102011 <dirlink+0x51>
80101fe8:	31 ff                	xor    %edi,%edi
80101fea:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fed:	eb 09                	jmp    80101ff8 <dirlink+0x38>
80101fef:	90                   	nop
80101ff0:	83 c7 10             	add    $0x10,%edi
80101ff3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101ff6:	73 19                	jae    80102011 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ff8:	6a 10                	push   $0x10
80101ffa:	57                   	push   %edi
80101ffb:	56                   	push   %esi
80101ffc:	53                   	push   %ebx
80101ffd:	e8 6e fa ff ff       	call   80101a70 <readi>
80102002:	83 c4 10             	add    $0x10,%esp
80102005:	83 f8 10             	cmp    $0x10,%eax
80102008:	75 4e                	jne    80102058 <dirlink+0x98>
    if(de.inum == 0)
8010200a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010200f:	75 df                	jne    80101ff0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102011:	83 ec 04             	sub    $0x4,%esp
80102014:	8d 45 da             	lea    -0x26(%ebp),%eax
80102017:	6a 0e                	push   $0xe
80102019:	ff 75 0c             	push   0xc(%ebp)
8010201c:	50                   	push   %eax
8010201d:	e8 8e 2a 00 00       	call   80104ab0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102022:	6a 10                	push   $0x10
  de.inum = inum;
80102024:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102027:	57                   	push   %edi
80102028:	56                   	push   %esi
80102029:	53                   	push   %ebx
  de.inum = inum;
8010202a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010202e:	e8 3d fb ff ff       	call   80101b70 <writei>
80102033:	83 c4 20             	add    $0x20,%esp
80102036:	83 f8 10             	cmp    $0x10,%eax
80102039:	75 2a                	jne    80102065 <dirlink+0xa5>
  return 0;
8010203b:	31 c0                	xor    %eax,%eax
}
8010203d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102040:	5b                   	pop    %ebx
80102041:	5e                   	pop    %esi
80102042:	5f                   	pop    %edi
80102043:	5d                   	pop    %ebp
80102044:	c3                   	ret    
    iput(ip);
80102045:	83 ec 0c             	sub    $0xc,%esp
80102048:	50                   	push   %eax
80102049:	e8 42 f8 ff ff       	call   80101890 <iput>
    return -1;
8010204e:	83 c4 10             	add    $0x10,%esp
80102051:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102056:	eb e5                	jmp    8010203d <dirlink+0x7d>
      panic("dirlink read");
80102058:	83 ec 0c             	sub    $0xc,%esp
8010205b:	68 48 81 10 80       	push   $0x80108148
80102060:	e8 1b e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	68 ee 87 10 80       	push   $0x801087ee
8010206d:	e8 0e e3 ff ff       	call   80100380 <panic>
80102072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102080 <namei>:

struct inode*
namei(char *path)
{
80102080:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102081:	31 d2                	xor    %edx,%edx
{
80102083:	89 e5                	mov    %esp,%ebp
80102085:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102088:	8b 45 08             	mov    0x8(%ebp),%eax
8010208b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010208e:	e8 dd fc ff ff       	call   80101d70 <namex>
}
80102093:	c9                   	leave  
80102094:	c3                   	ret    
80102095:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010209c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020a0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020a0:	55                   	push   %ebp
  return namex(path, 1, name);
801020a1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801020a6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020ae:	5d                   	pop    %ebp
  return namex(path, 1, name);
801020af:	e9 bc fc ff ff       	jmp    80101d70 <namex>
801020b4:	66 90                	xchg   %ax,%ax
801020b6:	66 90                	xchg   %ax,%ax
801020b8:	66 90                	xchg   %ax,%ax
801020ba:	66 90                	xchg   %ax,%ax
801020bc:	66 90                	xchg   %ax,%ax
801020be:	66 90                	xchg   %ax,%ax

801020c0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	57                   	push   %edi
801020c4:	56                   	push   %esi
801020c5:	53                   	push   %ebx
801020c6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020c9:	85 c0                	test   %eax,%eax
801020cb:	0f 84 b4 00 00 00    	je     80102185 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020d1:	8b 70 08             	mov    0x8(%eax),%esi
801020d4:	89 c3                	mov    %eax,%ebx
801020d6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020dc:	0f 87 96 00 00 00    	ja     80102178 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020ee:	66 90                	xchg   %ax,%ax
801020f0:	89 ca                	mov    %ecx,%edx
801020f2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f3:	83 e0 c0             	and    $0xffffffc0,%eax
801020f6:	3c 40                	cmp    $0x40,%al
801020f8:	75 f6                	jne    801020f0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020fa:	31 ff                	xor    %edi,%edi
801020fc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102101:	89 f8                	mov    %edi,%eax
80102103:	ee                   	out    %al,(%dx)
80102104:	b8 01 00 00 00       	mov    $0x1,%eax
80102109:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010210e:	ee                   	out    %al,(%dx)
8010210f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102114:	89 f0                	mov    %esi,%eax
80102116:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102117:	89 f0                	mov    %esi,%eax
80102119:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010211e:	c1 f8 08             	sar    $0x8,%eax
80102121:	ee                   	out    %al,(%dx)
80102122:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102127:	89 f8                	mov    %edi,%eax
80102129:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010212a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010212e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102133:	c1 e0 04             	shl    $0x4,%eax
80102136:	83 e0 10             	and    $0x10,%eax
80102139:	83 c8 e0             	or     $0xffffffe0,%eax
8010213c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010213d:	f6 03 04             	testb  $0x4,(%ebx)
80102140:	75 16                	jne    80102158 <idestart+0x98>
80102142:	b8 20 00 00 00       	mov    $0x20,%eax
80102147:	89 ca                	mov    %ecx,%edx
80102149:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010214a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010214d:	5b                   	pop    %ebx
8010214e:	5e                   	pop    %esi
8010214f:	5f                   	pop    %edi
80102150:	5d                   	pop    %ebp
80102151:	c3                   	ret    
80102152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102158:	b8 30 00 00 00       	mov    $0x30,%eax
8010215d:	89 ca                	mov    %ecx,%edx
8010215f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102160:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102165:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102168:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010216d:	fc                   	cld    
8010216e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102170:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102173:	5b                   	pop    %ebx
80102174:	5e                   	pop    %esi
80102175:	5f                   	pop    %edi
80102176:	5d                   	pop    %ebp
80102177:	c3                   	ret    
    panic("incorrect blockno");
80102178:	83 ec 0c             	sub    $0xc,%esp
8010217b:	68 b4 81 10 80       	push   $0x801081b4
80102180:	e8 fb e1 ff ff       	call   80100380 <panic>
    panic("idestart");
80102185:	83 ec 0c             	sub    $0xc,%esp
80102188:	68 ab 81 10 80       	push   $0x801081ab
8010218d:	e8 ee e1 ff ff       	call   80100380 <panic>
80102192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021a0 <ideinit>:
{
801021a0:	55                   	push   %ebp
801021a1:	89 e5                	mov    %esp,%ebp
801021a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021a6:	68 c6 81 10 80       	push   $0x801081c6
801021ab:	68 00 26 11 80       	push   $0x80112600
801021b0:	e8 0b 25 00 00       	call   801046c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021b5:	58                   	pop    %eax
801021b6:	a1 84 27 11 80       	mov    0x80112784,%eax
801021bb:	5a                   	pop    %edx
801021bc:	83 e8 01             	sub    $0x1,%eax
801021bf:	50                   	push   %eax
801021c0:	6a 0e                	push   $0xe
801021c2:	e8 99 02 00 00       	call   80102460 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021c7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ca:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021cf:	90                   	nop
801021d0:	ec                   	in     (%dx),%al
801021d1:	83 e0 c0             	and    $0xffffffc0,%eax
801021d4:	3c 40                	cmp    $0x40,%al
801021d6:	75 f8                	jne    801021d0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021d8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021dd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021e2:	ee                   	out    %al,(%dx)
801021e3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ed:	eb 06                	jmp    801021f5 <ideinit+0x55>
801021ef:	90                   	nop
  for(i=0; i<1000; i++){
801021f0:	83 e9 01             	sub    $0x1,%ecx
801021f3:	74 0f                	je     80102204 <ideinit+0x64>
801021f5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021f6:	84 c0                	test   %al,%al
801021f8:	74 f6                	je     801021f0 <ideinit+0x50>
      havedisk1 = 1;
801021fa:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102201:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102204:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102209:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010220e:	ee                   	out    %al,(%dx)
}
8010220f:	c9                   	leave  
80102210:	c3                   	ret    
80102211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010221f:	90                   	nop

80102220 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	57                   	push   %edi
80102224:	56                   	push   %esi
80102225:	53                   	push   %ebx
80102226:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102229:	68 00 26 11 80       	push   $0x80112600
8010222e:	e8 5d 26 00 00       	call   80104890 <acquire>

  if((b = idequeue) == 0){
80102233:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102239:	83 c4 10             	add    $0x10,%esp
8010223c:	85 db                	test   %ebx,%ebx
8010223e:	74 63                	je     801022a3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102240:	8b 43 58             	mov    0x58(%ebx),%eax
80102243:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102248:	8b 33                	mov    (%ebx),%esi
8010224a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102250:	75 2f                	jne    80102281 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102252:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010225e:	66 90                	xchg   %ax,%ax
80102260:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102261:	89 c1                	mov    %eax,%ecx
80102263:	83 e1 c0             	and    $0xffffffc0,%ecx
80102266:	80 f9 40             	cmp    $0x40,%cl
80102269:	75 f5                	jne    80102260 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010226b:	a8 21                	test   $0x21,%al
8010226d:	75 12                	jne    80102281 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010226f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102272:	b9 80 00 00 00       	mov    $0x80,%ecx
80102277:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010227c:	fc                   	cld    
8010227d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010227f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102281:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102284:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102287:	83 ce 02             	or     $0x2,%esi
8010228a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010228c:	53                   	push   %ebx
8010228d:	e8 fe 1f 00 00       	call   80104290 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102292:	a1 e4 25 11 80       	mov    0x801125e4,%eax
80102297:	83 c4 10             	add    $0x10,%esp
8010229a:	85 c0                	test   %eax,%eax
8010229c:	74 05                	je     801022a3 <ideintr+0x83>
    idestart(idequeue);
8010229e:	e8 1d fe ff ff       	call   801020c0 <idestart>
    release(&idelock);
801022a3:	83 ec 0c             	sub    $0xc,%esp
801022a6:	68 00 26 11 80       	push   $0x80112600
801022ab:	e8 80 25 00 00       	call   80104830 <release>

  release(&idelock);
}
801022b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b3:	5b                   	pop    %ebx
801022b4:	5e                   	pop    %esi
801022b5:	5f                   	pop    %edi
801022b6:	5d                   	pop    %ebp
801022b7:	c3                   	ret    
801022b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022bf:	90                   	nop

801022c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	53                   	push   %ebx
801022c4:	83 ec 10             	sub    $0x10,%esp
801022c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801022cd:	50                   	push   %eax
801022ce:	e8 9d 23 00 00       	call   80104670 <holdingsleep>
801022d3:	83 c4 10             	add    $0x10,%esp
801022d6:	85 c0                	test   %eax,%eax
801022d8:	0f 84 c3 00 00 00    	je     801023a1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022de:	8b 03                	mov    (%ebx),%eax
801022e0:	83 e0 06             	and    $0x6,%eax
801022e3:	83 f8 02             	cmp    $0x2,%eax
801022e6:	0f 84 a8 00 00 00    	je     80102394 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022ec:	8b 53 04             	mov    0x4(%ebx),%edx
801022ef:	85 d2                	test   %edx,%edx
801022f1:	74 0d                	je     80102300 <iderw+0x40>
801022f3:	a1 e0 25 11 80       	mov    0x801125e0,%eax
801022f8:	85 c0                	test   %eax,%eax
801022fa:	0f 84 87 00 00 00    	je     80102387 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102300:	83 ec 0c             	sub    $0xc,%esp
80102303:	68 00 26 11 80       	push   $0x80112600
80102308:	e8 83 25 00 00       	call   80104890 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010230d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102312:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102319:	83 c4 10             	add    $0x10,%esp
8010231c:	85 c0                	test   %eax,%eax
8010231e:	74 60                	je     80102380 <iderw+0xc0>
80102320:	89 c2                	mov    %eax,%edx
80102322:	8b 40 58             	mov    0x58(%eax),%eax
80102325:	85 c0                	test   %eax,%eax
80102327:	75 f7                	jne    80102320 <iderw+0x60>
80102329:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010232c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010232e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102334:	74 3a                	je     80102370 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102336:	8b 03                	mov    (%ebx),%eax
80102338:	83 e0 06             	and    $0x6,%eax
8010233b:	83 f8 02             	cmp    $0x2,%eax
8010233e:	74 1b                	je     8010235b <iderw+0x9b>
    sleep(b, &idelock);
80102340:	83 ec 08             	sub    $0x8,%esp
80102343:	68 00 26 11 80       	push   $0x80112600
80102348:	53                   	push   %ebx
80102349:	e8 82 1e 00 00       	call   801041d0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010234e:	8b 03                	mov    (%ebx),%eax
80102350:	83 c4 10             	add    $0x10,%esp
80102353:	83 e0 06             	and    $0x6,%eax
80102356:	83 f8 02             	cmp    $0x2,%eax
80102359:	75 e5                	jne    80102340 <iderw+0x80>
  }


  release(&idelock);
8010235b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102362:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102365:	c9                   	leave  
  release(&idelock);
80102366:	e9 c5 24 00 00       	jmp    80104830 <release>
8010236b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010236f:	90                   	nop
    idestart(b);
80102370:	89 d8                	mov    %ebx,%eax
80102372:	e8 49 fd ff ff       	call   801020c0 <idestart>
80102377:	eb bd                	jmp    80102336 <iderw+0x76>
80102379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102380:	ba e4 25 11 80       	mov    $0x801125e4,%edx
80102385:	eb a5                	jmp    8010232c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102387:	83 ec 0c             	sub    $0xc,%esp
8010238a:	68 f5 81 10 80       	push   $0x801081f5
8010238f:	e8 ec df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102394:	83 ec 0c             	sub    $0xc,%esp
80102397:	68 e0 81 10 80       	push   $0x801081e0
8010239c:	e8 df df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023a1:	83 ec 0c             	sub    $0xc,%esp
801023a4:	68 ca 81 10 80       	push   $0x801081ca
801023a9:	e8 d2 df ff ff       	call   80100380 <panic>
801023ae:	66 90                	xchg   %ax,%ax

801023b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023b0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023b1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023b8:	00 c0 fe 
{
801023bb:	89 e5                	mov    %esp,%ebp
801023bd:	56                   	push   %esi
801023be:	53                   	push   %ebx
  ioapic->reg = reg;
801023bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023c6:	00 00 00 
  return ioapic->data;
801023c9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023cf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023d2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023d8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023de:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023e5:	c1 ee 10             	shr    $0x10,%esi
801023e8:	89 f0                	mov    %esi,%eax
801023ea:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801023ed:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801023f0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023f3:	39 c2                	cmp    %eax,%edx
801023f5:	74 16                	je     8010240d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023f7:	83 ec 0c             	sub    $0xc,%esp
801023fa:	68 14 82 10 80       	push   $0x80108214
801023ff:	e8 9c e2 ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
80102404:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010240a:	83 c4 10             	add    $0x10,%esp
8010240d:	83 c6 21             	add    $0x21,%esi
{
80102410:	ba 10 00 00 00       	mov    $0x10,%edx
80102415:	b8 20 00 00 00       	mov    $0x20,%eax
8010241a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102420:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102422:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102424:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010242a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010242d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102433:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102436:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102439:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010243c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010243e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102444:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010244b:	39 f0                	cmp    %esi,%eax
8010244d:	75 d1                	jne    80102420 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010244f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102452:	5b                   	pop    %ebx
80102453:	5e                   	pop    %esi
80102454:	5d                   	pop    %ebp
80102455:	c3                   	ret    
80102456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010245d:	8d 76 00             	lea    0x0(%esi),%esi

80102460 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102460:	55                   	push   %ebp
  ioapic->reg = reg;
80102461:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102467:	89 e5                	mov    %esp,%ebp
80102469:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010246c:	8d 50 20             	lea    0x20(%eax),%edx
8010246f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102473:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102475:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010247b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010247e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102481:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102484:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102486:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010248b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010248e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102491:	5d                   	pop    %ebp
80102492:	c3                   	ret    
80102493:	66 90                	xchg   %ax,%ax
80102495:	66 90                	xchg   %ax,%ax
80102497:	66 90                	xchg   %ax,%ax
80102499:	66 90                	xchg   %ax,%ax
8010249b:	66 90                	xchg   %ax,%ax
8010249d:	66 90                	xchg   %ax,%ax
8010249f:	90                   	nop

801024a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	53                   	push   %ebx
801024a4:	83 ec 04             	sub    $0x4,%esp
801024a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024b0:	75 76                	jne    80102528 <kfree+0x88>
801024b2:	81 fb d0 6a 11 80    	cmp    $0x80116ad0,%ebx
801024b8:	72 6e                	jb     80102528 <kfree+0x88>
801024ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024c5:	77 61                	ja     80102528 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024c7:	83 ec 04             	sub    $0x4,%esp
801024ca:	68 00 10 00 00       	push   $0x1000
801024cf:	6a 01                	push   $0x1
801024d1:	53                   	push   %ebx
801024d2:	e8 79 24 00 00       	call   80104950 <memset>

  if(kmem.use_lock)
801024d7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	85 d2                	test   %edx,%edx
801024e2:	75 1c                	jne    80102500 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024e4:	a1 78 26 11 80       	mov    0x80112678,%eax
801024e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024eb:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
801024f0:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
801024f6:	85 c0                	test   %eax,%eax
801024f8:	75 1e                	jne    80102518 <kfree+0x78>
    release(&kmem.lock);
}
801024fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024fd:	c9                   	leave  
801024fe:	c3                   	ret    
801024ff:	90                   	nop
    acquire(&kmem.lock);
80102500:	83 ec 0c             	sub    $0xc,%esp
80102503:	68 40 26 11 80       	push   $0x80112640
80102508:	e8 83 23 00 00       	call   80104890 <acquire>
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	eb d2                	jmp    801024e4 <kfree+0x44>
80102512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102518:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010251f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102522:	c9                   	leave  
    release(&kmem.lock);
80102523:	e9 08 23 00 00       	jmp    80104830 <release>
    panic("kfree");
80102528:	83 ec 0c             	sub    $0xc,%esp
8010252b:	68 46 82 10 80       	push   $0x80108246
80102530:	e8 4b de ff ff       	call   80100380 <panic>
80102535:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010253c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102540 <freerange>:
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102544:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102547:	8b 75 0c             	mov    0xc(%ebp),%esi
8010254a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010254b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102551:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102557:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010255d:	39 de                	cmp    %ebx,%esi
8010255f:	72 23                	jb     80102584 <freerange+0x44>
80102561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102568:	83 ec 0c             	sub    $0xc,%esp
8010256b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102571:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102577:	50                   	push   %eax
80102578:	e8 23 ff ff ff       	call   801024a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	39 f3                	cmp    %esi,%ebx
80102582:	76 e4                	jbe    80102568 <freerange+0x28>
}
80102584:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102587:	5b                   	pop    %ebx
80102588:	5e                   	pop    %esi
80102589:	5d                   	pop    %ebp
8010258a:	c3                   	ret    
8010258b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010258f:	90                   	nop

80102590 <kinit2>:
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102594:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102597:	8b 75 0c             	mov    0xc(%ebp),%esi
8010259a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010259b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025ad:	39 de                	cmp    %ebx,%esi
801025af:	72 23                	jb     801025d4 <kinit2+0x44>
801025b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025b8:	83 ec 0c             	sub    $0xc,%esp
801025bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025c7:	50                   	push   %eax
801025c8:	e8 d3 fe ff ff       	call   801024a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025cd:	83 c4 10             	add    $0x10,%esp
801025d0:	39 de                	cmp    %ebx,%esi
801025d2:	73 e4                	jae    801025b8 <kinit2+0x28>
  kmem.use_lock = 1;
801025d4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801025db:	00 00 00 
}
801025de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025e1:	5b                   	pop    %ebx
801025e2:	5e                   	pop    %esi
801025e3:	5d                   	pop    %ebp
801025e4:	c3                   	ret    
801025e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025f0 <kinit1>:
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	56                   	push   %esi
801025f4:	53                   	push   %ebx
801025f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801025f8:	83 ec 08             	sub    $0x8,%esp
801025fb:	68 4c 82 10 80       	push   $0x8010824c
80102600:	68 40 26 11 80       	push   $0x80112640
80102605:	e8 b6 20 00 00       	call   801046c0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010260a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010260d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102610:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102617:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010261a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102620:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102626:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010262c:	39 de                	cmp    %ebx,%esi
8010262e:	72 1c                	jb     8010264c <kinit1+0x5c>
    kfree(p);
80102630:	83 ec 0c             	sub    $0xc,%esp
80102633:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102639:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010263f:	50                   	push   %eax
80102640:	e8 5b fe ff ff       	call   801024a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102645:	83 c4 10             	add    $0x10,%esp
80102648:	39 de                	cmp    %ebx,%esi
8010264a:	73 e4                	jae    80102630 <kinit1+0x40>
}
8010264c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010264f:	5b                   	pop    %ebx
80102650:	5e                   	pop    %esi
80102651:	5d                   	pop    %ebp
80102652:	c3                   	ret    
80102653:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010265a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102660 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102660:	a1 74 26 11 80       	mov    0x80112674,%eax
80102665:	85 c0                	test   %eax,%eax
80102667:	75 1f                	jne    80102688 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102669:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010266e:	85 c0                	test   %eax,%eax
80102670:	74 0e                	je     80102680 <kalloc+0x20>
    kmem.freelist = r->next;
80102672:	8b 10                	mov    (%eax),%edx
80102674:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
8010267a:	c3                   	ret    
8010267b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010267f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102680:	c3                   	ret    
80102681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102688:	55                   	push   %ebp
80102689:	89 e5                	mov    %esp,%ebp
8010268b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010268e:	68 40 26 11 80       	push   $0x80112640
80102693:	e8 f8 21 00 00       	call   80104890 <acquire>
  r = kmem.freelist;
80102698:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
8010269d:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801026a3:	83 c4 10             	add    $0x10,%esp
801026a6:	85 c0                	test   %eax,%eax
801026a8:	74 08                	je     801026b2 <kalloc+0x52>
    kmem.freelist = r->next;
801026aa:	8b 08                	mov    (%eax),%ecx
801026ac:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801026b2:	85 d2                	test   %edx,%edx
801026b4:	74 16                	je     801026cc <kalloc+0x6c>
    release(&kmem.lock);
801026b6:	83 ec 0c             	sub    $0xc,%esp
801026b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026bc:	68 40 26 11 80       	push   $0x80112640
801026c1:	e8 6a 21 00 00       	call   80104830 <release>
  return (char*)r;
801026c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026c9:	83 c4 10             	add    $0x10,%esp
}
801026cc:	c9                   	leave  
801026cd:	c3                   	ret    
801026ce:	66 90                	xchg   %ax,%ax

801026d0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026d0:	ba 64 00 00 00       	mov    $0x64,%edx
801026d5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026d6:	a8 01                	test   $0x1,%al
801026d8:	0f 84 c2 00 00 00    	je     801027a0 <kbdgetc+0xd0>
{
801026de:	55                   	push   %ebp
801026df:	ba 60 00 00 00       	mov    $0x60,%edx
801026e4:	89 e5                	mov    %esp,%ebp
801026e6:	53                   	push   %ebx
801026e7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801026e8:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
801026ee:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801026f1:	3c e0                	cmp    $0xe0,%al
801026f3:	74 5b                	je     80102750 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801026f5:	89 da                	mov    %ebx,%edx
801026f7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801026fa:	84 c0                	test   %al,%al
801026fc:	78 62                	js     80102760 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026fe:	85 d2                	test   %edx,%edx
80102700:	74 09                	je     8010270b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102702:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102705:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102708:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010270b:	0f b6 91 80 83 10 80 	movzbl -0x7fef7c80(%ecx),%edx
  shift ^= togglecode[data];
80102712:	0f b6 81 80 82 10 80 	movzbl -0x7fef7d80(%ecx),%eax
  shift |= shiftcode[data];
80102719:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010271b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010271d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010271f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102725:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102728:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010272b:	8b 04 85 60 82 10 80 	mov    -0x7fef7da0(,%eax,4),%eax
80102732:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102736:	74 0b                	je     80102743 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102738:	8d 50 9f             	lea    -0x61(%eax),%edx
8010273b:	83 fa 19             	cmp    $0x19,%edx
8010273e:	77 48                	ja     80102788 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102740:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102743:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102746:	c9                   	leave  
80102747:	c3                   	ret    
80102748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010274f:	90                   	nop
    shift |= E0ESC;
80102750:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102753:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102755:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010275b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010275e:	c9                   	leave  
8010275f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102760:	83 e0 7f             	and    $0x7f,%eax
80102763:	85 d2                	test   %edx,%edx
80102765:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102768:	0f b6 81 80 83 10 80 	movzbl -0x7fef7c80(%ecx),%eax
8010276f:	83 c8 40             	or     $0x40,%eax
80102772:	0f b6 c0             	movzbl %al,%eax
80102775:	f7 d0                	not    %eax
80102777:	21 d8                	and    %ebx,%eax
}
80102779:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010277c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
80102781:	31 c0                	xor    %eax,%eax
}
80102783:	c9                   	leave  
80102784:	c3                   	ret    
80102785:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102788:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010278b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010278e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102791:	c9                   	leave  
      c += 'a' - 'A';
80102792:	83 f9 1a             	cmp    $0x1a,%ecx
80102795:	0f 42 c2             	cmovb  %edx,%eax
}
80102798:	c3                   	ret    
80102799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801027a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801027a5:	c3                   	ret    
801027a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ad:	8d 76 00             	lea    0x0(%esi),%esi

801027b0 <kbdintr>:

void
kbdintr(void)
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027b6:	68 d0 26 10 80       	push   $0x801026d0
801027bb:	e8 c0 e0 ff ff       	call   80100880 <consoleintr>
}
801027c0:	83 c4 10             	add    $0x10,%esp
801027c3:	c9                   	leave  
801027c4:	c3                   	ret    
801027c5:	66 90                	xchg   %ax,%ax
801027c7:	66 90                	xchg   %ax,%ax
801027c9:	66 90                	xchg   %ax,%ax
801027cb:	66 90                	xchg   %ax,%ax
801027cd:	66 90                	xchg   %ax,%ax
801027cf:	90                   	nop

801027d0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027d0:	a1 80 26 11 80       	mov    0x80112680,%eax
801027d5:	85 c0                	test   %eax,%eax
801027d7:	0f 84 cb 00 00 00    	je     801028a8 <lapicinit+0xd8>
  lapic[index] = value;
801027dd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027e4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ea:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027f1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027fe:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102801:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102804:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010280b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102811:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102818:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010281b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010281e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102825:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102828:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010282b:	8b 50 30             	mov    0x30(%eax),%edx
8010282e:	c1 ea 10             	shr    $0x10,%edx
80102831:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102837:	75 77                	jne    801028b0 <lapicinit+0xe0>
  lapic[index] = value;
80102839:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102840:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102843:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102846:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010284d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102850:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102853:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010285a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010285d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102860:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102867:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010286a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010286d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102874:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102877:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010287a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102881:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102884:	8b 50 20             	mov    0x20(%eax),%edx
80102887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010288e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102890:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102896:	80 e6 10             	and    $0x10,%dh
80102899:	75 f5                	jne    80102890 <lapicinit+0xc0>
  lapic[index] = value;
8010289b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028a2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028a8:	c3                   	ret    
801028a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028b0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028b7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028ba:	8b 50 20             	mov    0x20(%eax),%edx
}
801028bd:	e9 77 ff ff ff       	jmp    80102839 <lapicinit+0x69>
801028c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028d0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028d0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028d5:	85 c0                	test   %eax,%eax
801028d7:	74 07                	je     801028e0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028d9:	8b 40 20             	mov    0x20(%eax),%eax
801028dc:	c1 e8 18             	shr    $0x18,%eax
801028df:	c3                   	ret    
    return 0;
801028e0:	31 c0                	xor    %eax,%eax
}
801028e2:	c3                   	ret    
801028e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028f5:	85 c0                	test   %eax,%eax
801028f7:	74 0d                	je     80102906 <lapiceoi+0x16>
  lapic[index] = value;
801028f9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102900:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102903:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102906:	c3                   	ret    
80102907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290e:	66 90                	xchg   %ax,%ax

80102910 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102910:	c3                   	ret    
80102911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291f:	90                   	nop

80102920 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102920:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102921:	b8 0f 00 00 00       	mov    $0xf,%eax
80102926:	ba 70 00 00 00       	mov    $0x70,%edx
8010292b:	89 e5                	mov    %esp,%ebp
8010292d:	53                   	push   %ebx
8010292e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102931:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102934:	ee                   	out    %al,(%dx)
80102935:	b8 0a 00 00 00       	mov    $0xa,%eax
8010293a:	ba 71 00 00 00       	mov    $0x71,%edx
8010293f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102940:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102942:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102945:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010294b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010294d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102950:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102952:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102955:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102958:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010295e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102963:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102969:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010296c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102973:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102976:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102979:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102980:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102983:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102986:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010298c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010298f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102995:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102998:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010299e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029a7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801029aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029ad:	c9                   	leave  
801029ae:	c3                   	ret    
801029af:	90                   	nop

801029b0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029b0:	55                   	push   %ebp
801029b1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029b6:	ba 70 00 00 00       	mov    $0x70,%edx
801029bb:	89 e5                	mov    %esp,%ebp
801029bd:	57                   	push   %edi
801029be:	56                   	push   %esi
801029bf:	53                   	push   %ebx
801029c0:	83 ec 4c             	sub    $0x4c,%esp
801029c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c4:	ba 71 00 00 00       	mov    $0x71,%edx
801029c9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029ca:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029cd:	bb 70 00 00 00       	mov    $0x70,%ebx
801029d2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029d5:	8d 76 00             	lea    0x0(%esi),%esi
801029d8:	31 c0                	xor    %eax,%eax
801029da:	89 da                	mov    %ebx,%edx
801029dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029dd:	b9 71 00 00 00       	mov    $0x71,%ecx
801029e2:	89 ca                	mov    %ecx,%edx
801029e4:	ec                   	in     (%dx),%al
801029e5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e8:	89 da                	mov    %ebx,%edx
801029ea:	b8 02 00 00 00       	mov    $0x2,%eax
801029ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f0:	89 ca                	mov    %ecx,%edx
801029f2:	ec                   	in     (%dx),%al
801029f3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f6:	89 da                	mov    %ebx,%edx
801029f8:	b8 04 00 00 00       	mov    $0x4,%eax
801029fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fe:	89 ca                	mov    %ecx,%edx
80102a00:	ec                   	in     (%dx),%al
80102a01:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a04:	89 da                	mov    %ebx,%edx
80102a06:	b8 07 00 00 00       	mov    $0x7,%eax
80102a0b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0c:	89 ca                	mov    %ecx,%edx
80102a0e:	ec                   	in     (%dx),%al
80102a0f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a12:	89 da                	mov    %ebx,%edx
80102a14:	b8 08 00 00 00       	mov    $0x8,%eax
80102a19:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1a:	89 ca                	mov    %ecx,%edx
80102a1c:	ec                   	in     (%dx),%al
80102a1d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a1f:	89 da                	mov    %ebx,%edx
80102a21:	b8 09 00 00 00       	mov    $0x9,%eax
80102a26:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a27:	89 ca                	mov    %ecx,%edx
80102a29:	ec                   	in     (%dx),%al
80102a2a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a2c:	89 da                	mov    %ebx,%edx
80102a2e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a34:	89 ca                	mov    %ecx,%edx
80102a36:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a37:	84 c0                	test   %al,%al
80102a39:	78 9d                	js     801029d8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a3b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a3f:	89 fa                	mov    %edi,%edx
80102a41:	0f b6 fa             	movzbl %dl,%edi
80102a44:	89 f2                	mov    %esi,%edx
80102a46:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a49:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a4d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a50:	89 da                	mov    %ebx,%edx
80102a52:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a55:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a58:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a5c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a5f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a62:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a66:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a69:	31 c0                	xor    %eax,%eax
80102a6b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6c:	89 ca                	mov    %ecx,%edx
80102a6e:	ec                   	in     (%dx),%al
80102a6f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a72:	89 da                	mov    %ebx,%edx
80102a74:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a77:	b8 02 00 00 00       	mov    $0x2,%eax
80102a7c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7d:	89 ca                	mov    %ecx,%edx
80102a7f:	ec                   	in     (%dx),%al
80102a80:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a83:	89 da                	mov    %ebx,%edx
80102a85:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a88:	b8 04 00 00 00       	mov    $0x4,%eax
80102a8d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8e:	89 ca                	mov    %ecx,%edx
80102a90:	ec                   	in     (%dx),%al
80102a91:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a94:	89 da                	mov    %ebx,%edx
80102a96:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a99:	b8 07 00 00 00       	mov    $0x7,%eax
80102a9e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9f:	89 ca                	mov    %ecx,%edx
80102aa1:	ec                   	in     (%dx),%al
80102aa2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa5:	89 da                	mov    %ebx,%edx
80102aa7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aaa:	b8 08 00 00 00       	mov    $0x8,%eax
80102aaf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab0:	89 ca                	mov    %ecx,%edx
80102ab2:	ec                   	in     (%dx),%al
80102ab3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab6:	89 da                	mov    %ebx,%edx
80102ab8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102abb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ac0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac1:	89 ca                	mov    %ecx,%edx
80102ac3:	ec                   	in     (%dx),%al
80102ac4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ac7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102acd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ad0:	6a 18                	push   $0x18
80102ad2:	50                   	push   %eax
80102ad3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ad6:	50                   	push   %eax
80102ad7:	e8 c4 1e 00 00       	call   801049a0 <memcmp>
80102adc:	83 c4 10             	add    $0x10,%esp
80102adf:	85 c0                	test   %eax,%eax
80102ae1:	0f 85 f1 fe ff ff    	jne    801029d8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ae7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102aeb:	75 78                	jne    80102b65 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102aed:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102af0:	89 c2                	mov    %eax,%edx
80102af2:	83 e0 0f             	and    $0xf,%eax
80102af5:	c1 ea 04             	shr    $0x4,%edx
80102af8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102afb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102afe:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b01:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b04:	89 c2                	mov    %eax,%edx
80102b06:	83 e0 0f             	and    $0xf,%eax
80102b09:	c1 ea 04             	shr    $0x4,%edx
80102b0c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b0f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b12:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b15:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b18:	89 c2                	mov    %eax,%edx
80102b1a:	83 e0 0f             	and    $0xf,%eax
80102b1d:	c1 ea 04             	shr    $0x4,%edx
80102b20:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b23:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b26:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b29:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b2c:	89 c2                	mov    %eax,%edx
80102b2e:	83 e0 0f             	and    $0xf,%eax
80102b31:	c1 ea 04             	shr    $0x4,%edx
80102b34:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b37:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b3a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b3d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b40:	89 c2                	mov    %eax,%edx
80102b42:	83 e0 0f             	and    $0xf,%eax
80102b45:	c1 ea 04             	shr    $0x4,%edx
80102b48:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b4b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b4e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b51:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b54:	89 c2                	mov    %eax,%edx
80102b56:	83 e0 0f             	and    $0xf,%eax
80102b59:	c1 ea 04             	shr    $0x4,%edx
80102b5c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b5f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b62:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b65:	8b 75 08             	mov    0x8(%ebp),%esi
80102b68:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b6b:	89 06                	mov    %eax,(%esi)
80102b6d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b70:	89 46 04             	mov    %eax,0x4(%esi)
80102b73:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b76:	89 46 08             	mov    %eax,0x8(%esi)
80102b79:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b7c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b7f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b82:	89 46 10             	mov    %eax,0x10(%esi)
80102b85:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b88:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b8b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b95:	5b                   	pop    %ebx
80102b96:	5e                   	pop    %esi
80102b97:	5f                   	pop    %edi
80102b98:	5d                   	pop    %ebp
80102b99:	c3                   	ret    
80102b9a:	66 90                	xchg   %ax,%ax
80102b9c:	66 90                	xchg   %ax,%ax
80102b9e:	66 90                	xchg   %ax,%ax

80102ba0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ba0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102ba6:	85 c9                	test   %ecx,%ecx
80102ba8:	0f 8e 8a 00 00 00    	jle    80102c38 <install_trans+0x98>
{
80102bae:	55                   	push   %ebp
80102baf:	89 e5                	mov    %esp,%ebp
80102bb1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102bb2:	31 ff                	xor    %edi,%edi
{
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	83 ec 0c             	sub    $0xc,%esp
80102bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bc0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102bc5:	83 ec 08             	sub    $0x8,%esp
80102bc8:	01 f8                	add    %edi,%eax
80102bca:	83 c0 01             	add    $0x1,%eax
80102bcd:	50                   	push   %eax
80102bce:	ff 35 e4 26 11 80    	push   0x801126e4
80102bd4:	e8 f7 d4 ff ff       	call   801000d0 <bread>
80102bd9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bdb:	58                   	pop    %eax
80102bdc:	5a                   	pop    %edx
80102bdd:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102be4:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bea:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bed:	e8 de d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bf2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bf5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bf7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bfa:	68 00 02 00 00       	push   $0x200
80102bff:	50                   	push   %eax
80102c00:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c03:	50                   	push   %eax
80102c04:	e8 e7 1d 00 00       	call   801049f0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c09:	89 1c 24             	mov    %ebx,(%esp)
80102c0c:	e8 9f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c11:	89 34 24             	mov    %esi,(%esp)
80102c14:	e8 d7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c19:	89 1c 24             	mov    %ebx,(%esp)
80102c1c:	e8 cf d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102c2a:	7f 94                	jg     80102bc0 <install_trans+0x20>
  }
}
80102c2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c2f:	5b                   	pop    %ebx
80102c30:	5e                   	pop    %esi
80102c31:	5f                   	pop    %edi
80102c32:	5d                   	pop    %ebp
80102c33:	c3                   	ret    
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c38:	c3                   	ret    
80102c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	53                   	push   %ebx
80102c44:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c47:	ff 35 d4 26 11 80    	push   0x801126d4
80102c4d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c53:	e8 78 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c58:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c5b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c5d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c62:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c65:	85 c0                	test   %eax,%eax
80102c67:	7e 19                	jle    80102c82 <write_head+0x42>
80102c69:	31 d2                	xor    %edx,%edx
80102c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c6f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c70:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c77:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c7b:	83 c2 01             	add    $0x1,%edx
80102c7e:	39 d0                	cmp    %edx,%eax
80102c80:	75 ee                	jne    80102c70 <write_head+0x30>
  }
  bwrite(buf);
80102c82:	83 ec 0c             	sub    $0xc,%esp
80102c85:	53                   	push   %ebx
80102c86:	e8 25 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102c8b:	89 1c 24             	mov    %ebx,(%esp)
80102c8e:	e8 5d d5 ff ff       	call   801001f0 <brelse>
}
80102c93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c96:	83 c4 10             	add    $0x10,%esp
80102c99:	c9                   	leave  
80102c9a:	c3                   	ret    
80102c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c9f:	90                   	nop

80102ca0 <initlog>:
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	53                   	push   %ebx
80102ca4:	83 ec 2c             	sub    $0x2c,%esp
80102ca7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102caa:	68 80 84 10 80       	push   $0x80108480
80102caf:	68 a0 26 11 80       	push   $0x801126a0
80102cb4:	e8 07 1a 00 00       	call   801046c0 <initlock>
  readsb(dev, &sb);
80102cb9:	58                   	pop    %eax
80102cba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cbd:	5a                   	pop    %edx
80102cbe:	50                   	push   %eax
80102cbf:	53                   	push   %ebx
80102cc0:	e8 3b e8 ff ff       	call   80101500 <readsb>
  log.start = sb.logstart;
80102cc5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102cc8:	59                   	pop    %ecx
  log.dev = dev;
80102cc9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102ccf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cd2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102cd7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102cdd:	5a                   	pop    %edx
80102cde:	50                   	push   %eax
80102cdf:	53                   	push   %ebx
80102ce0:	e8 eb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ce5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102ce8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ceb:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102cf1:	85 db                	test   %ebx,%ebx
80102cf3:	7e 1d                	jle    80102d12 <initlog+0x72>
80102cf5:	31 d2                	xor    %edx,%edx
80102cf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cfe:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d00:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d04:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d0b:	83 c2 01             	add    $0x1,%edx
80102d0e:	39 d3                	cmp    %edx,%ebx
80102d10:	75 ee                	jne    80102d00 <initlog+0x60>
  brelse(buf);
80102d12:	83 ec 0c             	sub    $0xc,%esp
80102d15:	50                   	push   %eax
80102d16:	e8 d5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d1b:	e8 80 fe ff ff       	call   80102ba0 <install_trans>
  log.lh.n = 0;
80102d20:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d27:	00 00 00 
  write_head(); // clear the log
80102d2a:	e8 11 ff ff ff       	call   80102c40 <write_head>
}
80102d2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d32:	83 c4 10             	add    $0x10,%esp
80102d35:	c9                   	leave  
80102d36:	c3                   	ret    
80102d37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d3e:	66 90                	xchg   %ax,%ax

80102d40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d40:	55                   	push   %ebp
80102d41:	89 e5                	mov    %esp,%ebp
80102d43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d46:	68 a0 26 11 80       	push   $0x801126a0
80102d4b:	e8 40 1b 00 00       	call   80104890 <acquire>
80102d50:	83 c4 10             	add    $0x10,%esp
80102d53:	eb 18                	jmp    80102d6d <begin_op+0x2d>
80102d55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d58:	83 ec 08             	sub    $0x8,%esp
80102d5b:	68 a0 26 11 80       	push   $0x801126a0
80102d60:	68 a0 26 11 80       	push   $0x801126a0
80102d65:	e8 66 14 00 00       	call   801041d0 <sleep>
80102d6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d6d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d72:	85 c0                	test   %eax,%eax
80102d74:	75 e2                	jne    80102d58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d76:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102d81:	83 c0 01             	add    $0x1,%eax
80102d84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d8a:	83 fa 1e             	cmp    $0x1e,%edx
80102d8d:	7f c9                	jg     80102d58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d92:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102d97:	68 a0 26 11 80       	push   $0x801126a0
80102d9c:	e8 8f 1a 00 00       	call   80104830 <release>
      break;
    }
  }
}
80102da1:	83 c4 10             	add    $0x10,%esp
80102da4:	c9                   	leave  
80102da5:	c3                   	ret    
80102da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dad:	8d 76 00             	lea    0x0(%esi),%esi

80102db0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	57                   	push   %edi
80102db4:	56                   	push   %esi
80102db5:	53                   	push   %ebx
80102db6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102db9:	68 a0 26 11 80       	push   $0x801126a0
80102dbe:	e8 cd 1a 00 00       	call   80104890 <acquire>
  log.outstanding -= 1;
80102dc3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102dc8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dce:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102dd1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102dd4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102dda:	85 f6                	test   %esi,%esi
80102ddc:	0f 85 22 01 00 00    	jne    80102f04 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102de2:	85 db                	test   %ebx,%ebx
80102de4:	0f 85 f6 00 00 00    	jne    80102ee0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102dea:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102df1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102df4:	83 ec 0c             	sub    $0xc,%esp
80102df7:	68 a0 26 11 80       	push   $0x801126a0
80102dfc:	e8 2f 1a 00 00       	call   80104830 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e01:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e07:	83 c4 10             	add    $0x10,%esp
80102e0a:	85 c9                	test   %ecx,%ecx
80102e0c:	7f 42                	jg     80102e50 <end_op+0xa0>
    acquire(&log.lock);
80102e0e:	83 ec 0c             	sub    $0xc,%esp
80102e11:	68 a0 26 11 80       	push   $0x801126a0
80102e16:	e8 75 1a 00 00       	call   80104890 <acquire>
    wakeup(&log);
80102e1b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e22:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e29:	00 00 00 
    wakeup(&log);
80102e2c:	e8 5f 14 00 00       	call   80104290 <wakeup>
    release(&log.lock);
80102e31:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e38:	e8 f3 19 00 00       	call   80104830 <release>
80102e3d:	83 c4 10             	add    $0x10,%esp
}
80102e40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e43:	5b                   	pop    %ebx
80102e44:	5e                   	pop    %esi
80102e45:	5f                   	pop    %edi
80102e46:	5d                   	pop    %ebp
80102e47:	c3                   	ret    
80102e48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e4f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e50:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e55:	83 ec 08             	sub    $0x8,%esp
80102e58:	01 d8                	add    %ebx,%eax
80102e5a:	83 c0 01             	add    $0x1,%eax
80102e5d:	50                   	push   %eax
80102e5e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e64:	e8 67 d2 ff ff       	call   801000d0 <bread>
80102e69:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e6b:	58                   	pop    %eax
80102e6c:	5a                   	pop    %edx
80102e6d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102e74:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e7d:	e8 4e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102e82:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e85:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e87:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e8a:	68 00 02 00 00       	push   $0x200
80102e8f:	50                   	push   %eax
80102e90:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e93:	50                   	push   %eax
80102e94:	e8 57 1b 00 00       	call   801049f0 <memmove>
    bwrite(to);  // write the log
80102e99:	89 34 24             	mov    %esi,(%esp)
80102e9c:	e8 0f d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102ea1:	89 3c 24             	mov    %edi,(%esp)
80102ea4:	e8 47 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102ea9:	89 34 24             	mov    %esi,(%esp)
80102eac:	e8 3f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102eb1:	83 c4 10             	add    $0x10,%esp
80102eb4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eba:	7c 94                	jl     80102e50 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ebc:	e8 7f fd ff ff       	call   80102c40 <write_head>
    install_trans(); // Now install writes to home locations
80102ec1:	e8 da fc ff ff       	call   80102ba0 <install_trans>
    log.lh.n = 0;
80102ec6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102ecd:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ed0:	e8 6b fd ff ff       	call   80102c40 <write_head>
80102ed5:	e9 34 ff ff ff       	jmp    80102e0e <end_op+0x5e>
80102eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102ee0:	83 ec 0c             	sub    $0xc,%esp
80102ee3:	68 a0 26 11 80       	push   $0x801126a0
80102ee8:	e8 a3 13 00 00       	call   80104290 <wakeup>
  release(&log.lock);
80102eed:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ef4:	e8 37 19 00 00       	call   80104830 <release>
80102ef9:	83 c4 10             	add    $0x10,%esp
}
80102efc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eff:	5b                   	pop    %ebx
80102f00:	5e                   	pop    %esi
80102f01:	5f                   	pop    %edi
80102f02:	5d                   	pop    %ebp
80102f03:	c3                   	ret    
    panic("log.committing");
80102f04:	83 ec 0c             	sub    $0xc,%esp
80102f07:	68 84 84 10 80       	push   $0x80108484
80102f0c:	e8 6f d4 ff ff       	call   80100380 <panic>
80102f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f1f:	90                   	nop

80102f20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f27:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102f2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f30:	83 fa 1d             	cmp    $0x1d,%edx
80102f33:	0f 8f 85 00 00 00    	jg     80102fbe <log_write+0x9e>
80102f39:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f3e:	83 e8 01             	sub    $0x1,%eax
80102f41:	39 c2                	cmp    %eax,%edx
80102f43:	7d 79                	jge    80102fbe <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f45:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f4a:	85 c0                	test   %eax,%eax
80102f4c:	7e 7d                	jle    80102fcb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f4e:	83 ec 0c             	sub    $0xc,%esp
80102f51:	68 a0 26 11 80       	push   $0x801126a0
80102f56:	e8 35 19 00 00       	call   80104890 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f5b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f61:	83 c4 10             	add    $0x10,%esp
80102f64:	85 d2                	test   %edx,%edx
80102f66:	7e 4a                	jle    80102fb2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f68:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f6b:	31 c0                	xor    %eax,%eax
80102f6d:	eb 08                	jmp    80102f77 <log_write+0x57>
80102f6f:	90                   	nop
80102f70:	83 c0 01             	add    $0x1,%eax
80102f73:	39 c2                	cmp    %eax,%edx
80102f75:	74 29                	je     80102fa0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f77:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102f7e:	75 f0                	jne    80102f70 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f80:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102f87:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102f8d:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102f94:	c9                   	leave  
  release(&log.lock);
80102f95:	e9 96 18 00 00       	jmp    80104830 <release>
80102f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80102fa7:	83 c2 01             	add    $0x1,%edx
80102faa:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fb0:	eb d5                	jmp    80102f87 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102fb2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fb5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102fba:	75 cb                	jne    80102f87 <log_write+0x67>
80102fbc:	eb e9                	jmp    80102fa7 <log_write+0x87>
    panic("too big a transaction");
80102fbe:	83 ec 0c             	sub    $0xc,%esp
80102fc1:	68 93 84 10 80       	push   $0x80108493
80102fc6:	e8 b5 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102fcb:	83 ec 0c             	sub    $0xc,%esp
80102fce:	68 a9 84 10 80       	push   $0x801084a9
80102fd3:	e8 a8 d3 ff ff       	call   80100380 <panic>
80102fd8:	66 90                	xchg   %ax,%ax
80102fda:	66 90                	xchg   %ax,%ax
80102fdc:	66 90                	xchg   %ax,%ax
80102fde:	66 90                	xchg   %ax,%ax

80102fe0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	53                   	push   %ebx
80102fe4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fe7:	e8 e4 09 00 00       	call   801039d0 <cpuid>
80102fec:	89 c3                	mov    %eax,%ebx
80102fee:	e8 dd 09 00 00       	call   801039d0 <cpuid>
80102ff3:	83 ec 04             	sub    $0x4,%esp
80102ff6:	53                   	push   %ebx
80102ff7:	50                   	push   %eax
80102ff8:	68 c4 84 10 80       	push   $0x801084c4
80102ffd:	e8 9e d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103002:	e8 99 33 00 00       	call   801063a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103007:	e8 64 09 00 00       	call   80103970 <mycpu>
8010300c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010300e:	b8 01 00 00 00       	mov    $0x1,%eax
80103013:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010301a:	e8 f1 0c 00 00       	call   80103d10 <scheduler>
8010301f:	90                   	nop

80103020 <mpenter>:
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103026:	e8 c5 45 00 00       	call   801075f0 <switchkvm>
  seginit();
8010302b:	e8 30 45 00 00       	call   80107560 <seginit>
  lapicinit();
80103030:	e8 9b f7 ff ff       	call   801027d0 <lapicinit>
  mpmain();
80103035:	e8 a6 ff ff ff       	call   80102fe0 <mpmain>
8010303a:	66 90                	xchg   %ax,%ax
8010303c:	66 90                	xchg   %ax,%ax
8010303e:	66 90                	xchg   %ax,%ax

80103040 <main>:
{
80103040:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103044:	83 e4 f0             	and    $0xfffffff0,%esp
80103047:	ff 71 fc             	push   -0x4(%ecx)
8010304a:	55                   	push   %ebp
8010304b:	89 e5                	mov    %esp,%ebp
8010304d:	53                   	push   %ebx
8010304e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010304f:	83 ec 08             	sub    $0x8,%esp
80103052:	68 00 00 40 80       	push   $0x80400000
80103057:	68 d0 6a 11 80       	push   $0x80116ad0
8010305c:	e8 8f f5 ff ff       	call   801025f0 <kinit1>
  kvmalloc();      // kernel page table
80103061:	e8 7a 4a 00 00       	call   80107ae0 <kvmalloc>
  mpinit();        // detect other processors
80103066:	e8 85 01 00 00       	call   801031f0 <mpinit>
  lapicinit();     // interrupt controller
8010306b:	e8 60 f7 ff ff       	call   801027d0 <lapicinit>
  seginit();       // segment descriptors
80103070:	e8 eb 44 00 00       	call   80107560 <seginit>
  picinit();       // disable pic
80103075:	e8 76 03 00 00       	call   801033f0 <picinit>
  ioapicinit();    // another interrupt controller
8010307a:	e8 31 f3 ff ff       	call   801023b0 <ioapicinit>
  consoleinit();   // console hardware
8010307f:	e8 dc d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
80103084:	e8 e7 36 00 00       	call   80106770 <uartinit>
  pinit();         // process table
80103089:	e8 c2 08 00 00       	call   80103950 <pinit>
  tvinit();        // trap vectors
8010308e:	e8 8d 32 00 00       	call   80106320 <tvinit>
  binit();         // buffer cache
80103093:	e8 a8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103098:	e8 53 dd ff ff       	call   80100df0 <fileinit>
  ideinit();       // disk 
8010309d:	e8 fe f0 ff ff       	call   801021a0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030a2:	83 c4 0c             	add    $0xc,%esp
801030a5:	68 8a 00 00 00       	push   $0x8a
801030aa:	68 8c b4 10 80       	push   $0x8010b48c
801030af:	68 00 70 00 80       	push   $0x80007000
801030b4:	e8 37 19 00 00       	call   801049f0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030b9:	83 c4 10             	add    $0x10,%esp
801030bc:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030c3:	00 00 00 
801030c6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030cb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801030d0:	76 7e                	jbe    80103150 <main+0x110>
801030d2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801030d7:	eb 20                	jmp    801030f9 <main+0xb9>
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030e0:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030e7:	00 00 00 
801030ea:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801030f0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030f5:	39 c3                	cmp    %eax,%ebx
801030f7:	73 57                	jae    80103150 <main+0x110>
    if(c == mycpu())  // We've started already.
801030f9:	e8 72 08 00 00       	call   80103970 <mycpu>
801030fe:	39 c3                	cmp    %eax,%ebx
80103100:	74 de                	je     801030e0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103102:	e8 59 f5 ff ff       	call   80102660 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103107:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010310a:	c7 05 f8 6f 00 80 20 	movl   $0x80103020,0x80006ff8
80103111:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103114:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010311b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010311e:	05 00 10 00 00       	add    $0x1000,%eax
80103123:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103128:	0f b6 03             	movzbl (%ebx),%eax
8010312b:	68 00 70 00 00       	push   $0x7000
80103130:	50                   	push   %eax
80103131:	e8 ea f7 ff ff       	call   80102920 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103136:	83 c4 10             	add    $0x10,%esp
80103139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103140:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103146:	85 c0                	test   %eax,%eax
80103148:	74 f6                	je     80103140 <main+0x100>
8010314a:	eb 94                	jmp    801030e0 <main+0xa0>
8010314c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103150:	83 ec 08             	sub    $0x8,%esp
80103153:	68 00 00 00 8e       	push   $0x8e000000
80103158:	68 00 00 40 80       	push   $0x80400000
8010315d:	e8 2e f4 ff ff       	call   80102590 <kinit2>
  userinit();      // first user process
80103162:	e8 b9 08 00 00       	call   80103a20 <userinit>
  mpmain();        // finish this processor's setup
80103167:	e8 74 fe ff ff       	call   80102fe0 <mpmain>
8010316c:	66 90                	xchg   %ax,%ax
8010316e:	66 90                	xchg   %ax,%ax

80103170 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103175:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010317b:	53                   	push   %ebx
  e = addr+len;
8010317c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010317f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103182:	39 de                	cmp    %ebx,%esi
80103184:	72 10                	jb     80103196 <mpsearch1+0x26>
80103186:	eb 50                	jmp    801031d8 <mpsearch1+0x68>
80103188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010318f:	90                   	nop
80103190:	89 fe                	mov    %edi,%esi
80103192:	39 fb                	cmp    %edi,%ebx
80103194:	76 42                	jbe    801031d8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103196:	83 ec 04             	sub    $0x4,%esp
80103199:	8d 7e 10             	lea    0x10(%esi),%edi
8010319c:	6a 04                	push   $0x4
8010319e:	68 d8 84 10 80       	push   $0x801084d8
801031a3:	56                   	push   %esi
801031a4:	e8 f7 17 00 00       	call   801049a0 <memcmp>
801031a9:	83 c4 10             	add    $0x10,%esp
801031ac:	85 c0                	test   %eax,%eax
801031ae:	75 e0                	jne    80103190 <mpsearch1+0x20>
801031b0:	89 f2                	mov    %esi,%edx
801031b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031b8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031bb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031be:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031c0:	39 fa                	cmp    %edi,%edx
801031c2:	75 f4                	jne    801031b8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031c4:	84 c0                	test   %al,%al
801031c6:	75 c8                	jne    80103190 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031cb:	89 f0                	mov    %esi,%eax
801031cd:	5b                   	pop    %ebx
801031ce:	5e                   	pop    %esi
801031cf:	5f                   	pop    %edi
801031d0:	5d                   	pop    %ebp
801031d1:	c3                   	ret    
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031db:	31 f6                	xor    %esi,%esi
}
801031dd:	5b                   	pop    %ebx
801031de:	89 f0                	mov    %esi,%eax
801031e0:	5e                   	pop    %esi
801031e1:	5f                   	pop    %edi
801031e2:	5d                   	pop    %ebp
801031e3:	c3                   	ret    
801031e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031ef:	90                   	nop

801031f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	57                   	push   %edi
801031f4:	56                   	push   %esi
801031f5:	53                   	push   %ebx
801031f6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031f9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103200:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103207:	c1 e0 08             	shl    $0x8,%eax
8010320a:	09 d0                	or     %edx,%eax
8010320c:	c1 e0 04             	shl    $0x4,%eax
8010320f:	75 1b                	jne    8010322c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103211:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103218:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010321f:	c1 e0 08             	shl    $0x8,%eax
80103222:	09 d0                	or     %edx,%eax
80103224:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103227:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010322c:	ba 00 04 00 00       	mov    $0x400,%edx
80103231:	e8 3a ff ff ff       	call   80103170 <mpsearch1>
80103236:	89 c3                	mov    %eax,%ebx
80103238:	85 c0                	test   %eax,%eax
8010323a:	0f 84 40 01 00 00    	je     80103380 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103240:	8b 73 04             	mov    0x4(%ebx),%esi
80103243:	85 f6                	test   %esi,%esi
80103245:	0f 84 25 01 00 00    	je     80103370 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010324b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010324e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103254:	6a 04                	push   $0x4
80103256:	68 dd 84 10 80       	push   $0x801084dd
8010325b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010325c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010325f:	e8 3c 17 00 00       	call   801049a0 <memcmp>
80103264:	83 c4 10             	add    $0x10,%esp
80103267:	85 c0                	test   %eax,%eax
80103269:	0f 85 01 01 00 00    	jne    80103370 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010326f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103276:	3c 01                	cmp    $0x1,%al
80103278:	74 08                	je     80103282 <mpinit+0x92>
8010327a:	3c 04                	cmp    $0x4,%al
8010327c:	0f 85 ee 00 00 00    	jne    80103370 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103282:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103289:	66 85 d2             	test   %dx,%dx
8010328c:	74 22                	je     801032b0 <mpinit+0xc0>
8010328e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103291:	89 f0                	mov    %esi,%eax
  sum = 0;
80103293:	31 d2                	xor    %edx,%edx
80103295:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103298:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010329f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032a2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032a4:	39 c7                	cmp    %eax,%edi
801032a6:	75 f0                	jne    80103298 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801032a8:	84 d2                	test   %dl,%dl
801032aa:	0f 85 c0 00 00 00    	jne    80103370 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032b0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801032b6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032bb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032c2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801032c8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032cd:	03 55 e4             	add    -0x1c(%ebp),%edx
801032d0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801032d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032d7:	90                   	nop
801032d8:	39 d0                	cmp    %edx,%eax
801032da:	73 15                	jae    801032f1 <mpinit+0x101>
    switch(*p){
801032dc:	0f b6 08             	movzbl (%eax),%ecx
801032df:	80 f9 02             	cmp    $0x2,%cl
801032e2:	74 4c                	je     80103330 <mpinit+0x140>
801032e4:	77 3a                	ja     80103320 <mpinit+0x130>
801032e6:	84 c9                	test   %cl,%cl
801032e8:	74 56                	je     80103340 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032ea:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032ed:	39 d0                	cmp    %edx,%eax
801032ef:	72 eb                	jb     801032dc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032f1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801032f4:	85 f6                	test   %esi,%esi
801032f6:	0f 84 d9 00 00 00    	je     801033d5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032fc:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103300:	74 15                	je     80103317 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103302:	b8 70 00 00 00       	mov    $0x70,%eax
80103307:	ba 22 00 00 00       	mov    $0x22,%edx
8010330c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010330d:	ba 23 00 00 00       	mov    $0x23,%edx
80103312:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103313:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103316:	ee                   	out    %al,(%dx)
  }
}
80103317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010331a:	5b                   	pop    %ebx
8010331b:	5e                   	pop    %esi
8010331c:	5f                   	pop    %edi
8010331d:	5d                   	pop    %ebp
8010331e:	c3                   	ret    
8010331f:	90                   	nop
    switch(*p){
80103320:	83 e9 03             	sub    $0x3,%ecx
80103323:	80 f9 01             	cmp    $0x1,%cl
80103326:	76 c2                	jbe    801032ea <mpinit+0xfa>
80103328:	31 f6                	xor    %esi,%esi
8010332a:	eb ac                	jmp    801032d8 <mpinit+0xe8>
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103330:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103334:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103337:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010333d:	eb 99                	jmp    801032d8 <mpinit+0xe8>
8010333f:	90                   	nop
      if(ncpu < NCPU) {
80103340:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103346:	83 f9 07             	cmp    $0x7,%ecx
80103349:	7f 19                	jg     80103364 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010334b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103351:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103355:	83 c1 01             	add    $0x1,%ecx
80103358:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010335e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103364:	83 c0 14             	add    $0x14,%eax
      continue;
80103367:	e9 6c ff ff ff       	jmp    801032d8 <mpinit+0xe8>
8010336c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103370:	83 ec 0c             	sub    $0xc,%esp
80103373:	68 e2 84 10 80       	push   $0x801084e2
80103378:	e8 03 d0 ff ff       	call   80100380 <panic>
8010337d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103380:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103385:	eb 13                	jmp    8010339a <mpinit+0x1aa>
80103387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010338e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103390:	89 f3                	mov    %esi,%ebx
80103392:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103398:	74 d6                	je     80103370 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010339a:	83 ec 04             	sub    $0x4,%esp
8010339d:	8d 73 10             	lea    0x10(%ebx),%esi
801033a0:	6a 04                	push   $0x4
801033a2:	68 d8 84 10 80       	push   $0x801084d8
801033a7:	53                   	push   %ebx
801033a8:	e8 f3 15 00 00       	call   801049a0 <memcmp>
801033ad:	83 c4 10             	add    $0x10,%esp
801033b0:	85 c0                	test   %eax,%eax
801033b2:	75 dc                	jne    80103390 <mpinit+0x1a0>
801033b4:	89 da                	mov    %ebx,%edx
801033b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033bd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033c0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033c3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033c6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033c8:	39 d6                	cmp    %edx,%esi
801033ca:	75 f4                	jne    801033c0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033cc:	84 c0                	test   %al,%al
801033ce:	75 c0                	jne    80103390 <mpinit+0x1a0>
801033d0:	e9 6b fe ff ff       	jmp    80103240 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801033d5:	83 ec 0c             	sub    $0xc,%esp
801033d8:	68 fc 84 10 80       	push   $0x801084fc
801033dd:	e8 9e cf ff ff       	call   80100380 <panic>
801033e2:	66 90                	xchg   %ax,%ax
801033e4:	66 90                	xchg   %ax,%ax
801033e6:	66 90                	xchg   %ax,%ax
801033e8:	66 90                	xchg   %ax,%ax
801033ea:	66 90                	xchg   %ax,%ax
801033ec:	66 90                	xchg   %ax,%ax
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <picinit>:
801033f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033f5:	ba 21 00 00 00       	mov    $0x21,%edx
801033fa:	ee                   	out    %al,(%dx)
801033fb:	ba a1 00 00 00       	mov    $0xa1,%edx
80103400:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103401:	c3                   	ret    
80103402:	66 90                	xchg   %ax,%ax
80103404:	66 90                	xchg   %ax,%ax
80103406:	66 90                	xchg   %ax,%ax
80103408:	66 90                	xchg   %ax,%ax
8010340a:	66 90                	xchg   %ax,%ax
8010340c:	66 90                	xchg   %ax,%ax
8010340e:	66 90                	xchg   %ax,%ax

80103410 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	57                   	push   %edi
80103414:	56                   	push   %esi
80103415:	53                   	push   %ebx
80103416:	83 ec 0c             	sub    $0xc,%esp
80103419:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010341c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010341f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103425:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010342b:	e8 e0 d9 ff ff       	call   80100e10 <filealloc>
80103430:	89 03                	mov    %eax,(%ebx)
80103432:	85 c0                	test   %eax,%eax
80103434:	0f 84 a8 00 00 00    	je     801034e2 <pipealloc+0xd2>
8010343a:	e8 d1 d9 ff ff       	call   80100e10 <filealloc>
8010343f:	89 06                	mov    %eax,(%esi)
80103441:	85 c0                	test   %eax,%eax
80103443:	0f 84 87 00 00 00    	je     801034d0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103449:	e8 12 f2 ff ff       	call   80102660 <kalloc>
8010344e:	89 c7                	mov    %eax,%edi
80103450:	85 c0                	test   %eax,%eax
80103452:	0f 84 b0 00 00 00    	je     80103508 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103458:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010345f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103462:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103465:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010346c:	00 00 00 
  p->nwrite = 0;
8010346f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103476:	00 00 00 
  p->nread = 0;
80103479:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103480:	00 00 00 
  initlock(&p->lock, "pipe");
80103483:	68 1b 85 10 80       	push   $0x8010851b
80103488:	50                   	push   %eax
80103489:	e8 32 12 00 00       	call   801046c0 <initlock>
  (*f0)->type = FD_PIPE;
8010348e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103490:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103493:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103499:	8b 03                	mov    (%ebx),%eax
8010349b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010349f:	8b 03                	mov    (%ebx),%eax
801034a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034a5:	8b 03                	mov    (%ebx),%eax
801034a7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034aa:	8b 06                	mov    (%esi),%eax
801034ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034b2:	8b 06                	mov    (%esi),%eax
801034b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034b8:	8b 06                	mov    (%esi),%eax
801034ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034be:	8b 06                	mov    (%esi),%eax
801034c0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034c6:	31 c0                	xor    %eax,%eax
}
801034c8:	5b                   	pop    %ebx
801034c9:	5e                   	pop    %esi
801034ca:	5f                   	pop    %edi
801034cb:	5d                   	pop    %ebp
801034cc:	c3                   	ret    
801034cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801034d0:	8b 03                	mov    (%ebx),%eax
801034d2:	85 c0                	test   %eax,%eax
801034d4:	74 1e                	je     801034f4 <pipealloc+0xe4>
    fileclose(*f0);
801034d6:	83 ec 0c             	sub    $0xc,%esp
801034d9:	50                   	push   %eax
801034da:	e8 f1 d9 ff ff       	call   80100ed0 <fileclose>
801034df:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034e2:	8b 06                	mov    (%esi),%eax
801034e4:	85 c0                	test   %eax,%eax
801034e6:	74 0c                	je     801034f4 <pipealloc+0xe4>
    fileclose(*f1);
801034e8:	83 ec 0c             	sub    $0xc,%esp
801034eb:	50                   	push   %eax
801034ec:	e8 df d9 ff ff       	call   80100ed0 <fileclose>
801034f1:	83 c4 10             	add    $0x10,%esp
}
801034f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801034f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034fc:	5b                   	pop    %ebx
801034fd:	5e                   	pop    %esi
801034fe:	5f                   	pop    %edi
801034ff:	5d                   	pop    %ebp
80103500:	c3                   	ret    
80103501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103508:	8b 03                	mov    (%ebx),%eax
8010350a:	85 c0                	test   %eax,%eax
8010350c:	75 c8                	jne    801034d6 <pipealloc+0xc6>
8010350e:	eb d2                	jmp    801034e2 <pipealloc+0xd2>

80103510 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	56                   	push   %esi
80103514:	53                   	push   %ebx
80103515:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103518:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010351b:	83 ec 0c             	sub    $0xc,%esp
8010351e:	53                   	push   %ebx
8010351f:	e8 6c 13 00 00       	call   80104890 <acquire>
  if(writable){
80103524:	83 c4 10             	add    $0x10,%esp
80103527:	85 f6                	test   %esi,%esi
80103529:	74 65                	je     80103590 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010352b:	83 ec 0c             	sub    $0xc,%esp
8010352e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103534:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010353b:	00 00 00 
    wakeup(&p->nread);
8010353e:	50                   	push   %eax
8010353f:	e8 4c 0d 00 00       	call   80104290 <wakeup>
80103544:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103547:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010354d:	85 d2                	test   %edx,%edx
8010354f:	75 0a                	jne    8010355b <pipeclose+0x4b>
80103551:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103557:	85 c0                	test   %eax,%eax
80103559:	74 15                	je     80103570 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010355b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010355e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103561:	5b                   	pop    %ebx
80103562:	5e                   	pop    %esi
80103563:	5d                   	pop    %ebp
    release(&p->lock);
80103564:	e9 c7 12 00 00       	jmp    80104830 <release>
80103569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 b7 12 00 00       	call   80104830 <release>
    kfree((char*)p);
80103579:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010357c:	83 c4 10             	add    $0x10,%esp
}
8010357f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103582:	5b                   	pop    %ebx
80103583:	5e                   	pop    %esi
80103584:	5d                   	pop    %ebp
    kfree((char*)p);
80103585:	e9 16 ef ff ff       	jmp    801024a0 <kfree>
8010358a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103590:	83 ec 0c             	sub    $0xc,%esp
80103593:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103599:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035a0:	00 00 00 
    wakeup(&p->nwrite);
801035a3:	50                   	push   %eax
801035a4:	e8 e7 0c 00 00       	call   80104290 <wakeup>
801035a9:	83 c4 10             	add    $0x10,%esp
801035ac:	eb 99                	jmp    80103547 <pipeclose+0x37>
801035ae:	66 90                	xchg   %ax,%ax

801035b0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035b0:	55                   	push   %ebp
801035b1:	89 e5                	mov    %esp,%ebp
801035b3:	57                   	push   %edi
801035b4:	56                   	push   %esi
801035b5:	53                   	push   %ebx
801035b6:	83 ec 28             	sub    $0x28,%esp
801035b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035bc:	53                   	push   %ebx
801035bd:	e8 ce 12 00 00       	call   80104890 <acquire>
  for(i = 0; i < n; i++){
801035c2:	8b 45 10             	mov    0x10(%ebp),%eax
801035c5:	83 c4 10             	add    $0x10,%esp
801035c8:	85 c0                	test   %eax,%eax
801035ca:	0f 8e c0 00 00 00    	jle    80103690 <pipewrite+0xe0>
801035d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035d3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035d9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801035df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035e2:	03 45 10             	add    0x10(%ebp),%eax
801035e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035e8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035ee:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f4:	89 ca                	mov    %ecx,%edx
801035f6:	05 00 02 00 00       	add    $0x200,%eax
801035fb:	39 c1                	cmp    %eax,%ecx
801035fd:	74 3f                	je     8010363e <pipewrite+0x8e>
801035ff:	eb 67                	jmp    80103668 <pipewrite+0xb8>
80103601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103608:	e8 e3 03 00 00       	call   801039f0 <myproc>
8010360d:	8b 48 24             	mov    0x24(%eax),%ecx
80103610:	85 c9                	test   %ecx,%ecx
80103612:	75 34                	jne    80103648 <pipewrite+0x98>
      wakeup(&p->nread);
80103614:	83 ec 0c             	sub    $0xc,%esp
80103617:	57                   	push   %edi
80103618:	e8 73 0c 00 00       	call   80104290 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010361d:	58                   	pop    %eax
8010361e:	5a                   	pop    %edx
8010361f:	53                   	push   %ebx
80103620:	56                   	push   %esi
80103621:	e8 aa 0b 00 00       	call   801041d0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103626:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010362c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103632:	83 c4 10             	add    $0x10,%esp
80103635:	05 00 02 00 00       	add    $0x200,%eax
8010363a:	39 c2                	cmp    %eax,%edx
8010363c:	75 2a                	jne    80103668 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010363e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103644:	85 c0                	test   %eax,%eax
80103646:	75 c0                	jne    80103608 <pipewrite+0x58>
        release(&p->lock);
80103648:	83 ec 0c             	sub    $0xc,%esp
8010364b:	53                   	push   %ebx
8010364c:	e8 df 11 00 00       	call   80104830 <release>
        return -1;
80103651:	83 c4 10             	add    $0x10,%esp
80103654:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103659:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010365c:	5b                   	pop    %ebx
8010365d:	5e                   	pop    %esi
8010365e:	5f                   	pop    %edi
8010365f:	5d                   	pop    %ebp
80103660:	c3                   	ret    
80103661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103668:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010366b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010366e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103674:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010367a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010367d:	83 c6 01             	add    $0x1,%esi
80103680:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103683:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103687:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010368a:	0f 85 58 ff ff ff    	jne    801035e8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103690:	83 ec 0c             	sub    $0xc,%esp
80103693:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103699:	50                   	push   %eax
8010369a:	e8 f1 0b 00 00       	call   80104290 <wakeup>
  release(&p->lock);
8010369f:	89 1c 24             	mov    %ebx,(%esp)
801036a2:	e8 89 11 00 00       	call   80104830 <release>
  return n;
801036a7:	8b 45 10             	mov    0x10(%ebp),%eax
801036aa:	83 c4 10             	add    $0x10,%esp
801036ad:	eb aa                	jmp    80103659 <pipewrite+0xa9>
801036af:	90                   	nop

801036b0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	57                   	push   %edi
801036b4:	56                   	push   %esi
801036b5:	53                   	push   %ebx
801036b6:	83 ec 18             	sub    $0x18,%esp
801036b9:	8b 75 08             	mov    0x8(%ebp),%esi
801036bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036bf:	56                   	push   %esi
801036c0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036c6:	e8 c5 11 00 00       	call   80104890 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036cb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036d1:	83 c4 10             	add    $0x10,%esp
801036d4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036da:	74 2f                	je     8010370b <piperead+0x5b>
801036dc:	eb 37                	jmp    80103715 <piperead+0x65>
801036de:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801036e0:	e8 0b 03 00 00       	call   801039f0 <myproc>
801036e5:	8b 48 24             	mov    0x24(%eax),%ecx
801036e8:	85 c9                	test   %ecx,%ecx
801036ea:	0f 85 80 00 00 00    	jne    80103770 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036f0:	83 ec 08             	sub    $0x8,%esp
801036f3:	56                   	push   %esi
801036f4:	53                   	push   %ebx
801036f5:	e8 d6 0a 00 00       	call   801041d0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036fa:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103700:	83 c4 10             	add    $0x10,%esp
80103703:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103709:	75 0a                	jne    80103715 <piperead+0x65>
8010370b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103711:	85 c0                	test   %eax,%eax
80103713:	75 cb                	jne    801036e0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103715:	8b 55 10             	mov    0x10(%ebp),%edx
80103718:	31 db                	xor    %ebx,%ebx
8010371a:	85 d2                	test   %edx,%edx
8010371c:	7f 20                	jg     8010373e <piperead+0x8e>
8010371e:	eb 2c                	jmp    8010374c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103720:	8d 48 01             	lea    0x1(%eax),%ecx
80103723:	25 ff 01 00 00       	and    $0x1ff,%eax
80103728:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010372e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103733:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103736:	83 c3 01             	add    $0x1,%ebx
80103739:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010373c:	74 0e                	je     8010374c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010373e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103744:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010374a:	75 d4                	jne    80103720 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010374c:	83 ec 0c             	sub    $0xc,%esp
8010374f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103755:	50                   	push   %eax
80103756:	e8 35 0b 00 00       	call   80104290 <wakeup>
  release(&p->lock);
8010375b:	89 34 24             	mov    %esi,(%esp)
8010375e:	e8 cd 10 00 00       	call   80104830 <release>
  return i;
80103763:	83 c4 10             	add    $0x10,%esp
}
80103766:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103769:	89 d8                	mov    %ebx,%eax
8010376b:	5b                   	pop    %ebx
8010376c:	5e                   	pop    %esi
8010376d:	5f                   	pop    %edi
8010376e:	5d                   	pop    %ebp
8010376f:	c3                   	ret    
      release(&p->lock);
80103770:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103773:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103778:	56                   	push   %esi
80103779:	e8 b2 10 00 00       	call   80104830 <release>
      return -1;
8010377e:	83 c4 10             	add    $0x10,%esp
}
80103781:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103784:	89 d8                	mov    %ebx,%eax
80103786:	5b                   	pop    %ebx
80103787:	5e                   	pop    %esi
80103788:	5f                   	pop    %edi
80103789:	5d                   	pop    %ebp
8010378a:	c3                   	ret    
8010378b:	66 90                	xchg   %ax,%ax
8010378d:	66 90                	xchg   %ax,%ax
8010378f:	90                   	nop

80103790 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	57                   	push   %edi
80103794:	56                   	push   %esi
80103795:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103796:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
8010379b:	83 ec 38             	sub    $0x38,%esp
  acquire(&ptable.lock);
8010379e:	68 20 2d 11 80       	push   $0x80112d20
801037a3:	e8 e8 10 00 00       	call   80104890 <acquire>
801037a8:	83 c4 10             	add    $0x10,%esp
801037ab:	eb 15                	jmp    801037c2 <allocproc+0x32>
801037ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b0:	81 c3 94 00 00 00    	add    $0x94,%ebx
801037b6:	81 fb 54 52 11 80    	cmp    $0x80115254,%ebx
801037bc:	0f 84 0e 01 00 00    	je     801038d0 <allocproc+0x140>
    if(p->state == UNUSED)
801037c2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037c5:	85 c0                	test   %eax,%eax
801037c7:	75 e7                	jne    801037b0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037c9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->priority=10;
  char isker[3];
  int j=0;
  for(int i=strlen(p->name)-3;i<strlen(p->name);i++){
801037ce:	83 ec 0c             	sub    $0xc,%esp
801037d1:	8d 7d e5             	lea    -0x1b(%ebp),%edi
  p->state = EMBRYO;
801037d4:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority=10;
801037db:	c7 83 90 00 00 00 0a 	movl   $0xa,0x90(%ebx)
801037e2:	00 00 00 
  p->pid = nextpid++;
801037e5:	89 43 10             	mov    %eax,0x10(%ebx)
801037e8:	8d 50 01             	lea    0x1(%eax),%edx
  for(int i=strlen(p->name)-3;i<strlen(p->name);i++){
801037eb:	8d 43 6c             	lea    0x6c(%ebx),%eax
801037ee:	50                   	push   %eax
  p->pid = nextpid++;
801037ef:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  for(int i=strlen(p->name)-3;i<strlen(p->name);i++){
801037f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801037f8:	e8 53 13 00 00       	call   80104b50 <strlen>
801037fd:	83 c4 10             	add    $0x10,%esp
80103800:	8d 70 fd             	lea    -0x3(%eax),%esi
80103803:	83 ec 0c             	sub    $0xc,%esp
80103806:	ff 75 d4             	push   -0x2c(%ebp)
80103809:	e8 42 13 00 00       	call   80104b50 <strlen>
8010380e:	83 c4 10             	add    $0x10,%esp
80103811:	39 f0                	cmp    %esi,%eax
80103813:	7e 13                	jle    80103828 <allocproc+0x98>
   isker[j]+=p->name[i];
80103815:	0f b6 44 33 6c       	movzbl 0x6c(%ebx,%esi,1),%eax
  for(int i=strlen(p->name)-3;i<strlen(p->name);i++){
8010381a:	83 c6 01             	add    $0x1,%esi
   isker[j]+=p->name[i];
8010381d:	00 07                	add    %al,(%edi)
  for(int i=strlen(p->name)-3;i<strlen(p->name);i++){
8010381f:	83 c7 01             	add    $0x1,%edi
80103822:	eb df                	jmp    80103803 <allocproc+0x73>
80103824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
   j++;
  }
  if(strncmp(isker,"ker",3) == 0) // is a text file
80103828:	83 ec 04             	sub    $0x4,%esp
8010382b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
8010382e:	6a 03                	push   $0x3
80103830:	68 20 85 10 80       	push   $0x80108520
80103835:	50                   	push   %eax
80103836:	e8 25 12 00 00       	call   80104a60 <strncmp>
8010383b:	83 c4 10             	add    $0x10,%esp
8010383e:	85 c0                	test   %eax,%eax
80103840:	74 7e                	je     801038c0 <allocproc+0x130>
  {p->priority = 9;}
  

  p->end_time = 0;
80103842:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103849:	00 00 00 
  p->ran_time = 0;
  p->wait_time = 0;
  
  release(&ptable.lock);
8010384c:	83 ec 0c             	sub    $0xc,%esp
  p->ran_time = 0;
8010384f:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103856:	00 00 00 
  p->wait_time = 0;
80103859:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103860:	00 00 00 
  release(&ptable.lock);
80103863:	68 20 2d 11 80       	push   $0x80112d20
80103868:	e8 c3 0f 00 00       	call   80104830 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010386d:	e8 ee ed ff ff       	call   80102660 <kalloc>
80103872:	83 c4 10             	add    $0x10,%esp
80103875:	89 43 08             	mov    %eax,0x8(%ebx)
80103878:	85 c0                	test   %eax,%eax
8010387a:	74 70                	je     801038ec <allocproc+0x15c>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010387c:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103882:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103885:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010388a:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010388d:	c7 40 14 12 63 10 80 	movl   $0x80106312,0x14(%eax)
  p->context = (struct context*)sp;
80103894:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103897:	6a 14                	push   $0x14
80103899:	6a 00                	push   $0x0
8010389b:	50                   	push   %eax
8010389c:	e8 af 10 00 00       	call   80104950 <memset>
  p->context->eip = (uint)forkret;
801038a1:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801038a4:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801038a7:	c7 40 10 00 39 10 80 	movl   $0x80103900,0x10(%eax)
}
801038ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b1:	89 d8                	mov    %ebx,%eax
801038b3:	5b                   	pop    %ebx
801038b4:	5e                   	pop    %esi
801038b5:	5f                   	pop    %edi
801038b6:	5d                   	pop    %ebp
801038b7:	c3                   	ret    
801038b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038bf:	90                   	nop
  {p->priority = 9;}
801038c0:	c7 83 90 00 00 00 09 	movl   $0x9,0x90(%ebx)
801038c7:	00 00 00 
801038ca:	e9 73 ff ff ff       	jmp    80103842 <allocproc+0xb2>
801038cf:	90                   	nop
  release(&ptable.lock);
801038d0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801038d3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038d5:	68 20 2d 11 80       	push   $0x80112d20
801038da:	e8 51 0f 00 00       	call   80104830 <release>
  return 0;
801038df:	83 c4 10             	add    $0x10,%esp
}
801038e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038e5:	89 d8                	mov    %ebx,%eax
801038e7:	5b                   	pop    %ebx
801038e8:	5e                   	pop    %esi
801038e9:	5f                   	pop    %edi
801038ea:	5d                   	pop    %ebp
801038eb:	c3                   	ret    
    p->state = UNUSED;
801038ec:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
}
801038f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801038f6:	31 db                	xor    %ebx,%ebx
}
801038f8:	89 d8                	mov    %ebx,%eax
801038fa:	5b                   	pop    %ebx
801038fb:	5e                   	pop    %esi
801038fc:	5f                   	pop    %edi
801038fd:	5d                   	pop    %ebp
801038fe:	c3                   	ret    
801038ff:	90                   	nop

80103900 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103906:	68 20 2d 11 80       	push   $0x80112d20
8010390b:	e8 20 0f 00 00       	call   80104830 <release>

  if (first) {
80103910:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103915:	83 c4 10             	add    $0x10,%esp
80103918:	85 c0                	test   %eax,%eax
8010391a:	75 04                	jne    80103920 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010391c:	c9                   	leave  
8010391d:	c3                   	ret    
8010391e:	66 90                	xchg   %ax,%ax
    first = 0;
80103920:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103927:	00 00 00 
    iinit(ROOTDEV);
8010392a:	83 ec 0c             	sub    $0xc,%esp
8010392d:	6a 01                	push   $0x1
8010392f:	e8 0c dc ff ff       	call   80101540 <iinit>
    initlog(ROOTDEV);
80103934:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010393b:	e8 60 f3 ff ff       	call   80102ca0 <initlog>
}
80103940:	83 c4 10             	add    $0x10,%esp
80103943:	c9                   	leave  
80103944:	c3                   	ret    
80103945:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010394c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103950 <pinit>:
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103956:	68 24 85 10 80       	push   $0x80108524
8010395b:	68 20 2d 11 80       	push   $0x80112d20
80103960:	e8 5b 0d 00 00       	call   801046c0 <initlock>
}
80103965:	83 c4 10             	add    $0x10,%esp
80103968:	c9                   	leave  
80103969:	c3                   	ret    
8010396a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103970 <mycpu>:
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	56                   	push   %esi
80103974:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103975:	9c                   	pushf  
80103976:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103977:	f6 c4 02             	test   $0x2,%ah
8010397a:	75 46                	jne    801039c2 <mycpu+0x52>
  apicid = lapicid();
8010397c:	e8 4f ef ff ff       	call   801028d0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103981:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103987:	85 f6                	test   %esi,%esi
80103989:	7e 2a                	jle    801039b5 <mycpu+0x45>
8010398b:	31 d2                	xor    %edx,%edx
8010398d:	eb 08                	jmp    80103997 <mycpu+0x27>
8010398f:	90                   	nop
80103990:	83 c2 01             	add    $0x1,%edx
80103993:	39 f2                	cmp    %esi,%edx
80103995:	74 1e                	je     801039b5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103997:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010399d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
801039a4:	39 c3                	cmp    %eax,%ebx
801039a6:	75 e8                	jne    80103990 <mycpu+0x20>
}
801039a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801039ab:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
801039b1:	5b                   	pop    %ebx
801039b2:	5e                   	pop    %esi
801039b3:	5d                   	pop    %ebp
801039b4:	c3                   	ret    
  panic("unknown apicid\n");
801039b5:	83 ec 0c             	sub    $0xc,%esp
801039b8:	68 2b 85 10 80       	push   $0x8010852b
801039bd:	e8 be c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
801039c2:	83 ec 0c             	sub    $0xc,%esp
801039c5:	68 08 86 10 80       	push   $0x80108608
801039ca:	e8 b1 c9 ff ff       	call   80100380 <panic>
801039cf:	90                   	nop

801039d0 <cpuid>:
cpuid() {
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801039d6:	e8 95 ff ff ff       	call   80103970 <mycpu>
}
801039db:	c9                   	leave  
  return mycpu()-cpus;
801039dc:	2d a0 27 11 80       	sub    $0x801127a0,%eax
801039e1:	c1 f8 04             	sar    $0x4,%eax
801039e4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039ea:	c3                   	ret    
801039eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039ef:	90                   	nop

801039f0 <myproc>:
myproc(void) {
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
801039f4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039f7:	e8 44 0d 00 00       	call   80104740 <pushcli>
  c = mycpu();
801039fc:	e8 6f ff ff ff       	call   80103970 <mycpu>
  p = c->proc;
80103a01:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a07:	e8 84 0d 00 00       	call   80104790 <popcli>
}
80103a0c:	89 d8                	mov    %ebx,%eax
80103a0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a11:	c9                   	leave  
80103a12:	c3                   	ret    
80103a13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a20 <userinit>:
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	53                   	push   %ebx
80103a24:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103a27:	e8 64 fd ff ff       	call   80103790 <allocproc>
80103a2c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a2e:	a3 54 52 11 80       	mov    %eax,0x80115254
  if((p->pgdir = setupkvm()) == 0)
80103a33:	e8 28 40 00 00       	call   80107a60 <setupkvm>
80103a38:	89 43 04             	mov    %eax,0x4(%ebx)
80103a3b:	85 c0                	test   %eax,%eax
80103a3d:	0f 84 c7 00 00 00    	je     80103b0a <userinit+0xea>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a43:	83 ec 04             	sub    $0x4,%esp
80103a46:	68 2c 00 00 00       	push   $0x2c
80103a4b:	68 60 b4 10 80       	push   $0x8010b460
80103a50:	50                   	push   %eax
80103a51:	e8 ba 3c 00 00       	call   80107710 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a56:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a59:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  p->stacktop = 0;
80103a5f:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103a66:	00 00 00 
  memset(p->tf, 0, sizeof(*p->tf));
80103a69:	6a 4c                	push   $0x4c
80103a6b:	6a 00                	push   $0x0
80103a6d:	ff 73 18             	push   0x18(%ebx)
80103a70:	e8 db 0e 00 00       	call   80104950 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a75:	8b 43 18             	mov    0x18(%ebx),%eax
80103a78:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a7d:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a80:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a85:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a89:	8b 43 18             	mov    0x18(%ebx),%eax
80103a8c:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a90:	8b 43 18             	mov    0x18(%ebx),%eax
80103a93:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a97:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a9b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a9e:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103aa2:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103aa6:	8b 43 18             	mov    0x18(%ebx),%eax
80103aa9:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ab0:	8b 43 18             	mov    0x18(%ebx),%eax
80103ab3:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103aba:	8b 43 18             	mov    0x18(%ebx),%eax
80103abd:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ac4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ac7:	6a 10                	push   $0x10
80103ac9:	68 54 85 10 80       	push   $0x80108554
80103ace:	50                   	push   %eax
80103acf:	e8 3c 10 00 00       	call   80104b10 <safestrcpy>
  p->cwd = namei("/");
80103ad4:	c7 04 24 5d 85 10 80 	movl   $0x8010855d,(%esp)
80103adb:	e8 a0 e5 ff ff       	call   80102080 <namei>
80103ae0:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103ae3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103aea:	e8 a1 0d 00 00       	call   80104890 <acquire>
  p->state = RUNNABLE;
80103aef:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103af6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103afd:	e8 2e 0d 00 00       	call   80104830 <release>
}
80103b02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b05:	83 c4 10             	add    $0x10,%esp
80103b08:	c9                   	leave  
80103b09:	c3                   	ret    
    panic("userinit: out of memory?");
80103b0a:	83 ec 0c             	sub    $0xc,%esp
80103b0d:	68 3b 85 10 80       	push   $0x8010853b
80103b12:	e8 69 c8 ff ff       	call   80100380 <panic>
80103b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b1e:	66 90                	xchg   %ax,%ax

80103b20 <growproc>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	56                   	push   %esi
80103b24:	53                   	push   %ebx
80103b25:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103b28:	e8 13 0c 00 00       	call   80104740 <pushcli>
  c = mycpu();
80103b2d:	e8 3e fe ff ff       	call   80103970 <mycpu>
  p = c->proc;
80103b32:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b38:	e8 53 0c 00 00       	call   80104790 <popcli>
  sz = curproc->sz;
80103b3d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b3f:	85 f6                	test   %esi,%esi
80103b41:	7f 1d                	jg     80103b60 <growproc+0x40>
  } else if(n < 0){
80103b43:	75 3b                	jne    80103b80 <growproc+0x60>
  switchuvm(curproc);
80103b45:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b48:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b4a:	53                   	push   %ebx
80103b4b:	e8 b0 3a 00 00       	call   80107600 <switchuvm>
  return 0;
80103b50:	83 c4 10             	add    $0x10,%esp
80103b53:	31 c0                	xor    %eax,%eax
}
80103b55:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b58:	5b                   	pop    %ebx
80103b59:	5e                   	pop    %esi
80103b5a:	5d                   	pop    %ebp
80103b5b:	c3                   	ret    
80103b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b60:	83 ec 04             	sub    $0x4,%esp
80103b63:	01 c6                	add    %eax,%esi
80103b65:	56                   	push   %esi
80103b66:	50                   	push   %eax
80103b67:	ff 73 04             	push   0x4(%ebx)
80103b6a:	e8 11 3d 00 00       	call   80107880 <allocuvm>
80103b6f:	83 c4 10             	add    $0x10,%esp
80103b72:	85 c0                	test   %eax,%eax
80103b74:	75 cf                	jne    80103b45 <growproc+0x25>
      return -1;
80103b76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b7b:	eb d8                	jmp    80103b55 <growproc+0x35>
80103b7d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b80:	83 ec 04             	sub    $0x4,%esp
80103b83:	01 c6                	add    %eax,%esi
80103b85:	56                   	push   %esi
80103b86:	50                   	push   %eax
80103b87:	ff 73 04             	push   0x4(%ebx)
80103b8a:	e8 21 3e 00 00       	call   801079b0 <deallocuvm>
80103b8f:	83 c4 10             	add    $0x10,%esp
80103b92:	85 c0                	test   %eax,%eax
80103b94:	75 af                	jne    80103b45 <growproc+0x25>
80103b96:	eb de                	jmp    80103b76 <growproc+0x56>
80103b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b9f:	90                   	nop

80103ba0 <fork>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	57                   	push   %edi
80103ba4:	56                   	push   %esi
80103ba5:	53                   	push   %ebx
80103ba6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ba9:	e8 92 0b 00 00       	call   80104740 <pushcli>
  c = mycpu();
80103bae:	e8 bd fd ff ff       	call   80103970 <mycpu>
  p = c->proc;
80103bb3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bb9:	e8 d2 0b 00 00       	call   80104790 <popcli>
  acquire(&tickslock);
80103bbe:	83 ec 0c             	sub    $0xc,%esp
80103bc1:	68 80 52 11 80       	push   $0x80115280
80103bc6:	e8 c5 0c 00 00       	call   80104890 <acquire>
  curproc->create_time = ticks;
80103bcb:	a1 60 52 11 80       	mov    0x80115260,%eax
80103bd0:	89 43 7c             	mov    %eax,0x7c(%ebx)
  release(&tickslock);
80103bd3:	c7 04 24 80 52 11 80 	movl   $0x80115280,(%esp)
80103bda:	e8 51 0c 00 00       	call   80104830 <release>
  if((np = allocproc()) == 0){
80103bdf:	e8 ac fb ff ff       	call   80103790 <allocproc>
80103be4:	83 c4 10             	add    $0x10,%esp
80103be7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103bea:	85 c0                	test   %eax,%eax
80103bec:	0f 84 e7 00 00 00    	je     80103cd9 <fork+0x139>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz,curproc->stacktop)) == 0){
80103bf2:	83 ec 04             	sub    $0x4,%esp
80103bf5:	ff b3 8c 00 00 00    	push   0x8c(%ebx)
80103bfb:	89 c7                	mov    %eax,%edi
80103bfd:	ff 33                	push   (%ebx)
80103bff:	ff 73 04             	push   0x4(%ebx)
80103c02:	e8 99 3f 00 00       	call   80107ba0 <copyuvm>
80103c07:	83 c4 10             	add    $0x10,%esp
80103c0a:	89 47 04             	mov    %eax,0x4(%edi)
80103c0d:	85 c0                	test   %eax,%eax
80103c0f:	0f 84 cb 00 00 00    	je     80103ce0 <fork+0x140>
  np->sz = curproc->sz;
80103c15:	8b 03                	mov    (%ebx),%eax
80103c17:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c1a:	89 01                	mov    %eax,(%ecx)
  np->stacktop = curproc->stacktop;
80103c1c:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
  *np->tf = *curproc->tf;
80103c22:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103c25:	89 59 14             	mov    %ebx,0x14(%ecx)
  np->stacktop = curproc->stacktop;
80103c28:	89 81 8c 00 00 00    	mov    %eax,0x8c(%ecx)
  np->parent = curproc;
80103c2e:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103c30:	8b 73 18             	mov    0x18(%ebx),%esi
80103c33:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c38:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c3a:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103c3c:	8b 40 18             	mov    0x18(%eax),%eax
80103c3f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103c46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80103c50:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c54:	85 c0                	test   %eax,%eax
80103c56:	74 13                	je     80103c6b <fork+0xcb>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c58:	83 ec 0c             	sub    $0xc,%esp
80103c5b:	50                   	push   %eax
80103c5c:	e8 1f d2 ff ff       	call   80100e80 <filedup>
80103c61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c64:	83 c4 10             	add    $0x10,%esp
80103c67:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c6b:	83 c6 01             	add    $0x1,%esi
80103c6e:	83 fe 10             	cmp    $0x10,%esi
80103c71:	75 dd                	jne    80103c50 <fork+0xb0>
  np->cwd = idup(curproc->cwd);
80103c73:	83 ec 0c             	sub    $0xc,%esp
80103c76:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c79:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103c7c:	e8 af da ff ff       	call   80101730 <idup>
80103c81:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c84:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c87:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c8a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c8d:	6a 10                	push   $0x10
80103c8f:	53                   	push   %ebx
80103c90:	50                   	push   %eax
80103c91:	e8 7a 0e 00 00       	call   80104b10 <safestrcpy>
  pid = np->pid;
80103c96:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103c99:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ca0:	e8 eb 0b 00 00       	call   80104890 <acquire>
  np->state = RUNNABLE;
80103ca5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  np->wait_time = 0;
80103cac:	c7 87 88 00 00 00 00 	movl   $0x0,0x88(%edi)
80103cb3:	00 00 00 
  np->priority = 10;
80103cb6:	c7 87 90 00 00 00 0a 	movl   $0xa,0x90(%edi)
80103cbd:	00 00 00 
  release(&ptable.lock);
80103cc0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cc7:	e8 64 0b 00 00       	call   80104830 <release>
  return pid;
80103ccc:	83 c4 10             	add    $0x10,%esp
}
80103ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cd2:	89 d8                	mov    %ebx,%eax
80103cd4:	5b                   	pop    %ebx
80103cd5:	5e                   	pop    %esi
80103cd6:	5f                   	pop    %edi
80103cd7:	5d                   	pop    %ebp
80103cd8:	c3                   	ret    
    return -1;
80103cd9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103cde:	eb ef                	jmp    80103ccf <fork+0x12f>
    kfree(np->kstack);
80103ce0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ce3:	83 ec 0c             	sub    $0xc,%esp
80103ce6:	ff 73 08             	push   0x8(%ebx)
80103ce9:	e8 b2 e7 ff ff       	call   801024a0 <kfree>
    np->kstack = 0;
80103cee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103cf5:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103cf8:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103cff:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d04:	eb c9                	jmp    80103ccf <fork+0x12f>
80103d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d0d:	8d 76 00             	lea    0x0(%esi),%esi

80103d10 <scheduler>:
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	57                   	push   %edi
80103d14:	56                   	push   %esi
80103d15:	53                   	push   %ebx
80103d16:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103d19:	e8 52 fc ff ff       	call   80103970 <mycpu>
  c->proc = 0;
80103d1e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d25:	00 00 00 
  struct cpu *c = mycpu();
80103d28:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103d2a:	8d 40 04             	lea    0x4(%eax),%eax
80103d2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80103d30:	fb                   	sti    
    acquire(&ptable.lock);
80103d31:	83 ec 0c             	sub    $0xc,%esp
    struct proc *current = 0;
80103d34:	31 f6                	xor    %esi,%esi
    acquire(&ptable.lock);
80103d36:	68 20 2d 11 80       	push   $0x80112d20
80103d3b:	e8 50 0b 00 00       	call   80104890 <acquire>
80103d40:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d43:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d48:	eb 1b                	jmp    80103d65 <scheduler+0x55>
80103d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(current == 0 || p->create_time < current->create_time)
80103d50:	8b 56 7c             	mov    0x7c(%esi),%edx
80103d53:	39 50 7c             	cmp    %edx,0x7c(%eax)
80103d56:	0f 42 f0             	cmovb  %eax,%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d59:	05 94 00 00 00       	add    $0x94,%eax
80103d5e:	3d 54 52 11 80       	cmp    $0x80115254,%eax
80103d63:	74 1b                	je     80103d80 <scheduler+0x70>
      if(p->state != RUNNABLE)
80103d65:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103d69:	75 ee                	jne    80103d59 <scheduler+0x49>
      if(current == 0 || p->create_time < current->create_time)
80103d6b:	85 f6                	test   %esi,%esi
80103d6d:	75 e1                	jne    80103d50 <scheduler+0x40>
80103d6f:	89 c6                	mov    %eax,%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d71:	05 94 00 00 00       	add    $0x94,%eax
80103d76:	3d 54 52 11 80       	cmp    $0x80115254,%eax
80103d7b:	75 e8                	jne    80103d65 <scheduler+0x55>
80103d7d:	8d 76 00             	lea    0x0(%esi),%esi
if (current != 0) {
80103d80:	85 f6                	test   %esi,%esi
80103d82:	74 75                	je     80103df9 <scheduler+0xe9>
      acquire(&tickslock);
80103d84:	83 ec 0c             	sub    $0xc,%esp
80103d87:	68 80 52 11 80       	push   $0x80115280
80103d8c:	e8 ff 0a 00 00       	call   80104890 <acquire>
      uint present = ticks;
80103d91:	8b 3d 60 52 11 80    	mov    0x80115260,%edi
      release(&tickslock);
80103d97:	c7 04 24 80 52 11 80 	movl   $0x80115280,(%esp)
80103d9e:	e8 8d 0a 00 00       	call   80104830 <release>
      p->wait_time = present - p->create_time;
80103da3:	89 f8                	mov    %edi,%eax
80103da5:	2b 05 d0 52 11 80    	sub    0x801152d0,%eax
80103dab:	a3 dc 52 11 80       	mov    %eax,0x801152dc
      c->proc = current;
80103db0:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
      switchuvm(current);
80103db6:	89 34 24             	mov    %esi,(%esp)
80103db9:	e8 42 38 00 00       	call   80107600 <switchuvm>
      current->state = RUNNING;
80103dbe:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      swtch(&(c->scheduler), current->context);
80103dc5:	58                   	pop    %eax
80103dc6:	5a                   	pop    %edx
80103dc7:	ff 76 1c             	push   0x1c(%esi)
80103dca:	ff 75 e4             	push   -0x1c(%ebp)
80103dcd:	e8 99 0d 00 00       	call   80104b6b <swtch>
      switchkvm();
80103dd2:	e8 19 38 00 00       	call   801075f0 <switchkvm>
      if(p->end_time == 0)
80103dd7:	83 c4 10             	add    $0x10,%esp
      c->proc = 0;
80103dda:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103de1:	00 00 00 
      if(p->end_time == 0)
80103de4:	a1 d4 52 11 80       	mov    0x801152d4,%eax
80103de9:	85 c0                	test   %eax,%eax
80103deb:	75 21                	jne    80103e0e <scheduler+0xfe>
        p->wait_time = present - p->create_time;
80103ded:	2b 3d d0 52 11 80    	sub    0x801152d0,%edi
80103df3:	89 3d dc 52 11 80    	mov    %edi,0x801152dc
    release(&ptable.lock);
80103df9:	83 ec 0c             	sub    $0xc,%esp
80103dfc:	68 20 2d 11 80       	push   $0x80112d20
80103e01:	e8 2a 0a 00 00       	call   80104830 <release>
  for(;;){
80103e06:	83 c4 10             	add    $0x10,%esp
80103e09:	e9 22 ff ff ff       	jmp    80103d30 <scheduler+0x20>
        p->wait_time += present - p->end_time;
80103e0e:	29 c7                	sub    %eax,%edi
80103e10:	01 3d dc 52 11 80    	add    %edi,0x801152dc
80103e16:	eb e1                	jmp    80103df9 <scheduler+0xe9>
80103e18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e1f:	90                   	nop

80103e20 <sched>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	56                   	push   %esi
80103e24:	53                   	push   %ebx
  pushcli();
80103e25:	e8 16 09 00 00       	call   80104740 <pushcli>
  c = mycpu();
80103e2a:	e8 41 fb ff ff       	call   80103970 <mycpu>
  p = c->proc;
80103e2f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e35:	e8 56 09 00 00       	call   80104790 <popcli>
  if(!holding(&ptable.lock))
80103e3a:	83 ec 0c             	sub    $0xc,%esp
80103e3d:	68 20 2d 11 80       	push   $0x80112d20
80103e42:	e8 a9 09 00 00       	call   801047f0 <holding>
80103e47:	83 c4 10             	add    $0x10,%esp
80103e4a:	85 c0                	test   %eax,%eax
80103e4c:	74 4f                	je     80103e9d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103e4e:	e8 1d fb ff ff       	call   80103970 <mycpu>
80103e53:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e5a:	75 68                	jne    80103ec4 <sched+0xa4>
  if(p->state == RUNNING)
80103e5c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e60:	74 55                	je     80103eb7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e62:	9c                   	pushf  
80103e63:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e64:	f6 c4 02             	test   $0x2,%ah
80103e67:	75 41                	jne    80103eaa <sched+0x8a>
  intena = mycpu()->intena;
80103e69:	e8 02 fb ff ff       	call   80103970 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e6e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103e71:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e77:	e8 f4 fa ff ff       	call   80103970 <mycpu>
80103e7c:	83 ec 08             	sub    $0x8,%esp
80103e7f:	ff 70 04             	push   0x4(%eax)
80103e82:	53                   	push   %ebx
80103e83:	e8 e3 0c 00 00       	call   80104b6b <swtch>
  mycpu()->intena = intena;
80103e88:	e8 e3 fa ff ff       	call   80103970 <mycpu>
}
80103e8d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e90:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e99:	5b                   	pop    %ebx
80103e9a:	5e                   	pop    %esi
80103e9b:	5d                   	pop    %ebp
80103e9c:	c3                   	ret    
    panic("sched ptable.lock");
80103e9d:	83 ec 0c             	sub    $0xc,%esp
80103ea0:	68 5f 85 10 80       	push   $0x8010855f
80103ea5:	e8 d6 c4 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103eaa:	83 ec 0c             	sub    $0xc,%esp
80103ead:	68 8b 85 10 80       	push   $0x8010858b
80103eb2:	e8 c9 c4 ff ff       	call   80100380 <panic>
    panic("sched running");
80103eb7:	83 ec 0c             	sub    $0xc,%esp
80103eba:	68 7d 85 10 80       	push   $0x8010857d
80103ebf:	e8 bc c4 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103ec4:	83 ec 0c             	sub    $0xc,%esp
80103ec7:	68 71 85 10 80       	push   $0x80108571
80103ecc:	e8 af c4 ff ff       	call   80100380 <panic>
80103ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103edf:	90                   	nop

80103ee0 <exit>:
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	57                   	push   %edi
80103ee4:	56                   	push   %esi
80103ee5:	53                   	push   %ebx
80103ee6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103ee9:	e8 02 fb ff ff       	call   801039f0 <myproc>
  if(curproc == initproc)
80103eee:	39 05 54 52 11 80    	cmp    %eax,0x80115254
80103ef4:	0f 84 07 01 00 00    	je     80104001 <exit+0x121>
80103efa:	89 c3                	mov    %eax,%ebx
80103efc:	8d 70 28             	lea    0x28(%eax),%esi
80103eff:	8d 78 68             	lea    0x68(%eax),%edi
80103f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103f08:	8b 06                	mov    (%esi),%eax
80103f0a:	85 c0                	test   %eax,%eax
80103f0c:	74 12                	je     80103f20 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103f0e:	83 ec 0c             	sub    $0xc,%esp
80103f11:	50                   	push   %eax
80103f12:	e8 b9 cf ff ff       	call   80100ed0 <fileclose>
      curproc->ofile[fd] = 0;
80103f17:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103f1d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103f20:	83 c6 04             	add    $0x4,%esi
80103f23:	39 f7                	cmp    %esi,%edi
80103f25:	75 e1                	jne    80103f08 <exit+0x28>
  begin_op();
80103f27:	e8 14 ee ff ff       	call   80102d40 <begin_op>
  iput(curproc->cwd);
80103f2c:	83 ec 0c             	sub    $0xc,%esp
80103f2f:	ff 73 68             	push   0x68(%ebx)
80103f32:	e8 59 d9 ff ff       	call   80101890 <iput>
  end_op();
80103f37:	e8 74 ee ff ff       	call   80102db0 <end_op>
  curproc->cwd = 0;
80103f3c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103f43:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f4a:	e8 41 09 00 00       	call   80104890 <acquire>
  wakeup1(curproc->parent);
80103f4f:	8b 53 14             	mov    0x14(%ebx),%edx
80103f52:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f55:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f5a:	eb 10                	jmp    80103f6c <exit+0x8c>
80103f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f60:	05 94 00 00 00       	add    $0x94,%eax
80103f65:	3d 54 52 11 80       	cmp    $0x80115254,%eax
80103f6a:	74 1e                	je     80103f8a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103f6c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f70:	75 ee                	jne    80103f60 <exit+0x80>
80103f72:	3b 50 20             	cmp    0x20(%eax),%edx
80103f75:	75 e9                	jne    80103f60 <exit+0x80>
      p->state = RUNNABLE;
80103f77:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f7e:	05 94 00 00 00       	add    $0x94,%eax
80103f83:	3d 54 52 11 80       	cmp    $0x80115254,%eax
80103f88:	75 e2                	jne    80103f6c <exit+0x8c>
      p->parent = initproc;
80103f8a:	8b 0d 54 52 11 80    	mov    0x80115254,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f90:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103f95:	eb 17                	jmp    80103fae <exit+0xce>
80103f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f9e:	66 90                	xchg   %ax,%ax
80103fa0:	81 c2 94 00 00 00    	add    $0x94,%edx
80103fa6:	81 fa 54 52 11 80    	cmp    $0x80115254,%edx
80103fac:	74 3a                	je     80103fe8 <exit+0x108>
    if(p->parent == curproc){
80103fae:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103fb1:	75 ed                	jne    80103fa0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103fb3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103fb7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103fba:	75 e4                	jne    80103fa0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fbc:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103fc1:	eb 11                	jmp    80103fd4 <exit+0xf4>
80103fc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fc7:	90                   	nop
80103fc8:	05 94 00 00 00       	add    $0x94,%eax
80103fcd:	3d 54 52 11 80       	cmp    $0x80115254,%eax
80103fd2:	74 cc                	je     80103fa0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103fd4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fd8:	75 ee                	jne    80103fc8 <exit+0xe8>
80103fda:	3b 48 20             	cmp    0x20(%eax),%ecx
80103fdd:	75 e9                	jne    80103fc8 <exit+0xe8>
      p->state = RUNNABLE;
80103fdf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103fe6:	eb e0                	jmp    80103fc8 <exit+0xe8>
  curproc->state = ZOMBIE;
80103fe8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103fef:	e8 2c fe ff ff       	call   80103e20 <sched>
  panic("zombie exit");
80103ff4:	83 ec 0c             	sub    $0xc,%esp
80103ff7:	68 ac 85 10 80       	push   $0x801085ac
80103ffc:	e8 7f c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80104001:	83 ec 0c             	sub    $0xc,%esp
80104004:	68 9f 85 10 80       	push   $0x8010859f
80104009:	e8 72 c3 ff ff       	call   80100380 <panic>
8010400e:	66 90                	xchg   %ax,%ax

80104010 <wait>:
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	57                   	push   %edi
80104014:	56                   	push   %esi
80104015:	53                   	push   %ebx
80104016:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104019:	e8 22 07 00 00       	call   80104740 <pushcli>
  c = mycpu();
8010401e:	e8 4d f9 ff ff       	call   80103970 <mycpu>
  p = c->proc;
80104023:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104029:	e8 62 07 00 00       	call   80104790 <popcli>
  acquire(&ptable.lock);
8010402e:	83 ec 0c             	sub    $0xc,%esp
80104031:	68 20 2d 11 80       	push   $0x80112d20
80104036:	e8 55 08 00 00       	call   80104890 <acquire>
8010403b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010403e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104040:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104045:	eb 17                	jmp    8010405e <wait+0x4e>
80104047:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404e:	66 90                	xchg   %ax,%ax
80104050:	81 c3 94 00 00 00    	add    $0x94,%ebx
80104056:	81 fb 54 52 11 80    	cmp    $0x80115254,%ebx
8010405c:	74 1e                	je     8010407c <wait+0x6c>
      if(p->parent != curproc)
8010405e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104061:	75 ed                	jne    80104050 <wait+0x40>
      if(p->state == ZOMBIE){
80104063:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104067:	74 67                	je     801040d0 <wait+0xc0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104069:	81 c3 94 00 00 00    	add    $0x94,%ebx
      havekids = 1;
8010406f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104074:	81 fb 54 52 11 80    	cmp    $0x80115254,%ebx
8010407a:	75 e2                	jne    8010405e <wait+0x4e>
    if(!havekids || curproc->killed){
8010407c:	85 c0                	test   %eax,%eax
8010407e:	0f 84 d4 00 00 00    	je     80104158 <wait+0x148>
80104084:	8b 46 24             	mov    0x24(%esi),%eax
80104087:	85 c0                	test   %eax,%eax
80104089:	0f 85 c9 00 00 00    	jne    80104158 <wait+0x148>
  pushcli();
8010408f:	e8 ac 06 00 00       	call   80104740 <pushcli>
  c = mycpu();
80104094:	e8 d7 f8 ff ff       	call   80103970 <mycpu>
  p = c->proc;
80104099:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010409f:	e8 ec 06 00 00       	call   80104790 <popcli>
  if(p == 0)
801040a4:	85 db                	test   %ebx,%ebx
801040a6:	0f 84 c3 00 00 00    	je     8010416f <wait+0x15f>
  p->chan = chan;
801040ac:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
801040af:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040b6:	e8 65 fd ff ff       	call   80103e20 <sched>
  p->chan = 0;
801040bb:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801040c2:	e9 77 ff ff ff       	jmp    8010403e <wait+0x2e>
801040c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ce:	66 90                	xchg   %ax,%ax
        acquire(&tickslock);
801040d0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801040d3:	8b 7b 10             	mov    0x10(%ebx),%edi
        acquire(&tickslock);
801040d6:	68 80 52 11 80       	push   $0x80115280
801040db:	e8 b0 07 00 00       	call   80104890 <acquire>
        curproc->end_time=ticks;
801040e0:	a1 60 52 11 80       	mov    0x80115260,%eax
801040e5:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
        release(&tickslock);
801040eb:	c7 04 24 80 52 11 80 	movl   $0x80115280,(%esp)
801040f2:	e8 39 07 00 00       	call   80104830 <release>
        curproc->ran_time = curproc->end_time - curproc->create_time;
801040f7:	8b 86 80 00 00 00    	mov    0x80(%esi),%eax
801040fd:	2b 46 7c             	sub    0x7c(%esi),%eax
80104100:	89 86 84 00 00 00    	mov    %eax,0x84(%esi)
        kfree(p->kstack);
80104106:	5a                   	pop    %edx
80104107:	ff 73 08             	push   0x8(%ebx)
8010410a:	e8 91 e3 ff ff       	call   801024a0 <kfree>
        p->kstack = 0;
8010410f:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104116:	59                   	pop    %ecx
80104117:	ff 73 04             	push   0x4(%ebx)
8010411a:	e8 c1 38 00 00       	call   801079e0 <freevm>
        p->pid = 0;
8010411f:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104126:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010412d:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104131:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104138:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010413f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104146:	e8 e5 06 00 00       	call   80104830 <release>
        return pid;
8010414b:	83 c4 10             	add    $0x10,%esp
}
8010414e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104151:	89 f8                	mov    %edi,%eax
80104153:	5b                   	pop    %ebx
80104154:	5e                   	pop    %esi
80104155:	5f                   	pop    %edi
80104156:	5d                   	pop    %ebp
80104157:	c3                   	ret    
      release(&ptable.lock);
80104158:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010415b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
      release(&ptable.lock);
80104160:	68 20 2d 11 80       	push   $0x80112d20
80104165:	e8 c6 06 00 00       	call   80104830 <release>
      return -1;
8010416a:	83 c4 10             	add    $0x10,%esp
8010416d:	eb df                	jmp    8010414e <wait+0x13e>
    panic("sleep");
8010416f:	83 ec 0c             	sub    $0xc,%esp
80104172:	68 b8 85 10 80       	push   $0x801085b8
80104177:	e8 04 c2 ff ff       	call   80100380 <panic>
8010417c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104180 <yield>:
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	53                   	push   %ebx
80104184:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104187:	68 20 2d 11 80       	push   $0x80112d20
8010418c:	e8 ff 06 00 00       	call   80104890 <acquire>
  pushcli();
80104191:	e8 aa 05 00 00       	call   80104740 <pushcli>
  c = mycpu();
80104196:	e8 d5 f7 ff ff       	call   80103970 <mycpu>
  p = c->proc;
8010419b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041a1:	e8 ea 05 00 00       	call   80104790 <popcli>
  myproc()->state = RUNNABLE;
801041a6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801041ad:	e8 6e fc ff ff       	call   80103e20 <sched>
  release(&ptable.lock);
801041b2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801041b9:	e8 72 06 00 00       	call   80104830 <release>
}
801041be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041c1:	83 c4 10             	add    $0x10,%esp
801041c4:	c9                   	leave  
801041c5:	c3                   	ret    
801041c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041cd:	8d 76 00             	lea    0x0(%esi),%esi

801041d0 <sleep>:
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	57                   	push   %edi
801041d4:	56                   	push   %esi
801041d5:	53                   	push   %ebx
801041d6:	83 ec 0c             	sub    $0xc,%esp
801041d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801041dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801041df:	e8 5c 05 00 00       	call   80104740 <pushcli>
  c = mycpu();
801041e4:	e8 87 f7 ff ff       	call   80103970 <mycpu>
  p = c->proc;
801041e9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041ef:	e8 9c 05 00 00       	call   80104790 <popcli>
  if(p == 0)
801041f4:	85 db                	test   %ebx,%ebx
801041f6:	0f 84 87 00 00 00    	je     80104283 <sleep+0xb3>
  if(lk == 0)
801041fc:	85 f6                	test   %esi,%esi
801041fe:	74 76                	je     80104276 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104200:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104206:	74 50                	je     80104258 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104208:	83 ec 0c             	sub    $0xc,%esp
8010420b:	68 20 2d 11 80       	push   $0x80112d20
80104210:	e8 7b 06 00 00       	call   80104890 <acquire>
    release(lk);
80104215:	89 34 24             	mov    %esi,(%esp)
80104218:	e8 13 06 00 00       	call   80104830 <release>
  p->chan = chan;
8010421d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104220:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104227:	e8 f4 fb ff ff       	call   80103e20 <sched>
  p->chan = 0;
8010422c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104233:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010423a:	e8 f1 05 00 00       	call   80104830 <release>
    acquire(lk);
8010423f:	89 75 08             	mov    %esi,0x8(%ebp)
80104242:	83 c4 10             	add    $0x10,%esp
}
80104245:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104248:	5b                   	pop    %ebx
80104249:	5e                   	pop    %esi
8010424a:	5f                   	pop    %edi
8010424b:	5d                   	pop    %ebp
    acquire(lk);
8010424c:	e9 3f 06 00 00       	jmp    80104890 <acquire>
80104251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104258:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010425b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104262:	e8 b9 fb ff ff       	call   80103e20 <sched>
  p->chan = 0;
80104267:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010426e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104271:	5b                   	pop    %ebx
80104272:	5e                   	pop    %esi
80104273:	5f                   	pop    %edi
80104274:	5d                   	pop    %ebp
80104275:	c3                   	ret    
    panic("sleep without lk");
80104276:	83 ec 0c             	sub    $0xc,%esp
80104279:	68 be 85 10 80       	push   $0x801085be
8010427e:	e8 fd c0 ff ff       	call   80100380 <panic>
    panic("sleep");
80104283:	83 ec 0c             	sub    $0xc,%esp
80104286:	68 b8 85 10 80       	push   $0x801085b8
8010428b:	e8 f0 c0 ff ff       	call   80100380 <panic>

80104290 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 10             	sub    $0x10,%esp
80104297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010429a:	68 20 2d 11 80       	push   $0x80112d20
8010429f:	e8 ec 05 00 00       	call   80104890 <acquire>
801042a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042a7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801042ac:	eb 0e                	jmp    801042bc <wakeup+0x2c>
801042ae:	66 90                	xchg   %ax,%ax
801042b0:	05 94 00 00 00       	add    $0x94,%eax
801042b5:	3d 54 52 11 80       	cmp    $0x80115254,%eax
801042ba:	74 1e                	je     801042da <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801042bc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801042c0:	75 ee                	jne    801042b0 <wakeup+0x20>
801042c2:	3b 58 20             	cmp    0x20(%eax),%ebx
801042c5:	75 e9                	jne    801042b0 <wakeup+0x20>
      p->state = RUNNABLE;
801042c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042ce:	05 94 00 00 00       	add    $0x94,%eax
801042d3:	3d 54 52 11 80       	cmp    $0x80115254,%eax
801042d8:	75 e2                	jne    801042bc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801042da:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801042e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042e4:	c9                   	leave  
  release(&ptable.lock);
801042e5:	e9 46 05 00 00       	jmp    80104830 <release>
801042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042f0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 10             	sub    $0x10,%esp
801042f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801042fa:	68 20 2d 11 80       	push   $0x80112d20
801042ff:	e8 8c 05 00 00       	call   80104890 <acquire>
80104304:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104307:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010430c:	eb 0e                	jmp    8010431c <kill+0x2c>
8010430e:	66 90                	xchg   %ax,%ax
80104310:	05 94 00 00 00       	add    $0x94,%eax
80104315:	3d 54 52 11 80       	cmp    $0x80115254,%eax
8010431a:	74 34                	je     80104350 <kill+0x60>
    if(p->pid == pid){
8010431c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010431f:	75 ef                	jne    80104310 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104321:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104325:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010432c:	75 07                	jne    80104335 <kill+0x45>
        p->state = RUNNABLE;
8010432e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104335:	83 ec 0c             	sub    $0xc,%esp
80104338:	68 20 2d 11 80       	push   $0x80112d20
8010433d:	e8 ee 04 00 00       	call   80104830 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104342:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104345:	83 c4 10             	add    $0x10,%esp
80104348:	31 c0                	xor    %eax,%eax
}
8010434a:	c9                   	leave  
8010434b:	c3                   	ret    
8010434c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104350:	83 ec 0c             	sub    $0xc,%esp
80104353:	68 20 2d 11 80       	push   $0x80112d20
80104358:	e8 d3 04 00 00       	call   80104830 <release>
}
8010435d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104360:	83 c4 10             	add    $0x10,%esp
80104363:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104368:	c9                   	leave  
80104369:	c3                   	ret    
8010436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104370 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	57                   	push   %edi
80104374:	56                   	push   %esi
80104375:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104378:	53                   	push   %ebx
80104379:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010437e:	83 ec 3c             	sub    $0x3c,%esp
80104381:	eb 27                	jmp    801043aa <procdump+0x3a>
80104383:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104387:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104388:	83 ec 0c             	sub    $0xc,%esp
8010438b:	68 03 8b 10 80       	push   $0x80108b03
80104390:	e8 0b c3 ff ff       	call   801006a0 <cprintf>
80104395:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104398:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010439e:	81 fb c0 52 11 80    	cmp    $0x801152c0,%ebx
801043a4:	0f 84 7e 00 00 00    	je     80104428 <procdump+0xb8>
    if(p->state == UNUSED)
801043aa:	8b 43 a0             	mov    -0x60(%ebx),%eax
801043ad:	85 c0                	test   %eax,%eax
801043af:	74 e7                	je     80104398 <procdump+0x28>
      state = "???";
801043b1:	ba cf 85 10 80       	mov    $0x801085cf,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043b6:	83 f8 05             	cmp    $0x5,%eax
801043b9:	77 11                	ja     801043cc <procdump+0x5c>
801043bb:	8b 14 85 d4 86 10 80 	mov    -0x7fef792c(,%eax,4),%edx
      state = "???";
801043c2:	b8 cf 85 10 80       	mov    $0x801085cf,%eax
801043c7:	85 d2                	test   %edx,%edx
801043c9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801043cc:	53                   	push   %ebx
801043cd:	52                   	push   %edx
801043ce:	ff 73 a4             	push   -0x5c(%ebx)
801043d1:	68 d3 85 10 80       	push   $0x801085d3
801043d6:	e8 c5 c2 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
801043db:	83 c4 10             	add    $0x10,%esp
801043de:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801043e2:	75 a4                	jne    80104388 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801043e4:	83 ec 08             	sub    $0x8,%esp
801043e7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801043ea:	8d 7d c0             	lea    -0x40(%ebp),%edi
801043ed:	50                   	push   %eax
801043ee:	8b 43 b0             	mov    -0x50(%ebx),%eax
801043f1:	8b 40 0c             	mov    0xc(%eax),%eax
801043f4:	83 c0 08             	add    $0x8,%eax
801043f7:	50                   	push   %eax
801043f8:	e8 e3 02 00 00       	call   801046e0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801043fd:	83 c4 10             	add    $0x10,%esp
80104400:	8b 17                	mov    (%edi),%edx
80104402:	85 d2                	test   %edx,%edx
80104404:	74 82                	je     80104388 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104406:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104409:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010440c:	52                   	push   %edx
8010440d:	68 21 80 10 80       	push   $0x80108021
80104412:	e8 89 c2 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104417:	83 c4 10             	add    $0x10,%esp
8010441a:	39 fe                	cmp    %edi,%esi
8010441c:	75 e2                	jne    80104400 <procdump+0x90>
8010441e:	e9 65 ff ff ff       	jmp    80104388 <procdump+0x18>
80104423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104427:	90                   	nop
  }
}
80104428:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010442b:	5b                   	pop    %ebx
8010442c:	5e                   	pop    %esi
8010442d:	5f                   	pop    %edi
8010442e:	5d                   	pop    %ebp
8010442f:	c3                   	ret    

80104430 <ps>:
int 
ps(char*){
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	57                   	push   %edi
80104434:	56                   	push   %esi
  uint total_tat=0;
  int total_proc=0;
  uint total_wait=0;
   char *pr_name;
  argstr(0, &pr_name);
80104435:	8d 45 e4             	lea    -0x1c(%ebp),%eax
ps(char*){
80104438:	53                   	push   %ebx
80104439:	83 ec 34             	sub    $0x34,%esp
  argstr(0, &pr_name);
8010443c:	50                   	push   %eax
8010443d:	6a 00                	push   $0x0
8010443f:	e8 4c 08 00 00       	call   80104c90 <argstr>
  asm volatile("sti");
80104444:	fb                   	sti    
  struct proc *p;
  //struct proc *p;
  //cprintf("%s\n",pr_name); 
sti();
int len = strlen(pr_name) > 1 ?strlen(pr_name) : 1;
80104445:	58                   	pop    %eax
80104446:	ff 75 e4             	push   -0x1c(%ebp)
80104449:	e8 02 07 00 00       	call   80104b50 <strlen>
8010444e:	83 c4 10             	add    $0x10,%esp
80104451:	83 f8 01             	cmp    $0x1,%eax
80104454:	7e 0e                	jle    80104464 <ps+0x34>
80104456:	83 ec 0c             	sub    $0xc,%esp
80104459:	ff 75 e4             	push   -0x1c(%ebp)
8010445c:	e8 ef 06 00 00       	call   80104b50 <strlen>
80104461:	83 c4 10             	add    $0x10,%esp
//cprintf("len = %d\n",len);
len++;
len--;
  
  
  acquire(&ptable.lock);
80104464:	83 ec 0c             	sub    $0xc,%esp
80104467:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
  uint total_wait=0;
8010446c:	31 f6                	xor    %esi,%esi
  int total_proc=0;
8010446e:	31 ff                	xor    %edi,%edi
  acquire(&ptable.lock);
80104470:	68 20 2d 11 80       	push   $0x80112d20
80104475:	e8 16 04 00 00       	call   80104890 <acquire>
 cprintf("pid \t\t state \t\t start_time \t\t total_time \t name \t wait_time \n");
8010447a:	c7 04 24 30 86 10 80 	movl   $0x80108630,(%esp)
80104481:	e8 1a c2 ff ff       	call   801006a0 <cprintf>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104486:	83 c4 10             	add    $0x10,%esp
  uint total_tat=0;
80104489:	31 c0                	xor    %eax,%eax
8010448b:	eb 1b                	jmp    801044a8 <ps+0x78>
8010448d:	8d 76 00             	lea    0x0(%esi),%esi
 	  {
    total_wait+=p->wait_time;
    total_tat += p->ran_time;
    total_proc++;
    }
  else if(p->state == ZOMBIE)
80104490:	83 fa 05             	cmp    $0x5,%edx
80104493:	74 73                	je     80104508 <ps+0xd8>
    total_proc++;
      cprintf("%d \t\t SLEEPING \t\t%d \t\t %d \t\t %s \t %d\n ",p->pid,p->create_time,p->ran_time,p->name,p->wait_time);
      
    
    }
  else if(p->state == EMBRYO)
80104495:	83 fa 01             	cmp    $0x1,%edx
80104498:	74 6e                	je     80104508 <ps+0xd8>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010449a:	81 c3 94 00 00 00    	add    $0x94,%ebx
801044a0:	81 fb c0 52 11 80    	cmp    $0x801152c0,%ebx
801044a6:	74 29                	je     801044d1 <ps+0xa1>
  if(p->state == SLEEPING)
801044a8:	8b 53 a0             	mov    -0x60(%ebx),%edx
801044ab:	83 fa 02             	cmp    $0x2,%edx
801044ae:	74 58                	je     80104508 <ps+0xd8>
	else if(p->state == RUNNING)
801044b0:	83 fa 04             	cmp    $0x4,%edx
801044b3:	74 53                	je     80104508 <ps+0xd8>
	else if(p->state == RUNNABLE)
801044b5:	83 fa 03             	cmp    $0x3,%edx
801044b8:	75 d6                	jne    80104490 <ps+0x60>
    total_wait+=p->wait_time;
801044ba:	03 73 1c             	add    0x1c(%ebx),%esi
    total_tat += p->ran_time;
801044bd:	03 43 18             	add    0x18(%ebx),%eax
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044c0:	81 c3 94 00 00 00    	add    $0x94,%ebx
    total_proc++;
801044c6:	83 c7 01             	add    $0x1,%edi
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044c9:	81 fb c0 52 11 80    	cmp    $0x801152c0,%ebx
801044cf:	75 d7                	jne    801044a8 <ps+0x78>
    total_proc++;
      cprintf("%d \t\t SLEEPING \t\t%d \t\t %d \t\t %s \t %d\n ",p->pid,p->create_time,p->ran_time,p->name,p->wait_time);
      
    }
}
cprintf("Average waiting time = %d \n Average turnaround time = %d \n",total_wait/total_proc,total_tat/total_proc);
801044d1:	31 d2                	xor    %edx,%edx
801044d3:	83 ec 04             	sub    $0x4,%esp
801044d6:	f7 f7                	div    %edi
801044d8:	31 d2                	xor    %edx,%edx
801044da:	50                   	push   %eax
801044db:	89 f0                	mov    %esi,%eax
801044dd:	f7 f7                	div    %edi
801044df:	50                   	push   %eax
801044e0:	68 98 86 10 80       	push   $0x80108698
801044e5:	e8 b6 c1 ff ff       	call   801006a0 <cprintf>

release(&ptable.lock);
801044ea:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044f1:	e8 3a 03 00 00       	call   80104830 <release>
//   else if(p->state == EMBRYO)
//  	  cprintf("%d \t\t EMBRYO \t\t%d \t\t %d %s\n ",p->pid,p->create_time,p->ran_time,p->name);
// }
// release(&ptable.lock);
return 3;
}
801044f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044f9:	b8 03 00 00 00       	mov    $0x3,%eax
801044fe:	5b                   	pop    %ebx
801044ff:	5e                   	pop    %esi
80104500:	5f                   	pop    %edi
80104501:	5d                   	pop    %ebp
80104502:	c3                   	ret    
80104503:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104507:	90                   	nop
      total_wait+=p->wait_time;
80104508:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
    total_tat += p->ran_time;
8010450b:	8b 53 18             	mov    0x18(%ebx),%edx
      cprintf("%d \t\t SLEEPING \t\t%d \t\t %d \t\t %s \t %d\n ",p->pid,p->create_time,p->ran_time,p->name,p->wait_time);
8010450e:	83 ec 08             	sub    $0x8,%esp
    total_proc++;
80104511:	83 c7 01             	add    $0x1,%edi
      cprintf("%d \t\t SLEEPING \t\t%d \t\t %d \t\t %s \t %d\n ",p->pid,p->create_time,p->ran_time,p->name,p->wait_time);
80104514:	51                   	push   %ecx
    total_tat += p->ran_time;
80104515:	01 d0                	add    %edx,%eax
      total_wait+=p->wait_time;
80104517:	01 ce                	add    %ecx,%esi
      cprintf("%d \t\t SLEEPING \t\t%d \t\t %d \t\t %s \t %d\n ",p->pid,p->create_time,p->ran_time,p->name,p->wait_time);
80104519:	53                   	push   %ebx
8010451a:	52                   	push   %edx
8010451b:	ff 73 10             	push   0x10(%ebx)
8010451e:	ff 73 a4             	push   -0x5c(%ebx)
80104521:	68 70 86 10 80       	push   $0x80108670
    total_tat += p->ran_time;
80104526:	89 45 d4             	mov    %eax,-0x2c(%ebp)
      cprintf("%d \t\t SLEEPING \t\t%d \t\t %d \t\t %s \t %d\n ",p->pid,p->create_time,p->ran_time,p->name,p->wait_time);
80104529:	e8 72 c1 ff ff       	call   801006a0 <cprintf>
8010452e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104531:	83 c4 20             	add    $0x20,%esp
80104534:	e9 61 ff ff ff       	jmp    8010449a <ps+0x6a>
80104539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104540 <change_priority>:
int 
change_priority(int pid,int priority){
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 10             	sub    $0x10,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc *p;
	acquire(&ptable.lock);
8010454a:	68 20 2d 11 80       	push   $0x80112d20
8010454f:	e8 3c 03 00 00       	call   80104890 <acquire>
80104554:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104557:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010455c:	eb 0e                	jmp    8010456c <change_priority+0x2c>
8010455e:	66 90                	xchg   %ax,%ax
80104560:	05 94 00 00 00       	add    $0x94,%eax
80104565:	3d 54 52 11 80       	cmp    $0x80115254,%eax
8010456a:	74 0e                	je     8010457a <change_priority+0x3a>
	  if(p->pid == pid){
8010456c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010456f:	75 ef                	jne    80104560 <change_priority+0x20>
			p->priority = priority;
80104571:	8b 55 0c             	mov    0xc(%ebp),%edx
80104574:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
			break;
		}
	}
	release(&ptable.lock);
8010457a:	83 ec 0c             	sub    $0xc,%esp
8010457d:	68 20 2d 11 80       	push   $0x80112d20
80104582:	e8 a9 02 00 00       	call   80104830 <release>
	return pid;
80104587:	89 d8                	mov    %ebx,%eax
80104589:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010458c:	c9                   	leave  
8010458d:	c3                   	ret    
8010458e:	66 90                	xchg   %ax,%ax

80104590 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	53                   	push   %ebx
80104594:	83 ec 0c             	sub    $0xc,%esp
80104597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010459a:	68 ec 86 10 80       	push   $0x801086ec
8010459f:	8d 43 04             	lea    0x4(%ebx),%eax
801045a2:	50                   	push   %eax
801045a3:	e8 18 01 00 00       	call   801046c0 <initlock>
  lk->name = name;
801045a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801045ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801045b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801045b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801045bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801045be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045c1:	c9                   	leave  
801045c2:	c3                   	ret    
801045c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	56                   	push   %esi
801045d4:	53                   	push   %ebx
801045d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045d8:	8d 73 04             	lea    0x4(%ebx),%esi
801045db:	83 ec 0c             	sub    $0xc,%esp
801045de:	56                   	push   %esi
801045df:	e8 ac 02 00 00       	call   80104890 <acquire>
  while (lk->locked) {
801045e4:	8b 13                	mov    (%ebx),%edx
801045e6:	83 c4 10             	add    $0x10,%esp
801045e9:	85 d2                	test   %edx,%edx
801045eb:	74 16                	je     80104603 <acquiresleep+0x33>
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801045f0:	83 ec 08             	sub    $0x8,%esp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	e8 d6 fb ff ff       	call   801041d0 <sleep>
  while (lk->locked) {
801045fa:	8b 03                	mov    (%ebx),%eax
801045fc:	83 c4 10             	add    $0x10,%esp
801045ff:	85 c0                	test   %eax,%eax
80104601:	75 ed                	jne    801045f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104603:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104609:	e8 e2 f3 ff ff       	call   801039f0 <myproc>
8010460e:	8b 40 10             	mov    0x10(%eax),%eax
80104611:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104614:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104617:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010461a:	5b                   	pop    %ebx
8010461b:	5e                   	pop    %esi
8010461c:	5d                   	pop    %ebp
  release(&lk->lk);
8010461d:	e9 0e 02 00 00       	jmp    80104830 <release>
80104622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104630 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	56                   	push   %esi
80104634:	53                   	push   %ebx
80104635:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104638:	8d 73 04             	lea    0x4(%ebx),%esi
8010463b:	83 ec 0c             	sub    $0xc,%esp
8010463e:	56                   	push   %esi
8010463f:	e8 4c 02 00 00       	call   80104890 <acquire>
  lk->locked = 0;
80104644:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010464a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104651:	89 1c 24             	mov    %ebx,(%esp)
80104654:	e8 37 fc ff ff       	call   80104290 <wakeup>
  release(&lk->lk);
80104659:	89 75 08             	mov    %esi,0x8(%ebp)
8010465c:	83 c4 10             	add    $0x10,%esp
}
8010465f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104662:	5b                   	pop    %ebx
80104663:	5e                   	pop    %esi
80104664:	5d                   	pop    %ebp
  release(&lk->lk);
80104665:	e9 c6 01 00 00       	jmp    80104830 <release>
8010466a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104670 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	31 ff                	xor    %edi,%edi
80104676:	56                   	push   %esi
80104677:	53                   	push   %ebx
80104678:	83 ec 18             	sub    $0x18,%esp
8010467b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010467e:	8d 73 04             	lea    0x4(%ebx),%esi
80104681:	56                   	push   %esi
80104682:	e8 09 02 00 00       	call   80104890 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104687:	8b 03                	mov    (%ebx),%eax
80104689:	83 c4 10             	add    $0x10,%esp
8010468c:	85 c0                	test   %eax,%eax
8010468e:	75 18                	jne    801046a8 <holdingsleep+0x38>
  release(&lk->lk);
80104690:	83 ec 0c             	sub    $0xc,%esp
80104693:	56                   	push   %esi
80104694:	e8 97 01 00 00       	call   80104830 <release>
  return r;
}
80104699:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010469c:	89 f8                	mov    %edi,%eax
8010469e:	5b                   	pop    %ebx
8010469f:	5e                   	pop    %esi
801046a0:	5f                   	pop    %edi
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret    
801046a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046a7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
801046a8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801046ab:	e8 40 f3 ff ff       	call   801039f0 <myproc>
801046b0:	39 58 10             	cmp    %ebx,0x10(%eax)
801046b3:	0f 94 c0             	sete   %al
801046b6:	0f b6 c0             	movzbl %al,%eax
801046b9:	89 c7                	mov    %eax,%edi
801046bb:	eb d3                	jmp    80104690 <holdingsleep+0x20>
801046bd:	66 90                	xchg   %ax,%ax
801046bf:	90                   	nop

801046c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801046c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801046c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801046cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801046d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801046d9:	5d                   	pop    %ebp
801046da:	c3                   	ret    
801046db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046df:	90                   	nop

801046e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801046e0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801046e1:	31 d2                	xor    %edx,%edx
{
801046e3:	89 e5                	mov    %esp,%ebp
801046e5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801046e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801046e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801046ec:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801046ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046f0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801046f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801046fc:	77 1a                	ja     80104718 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801046fe:	8b 58 04             	mov    0x4(%eax),%ebx
80104701:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104704:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104707:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104709:	83 fa 0a             	cmp    $0xa,%edx
8010470c:	75 e2                	jne    801046f0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010470e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104711:	c9                   	leave  
80104712:	c3                   	ret    
80104713:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104717:	90                   	nop
  for(; i < 10; i++)
80104718:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010471b:	8d 51 28             	lea    0x28(%ecx),%edx
8010471e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104720:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104726:	83 c0 04             	add    $0x4,%eax
80104729:	39 d0                	cmp    %edx,%eax
8010472b:	75 f3                	jne    80104720 <getcallerpcs+0x40>
}
8010472d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104730:	c9                   	leave  
80104731:	c3                   	ret    
80104732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104740 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104747:	9c                   	pushf  
80104748:	5b                   	pop    %ebx
  asm volatile("cli");
80104749:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010474a:	e8 21 f2 ff ff       	call   80103970 <mycpu>
8010474f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104755:	85 c0                	test   %eax,%eax
80104757:	74 17                	je     80104770 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104759:	e8 12 f2 ff ff       	call   80103970 <mycpu>
8010475e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104765:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104768:	c9                   	leave  
80104769:	c3                   	ret    
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104770:	e8 fb f1 ff ff       	call   80103970 <mycpu>
80104775:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010477b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104781:	eb d6                	jmp    80104759 <pushcli+0x19>
80104783:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010478a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104790 <popcli>:

void
popcli(void)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104796:	9c                   	pushf  
80104797:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104798:	f6 c4 02             	test   $0x2,%ah
8010479b:	75 35                	jne    801047d2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010479d:	e8 ce f1 ff ff       	call   80103970 <mycpu>
801047a2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801047a9:	78 34                	js     801047df <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047ab:	e8 c0 f1 ff ff       	call   80103970 <mycpu>
801047b0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801047b6:	85 d2                	test   %edx,%edx
801047b8:	74 06                	je     801047c0 <popcli+0x30>
    sti();
}
801047ba:	c9                   	leave  
801047bb:	c3                   	ret    
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047c0:	e8 ab f1 ff ff       	call   80103970 <mycpu>
801047c5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801047cb:	85 c0                	test   %eax,%eax
801047cd:	74 eb                	je     801047ba <popcli+0x2a>
  asm volatile("sti");
801047cf:	fb                   	sti    
}
801047d0:	c9                   	leave  
801047d1:	c3                   	ret    
    panic("popcli - interruptible");
801047d2:	83 ec 0c             	sub    $0xc,%esp
801047d5:	68 f7 86 10 80       	push   $0x801086f7
801047da:	e8 a1 bb ff ff       	call   80100380 <panic>
    panic("popcli");
801047df:	83 ec 0c             	sub    $0xc,%esp
801047e2:	68 0e 87 10 80       	push   $0x8010870e
801047e7:	e8 94 bb ff ff       	call   80100380 <panic>
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <holding>:
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	8b 75 08             	mov    0x8(%ebp),%esi
801047f8:	31 db                	xor    %ebx,%ebx
  pushcli();
801047fa:	e8 41 ff ff ff       	call   80104740 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801047ff:	8b 06                	mov    (%esi),%eax
80104801:	85 c0                	test   %eax,%eax
80104803:	75 0b                	jne    80104810 <holding+0x20>
  popcli();
80104805:	e8 86 ff ff ff       	call   80104790 <popcli>
}
8010480a:	89 d8                	mov    %ebx,%eax
8010480c:	5b                   	pop    %ebx
8010480d:	5e                   	pop    %esi
8010480e:	5d                   	pop    %ebp
8010480f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104810:	8b 5e 08             	mov    0x8(%esi),%ebx
80104813:	e8 58 f1 ff ff       	call   80103970 <mycpu>
80104818:	39 c3                	cmp    %eax,%ebx
8010481a:	0f 94 c3             	sete   %bl
  popcli();
8010481d:	e8 6e ff ff ff       	call   80104790 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104822:	0f b6 db             	movzbl %bl,%ebx
}
80104825:	89 d8                	mov    %ebx,%eax
80104827:	5b                   	pop    %ebx
80104828:	5e                   	pop    %esi
80104829:	5d                   	pop    %ebp
8010482a:	c3                   	ret    
8010482b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010482f:	90                   	nop

80104830 <release>:
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	53                   	push   %ebx
80104835:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104838:	e8 03 ff ff ff       	call   80104740 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010483d:	8b 03                	mov    (%ebx),%eax
8010483f:	85 c0                	test   %eax,%eax
80104841:	75 15                	jne    80104858 <release+0x28>
  popcli();
80104843:	e8 48 ff ff ff       	call   80104790 <popcli>
    panic("release");
80104848:	83 ec 0c             	sub    $0xc,%esp
8010484b:	68 15 87 10 80       	push   $0x80108715
80104850:	e8 2b bb ff ff       	call   80100380 <panic>
80104855:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104858:	8b 73 08             	mov    0x8(%ebx),%esi
8010485b:	e8 10 f1 ff ff       	call   80103970 <mycpu>
80104860:	39 c6                	cmp    %eax,%esi
80104862:	75 df                	jne    80104843 <release+0x13>
  popcli();
80104864:	e8 27 ff ff ff       	call   80104790 <popcli>
  lk->pcs[0] = 0;
80104869:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104870:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104877:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010487c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104882:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104885:	5b                   	pop    %ebx
80104886:	5e                   	pop    %esi
80104887:	5d                   	pop    %ebp
  popcli();
80104888:	e9 03 ff ff ff       	jmp    80104790 <popcli>
8010488d:	8d 76 00             	lea    0x0(%esi),%esi

80104890 <acquire>:
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104897:	e8 a4 fe ff ff       	call   80104740 <pushcli>
  if(holding(lk))
8010489c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010489f:	e8 9c fe ff ff       	call   80104740 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048a4:	8b 03                	mov    (%ebx),%eax
801048a6:	85 c0                	test   %eax,%eax
801048a8:	75 7e                	jne    80104928 <acquire+0x98>
  popcli();
801048aa:	e8 e1 fe ff ff       	call   80104790 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801048af:	b9 01 00 00 00       	mov    $0x1,%ecx
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
801048b8:	8b 55 08             	mov    0x8(%ebp),%edx
801048bb:	89 c8                	mov    %ecx,%eax
801048bd:	f0 87 02             	lock xchg %eax,(%edx)
801048c0:	85 c0                	test   %eax,%eax
801048c2:	75 f4                	jne    801048b8 <acquire+0x28>
  __sync_synchronize();
801048c4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801048c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048cc:	e8 9f f0 ff ff       	call   80103970 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801048d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
801048d4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801048d6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801048d9:	31 c0                	xor    %eax,%eax
801048db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048df:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048e0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801048e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801048ec:	77 1a                	ja     80104908 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801048ee:	8b 5a 04             	mov    0x4(%edx),%ebx
801048f1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801048f5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801048f8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801048fa:	83 f8 0a             	cmp    $0xa,%eax
801048fd:	75 e1                	jne    801048e0 <acquire+0x50>
}
801048ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104902:	c9                   	leave  
80104903:	c3                   	ret    
80104904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104908:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010490c:	8d 51 34             	lea    0x34(%ecx),%edx
8010490f:	90                   	nop
    pcs[i] = 0;
80104910:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104916:	83 c0 04             	add    $0x4,%eax
80104919:	39 c2                	cmp    %eax,%edx
8010491b:	75 f3                	jne    80104910 <acquire+0x80>
}
8010491d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104920:	c9                   	leave  
80104921:	c3                   	ret    
80104922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104928:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010492b:	e8 40 f0 ff ff       	call   80103970 <mycpu>
80104930:	39 c3                	cmp    %eax,%ebx
80104932:	0f 85 72 ff ff ff    	jne    801048aa <acquire+0x1a>
  popcli();
80104938:	e8 53 fe ff ff       	call   80104790 <popcli>
    panic("acquire");
8010493d:	83 ec 0c             	sub    $0xc,%esp
80104940:	68 1d 87 10 80       	push   $0x8010871d
80104945:	e8 36 ba ff ff       	call   80100380 <panic>
8010494a:	66 90                	xchg   %ax,%ax
8010494c:	66 90                	xchg   %ax,%ax
8010494e:	66 90                	xchg   %ax,%ax

80104950 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	57                   	push   %edi
80104954:	8b 55 08             	mov    0x8(%ebp),%edx
80104957:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010495a:	53                   	push   %ebx
8010495b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010495e:	89 d7                	mov    %edx,%edi
80104960:	09 cf                	or     %ecx,%edi
80104962:	83 e7 03             	and    $0x3,%edi
80104965:	75 29                	jne    80104990 <memset+0x40>
    c &= 0xFF;
80104967:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010496a:	c1 e0 18             	shl    $0x18,%eax
8010496d:	89 fb                	mov    %edi,%ebx
8010496f:	c1 e9 02             	shr    $0x2,%ecx
80104972:	c1 e3 10             	shl    $0x10,%ebx
80104975:	09 d8                	or     %ebx,%eax
80104977:	09 f8                	or     %edi,%eax
80104979:	c1 e7 08             	shl    $0x8,%edi
8010497c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010497e:	89 d7                	mov    %edx,%edi
80104980:	fc                   	cld    
80104981:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104983:	5b                   	pop    %ebx
80104984:	89 d0                	mov    %edx,%eax
80104986:	5f                   	pop    %edi
80104987:	5d                   	pop    %ebp
80104988:	c3                   	ret    
80104989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104990:	89 d7                	mov    %edx,%edi
80104992:	fc                   	cld    
80104993:	f3 aa                	rep stos %al,%es:(%edi)
80104995:	5b                   	pop    %ebx
80104996:	89 d0                	mov    %edx,%eax
80104998:	5f                   	pop    %edi
80104999:	5d                   	pop    %ebp
8010499a:	c3                   	ret    
8010499b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010499f:	90                   	nop

801049a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	56                   	push   %esi
801049a4:	8b 75 10             	mov    0x10(%ebp),%esi
801049a7:	8b 55 08             	mov    0x8(%ebp),%edx
801049aa:	53                   	push   %ebx
801049ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801049ae:	85 f6                	test   %esi,%esi
801049b0:	74 2e                	je     801049e0 <memcmp+0x40>
801049b2:	01 c6                	add    %eax,%esi
801049b4:	eb 14                	jmp    801049ca <memcmp+0x2a>
801049b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801049c0:	83 c0 01             	add    $0x1,%eax
801049c3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801049c6:	39 f0                	cmp    %esi,%eax
801049c8:	74 16                	je     801049e0 <memcmp+0x40>
    if(*s1 != *s2)
801049ca:	0f b6 0a             	movzbl (%edx),%ecx
801049cd:	0f b6 18             	movzbl (%eax),%ebx
801049d0:	38 d9                	cmp    %bl,%cl
801049d2:	74 ec                	je     801049c0 <memcmp+0x20>
      return *s1 - *s2;
801049d4:	0f b6 c1             	movzbl %cl,%eax
801049d7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801049d9:	5b                   	pop    %ebx
801049da:	5e                   	pop    %esi
801049db:	5d                   	pop    %ebp
801049dc:	c3                   	ret    
801049dd:	8d 76 00             	lea    0x0(%esi),%esi
801049e0:	5b                   	pop    %ebx
  return 0;
801049e1:	31 c0                	xor    %eax,%eax
}
801049e3:	5e                   	pop    %esi
801049e4:	5d                   	pop    %ebp
801049e5:	c3                   	ret    
801049e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ed:	8d 76 00             	lea    0x0(%esi),%esi

801049f0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	57                   	push   %edi
801049f4:	8b 55 08             	mov    0x8(%ebp),%edx
801049f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801049fa:	56                   	push   %esi
801049fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801049fe:	39 d6                	cmp    %edx,%esi
80104a00:	73 26                	jae    80104a28 <memmove+0x38>
80104a02:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104a05:	39 fa                	cmp    %edi,%edx
80104a07:	73 1f                	jae    80104a28 <memmove+0x38>
80104a09:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104a0c:	85 c9                	test   %ecx,%ecx
80104a0e:	74 0c                	je     80104a1c <memmove+0x2c>
      *--d = *--s;
80104a10:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104a14:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104a17:	83 e8 01             	sub    $0x1,%eax
80104a1a:	73 f4                	jae    80104a10 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104a1c:	5e                   	pop    %esi
80104a1d:	89 d0                	mov    %edx,%eax
80104a1f:	5f                   	pop    %edi
80104a20:	5d                   	pop    %ebp
80104a21:	c3                   	ret    
80104a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104a28:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104a2b:	89 d7                	mov    %edx,%edi
80104a2d:	85 c9                	test   %ecx,%ecx
80104a2f:	74 eb                	je     80104a1c <memmove+0x2c>
80104a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104a38:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104a39:	39 c6                	cmp    %eax,%esi
80104a3b:	75 fb                	jne    80104a38 <memmove+0x48>
}
80104a3d:	5e                   	pop    %esi
80104a3e:	89 d0                	mov    %edx,%eax
80104a40:	5f                   	pop    %edi
80104a41:	5d                   	pop    %ebp
80104a42:	c3                   	ret    
80104a43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a50 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104a50:	eb 9e                	jmp    801049f0 <memmove>
80104a52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a60 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	56                   	push   %esi
80104a64:	8b 75 10             	mov    0x10(%ebp),%esi
80104a67:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a6a:	53                   	push   %ebx
80104a6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80104a6e:	85 f6                	test   %esi,%esi
80104a70:	74 2e                	je     80104aa0 <strncmp+0x40>
80104a72:	01 d6                	add    %edx,%esi
80104a74:	eb 18                	jmp    80104a8e <strncmp+0x2e>
80104a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
80104a80:	38 d8                	cmp    %bl,%al
80104a82:	75 14                	jne    80104a98 <strncmp+0x38>
    n--, p++, q++;
80104a84:	83 c2 01             	add    $0x1,%edx
80104a87:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104a8a:	39 f2                	cmp    %esi,%edx
80104a8c:	74 12                	je     80104aa0 <strncmp+0x40>
80104a8e:	0f b6 01             	movzbl (%ecx),%eax
80104a91:	0f b6 1a             	movzbl (%edx),%ebx
80104a94:	84 c0                	test   %al,%al
80104a96:	75 e8                	jne    80104a80 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104a98:	29 d8                	sub    %ebx,%eax
}
80104a9a:	5b                   	pop    %ebx
80104a9b:	5e                   	pop    %esi
80104a9c:	5d                   	pop    %ebp
80104a9d:	c3                   	ret    
80104a9e:	66 90                	xchg   %ax,%ax
80104aa0:	5b                   	pop    %ebx
    return 0;
80104aa1:	31 c0                	xor    %eax,%eax
}
80104aa3:	5e                   	pop    %esi
80104aa4:	5d                   	pop    %ebp
80104aa5:	c3                   	ret    
80104aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aad:	8d 76 00             	lea    0x0(%esi),%esi

80104ab0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	57                   	push   %edi
80104ab4:	56                   	push   %esi
80104ab5:	8b 75 08             	mov    0x8(%ebp),%esi
80104ab8:	53                   	push   %ebx
80104ab9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104abc:	89 f0                	mov    %esi,%eax
80104abe:	eb 15                	jmp    80104ad5 <strncpy+0x25>
80104ac0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104ac4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104ac7:	83 c0 01             	add    $0x1,%eax
80104aca:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104ace:	88 50 ff             	mov    %dl,-0x1(%eax)
80104ad1:	84 d2                	test   %dl,%dl
80104ad3:	74 09                	je     80104ade <strncpy+0x2e>
80104ad5:	89 cb                	mov    %ecx,%ebx
80104ad7:	83 e9 01             	sub    $0x1,%ecx
80104ada:	85 db                	test   %ebx,%ebx
80104adc:	7f e2                	jg     80104ac0 <strncpy+0x10>
    ;
  while(n-- > 0)
80104ade:	89 c2                	mov    %eax,%edx
80104ae0:	85 c9                	test   %ecx,%ecx
80104ae2:	7e 17                	jle    80104afb <strncpy+0x4b>
80104ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104ae8:	83 c2 01             	add    $0x1,%edx
80104aeb:	89 c1                	mov    %eax,%ecx
80104aed:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104af1:	29 d1                	sub    %edx,%ecx
80104af3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104af7:	85 c9                	test   %ecx,%ecx
80104af9:	7f ed                	jg     80104ae8 <strncpy+0x38>
  return os;
}
80104afb:	5b                   	pop    %ebx
80104afc:	89 f0                	mov    %esi,%eax
80104afe:	5e                   	pop    %esi
80104aff:	5f                   	pop    %edi
80104b00:	5d                   	pop    %ebp
80104b01:	c3                   	ret    
80104b02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b10 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	56                   	push   %esi
80104b14:	8b 55 10             	mov    0x10(%ebp),%edx
80104b17:	8b 75 08             	mov    0x8(%ebp),%esi
80104b1a:	53                   	push   %ebx
80104b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104b1e:	85 d2                	test   %edx,%edx
80104b20:	7e 25                	jle    80104b47 <safestrcpy+0x37>
80104b22:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104b26:	89 f2                	mov    %esi,%edx
80104b28:	eb 16                	jmp    80104b40 <safestrcpy+0x30>
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104b30:	0f b6 08             	movzbl (%eax),%ecx
80104b33:	83 c0 01             	add    $0x1,%eax
80104b36:	83 c2 01             	add    $0x1,%edx
80104b39:	88 4a ff             	mov    %cl,-0x1(%edx)
80104b3c:	84 c9                	test   %cl,%cl
80104b3e:	74 04                	je     80104b44 <safestrcpy+0x34>
80104b40:	39 d8                	cmp    %ebx,%eax
80104b42:	75 ec                	jne    80104b30 <safestrcpy+0x20>
    ;
  *s = 0;
80104b44:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104b47:	89 f0                	mov    %esi,%eax
80104b49:	5b                   	pop    %ebx
80104b4a:	5e                   	pop    %esi
80104b4b:	5d                   	pop    %ebp
80104b4c:	c3                   	ret    
80104b4d:	8d 76 00             	lea    0x0(%esi),%esi

80104b50 <strlen>:

int
strlen(const char *s)
{
80104b50:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104b51:	31 c0                	xor    %eax,%eax
{
80104b53:	89 e5                	mov    %esp,%ebp
80104b55:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104b58:	80 3a 00             	cmpb   $0x0,(%edx)
80104b5b:	74 0c                	je     80104b69 <strlen+0x19>
80104b5d:	8d 76 00             	lea    0x0(%esi),%esi
80104b60:	83 c0 01             	add    $0x1,%eax
80104b63:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104b67:	75 f7                	jne    80104b60 <strlen+0x10>
    ;
  return n;
}
80104b69:	5d                   	pop    %ebp
80104b6a:	c3                   	ret    

80104b6b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104b6b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104b6f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104b73:	55                   	push   %ebp
  pushl %ebx
80104b74:	53                   	push   %ebx
  pushl %esi
80104b75:	56                   	push   %esi
  pushl %edi
80104b76:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104b77:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104b79:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104b7b:	5f                   	pop    %edi
  popl %esi
80104b7c:	5e                   	pop    %esi
  popl %ebx
80104b7d:	5b                   	pop    %ebx
  popl %ebp
80104b7e:	5d                   	pop    %ebp
  ret
80104b7f:	c3                   	ret    

80104b80 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	8b 45 08             	mov    0x8(%ebp),%eax
  // struct proc *curproc = myproc();

  if(addr >= USERTOP || addr+4 >= USERTOP)
80104b86:	3d fb df d4 0d       	cmp    $0xdd4dffb,%eax
80104b8b:	77 13                	ja     80104ba0 <fetchint+0x20>
    return -1;
  *ip = *(int*)(addr);
80104b8d:	8b 10                	mov    (%eax),%edx
80104b8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b92:	89 10                	mov    %edx,(%eax)
  return 0;
80104b94:	31 c0                	xor    %eax,%eax
}
80104b96:	5d                   	pop    %ebp
80104b97:	c3                   	ret    
80104b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b9f:	90                   	nop
    return -1;
80104ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ba5:	5d                   	pop    %ebp
80104ba6:	c3                   	ret    
80104ba7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bae:	66 90                	xchg   %ax,%ax

80104bb0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	8b 55 08             	mov    0x8(%ebp),%edx
  char *s, *ep;
  // struct proc *curproc = myproc();

  if(addr >= USERTOP)
80104bb6:	81 fa ff df d4 0d    	cmp    $0xdd4dfff,%edx
80104bbc:	77 19                	ja     80104bd7 <fetchstr+0x27>
    return -1;
  *pp = (char*)addr;
80104bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bc1:	89 10                	mov    %edx,(%eax)
  ep = (char*)USERTOP;
  for(s = *pp; s < ep; s++){
80104bc3:	89 d0                	mov    %edx,%eax
80104bc5:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s == 0)
80104bc8:	80 38 00             	cmpb   $0x0,(%eax)
80104bcb:	74 13                	je     80104be0 <fetchstr+0x30>
  for(s = *pp; s < ep; s++){
80104bcd:	83 c0 01             	add    $0x1,%eax
80104bd0:	3d 00 e0 d4 0d       	cmp    $0xdd4e000,%eax
80104bd5:	75 f1                	jne    80104bc8 <fetchstr+0x18>
    return -1;
80104bd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104bdc:	5d                   	pop    %ebp
80104bdd:	c3                   	ret    
80104bde:	66 90                	xchg   %ax,%ax
      return s - *pp;
80104be0:	29 d0                	sub    %edx,%eax
}
80104be2:	5d                   	pop    %ebp
80104be3:	c3                   	ret    
80104be4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bef:	90                   	nop

80104bf0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bf6:	e8 f5 ed ff ff       	call   801039f0 <myproc>
80104bfb:	8b 55 08             	mov    0x8(%ebp),%edx
80104bfe:	8b 40 18             	mov    0x18(%eax),%eax
80104c01:	8b 40 44             	mov    0x44(%eax),%eax
80104c04:	8d 44 90 04          	lea    0x4(%eax,%edx,4),%eax
  if(addr >= USERTOP || addr+4 >= USERTOP)
80104c08:	3d fb df d4 0d       	cmp    $0xdd4dffb,%eax
80104c0d:	77 11                	ja     80104c20 <argint+0x30>
  *ip = *(int*)(addr);
80104c0f:	8b 10                	mov    (%eax),%edx
80104c11:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c14:	89 10                	mov    %edx,(%eax)
  return 0;
80104c16:	31 c0                	xor    %eax,%eax
}
80104c18:	c9                   	leave  
80104c19:	c3                   	ret    
80104c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c20:	c9                   	leave  
    return -1;
80104c21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c26:	c3                   	ret    
80104c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c2e:	66 90                	xchg   %ax,%ax

80104c30 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	53                   	push   %ebx
80104c34:	83 ec 04             	sub    $0x4,%esp
80104c37:	8b 5d 10             	mov    0x10(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c3a:	e8 b1 ed ff ff       	call   801039f0 <myproc>
80104c3f:	8b 55 08             	mov    0x8(%ebp),%edx
80104c42:	8b 40 18             	mov    0x18(%eax),%eax
80104c45:	8b 40 44             	mov    0x44(%eax),%eax
80104c48:	8d 44 90 04          	lea    0x4(%eax,%edx,4),%eax
  if(addr >= USERTOP || addr+4 >= USERTOP)
80104c4c:	3d fb df d4 0d       	cmp    $0xdd4dffb,%eax
80104c51:	77 2d                	ja     80104c80 <argptr+0x50>
  *ip = *(int*)(addr);
80104c53:	8b 00                	mov    (%eax),%eax
  int i;
  // struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= USERTOP || (uint)i+size > USERTOP)
80104c55:	85 db                	test   %ebx,%ebx
80104c57:	78 27                	js     80104c80 <argptr+0x50>
80104c59:	3d ff df d4 0d       	cmp    $0xdd4dfff,%eax
80104c5e:	77 20                	ja     80104c80 <argptr+0x50>
80104c60:	01 c3                	add    %eax,%ebx
80104c62:	81 fb 00 e0 d4 0d    	cmp    $0xdd4e000,%ebx
80104c68:	77 16                	ja     80104c80 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c6d:	89 02                	mov    %eax,(%edx)
  return 0;
80104c6f:	31 c0                	xor    %eax,%eax
}
80104c71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c74:	c9                   	leave  
80104c75:	c3                   	ret    
80104c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c7d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c85:	eb ea                	jmp    80104c71 <argptr+0x41>
80104c87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c8e:	66 90                	xchg   %ax,%ax

80104c90 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c96:	e8 55 ed ff ff       	call   801039f0 <myproc>
80104c9b:	8b 55 08             	mov    0x8(%ebp),%edx
80104c9e:	8b 40 18             	mov    0x18(%eax),%eax
80104ca1:	8b 40 44             	mov    0x44(%eax),%eax
80104ca4:	8d 44 90 04          	lea    0x4(%eax,%edx,4),%eax
  if(addr >= USERTOP || addr+4 >= USERTOP)
80104ca8:	3d fb df d4 0d       	cmp    $0xdd4dffb,%eax
80104cad:	77 20                	ja     80104ccf <argstr+0x3f>
  *ip = *(int*)(addr);
80104caf:	8b 10                	mov    (%eax),%edx
  if(addr >= USERTOP)
80104cb1:	81 fa ff df d4 0d    	cmp    $0xdd4dfff,%edx
80104cb7:	77 16                	ja     80104ccf <argstr+0x3f>
  *pp = (char*)addr;
80104cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cbc:	89 10                	mov    %edx,(%eax)
  for(s = *pp; s < ep; s++){
80104cbe:	89 d0                	mov    %edx,%eax
    if(*s == 0)
80104cc0:	80 38 00             	cmpb   $0x0,(%eax)
80104cc3:	74 1b                	je     80104ce0 <argstr+0x50>
  for(s = *pp; s < ep; s++){
80104cc5:	83 c0 01             	add    $0x1,%eax
80104cc8:	3d ff df d4 0d       	cmp    $0xdd4dfff,%eax
80104ccd:	76 f1                	jbe    80104cc0 <argstr+0x30>
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104ccf:	c9                   	leave  
    return -1;
80104cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cd5:	c3                   	ret    
80104cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi
80104ce0:	c9                   	leave  
      return s - *pp;
80104ce1:	29 d0                	sub    %edx,%eax
}
80104ce3:	c3                   	ret    
80104ce4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ceb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cef:	90                   	nop

80104cf0 <syscall>:
[SYS_change_priority] sys_change_priority,
};

void
syscall(void)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	53                   	push   %ebx
80104cf4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104cf7:	e8 f4 ec ff ff       	call   801039f0 <myproc>
80104cfc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104cfe:	8b 40 18             	mov    0x18(%eax),%eax
80104d01:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104d04:	8d 50 ff             	lea    -0x1(%eax),%edx
80104d07:	83 fa 18             	cmp    $0x18,%edx
80104d0a:	77 24                	ja     80104d30 <syscall+0x40>
80104d0c:	8b 14 85 60 87 10 80 	mov    -0x7fef78a0(,%eax,4),%edx
80104d13:	85 d2                	test   %edx,%edx
80104d15:	74 19                	je     80104d30 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104d17:	ff d2                	call   *%edx
80104d19:	89 c2                	mov    %eax,%edx
80104d1b:	8b 43 18             	mov    0x18(%ebx),%eax
80104d1e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104d21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d24:	c9                   	leave  
80104d25:	c3                   	ret    
80104d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d2d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104d30:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104d31:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104d34:	50                   	push   %eax
80104d35:	ff 73 10             	push   0x10(%ebx)
80104d38:	68 25 87 10 80       	push   $0x80108725
80104d3d:	e8 5e b9 ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80104d42:	8b 43 18             	mov    0x18(%ebx),%eax
80104d45:	83 c4 10             	add    $0x10,%esp
80104d48:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104d4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d52:	c9                   	leave  
80104d53:	c3                   	ret    
80104d54:	66 90                	xchg   %ax,%ax
80104d56:	66 90                	xchg   %ax,%ax
80104d58:	66 90                	xchg   %ax,%ax
80104d5a:	66 90                	xchg   %ax,%ax
80104d5c:	66 90                	xchg   %ax,%ax
80104d5e:	66 90                	xchg   %ax,%ax

80104d60 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	57                   	push   %edi
80104d64:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d65:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104d68:	53                   	push   %ebx
80104d69:	83 ec 34             	sub    $0x34,%esp
80104d6c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104d6f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104d72:	57                   	push   %edi
80104d73:	50                   	push   %eax
{
80104d74:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104d77:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d7a:	e8 21 d3 ff ff       	call   801020a0 <nameiparent>
80104d7f:	83 c4 10             	add    $0x10,%esp
80104d82:	85 c0                	test   %eax,%eax
80104d84:	0f 84 46 01 00 00    	je     80104ed0 <create+0x170>
    return 0;
  ilock(dp);
80104d8a:	83 ec 0c             	sub    $0xc,%esp
80104d8d:	89 c3                	mov    %eax,%ebx
80104d8f:	50                   	push   %eax
80104d90:	e8 cb c9 ff ff       	call   80101760 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104d95:	83 c4 0c             	add    $0xc,%esp
80104d98:	6a 00                	push   $0x0
80104d9a:	57                   	push   %edi
80104d9b:	53                   	push   %ebx
80104d9c:	e8 1f cf ff ff       	call   80101cc0 <dirlookup>
80104da1:	83 c4 10             	add    $0x10,%esp
80104da4:	89 c6                	mov    %eax,%esi
80104da6:	85 c0                	test   %eax,%eax
80104da8:	74 56                	je     80104e00 <create+0xa0>
    iunlockput(dp);
80104daa:	83 ec 0c             	sub    $0xc,%esp
80104dad:	53                   	push   %ebx
80104dae:	e8 3d cc ff ff       	call   801019f0 <iunlockput>
    ilock(ip);
80104db3:	89 34 24             	mov    %esi,(%esp)
80104db6:	e8 a5 c9 ff ff       	call   80101760 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104dbb:	83 c4 10             	add    $0x10,%esp
80104dbe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104dc3:	75 1b                	jne    80104de0 <create+0x80>
80104dc5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104dca:	75 14                	jne    80104de0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104dcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dcf:	89 f0                	mov    %esi,%eax
80104dd1:	5b                   	pop    %ebx
80104dd2:	5e                   	pop    %esi
80104dd3:	5f                   	pop    %edi
80104dd4:	5d                   	pop    %ebp
80104dd5:	c3                   	ret    
80104dd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ddd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104de0:	83 ec 0c             	sub    $0xc,%esp
80104de3:	56                   	push   %esi
    return 0;
80104de4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104de6:	e8 05 cc ff ff       	call   801019f0 <iunlockput>
    return 0;
80104deb:	83 c4 10             	add    $0x10,%esp
}
80104dee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104df1:	89 f0                	mov    %esi,%eax
80104df3:	5b                   	pop    %ebx
80104df4:	5e                   	pop    %esi
80104df5:	5f                   	pop    %edi
80104df6:	5d                   	pop    %ebp
80104df7:	c3                   	ret    
80104df8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dff:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104e00:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e04:	83 ec 08             	sub    $0x8,%esp
80104e07:	50                   	push   %eax
80104e08:	ff 33                	push   (%ebx)
80104e0a:	e8 e1 c7 ff ff       	call   801015f0 <ialloc>
80104e0f:	83 c4 10             	add    $0x10,%esp
80104e12:	89 c6                	mov    %eax,%esi
80104e14:	85 c0                	test   %eax,%eax
80104e16:	0f 84 cd 00 00 00    	je     80104ee9 <create+0x189>
  ilock(ip);
80104e1c:	83 ec 0c             	sub    $0xc,%esp
80104e1f:	50                   	push   %eax
80104e20:	e8 3b c9 ff ff       	call   80101760 <ilock>
  ip->major = major;
80104e25:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104e29:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104e2d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104e31:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104e35:	b8 01 00 00 00       	mov    $0x1,%eax
80104e3a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104e3e:	89 34 24             	mov    %esi,(%esp)
80104e41:	e8 6a c8 ff ff       	call   801016b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104e46:	83 c4 10             	add    $0x10,%esp
80104e49:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104e4e:	74 30                	je     80104e80 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104e50:	83 ec 04             	sub    $0x4,%esp
80104e53:	ff 76 04             	push   0x4(%esi)
80104e56:	57                   	push   %edi
80104e57:	53                   	push   %ebx
80104e58:	e8 63 d1 ff ff       	call   80101fc0 <dirlink>
80104e5d:	83 c4 10             	add    $0x10,%esp
80104e60:	85 c0                	test   %eax,%eax
80104e62:	78 78                	js     80104edc <create+0x17c>
  iunlockput(dp);
80104e64:	83 ec 0c             	sub    $0xc,%esp
80104e67:	53                   	push   %ebx
80104e68:	e8 83 cb ff ff       	call   801019f0 <iunlockput>
  return ip;
80104e6d:	83 c4 10             	add    $0x10,%esp
}
80104e70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e73:	89 f0                	mov    %esi,%eax
80104e75:	5b                   	pop    %ebx
80104e76:	5e                   	pop    %esi
80104e77:	5f                   	pop    %edi
80104e78:	5d                   	pop    %ebp
80104e79:	c3                   	ret    
80104e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104e80:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104e83:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104e88:	53                   	push   %ebx
80104e89:	e8 22 c8 ff ff       	call   801016b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e8e:	83 c4 0c             	add    $0xc,%esp
80104e91:	ff 76 04             	push   0x4(%esi)
80104e94:	68 e4 87 10 80       	push   $0x801087e4
80104e99:	56                   	push   %esi
80104e9a:	e8 21 d1 ff ff       	call   80101fc0 <dirlink>
80104e9f:	83 c4 10             	add    $0x10,%esp
80104ea2:	85 c0                	test   %eax,%eax
80104ea4:	78 18                	js     80104ebe <create+0x15e>
80104ea6:	83 ec 04             	sub    $0x4,%esp
80104ea9:	ff 73 04             	push   0x4(%ebx)
80104eac:	68 e3 87 10 80       	push   $0x801087e3
80104eb1:	56                   	push   %esi
80104eb2:	e8 09 d1 ff ff       	call   80101fc0 <dirlink>
80104eb7:	83 c4 10             	add    $0x10,%esp
80104eba:	85 c0                	test   %eax,%eax
80104ebc:	79 92                	jns    80104e50 <create+0xf0>
      panic("create dots");
80104ebe:	83 ec 0c             	sub    $0xc,%esp
80104ec1:	68 d7 87 10 80       	push   $0x801087d7
80104ec6:	e8 b5 b4 ff ff       	call   80100380 <panic>
80104ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ecf:	90                   	nop
}
80104ed0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104ed3:	31 f6                	xor    %esi,%esi
}
80104ed5:	5b                   	pop    %ebx
80104ed6:	89 f0                	mov    %esi,%eax
80104ed8:	5e                   	pop    %esi
80104ed9:	5f                   	pop    %edi
80104eda:	5d                   	pop    %ebp
80104edb:	c3                   	ret    
    panic("create: dirlink");
80104edc:	83 ec 0c             	sub    $0xc,%esp
80104edf:	68 e6 87 10 80       	push   $0x801087e6
80104ee4:	e8 97 b4 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104ee9:	83 ec 0c             	sub    $0xc,%esp
80104eec:	68 c8 87 10 80       	push   $0x801087c8
80104ef1:	e8 8a b4 ff ff       	call   80100380 <panic>
80104ef6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104efd:	8d 76 00             	lea    0x0(%esi),%esi

80104f00 <sys_dup>:
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f05:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f0b:	50                   	push   %eax
80104f0c:	6a 00                	push   $0x0
80104f0e:	e8 dd fc ff ff       	call   80104bf0 <argint>
80104f13:	83 c4 10             	add    $0x10,%esp
80104f16:	85 c0                	test   %eax,%eax
80104f18:	78 36                	js     80104f50 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f1e:	77 30                	ja     80104f50 <sys_dup+0x50>
80104f20:	e8 cb ea ff ff       	call   801039f0 <myproc>
80104f25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f28:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f2c:	85 f6                	test   %esi,%esi
80104f2e:	74 20                	je     80104f50 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104f30:	e8 bb ea ff ff       	call   801039f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104f35:	31 db                	xor    %ebx,%ebx
80104f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f3e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104f40:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f44:	85 d2                	test   %edx,%edx
80104f46:	74 18                	je     80104f60 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104f48:	83 c3 01             	add    $0x1,%ebx
80104f4b:	83 fb 10             	cmp    $0x10,%ebx
80104f4e:	75 f0                	jne    80104f40 <sys_dup+0x40>
}
80104f50:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f58:	89 d8                	mov    %ebx,%eax
80104f5a:	5b                   	pop    %ebx
80104f5b:	5e                   	pop    %esi
80104f5c:	5d                   	pop    %ebp
80104f5d:	c3                   	ret    
80104f5e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104f60:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104f63:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104f67:	56                   	push   %esi
80104f68:	e8 13 bf ff ff       	call   80100e80 <filedup>
  return fd;
80104f6d:	83 c4 10             	add    $0x10,%esp
}
80104f70:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f73:	89 d8                	mov    %ebx,%eax
80104f75:	5b                   	pop    %ebx
80104f76:	5e                   	pop    %esi
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret    
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f80 <sys_read>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f8b:	53                   	push   %ebx
80104f8c:	6a 00                	push   $0x0
80104f8e:	e8 5d fc ff ff       	call   80104bf0 <argint>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	78 5e                	js     80104ff8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f9e:	77 58                	ja     80104ff8 <sys_read+0x78>
80104fa0:	e8 4b ea ff ff       	call   801039f0 <myproc>
80104fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fa8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fac:	85 f6                	test   %esi,%esi
80104fae:	74 48                	je     80104ff8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fb0:	83 ec 08             	sub    $0x8,%esp
80104fb3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fb6:	50                   	push   %eax
80104fb7:	6a 02                	push   $0x2
80104fb9:	e8 32 fc ff ff       	call   80104bf0 <argint>
80104fbe:	83 c4 10             	add    $0x10,%esp
80104fc1:	85 c0                	test   %eax,%eax
80104fc3:	78 33                	js     80104ff8 <sys_read+0x78>
80104fc5:	83 ec 04             	sub    $0x4,%esp
80104fc8:	ff 75 f0             	push   -0x10(%ebp)
80104fcb:	53                   	push   %ebx
80104fcc:	6a 01                	push   $0x1
80104fce:	e8 5d fc ff ff       	call   80104c30 <argptr>
80104fd3:	83 c4 10             	add    $0x10,%esp
80104fd6:	85 c0                	test   %eax,%eax
80104fd8:	78 1e                	js     80104ff8 <sys_read+0x78>
  return fileread(f, p, n);
80104fda:	83 ec 04             	sub    $0x4,%esp
80104fdd:	ff 75 f0             	push   -0x10(%ebp)
80104fe0:	ff 75 f4             	push   -0xc(%ebp)
80104fe3:	56                   	push   %esi
80104fe4:	e8 17 c0 ff ff       	call   80101000 <fileread>
80104fe9:	83 c4 10             	add    $0x10,%esp
}
80104fec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fef:	5b                   	pop    %ebx
80104ff0:	5e                   	pop    %esi
80104ff1:	5d                   	pop    %ebp
80104ff2:	c3                   	ret    
80104ff3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ff7:	90                   	nop
    return -1;
80104ff8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ffd:	eb ed                	jmp    80104fec <sys_read+0x6c>
80104fff:	90                   	nop

80105000 <sys_write>:
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105005:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105008:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010500b:	53                   	push   %ebx
8010500c:	6a 00                	push   $0x0
8010500e:	e8 dd fb ff ff       	call   80104bf0 <argint>
80105013:	83 c4 10             	add    $0x10,%esp
80105016:	85 c0                	test   %eax,%eax
80105018:	78 5e                	js     80105078 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010501a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010501e:	77 58                	ja     80105078 <sys_write+0x78>
80105020:	e8 cb e9 ff ff       	call   801039f0 <myproc>
80105025:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105028:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010502c:	85 f6                	test   %esi,%esi
8010502e:	74 48                	je     80105078 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105030:	83 ec 08             	sub    $0x8,%esp
80105033:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105036:	50                   	push   %eax
80105037:	6a 02                	push   $0x2
80105039:	e8 b2 fb ff ff       	call   80104bf0 <argint>
8010503e:	83 c4 10             	add    $0x10,%esp
80105041:	85 c0                	test   %eax,%eax
80105043:	78 33                	js     80105078 <sys_write+0x78>
80105045:	83 ec 04             	sub    $0x4,%esp
80105048:	ff 75 f0             	push   -0x10(%ebp)
8010504b:	53                   	push   %ebx
8010504c:	6a 01                	push   $0x1
8010504e:	e8 dd fb ff ff       	call   80104c30 <argptr>
80105053:	83 c4 10             	add    $0x10,%esp
80105056:	85 c0                	test   %eax,%eax
80105058:	78 1e                	js     80105078 <sys_write+0x78>
  return filewrite(f, p, n);
8010505a:	83 ec 04             	sub    $0x4,%esp
8010505d:	ff 75 f0             	push   -0x10(%ebp)
80105060:	ff 75 f4             	push   -0xc(%ebp)
80105063:	56                   	push   %esi
80105064:	e8 27 c0 ff ff       	call   80101090 <filewrite>
80105069:	83 c4 10             	add    $0x10,%esp
}
8010506c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010506f:	5b                   	pop    %ebx
80105070:	5e                   	pop    %esi
80105071:	5d                   	pop    %ebp
80105072:	c3                   	ret    
80105073:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105077:	90                   	nop
    return -1;
80105078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010507d:	eb ed                	jmp    8010506c <sys_write+0x6c>
8010507f:	90                   	nop

80105080 <sys_close>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105085:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105088:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010508b:	50                   	push   %eax
8010508c:	6a 00                	push   $0x0
8010508e:	e8 5d fb ff ff       	call   80104bf0 <argint>
80105093:	83 c4 10             	add    $0x10,%esp
80105096:	85 c0                	test   %eax,%eax
80105098:	78 3e                	js     801050d8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010509a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010509e:	77 38                	ja     801050d8 <sys_close+0x58>
801050a0:	e8 4b e9 ff ff       	call   801039f0 <myproc>
801050a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050a8:	8d 5a 08             	lea    0x8(%edx),%ebx
801050ab:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801050af:	85 f6                	test   %esi,%esi
801050b1:	74 25                	je     801050d8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801050b3:	e8 38 e9 ff ff       	call   801039f0 <myproc>
  fileclose(f);
801050b8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801050bb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801050c2:	00 
  fileclose(f);
801050c3:	56                   	push   %esi
801050c4:	e8 07 be ff ff       	call   80100ed0 <fileclose>
  return 0;
801050c9:	83 c4 10             	add    $0x10,%esp
801050cc:	31 c0                	xor    %eax,%eax
}
801050ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050d1:	5b                   	pop    %ebx
801050d2:	5e                   	pop    %esi
801050d3:	5d                   	pop    %ebp
801050d4:	c3                   	ret    
801050d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050dd:	eb ef                	jmp    801050ce <sys_close+0x4e>
801050df:	90                   	nop

801050e0 <sys_fstat>:
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	56                   	push   %esi
801050e4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801050e8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050eb:	53                   	push   %ebx
801050ec:	6a 00                	push   $0x0
801050ee:	e8 fd fa ff ff       	call   80104bf0 <argint>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	85 c0                	test   %eax,%eax
801050f8:	78 46                	js     80105140 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050fe:	77 40                	ja     80105140 <sys_fstat+0x60>
80105100:	e8 eb e8 ff ff       	call   801039f0 <myproc>
80105105:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105108:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010510c:	85 f6                	test   %esi,%esi
8010510e:	74 30                	je     80105140 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105110:	83 ec 04             	sub    $0x4,%esp
80105113:	6a 14                	push   $0x14
80105115:	53                   	push   %ebx
80105116:	6a 01                	push   $0x1
80105118:	e8 13 fb ff ff       	call   80104c30 <argptr>
8010511d:	83 c4 10             	add    $0x10,%esp
80105120:	85 c0                	test   %eax,%eax
80105122:	78 1c                	js     80105140 <sys_fstat+0x60>
  return filestat(f, st);
80105124:	83 ec 08             	sub    $0x8,%esp
80105127:	ff 75 f4             	push   -0xc(%ebp)
8010512a:	56                   	push   %esi
8010512b:	e8 80 be ff ff       	call   80100fb0 <filestat>
80105130:	83 c4 10             	add    $0x10,%esp
}
80105133:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105136:	5b                   	pop    %ebx
80105137:	5e                   	pop    %esi
80105138:	5d                   	pop    %ebp
80105139:	c3                   	ret    
8010513a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105145:	eb ec                	jmp    80105133 <sys_fstat+0x53>
80105147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010514e:	66 90                	xchg   %ax,%ax

80105150 <sys_link>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105155:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105158:	53                   	push   %ebx
80105159:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010515c:	50                   	push   %eax
8010515d:	6a 00                	push   $0x0
8010515f:	e8 2c fb ff ff       	call   80104c90 <argstr>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	0f 88 fb 00 00 00    	js     8010526a <sys_link+0x11a>
8010516f:	83 ec 08             	sub    $0x8,%esp
80105172:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105175:	50                   	push   %eax
80105176:	6a 01                	push   $0x1
80105178:	e8 13 fb ff ff       	call   80104c90 <argstr>
8010517d:	83 c4 10             	add    $0x10,%esp
80105180:	85 c0                	test   %eax,%eax
80105182:	0f 88 e2 00 00 00    	js     8010526a <sys_link+0x11a>
  begin_op();
80105188:	e8 b3 db ff ff       	call   80102d40 <begin_op>
  if((ip = namei(old)) == 0){
8010518d:	83 ec 0c             	sub    $0xc,%esp
80105190:	ff 75 d4             	push   -0x2c(%ebp)
80105193:	e8 e8 ce ff ff       	call   80102080 <namei>
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	89 c3                	mov    %eax,%ebx
8010519d:	85 c0                	test   %eax,%eax
8010519f:	0f 84 e4 00 00 00    	je     80105289 <sys_link+0x139>
  ilock(ip);
801051a5:	83 ec 0c             	sub    $0xc,%esp
801051a8:	50                   	push   %eax
801051a9:	e8 b2 c5 ff ff       	call   80101760 <ilock>
  if(ip->type == T_DIR){
801051ae:	83 c4 10             	add    $0x10,%esp
801051b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051b6:	0f 84 b5 00 00 00    	je     80105271 <sys_link+0x121>
  iupdate(ip);
801051bc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801051bf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801051c4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801051c7:	53                   	push   %ebx
801051c8:	e8 e3 c4 ff ff       	call   801016b0 <iupdate>
  iunlock(ip);
801051cd:	89 1c 24             	mov    %ebx,(%esp)
801051d0:	e8 6b c6 ff ff       	call   80101840 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801051d5:	58                   	pop    %eax
801051d6:	5a                   	pop    %edx
801051d7:	57                   	push   %edi
801051d8:	ff 75 d0             	push   -0x30(%ebp)
801051db:	e8 c0 ce ff ff       	call   801020a0 <nameiparent>
801051e0:	83 c4 10             	add    $0x10,%esp
801051e3:	89 c6                	mov    %eax,%esi
801051e5:	85 c0                	test   %eax,%eax
801051e7:	74 5b                	je     80105244 <sys_link+0xf4>
  ilock(dp);
801051e9:	83 ec 0c             	sub    $0xc,%esp
801051ec:	50                   	push   %eax
801051ed:	e8 6e c5 ff ff       	call   80101760 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801051f2:	8b 03                	mov    (%ebx),%eax
801051f4:	83 c4 10             	add    $0x10,%esp
801051f7:	39 06                	cmp    %eax,(%esi)
801051f9:	75 3d                	jne    80105238 <sys_link+0xe8>
801051fb:	83 ec 04             	sub    $0x4,%esp
801051fe:	ff 73 04             	push   0x4(%ebx)
80105201:	57                   	push   %edi
80105202:	56                   	push   %esi
80105203:	e8 b8 cd ff ff       	call   80101fc0 <dirlink>
80105208:	83 c4 10             	add    $0x10,%esp
8010520b:	85 c0                	test   %eax,%eax
8010520d:	78 29                	js     80105238 <sys_link+0xe8>
  iunlockput(dp);
8010520f:	83 ec 0c             	sub    $0xc,%esp
80105212:	56                   	push   %esi
80105213:	e8 d8 c7 ff ff       	call   801019f0 <iunlockput>
  iput(ip);
80105218:	89 1c 24             	mov    %ebx,(%esp)
8010521b:	e8 70 c6 ff ff       	call   80101890 <iput>
  end_op();
80105220:	e8 8b db ff ff       	call   80102db0 <end_op>
  return 0;
80105225:	83 c4 10             	add    $0x10,%esp
80105228:	31 c0                	xor    %eax,%eax
}
8010522a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010522d:	5b                   	pop    %ebx
8010522e:	5e                   	pop    %esi
8010522f:	5f                   	pop    %edi
80105230:	5d                   	pop    %ebp
80105231:	c3                   	ret    
80105232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105238:	83 ec 0c             	sub    $0xc,%esp
8010523b:	56                   	push   %esi
8010523c:	e8 af c7 ff ff       	call   801019f0 <iunlockput>
    goto bad;
80105241:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105244:	83 ec 0c             	sub    $0xc,%esp
80105247:	53                   	push   %ebx
80105248:	e8 13 c5 ff ff       	call   80101760 <ilock>
  ip->nlink--;
8010524d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105252:	89 1c 24             	mov    %ebx,(%esp)
80105255:	e8 56 c4 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
8010525a:	89 1c 24             	mov    %ebx,(%esp)
8010525d:	e8 8e c7 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105262:	e8 49 db ff ff       	call   80102db0 <end_op>
  return -1;
80105267:	83 c4 10             	add    $0x10,%esp
8010526a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010526f:	eb b9                	jmp    8010522a <sys_link+0xda>
    iunlockput(ip);
80105271:	83 ec 0c             	sub    $0xc,%esp
80105274:	53                   	push   %ebx
80105275:	e8 76 c7 ff ff       	call   801019f0 <iunlockput>
    end_op();
8010527a:	e8 31 db ff ff       	call   80102db0 <end_op>
    return -1;
8010527f:	83 c4 10             	add    $0x10,%esp
80105282:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105287:	eb a1                	jmp    8010522a <sys_link+0xda>
    end_op();
80105289:	e8 22 db ff ff       	call   80102db0 <end_op>
    return -1;
8010528e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105293:	eb 95                	jmp    8010522a <sys_link+0xda>
80105295:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010529c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052a0 <sys_unlink>:
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	57                   	push   %edi
801052a4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801052a5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801052a8:	53                   	push   %ebx
801052a9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801052ac:	50                   	push   %eax
801052ad:	6a 00                	push   $0x0
801052af:	e8 dc f9 ff ff       	call   80104c90 <argstr>
801052b4:	83 c4 10             	add    $0x10,%esp
801052b7:	85 c0                	test   %eax,%eax
801052b9:	0f 88 7a 01 00 00    	js     80105439 <sys_unlink+0x199>
  begin_op();
801052bf:	e8 7c da ff ff       	call   80102d40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801052c4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801052c7:	83 ec 08             	sub    $0x8,%esp
801052ca:	53                   	push   %ebx
801052cb:	ff 75 c0             	push   -0x40(%ebp)
801052ce:	e8 cd cd ff ff       	call   801020a0 <nameiparent>
801052d3:	83 c4 10             	add    $0x10,%esp
801052d6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801052d9:	85 c0                	test   %eax,%eax
801052db:	0f 84 62 01 00 00    	je     80105443 <sys_unlink+0x1a3>
  ilock(dp);
801052e1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801052e4:	83 ec 0c             	sub    $0xc,%esp
801052e7:	57                   	push   %edi
801052e8:	e8 73 c4 ff ff       	call   80101760 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801052ed:	58                   	pop    %eax
801052ee:	5a                   	pop    %edx
801052ef:	68 e4 87 10 80       	push   $0x801087e4
801052f4:	53                   	push   %ebx
801052f5:	e8 a6 c9 ff ff       	call   80101ca0 <namecmp>
801052fa:	83 c4 10             	add    $0x10,%esp
801052fd:	85 c0                	test   %eax,%eax
801052ff:	0f 84 fb 00 00 00    	je     80105400 <sys_unlink+0x160>
80105305:	83 ec 08             	sub    $0x8,%esp
80105308:	68 e3 87 10 80       	push   $0x801087e3
8010530d:	53                   	push   %ebx
8010530e:	e8 8d c9 ff ff       	call   80101ca0 <namecmp>
80105313:	83 c4 10             	add    $0x10,%esp
80105316:	85 c0                	test   %eax,%eax
80105318:	0f 84 e2 00 00 00    	je     80105400 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010531e:	83 ec 04             	sub    $0x4,%esp
80105321:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105324:	50                   	push   %eax
80105325:	53                   	push   %ebx
80105326:	57                   	push   %edi
80105327:	e8 94 c9 ff ff       	call   80101cc0 <dirlookup>
8010532c:	83 c4 10             	add    $0x10,%esp
8010532f:	89 c3                	mov    %eax,%ebx
80105331:	85 c0                	test   %eax,%eax
80105333:	0f 84 c7 00 00 00    	je     80105400 <sys_unlink+0x160>
  ilock(ip);
80105339:	83 ec 0c             	sub    $0xc,%esp
8010533c:	50                   	push   %eax
8010533d:	e8 1e c4 ff ff       	call   80101760 <ilock>
  if(ip->nlink < 1)
80105342:	83 c4 10             	add    $0x10,%esp
80105345:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010534a:	0f 8e 1c 01 00 00    	jle    8010546c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105350:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105355:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105358:	74 66                	je     801053c0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010535a:	83 ec 04             	sub    $0x4,%esp
8010535d:	6a 10                	push   $0x10
8010535f:	6a 00                	push   $0x0
80105361:	57                   	push   %edi
80105362:	e8 e9 f5 ff ff       	call   80104950 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105367:	6a 10                	push   $0x10
80105369:	ff 75 c4             	push   -0x3c(%ebp)
8010536c:	57                   	push   %edi
8010536d:	ff 75 b4             	push   -0x4c(%ebp)
80105370:	e8 fb c7 ff ff       	call   80101b70 <writei>
80105375:	83 c4 20             	add    $0x20,%esp
80105378:	83 f8 10             	cmp    $0x10,%eax
8010537b:	0f 85 de 00 00 00    	jne    8010545f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105381:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105386:	0f 84 94 00 00 00    	je     80105420 <sys_unlink+0x180>
  iunlockput(dp);
8010538c:	83 ec 0c             	sub    $0xc,%esp
8010538f:	ff 75 b4             	push   -0x4c(%ebp)
80105392:	e8 59 c6 ff ff       	call   801019f0 <iunlockput>
  ip->nlink--;
80105397:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010539c:	89 1c 24             	mov    %ebx,(%esp)
8010539f:	e8 0c c3 ff ff       	call   801016b0 <iupdate>
  iunlockput(ip);
801053a4:	89 1c 24             	mov    %ebx,(%esp)
801053a7:	e8 44 c6 ff ff       	call   801019f0 <iunlockput>
  end_op();
801053ac:	e8 ff d9 ff ff       	call   80102db0 <end_op>
  return 0;
801053b1:	83 c4 10             	add    $0x10,%esp
801053b4:	31 c0                	xor    %eax,%eax
}
801053b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053b9:	5b                   	pop    %ebx
801053ba:	5e                   	pop    %esi
801053bb:	5f                   	pop    %edi
801053bc:	5d                   	pop    %ebp
801053bd:	c3                   	ret    
801053be:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801053c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801053c4:	76 94                	jbe    8010535a <sys_unlink+0xba>
801053c6:	be 20 00 00 00       	mov    $0x20,%esi
801053cb:	eb 0b                	jmp    801053d8 <sys_unlink+0x138>
801053cd:	8d 76 00             	lea    0x0(%esi),%esi
801053d0:	83 c6 10             	add    $0x10,%esi
801053d3:	3b 73 58             	cmp    0x58(%ebx),%esi
801053d6:	73 82                	jae    8010535a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053d8:	6a 10                	push   $0x10
801053da:	56                   	push   %esi
801053db:	57                   	push   %edi
801053dc:	53                   	push   %ebx
801053dd:	e8 8e c6 ff ff       	call   80101a70 <readi>
801053e2:	83 c4 10             	add    $0x10,%esp
801053e5:	83 f8 10             	cmp    $0x10,%eax
801053e8:	75 68                	jne    80105452 <sys_unlink+0x1b2>
    if(de.inum != 0)
801053ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801053ef:	74 df                	je     801053d0 <sys_unlink+0x130>
    iunlockput(ip);
801053f1:	83 ec 0c             	sub    $0xc,%esp
801053f4:	53                   	push   %ebx
801053f5:	e8 f6 c5 ff ff       	call   801019f0 <iunlockput>
    goto bad;
801053fa:	83 c4 10             	add    $0x10,%esp
801053fd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	ff 75 b4             	push   -0x4c(%ebp)
80105406:	e8 e5 c5 ff ff       	call   801019f0 <iunlockput>
  end_op();
8010540b:	e8 a0 d9 ff ff       	call   80102db0 <end_op>
  return -1;
80105410:	83 c4 10             	add    $0x10,%esp
80105413:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105418:	eb 9c                	jmp    801053b6 <sys_unlink+0x116>
8010541a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105420:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105423:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105426:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010542b:	50                   	push   %eax
8010542c:	e8 7f c2 ff ff       	call   801016b0 <iupdate>
80105431:	83 c4 10             	add    $0x10,%esp
80105434:	e9 53 ff ff ff       	jmp    8010538c <sys_unlink+0xec>
    return -1;
80105439:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010543e:	e9 73 ff ff ff       	jmp    801053b6 <sys_unlink+0x116>
    end_op();
80105443:	e8 68 d9 ff ff       	call   80102db0 <end_op>
    return -1;
80105448:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010544d:	e9 64 ff ff ff       	jmp    801053b6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105452:	83 ec 0c             	sub    $0xc,%esp
80105455:	68 08 88 10 80       	push   $0x80108808
8010545a:	e8 21 af ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010545f:	83 ec 0c             	sub    $0xc,%esp
80105462:	68 1a 88 10 80       	push   $0x8010881a
80105467:	e8 14 af ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010546c:	83 ec 0c             	sub    $0xc,%esp
8010546f:	68 f6 87 10 80       	push   $0x801087f6
80105474:	e8 07 af ff ff       	call   80100380 <panic>
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105480 <sys_open>:

int
sys_open(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	57                   	push   %edi
80105484:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105485:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105488:	53                   	push   %ebx
80105489:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010548c:	50                   	push   %eax
8010548d:	6a 00                	push   $0x0
8010548f:	e8 fc f7 ff ff       	call   80104c90 <argstr>
80105494:	83 c4 10             	add    $0x10,%esp
80105497:	85 c0                	test   %eax,%eax
80105499:	0f 88 8e 00 00 00    	js     8010552d <sys_open+0xad>
8010549f:	83 ec 08             	sub    $0x8,%esp
801054a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801054a5:	50                   	push   %eax
801054a6:	6a 01                	push   $0x1
801054a8:	e8 43 f7 ff ff       	call   80104bf0 <argint>
801054ad:	83 c4 10             	add    $0x10,%esp
801054b0:	85 c0                	test   %eax,%eax
801054b2:	78 79                	js     8010552d <sys_open+0xad>
    return -1;

  begin_op();
801054b4:	e8 87 d8 ff ff       	call   80102d40 <begin_op>

  if(omode & O_CREATE){
801054b9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801054bd:	75 79                	jne    80105538 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801054bf:	83 ec 0c             	sub    $0xc,%esp
801054c2:	ff 75 e0             	push   -0x20(%ebp)
801054c5:	e8 b6 cb ff ff       	call   80102080 <namei>
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	89 c6                	mov    %eax,%esi
801054cf:	85 c0                	test   %eax,%eax
801054d1:	0f 84 7e 00 00 00    	je     80105555 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801054d7:	83 ec 0c             	sub    $0xc,%esp
801054da:	50                   	push   %eax
801054db:	e8 80 c2 ff ff       	call   80101760 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801054e0:	83 c4 10             	add    $0x10,%esp
801054e3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801054e8:	0f 84 c2 00 00 00    	je     801055b0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801054ee:	e8 1d b9 ff ff       	call   80100e10 <filealloc>
801054f3:	89 c7                	mov    %eax,%edi
801054f5:	85 c0                	test   %eax,%eax
801054f7:	74 23                	je     8010551c <sys_open+0x9c>
  struct proc *curproc = myproc();
801054f9:	e8 f2 e4 ff ff       	call   801039f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801054fe:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105500:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105504:	85 d2                	test   %edx,%edx
80105506:	74 60                	je     80105568 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105508:	83 c3 01             	add    $0x1,%ebx
8010550b:	83 fb 10             	cmp    $0x10,%ebx
8010550e:	75 f0                	jne    80105500 <sys_open+0x80>
    if(f)
      fileclose(f);
80105510:	83 ec 0c             	sub    $0xc,%esp
80105513:	57                   	push   %edi
80105514:	e8 b7 b9 ff ff       	call   80100ed0 <fileclose>
80105519:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010551c:	83 ec 0c             	sub    $0xc,%esp
8010551f:	56                   	push   %esi
80105520:	e8 cb c4 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105525:	e8 86 d8 ff ff       	call   80102db0 <end_op>
    return -1;
8010552a:	83 c4 10             	add    $0x10,%esp
8010552d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105532:	eb 6d                	jmp    801055a1 <sys_open+0x121>
80105534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105538:	83 ec 0c             	sub    $0xc,%esp
8010553b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010553e:	31 c9                	xor    %ecx,%ecx
80105540:	ba 02 00 00 00       	mov    $0x2,%edx
80105545:	6a 00                	push   $0x0
80105547:	e8 14 f8 ff ff       	call   80104d60 <create>
    if(ip == 0){
8010554c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010554f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105551:	85 c0                	test   %eax,%eax
80105553:	75 99                	jne    801054ee <sys_open+0x6e>
      end_op();
80105555:	e8 56 d8 ff ff       	call   80102db0 <end_op>
      return -1;
8010555a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010555f:	eb 40                	jmp    801055a1 <sys_open+0x121>
80105561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105568:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010556b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010556f:	56                   	push   %esi
80105570:	e8 cb c2 ff ff       	call   80101840 <iunlock>
  end_op();
80105575:	e8 36 d8 ff ff       	call   80102db0 <end_op>

  f->type = FD_INODE;
8010557a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105580:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105583:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105586:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105589:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010558b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105592:	f7 d0                	not    %eax
80105594:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105597:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010559a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010559d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801055a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055a4:	89 d8                	mov    %ebx,%eax
801055a6:	5b                   	pop    %ebx
801055a7:	5e                   	pop    %esi
801055a8:	5f                   	pop    %edi
801055a9:	5d                   	pop    %ebp
801055aa:	c3                   	ret    
801055ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055af:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801055b0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801055b3:	85 c9                	test   %ecx,%ecx
801055b5:	0f 84 33 ff ff ff    	je     801054ee <sys_open+0x6e>
801055bb:	e9 5c ff ff ff       	jmp    8010551c <sys_open+0x9c>

801055c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801055c6:	e8 75 d7 ff ff       	call   80102d40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801055cb:	83 ec 08             	sub    $0x8,%esp
801055ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055d1:	50                   	push   %eax
801055d2:	6a 00                	push   $0x0
801055d4:	e8 b7 f6 ff ff       	call   80104c90 <argstr>
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	85 c0                	test   %eax,%eax
801055de:	78 30                	js     80105610 <sys_mkdir+0x50>
801055e0:	83 ec 0c             	sub    $0xc,%esp
801055e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e6:	31 c9                	xor    %ecx,%ecx
801055e8:	ba 01 00 00 00       	mov    $0x1,%edx
801055ed:	6a 00                	push   $0x0
801055ef:	e8 6c f7 ff ff       	call   80104d60 <create>
801055f4:	83 c4 10             	add    $0x10,%esp
801055f7:	85 c0                	test   %eax,%eax
801055f9:	74 15                	je     80105610 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801055fb:	83 ec 0c             	sub    $0xc,%esp
801055fe:	50                   	push   %eax
801055ff:	e8 ec c3 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105604:	e8 a7 d7 ff ff       	call   80102db0 <end_op>
  return 0;
80105609:	83 c4 10             	add    $0x10,%esp
8010560c:	31 c0                	xor    %eax,%eax
}
8010560e:	c9                   	leave  
8010560f:	c3                   	ret    
    end_op();
80105610:	e8 9b d7 ff ff       	call   80102db0 <end_op>
    return -1;
80105615:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010561a:	c9                   	leave  
8010561b:	c3                   	ret    
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105620 <sys_mknod>:

int
sys_mknod(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105626:	e8 15 d7 ff ff       	call   80102d40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010562b:	83 ec 08             	sub    $0x8,%esp
8010562e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105631:	50                   	push   %eax
80105632:	6a 00                	push   $0x0
80105634:	e8 57 f6 ff ff       	call   80104c90 <argstr>
80105639:	83 c4 10             	add    $0x10,%esp
8010563c:	85 c0                	test   %eax,%eax
8010563e:	78 60                	js     801056a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105640:	83 ec 08             	sub    $0x8,%esp
80105643:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105646:	50                   	push   %eax
80105647:	6a 01                	push   $0x1
80105649:	e8 a2 f5 ff ff       	call   80104bf0 <argint>
  if((argstr(0, &path)) < 0 ||
8010564e:	83 c4 10             	add    $0x10,%esp
80105651:	85 c0                	test   %eax,%eax
80105653:	78 4b                	js     801056a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105655:	83 ec 08             	sub    $0x8,%esp
80105658:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010565b:	50                   	push   %eax
8010565c:	6a 02                	push   $0x2
8010565e:	e8 8d f5 ff ff       	call   80104bf0 <argint>
     argint(1, &major) < 0 ||
80105663:	83 c4 10             	add    $0x10,%esp
80105666:	85 c0                	test   %eax,%eax
80105668:	78 36                	js     801056a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010566a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010566e:	83 ec 0c             	sub    $0xc,%esp
80105671:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105675:	ba 03 00 00 00       	mov    $0x3,%edx
8010567a:	50                   	push   %eax
8010567b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010567e:	e8 dd f6 ff ff       	call   80104d60 <create>
     argint(2, &minor) < 0 ||
80105683:	83 c4 10             	add    $0x10,%esp
80105686:	85 c0                	test   %eax,%eax
80105688:	74 16                	je     801056a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010568a:	83 ec 0c             	sub    $0xc,%esp
8010568d:	50                   	push   %eax
8010568e:	e8 5d c3 ff ff       	call   801019f0 <iunlockput>
  end_op();
80105693:	e8 18 d7 ff ff       	call   80102db0 <end_op>
  return 0;
80105698:	83 c4 10             	add    $0x10,%esp
8010569b:	31 c0                	xor    %eax,%eax
}
8010569d:	c9                   	leave  
8010569e:	c3                   	ret    
8010569f:	90                   	nop
    end_op();
801056a0:	e8 0b d7 ff ff       	call   80102db0 <end_op>
    return -1;
801056a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056aa:	c9                   	leave  
801056ab:	c3                   	ret    
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056b0 <sys_chdir>:

int
sys_chdir(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	56                   	push   %esi
801056b4:	53                   	push   %ebx
801056b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801056b8:	e8 33 e3 ff ff       	call   801039f0 <myproc>
801056bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801056bf:	e8 7c d6 ff ff       	call   80102d40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801056c4:	83 ec 08             	sub    $0x8,%esp
801056c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056ca:	50                   	push   %eax
801056cb:	6a 00                	push   $0x0
801056cd:	e8 be f5 ff ff       	call   80104c90 <argstr>
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	85 c0                	test   %eax,%eax
801056d7:	78 77                	js     80105750 <sys_chdir+0xa0>
801056d9:	83 ec 0c             	sub    $0xc,%esp
801056dc:	ff 75 f4             	push   -0xc(%ebp)
801056df:	e8 9c c9 ff ff       	call   80102080 <namei>
801056e4:	83 c4 10             	add    $0x10,%esp
801056e7:	89 c3                	mov    %eax,%ebx
801056e9:	85 c0                	test   %eax,%eax
801056eb:	74 63                	je     80105750 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801056ed:	83 ec 0c             	sub    $0xc,%esp
801056f0:	50                   	push   %eax
801056f1:	e8 6a c0 ff ff       	call   80101760 <ilock>
  if(ip->type != T_DIR){
801056f6:	83 c4 10             	add    $0x10,%esp
801056f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056fe:	75 30                	jne    80105730 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	53                   	push   %ebx
80105704:	e8 37 c1 ff ff       	call   80101840 <iunlock>
  iput(curproc->cwd);
80105709:	58                   	pop    %eax
8010570a:	ff 76 68             	push   0x68(%esi)
8010570d:	e8 7e c1 ff ff       	call   80101890 <iput>
  end_op();
80105712:	e8 99 d6 ff ff       	call   80102db0 <end_op>
  curproc->cwd = ip;
80105717:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010571a:	83 c4 10             	add    $0x10,%esp
8010571d:	31 c0                	xor    %eax,%eax
}
8010571f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105722:	5b                   	pop    %ebx
80105723:	5e                   	pop    %esi
80105724:	5d                   	pop    %ebp
80105725:	c3                   	ret    
80105726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010572d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105730:	83 ec 0c             	sub    $0xc,%esp
80105733:	53                   	push   %ebx
80105734:	e8 b7 c2 ff ff       	call   801019f0 <iunlockput>
    end_op();
80105739:	e8 72 d6 ff ff       	call   80102db0 <end_op>
    return -1;
8010573e:	83 c4 10             	add    $0x10,%esp
80105741:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105746:	eb d7                	jmp    8010571f <sys_chdir+0x6f>
80105748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574f:	90                   	nop
    end_op();
80105750:	e8 5b d6 ff ff       	call   80102db0 <end_op>
    return -1;
80105755:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010575a:	eb c3                	jmp    8010571f <sys_chdir+0x6f>
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105760 <sys_exec>:

int
sys_exec(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	57                   	push   %edi
80105764:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105765:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010576b:	53                   	push   %ebx
8010576c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105772:	50                   	push   %eax
80105773:	6a 00                	push   $0x0
80105775:	e8 16 f5 ff ff       	call   80104c90 <argstr>
8010577a:	83 c4 10             	add    $0x10,%esp
8010577d:	85 c0                	test   %eax,%eax
8010577f:	0f 88 87 00 00 00    	js     8010580c <sys_exec+0xac>
80105785:	83 ec 08             	sub    $0x8,%esp
80105788:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010578e:	50                   	push   %eax
8010578f:	6a 01                	push   $0x1
80105791:	e8 5a f4 ff ff       	call   80104bf0 <argint>
80105796:	83 c4 10             	add    $0x10,%esp
80105799:	85 c0                	test   %eax,%eax
8010579b:	78 6f                	js     8010580c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010579d:	83 ec 04             	sub    $0x4,%esp
801057a0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801057a6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801057a8:	68 80 00 00 00       	push   $0x80
801057ad:	6a 00                	push   $0x0
801057af:	56                   	push   %esi
801057b0:	e8 9b f1 ff ff       	call   80104950 <memset>
801057b5:	83 c4 10             	add    $0x10,%esp
801057b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057bf:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801057c0:	83 ec 08             	sub    $0x8,%esp
801057c3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801057c9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801057d0:	50                   	push   %eax
801057d1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801057d7:	01 f8                	add    %edi,%eax
801057d9:	50                   	push   %eax
801057da:	e8 a1 f3 ff ff       	call   80104b80 <fetchint>
801057df:	83 c4 10             	add    $0x10,%esp
801057e2:	85 c0                	test   %eax,%eax
801057e4:	78 26                	js     8010580c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801057e6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801057ec:	85 c0                	test   %eax,%eax
801057ee:	74 30                	je     80105820 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801057f0:	83 ec 08             	sub    $0x8,%esp
801057f3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801057f6:	52                   	push   %edx
801057f7:	50                   	push   %eax
801057f8:	e8 b3 f3 ff ff       	call   80104bb0 <fetchstr>
801057fd:	83 c4 10             	add    $0x10,%esp
80105800:	85 c0                	test   %eax,%eax
80105802:	78 08                	js     8010580c <sys_exec+0xac>
  for(i=0;; i++){
80105804:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105807:	83 fb 20             	cmp    $0x20,%ebx
8010580a:	75 b4                	jne    801057c0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010580c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010580f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105814:	5b                   	pop    %ebx
80105815:	5e                   	pop    %esi
80105816:	5f                   	pop    %edi
80105817:	5d                   	pop    %ebp
80105818:	c3                   	ret    
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105820:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105827:	00 00 00 00 
  return exec(path, argv);
8010582b:	83 ec 08             	sub    $0x8,%esp
8010582e:	56                   	push   %esi
8010582f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105835:	e8 76 b2 ff ff       	call   80100ab0 <exec>
8010583a:	83 c4 10             	add    $0x10,%esp
}
8010583d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105840:	5b                   	pop    %ebx
80105841:	5e                   	pop    %esi
80105842:	5f                   	pop    %edi
80105843:	5d                   	pop    %ebp
80105844:	c3                   	ret    
80105845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105850 <sys_pipe>:

int
sys_pipe(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	57                   	push   %edi
80105854:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105855:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105858:	53                   	push   %ebx
80105859:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010585c:	6a 08                	push   $0x8
8010585e:	50                   	push   %eax
8010585f:	6a 00                	push   $0x0
80105861:	e8 ca f3 ff ff       	call   80104c30 <argptr>
80105866:	83 c4 10             	add    $0x10,%esp
80105869:	85 c0                	test   %eax,%eax
8010586b:	78 4a                	js     801058b7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010586d:	83 ec 08             	sub    $0x8,%esp
80105870:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105873:	50                   	push   %eax
80105874:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105877:	50                   	push   %eax
80105878:	e8 93 db ff ff       	call   80103410 <pipealloc>
8010587d:	83 c4 10             	add    $0x10,%esp
80105880:	85 c0                	test   %eax,%eax
80105882:	78 33                	js     801058b7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105884:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105887:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105889:	e8 62 e1 ff ff       	call   801039f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010588e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105890:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105894:	85 f6                	test   %esi,%esi
80105896:	74 28                	je     801058c0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105898:	83 c3 01             	add    $0x1,%ebx
8010589b:	83 fb 10             	cmp    $0x10,%ebx
8010589e:	75 f0                	jne    80105890 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801058a0:	83 ec 0c             	sub    $0xc,%esp
801058a3:	ff 75 e0             	push   -0x20(%ebp)
801058a6:	e8 25 b6 ff ff       	call   80100ed0 <fileclose>
    fileclose(wf);
801058ab:	58                   	pop    %eax
801058ac:	ff 75 e4             	push   -0x1c(%ebp)
801058af:	e8 1c b6 ff ff       	call   80100ed0 <fileclose>
    return -1;
801058b4:	83 c4 10             	add    $0x10,%esp
801058b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058bc:	eb 53                	jmp    80105911 <sys_pipe+0xc1>
801058be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801058c0:	8d 73 08             	lea    0x8(%ebx),%esi
801058c3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801058c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801058ca:	e8 21 e1 ff ff       	call   801039f0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058cf:	31 d2                	xor    %edx,%edx
801058d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801058d8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801058dc:	85 c9                	test   %ecx,%ecx
801058de:	74 20                	je     80105900 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801058e0:	83 c2 01             	add    $0x1,%edx
801058e3:	83 fa 10             	cmp    $0x10,%edx
801058e6:	75 f0                	jne    801058d8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801058e8:	e8 03 e1 ff ff       	call   801039f0 <myproc>
801058ed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801058f4:	00 
801058f5:	eb a9                	jmp    801058a0 <sys_pipe+0x50>
801058f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058fe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105900:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105904:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105907:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105909:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010590c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010590f:	31 c0                	xor    %eax,%eax
}
80105911:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105914:	5b                   	pop    %ebx
80105915:	5e                   	pop    %esi
80105916:	5f                   	pop    %edi
80105917:	5d                   	pop    %ebp
80105918:	c3                   	ret    
80105919:	66 90                	xchg   %ax,%ax
8010591b:	66 90                	xchg   %ax,%ax
8010591d:	66 90                	xchg   %ax,%ax
8010591f:	90                   	nop

80105920 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
  return fork();
80105920:	e9 7b e2 ff ff       	jmp    80103ba0 <fork>
80105925:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010592c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105930 <sys_exit>:
}

int sys_exit(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	83 ec 08             	sub    $0x8,%esp
  exit();
80105936:	e8 a5 e5 ff ff       	call   80103ee0 <exit>
  return 0; // not reached
}
8010593b:	31 c0                	xor    %eax,%eax
8010593d:	c9                   	leave  
8010593e:	c3                   	ret    
8010593f:	90                   	nop

80105940 <sys_wait>:

int sys_wait(void)
{
  return wait();
80105940:	e9 cb e6 ff ff       	jmp    80104010 <wait>
80105945:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105950 <sys_kill>:
}

int sys_kill(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if (argint(0, &pid) < 0)
80105956:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105959:	50                   	push   %eax
8010595a:	6a 00                	push   $0x0
8010595c:	e8 8f f2 ff ff       	call   80104bf0 <argint>
80105961:	83 c4 10             	add    $0x10,%esp
80105964:	85 c0                	test   %eax,%eax
80105966:	78 18                	js     80105980 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105968:	83 ec 0c             	sub    $0xc,%esp
8010596b:	ff 75 f4             	push   -0xc(%ebp)
8010596e:	e8 7d e9 ff ff       	call   801042f0 <kill>
80105973:	83 c4 10             	add    $0x10,%esp
}
80105976:	c9                   	leave  
80105977:	c3                   	ret    
80105978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597f:	90                   	nop
80105980:	c9                   	leave  
    return -1;
80105981:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105986:	c3                   	ret    
80105987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010598e:	66 90                	xchg   %ax,%ax

80105990 <sys_getpid>:

int sys_getpid(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105996:	e8 55 e0 ff ff       	call   801039f0 <myproc>
8010599b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010599e:	c9                   	leave  
8010599f:	c3                   	ret    

801059a0 <sys_sbrk>:

int sys_sbrk(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	53                   	push   %ebx
  int addr;
  int n;

  if (argint(0, &n) < 0)
801059a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059a7:	83 ec 1c             	sub    $0x1c,%esp
  if (argint(0, &n) < 0)
801059aa:	50                   	push   %eax
801059ab:	6a 00                	push   $0x0
801059ad:	e8 3e f2 ff ff       	call   80104bf0 <argint>
801059b2:	83 c4 10             	add    $0x10,%esp
801059b5:	85 c0                	test   %eax,%eax
801059b7:	78 27                	js     801059e0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801059b9:	e8 32 e0 ff ff       	call   801039f0 <myproc>
  if (growproc(n) < 0)
801059be:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801059c1:	8b 18                	mov    (%eax),%ebx
  if (growproc(n) < 0)
801059c3:	ff 75 f4             	push   -0xc(%ebp)
801059c6:	e8 55 e1 ff ff       	call   80103b20 <growproc>
801059cb:	83 c4 10             	add    $0x10,%esp
801059ce:	85 c0                	test   %eax,%eax
801059d0:	78 0e                	js     801059e0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801059d2:	89 d8                	mov    %ebx,%eax
801059d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059d7:	c9                   	leave  
801059d8:	c3                   	ret    
801059d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801059e0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059e5:	eb eb                	jmp    801059d2 <sys_sbrk+0x32>
801059e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ee:	66 90                	xchg   %ax,%ax

801059f0 <sys_sleep>:

int sys_sleep(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
801059f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059f7:	83 ec 1c             	sub    $0x1c,%esp
  if (argint(0, &n) < 0)
801059fa:	50                   	push   %eax
801059fb:	6a 00                	push   $0x0
801059fd:	e8 ee f1 ff ff       	call   80104bf0 <argint>
80105a02:	83 c4 10             	add    $0x10,%esp
80105a05:	85 c0                	test   %eax,%eax
80105a07:	0f 88 8a 00 00 00    	js     80105a97 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105a0d:	83 ec 0c             	sub    $0xc,%esp
80105a10:	68 80 52 11 80       	push   $0x80115280
80105a15:	e8 76 ee ff ff       	call   80104890 <acquire>
  ticks0 = ticks;
  while (ticks - ticks0 < n)
80105a1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105a1d:	8b 1d 60 52 11 80    	mov    0x80115260,%ebx
  while (ticks - ticks0 < n)
80105a23:	83 c4 10             	add    $0x10,%esp
80105a26:	85 d2                	test   %edx,%edx
80105a28:	75 27                	jne    80105a51 <sys_sleep+0x61>
80105a2a:	eb 54                	jmp    80105a80 <sys_sleep+0x90>
80105a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105a30:	83 ec 08             	sub    $0x8,%esp
80105a33:	68 80 52 11 80       	push   $0x80115280
80105a38:	68 60 52 11 80       	push   $0x80115260
80105a3d:	e8 8e e7 ff ff       	call   801041d0 <sleep>
  while (ticks - ticks0 < n)
80105a42:	a1 60 52 11 80       	mov    0x80115260,%eax
80105a47:	83 c4 10             	add    $0x10,%esp
80105a4a:	29 d8                	sub    %ebx,%eax
80105a4c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105a4f:	73 2f                	jae    80105a80 <sys_sleep+0x90>
    if (myproc()->killed)
80105a51:	e8 9a df ff ff       	call   801039f0 <myproc>
80105a56:	8b 40 24             	mov    0x24(%eax),%eax
80105a59:	85 c0                	test   %eax,%eax
80105a5b:	74 d3                	je     80105a30 <sys_sleep+0x40>
      release(&tickslock);
80105a5d:	83 ec 0c             	sub    $0xc,%esp
80105a60:	68 80 52 11 80       	push   $0x80115280
80105a65:	e8 c6 ed ff ff       	call   80104830 <release>
  }
  release(&tickslock);
  return 0;
}
80105a6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105a6d:	83 c4 10             	add    $0x10,%esp
80105a70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a75:	c9                   	leave  
80105a76:	c3                   	ret    
80105a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a7e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105a80:	83 ec 0c             	sub    $0xc,%esp
80105a83:	68 80 52 11 80       	push   $0x80115280
80105a88:	e8 a3 ed ff ff       	call   80104830 <release>
  return 0;
80105a8d:	83 c4 10             	add    $0x10,%esp
80105a90:	31 c0                	xor    %eax,%eax
}
80105a92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a95:	c9                   	leave  
80105a96:	c3                   	ret    
    return -1;
80105a97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a9c:	eb f4                	jmp    80105a92 <sys_sleep+0xa2>
80105a9e:	66 90                	xchg   %ax,%ax

80105aa0 <sys_uniq>:
int sys_uniq(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	56                   	push   %esi
80105aa5:	53                   	push   %ebx
80105aa6:	81 ec 28 06 00 00    	sub    $0x628,%esp
  // int sentences;
  cprintf("Uniq command is getting executed in kernel mode\n");
80105aac:	68 2c 88 10 80       	push   $0x8010882c
80105ab1:	e8 ea ab ff ff       	call   801006a0 <cprintf>
  char *string;
  // argptr(0,&string,1);
  int option;
  argint(0, &option);
80105ab6:	8d 85 08 fa ff ff    	lea    -0x5f8(%ebp),%eax
80105abc:	59                   	pop    %ecx
80105abd:	5b                   	pop    %ebx
80105abe:	50                   	push   %eax
  int j = 0, k = 0;
  char curr_line[15][100]; // prev_line[] = "";
  if (strlen(curr_line[0]) > 0)
  {
  }
  for (int i = 0; i < strlen(string); i++)
80105abf:	31 db                	xor    %ebx,%ebx
  argint(0, &option);
80105ac1:	6a 00                	push   $0x0
80105ac3:	e8 28 f1 ff ff       	call   80104bf0 <argint>
  argstr(1, &string);
80105ac8:	8d 85 04 fa ff ff    	lea    -0x5fc(%ebp),%eax
80105ace:	5e                   	pop    %esi
80105acf:	5f                   	pop    %edi
80105ad0:	50                   	push   %eax
  int j = 0, k = 0;
80105ad1:	31 f6                	xor    %esi,%esi
  int sentences = 0;
80105ad3:	31 ff                	xor    %edi,%edi
  argstr(1, &string);
80105ad5:	6a 01                	push   $0x1
80105ad7:	e8 b4 f1 ff ff       	call   80104c90 <argstr>
  if (strlen(curr_line[0]) > 0)
80105adc:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
80105ae2:	89 04 24             	mov    %eax,(%esp)
80105ae5:	e8 66 f0 ff ff       	call   80104b50 <strlen>
  for (int i = 0; i < strlen(string); i++)
80105aea:	8b 8d 04 fa ff ff    	mov    -0x5fc(%ebp),%ecx
80105af0:	83 c4 10             	add    $0x10,%esp
80105af3:	eb 26                	jmp    80105b1b <sys_uniq+0x7b>
80105af5:	8d 76 00             	lea    0x0(%esi),%esi
  {
    // printf(1, "i= %d j= %d k= %d\n", i, j, k);
    if (string[i] != '\n')
    {
      curr_line[j][k++] = string[i];
80105af8:	89 bd f4 f9 ff ff    	mov    %edi,-0x60c(%ebp)
80105afe:	8d 56 01             	lea    0x1(%esi),%edx
80105b01:	6b ff 64             	imul   $0x64,%edi,%edi
  for (int i = 0; i < strlen(string); i++)
80105b04:	83 c3 01             	add    $0x1,%ebx
80105b07:	83 ef 18             	sub    $0x18,%edi
80105b0a:	01 ef                	add    %ebp,%edi
80105b0c:	88 84 3e 24 fa ff ff 	mov    %al,-0x5dc(%esi,%edi,1)
80105b13:	8b bd f4 f9 ff ff    	mov    -0x60c(%ebp),%edi
80105b19:	89 d6                	mov    %edx,%esi
80105b1b:	83 ec 0c             	sub    $0xc,%esp
80105b1e:	51                   	push   %ecx
80105b1f:	e8 2c f0 ff ff       	call   80104b50 <strlen>
80105b24:	83 c4 10             	add    $0x10,%esp
80105b27:	39 d8                	cmp    %ebx,%eax
80105b29:	7e 25                	jle    80105b50 <sys_uniq+0xb0>
    if (string[i] != '\n')
80105b2b:	8b 8d 04 fa ff ff    	mov    -0x5fc(%ebp),%ecx
80105b31:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
80105b35:	3c 0a                	cmp    $0xa,%al
80105b37:	75 bf                	jne    80105af8 <sys_uniq+0x58>
    }
    else
    {
      curr_line[j][k] = '\0';
      j++;
80105b39:	8d 47 01             	lea    0x1(%edi),%eax
      k = 0;
80105b3c:	31 d2                	xor    %edx,%edx
      j++;
80105b3e:	89 85 f4 f9 ff ff    	mov    %eax,-0x60c(%ebp)
      curr_line[j][k] = '\0';
80105b44:	31 c0                	xor    %eax,%eax
80105b46:	eb b9                	jmp    80105b01 <sys_uniq+0x61>
80105b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b4f:	90                   	nop
  }
  if (sentences > 0)
  {
    ;
  }
  if (option == 0)
80105b50:	89 bd f4 f9 ff ff    	mov    %edi,-0x60c(%ebp)
80105b56:	8b bd 08 fa ff ff    	mov    -0x5f8(%ebp),%edi
80105b5c:	85 ff                	test   %edi,%edi
80105b5e:	0f 84 cb 01 00 00    	je     80105d2f <sys_uniq+0x28f>
    //               }
    //           }
    //cprintf("before options = %d", sentences);
    return 0;
  }
  else if (option == 1)
80105b64:	83 ff 01             	cmp    $0x1,%edi
80105b67:	0f 84 1a 04 00 00    	je     80105f87 <sys_uniq+0x4e7>
      }
    }
    // cprintf("outside while\n");
    return 0;
  }
  else if(option == 2){
80105b6d:	83 ff 02             	cmp    $0x2,%edi
80105b70:	0f 84 77 01 00 00    	je     80105ced <sys_uniq+0x24d>
            }
            cprintf("%d %s\n", is_duplicate[sentences - 1], curr_line[sentences - 1]);
    return 0;
  }
  else{
    char small_case[sentences][100];
80105b76:	6b 85 f4 f9 ff ff 64 	imul   $0x64,-0x60c(%ebp),%eax
80105b7d:	89 e1                	mov    %esp,%ecx
  else{
80105b7f:	89 a5 e8 f9 ff ff    	mov    %esp,-0x618(%ebp)
    char small_case[sentences][100];
80105b85:	83 c0 0f             	add    $0xf,%eax
80105b88:	89 c2                	mov    %eax,%edx
80105b8a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105b8f:	29 c1                	sub    %eax,%ecx
80105b91:	83 e2 f0             	and    $0xfffffff0,%edx
80105b94:	39 cc                	cmp    %ecx,%esp
80105b96:	74 12                	je     80105baa <sys_uniq+0x10a>
80105b98:	81 ec 00 10 00 00    	sub    $0x1000,%esp
80105b9e:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
80105ba5:	00 
80105ba6:	39 cc                	cmp    %ecx,%esp
80105ba8:	75 ee                	jne    80105b98 <sys_uniq+0xf8>
80105baa:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
80105bb0:	29 d4                	sub    %edx,%esp
80105bb2:	85 d2                	test   %edx,%edx
80105bb4:	74 05                	je     80105bbb <sys_uniq+0x11b>
80105bb6:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
            for (int i = 0; i < sentences; i++)
80105bbb:	8b 85 f4 f9 ff ff    	mov    -0x60c(%ebp),%eax
    char small_case[sentences][100];
80105bc1:	89 a5 ec f9 ff ff    	mov    %esp,-0x614(%ebp)
            for (int i = 0; i < sentences; i++)
80105bc7:	85 c0                	test   %eax,%eax
80105bc9:	0f 84 3f 05 00 00    	je     8010610e <sys_uniq+0x66e>
80105bcf:	c7 85 f0 f9 ff ff 00 	movl   $0x0,-0x610(%ebp)
80105bd6:	00 00 00 
80105bd9:	8d bd 0c fa ff ff    	lea    -0x5f4(%ebp),%edi
80105bdf:	89 e6                	mov    %esp,%esi
80105be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            {
                for (int j = 0; j < strlen(curr_line[i]); j++)
80105be8:	31 db                	xor    %ebx,%ebx
80105bea:	eb 1a                	jmp    80105c06 <sys_uniq+0x166>
80105bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                {
                    if (curr_line[i][j] >= 'A' && curr_line[i][j] <= 'Z')
80105bf0:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
80105bf4:	8d 48 bf             	lea    -0x41(%eax),%ecx
                        small_case[i][j] = curr_line[i][j] + 32;
80105bf7:	8d 50 20             	lea    0x20(%eax),%edx
80105bfa:	80 f9 1a             	cmp    $0x1a,%cl
80105bfd:	0f 42 c2             	cmovb  %edx,%eax
80105c00:	88 04 1e             	mov    %al,(%esi,%ebx,1)
                for (int j = 0; j < strlen(curr_line[i]); j++)
80105c03:	83 c3 01             	add    $0x1,%ebx
80105c06:	83 ec 0c             	sub    $0xc,%esp
80105c09:	57                   	push   %edi
80105c0a:	e8 41 ef ff ff       	call   80104b50 <strlen>
80105c0f:	83 c4 10             	add    $0x10,%esp
80105c12:	39 d8                	cmp    %ebx,%eax
80105c14:	7f da                	jg     80105bf0 <sys_uniq+0x150>
            for (int i = 0; i < sentences; i++)
80105c16:	83 85 f0 f9 ff ff 01 	addl   $0x1,-0x610(%ebp)
80105c1d:	83 c7 64             	add    $0x64,%edi
80105c20:	83 c6 64             	add    $0x64,%esi
80105c23:	8b 85 f0 f9 ff ff    	mov    -0x610(%ebp),%eax
80105c29:	39 85 f4 f9 ff ff    	cmp    %eax,-0x60c(%ebp)
80105c2f:	75 b7                	jne    80105be8 <sys_uniq+0x148>
                    else
                        small_case[i][j] = curr_line[i][j];
                }
            }
            cprintf(curr_line[1]);
80105c31:	83 ec 0c             	sub    $0xc,%esp
80105c34:	8d 85 70 fa ff ff    	lea    -0x590(%ebp),%eax
80105c3a:	50                   	push   %eax
80105c3b:	e8 60 aa ff ff       	call   801006a0 <cprintf>
            cprintf("\n");
80105c40:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
80105c47:	e8 54 aa ff ff       	call   801006a0 <cprintf>
            int max=-1;
            for (int i = 1; i < sentences; i++)
80105c4c:	83 c4 10             	add    $0x10,%esp
80105c4f:	83 bd f4 f9 ff ff 01 	cmpl   $0x1,-0x60c(%ebp)
80105c56:	0f 8e 7e 02 00 00    	jle    80105eda <sys_uniq+0x43a>
80105c5c:	8b b5 ec f9 ff ff    	mov    -0x614(%ebp),%esi
80105c62:	8d 9d 0c fa ff ff    	lea    -0x5f4(%ebp),%ebx
80105c68:	bf 01 00 00 00       	mov    $0x1,%edi
80105c6d:	83 c6 64             	add    $0x64,%esi
80105c70:	eb 42                	jmp    80105cb4 <sys_uniq+0x214>
80105c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            {  
              max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80105c78:	83 ec 0c             	sub    $0xc,%esp
80105c7b:	ff b5 ec f9 ff ff    	push   -0x614(%ebp)
80105c81:	e8 ca ee ff ff       	call   80104b50 <strlen>
80105c86:	83 c4 10             	add    $0x10,%esp
                if (strncmp(small_case[i], small_case[i - 1],max) != 0)
80105c89:	83 ec 04             	sub    $0x4,%esp
80105c8c:	50                   	push   %eax
80105c8d:	8d 46 9c             	lea    -0x64(%esi),%eax
80105c90:	50                   	push   %eax
80105c91:	56                   	push   %esi
80105c92:	e8 c9 ed ff ff       	call   80104a60 <strncmp>
80105c97:	83 c4 10             	add    $0x10,%esp
80105c9a:	85 c0                	test   %eax,%eax
80105c9c:	0f 85 0e 02 00 00    	jne    80105eb0 <sys_uniq+0x410>
            for (int i = 1; i < sentences; i++)
80105ca2:	83 c7 01             	add    $0x1,%edi
80105ca5:	83 c6 64             	add    $0x64,%esi
80105ca8:	39 bd f4 f9 ff ff    	cmp    %edi,-0x60c(%ebp)
80105cae:	0f 84 26 02 00 00    	je     80105eda <sys_uniq+0x43a>
              max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80105cb4:	83 ec 0c             	sub    $0xc,%esp
80105cb7:	89 9d ec f9 ff ff    	mov    %ebx,-0x614(%ebp)
80105cbd:	53                   	push   %ebx
80105cbe:	83 c3 64             	add    $0x64,%ebx
80105cc1:	e8 8a ee ff ff       	call   80104b50 <strlen>
80105cc6:	89 85 f0 f9 ff ff    	mov    %eax,-0x610(%ebp)
80105ccc:	89 1c 24             	mov    %ebx,(%esp)
80105ccf:	e8 7c ee ff ff       	call   80104b50 <strlen>
80105cd4:	83 c4 10             	add    $0x10,%esp
80105cd7:	39 85 f0 f9 ff ff    	cmp    %eax,-0x610(%ebp)
80105cdd:	7f 99                	jg     80105c78 <sys_uniq+0x1d8>
80105cdf:	83 ec 0c             	sub    $0xc,%esp
80105ce2:	53                   	push   %ebx
80105ce3:	e8 68 ee ff ff       	call   80104b50 <strlen>
80105ce8:	83 c4 10             	add    $0x10,%esp
80105ceb:	eb 9c                	jmp    80105c89 <sys_uniq+0x1e9>
    int is_duplicate[sentences];
80105ced:	8b 85 f4 f9 ff ff    	mov    -0x60c(%ebp),%eax
  else if(option == 2){
80105cf3:	89 a5 e4 f9 ff ff    	mov    %esp,-0x61c(%ebp)
    int is_duplicate[sentences];
80105cf9:	89 e1                	mov    %esp,%ecx
80105cfb:	8d 50 ff             	lea    -0x1(%eax),%edx
80105cfe:	8d 04 85 0f 00 00 00 	lea    0xf(,%eax,4),%eax
80105d05:	89 95 e8 f9 ff ff    	mov    %edx,-0x618(%ebp)
80105d0b:	89 c2                	mov    %eax,%edx
80105d0d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105d12:	83 e2 f0             	and    $0xfffffff0,%edx
80105d15:	29 c1                	sub    %eax,%ecx
80105d17:	39 cc                	cmp    %ecx,%esp
80105d19:	0f 84 d0 00 00 00    	je     80105def <sys_uniq+0x34f>
80105d1f:	81 ec 00 10 00 00    	sub    $0x1000,%esp
80105d25:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
80105d2c:	00 
80105d2d:	eb e8                	jmp    80105d17 <sys_uniq+0x277>
    cprintf("%s", curr_line[0]);
80105d2f:	83 ec 08             	sub    $0x8,%esp
80105d32:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
80105d38:	8d 9d 0c fa ff ff    	lea    -0x5f4(%ebp),%ebx
    for (int i = 1; i < sentences; i++)
80105d3e:	be 01 00 00 00       	mov    $0x1,%esi
    cprintf("%s", curr_line[0]);
80105d43:	50                   	push   %eax
80105d44:	68 d9 85 10 80       	push   $0x801085d9
80105d49:	e8 52 a9 ff ff       	call   801006a0 <cprintf>
    cprintf("\n");
80105d4e:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
80105d55:	e8 46 a9 ff ff       	call   801006a0 <cprintf>
    for (int i = 1; i < sentences; i++)
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	83 bd f4 f9 ff ff 01 	cmpl   $0x1,-0x60c(%ebp)
80105d64:	7f 33                	jg     80105d99 <sys_uniq+0x2f9>
                }
            }
  return 0;
  }
  return 0;
}
80105d66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d69:	31 c0                	xor    %eax,%eax
80105d6b:	5b                   	pop    %ebx
80105d6c:	5e                   	pop    %esi
80105d6d:	5f                   	pop    %edi
80105d6e:	5d                   	pop    %ebp
80105d6f:	c3                   	ret    
      max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	57                   	push   %edi
80105d74:	e8 d7 ed ff ff       	call   80104b50 <strlen>
80105d79:	83 c4 10             	add    $0x10,%esp
      if (strncmp(curr_line[i], curr_line[i - 1], max) != 0)
80105d7c:	83 ec 04             	sub    $0x4,%esp
80105d7f:	50                   	push   %eax
80105d80:	57                   	push   %edi
80105d81:	53                   	push   %ebx
80105d82:	e8 d9 ec ff ff       	call   80104a60 <strncmp>
80105d87:	83 c4 10             	add    $0x10,%esp
80105d8a:	85 c0                	test   %eax,%eax
80105d8c:	75 42                	jne    80105dd0 <sys_uniq+0x330>
    for (int i = 1; i < sentences; i++)
80105d8e:	83 c6 01             	add    $0x1,%esi
80105d91:	39 b5 f4 f9 ff ff    	cmp    %esi,-0x60c(%ebp)
80105d97:	74 cd                	je     80105d66 <sys_uniq+0x2c6>
      max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80105d99:	83 ec 0c             	sub    $0xc,%esp
80105d9c:	89 df                	mov    %ebx,%edi
80105d9e:	53                   	push   %ebx
80105d9f:	83 c3 64             	add    $0x64,%ebx
80105da2:	e8 a9 ed ff ff       	call   80104b50 <strlen>
80105da7:	89 85 f0 f9 ff ff    	mov    %eax,-0x610(%ebp)
80105dad:	89 1c 24             	mov    %ebx,(%esp)
80105db0:	e8 9b ed ff ff       	call   80104b50 <strlen>
80105db5:	83 c4 10             	add    $0x10,%esp
80105db8:	39 85 f0 f9 ff ff    	cmp    %eax,-0x610(%ebp)
80105dbe:	7f b0                	jg     80105d70 <sys_uniq+0x2d0>
80105dc0:	83 ec 0c             	sub    $0xc,%esp
80105dc3:	53                   	push   %ebx
80105dc4:	e8 87 ed ff ff       	call   80104b50 <strlen>
80105dc9:	83 c4 10             	add    $0x10,%esp
80105dcc:	eb ae                	jmp    80105d7c <sys_uniq+0x2dc>
80105dce:	66 90                	xchg   %ax,%ax
        cprintf("%s", curr_line[i]);
80105dd0:	83 ec 08             	sub    $0x8,%esp
80105dd3:	53                   	push   %ebx
80105dd4:	68 d9 85 10 80       	push   $0x801085d9
80105dd9:	e8 c2 a8 ff ff       	call   801006a0 <cprintf>
        cprintf("\n");
80105dde:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
80105de5:	e8 b6 a8 ff ff       	call   801006a0 <cprintf>
80105dea:	83 c4 10             	add    $0x10,%esp
80105ded:	eb 9f                	jmp    80105d8e <sys_uniq+0x2ee>
    int is_duplicate[sentences];
80105def:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
80105df5:	29 d4                	sub    %edx,%esp
80105df7:	85 d2                	test   %edx,%edx
80105df9:	0f 85 fb 02 00 00    	jne    801060fa <sys_uniq+0x65a>
80105dff:	8d 44 24 03          	lea    0x3(%esp),%eax
80105e03:	8d bd 0c fa ff ff    	lea    -0x5f4(%ebp),%edi
            for (int i = 1; i < sentences; i++)
80105e09:	bb 01 00 00 00       	mov    $0x1,%ebx
    int is_duplicate[sentences];
80105e0e:	89 c2                	mov    %eax,%edx
80105e10:	83 e0 fc             	and    $0xfffffffc,%eax
80105e13:	c1 ea 02             	shr    $0x2,%edx
            for (int i = 1; i < sentences; i++)
80105e16:	83 bd f4 f9 ff ff 01 	cmpl   $0x1,-0x60c(%ebp)
    int is_duplicate[sentences];
80105e1d:	89 85 f0 f9 ff ff    	mov    %eax,-0x610(%ebp)
            is_duplicate[0] = 1;
80105e23:	c7 04 95 00 00 00 00 	movl   $0x1,0x0(,%edx,4)
80105e2a:	01 00 00 00 
            for (int i = 1; i < sentences; i++)
80105e2e:	7f 49                	jg     80105e79 <sys_uniq+0x3d9>
80105e30:	e9 d3 00 00 00       	jmp    80105f08 <sys_uniq+0x468>
80105e35:	8d 76 00             	lea    0x0(%esi),%esi
              max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80105e38:	83 ec 0c             	sub    $0xc,%esp
80105e3b:	56                   	push   %esi
80105e3c:	e8 0f ed ff ff       	call   80104b50 <strlen>
80105e41:	83 c4 10             	add    $0x10,%esp
                if (strncmp(curr_line[i], curr_line[i - 1],max) == 0)
80105e44:	83 ec 04             	sub    $0x4,%esp
80105e47:	50                   	push   %eax
80105e48:	56                   	push   %esi
80105e49:	57                   	push   %edi
80105e4a:	e8 11 ec ff ff       	call   80104a60 <strncmp>
80105e4f:	83 c4 10             	add    $0x10,%esp
80105e52:	89 c2                	mov    %eax,%edx
                    is_duplicate[i] = 1;
80105e54:	b8 01 00 00 00       	mov    $0x1,%eax
                if (strncmp(curr_line[i], curr_line[i - 1],max) == 0)
80105e59:	85 d2                	test   %edx,%edx
80105e5b:	0f 84 8f 00 00 00    	je     80105ef0 <sys_uniq+0x450>
80105e61:	8b 8d f0 f9 ff ff    	mov    -0x610(%ebp),%ecx
80105e67:	89 04 99             	mov    %eax,(%ecx,%ebx,4)
            for (int i = 1; i < sentences; i++)
80105e6a:	83 c3 01             	add    $0x1,%ebx
80105e6d:	39 9d f4 f9 ff ff    	cmp    %ebx,-0x60c(%ebp)
80105e73:	0f 84 8f 00 00 00    	je     80105f08 <sys_uniq+0x468>
              max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80105e79:	83 ec 0c             	sub    $0xc,%esp
80105e7c:	89 fe                	mov    %edi,%esi
80105e7e:	57                   	push   %edi
80105e7f:	83 c7 64             	add    $0x64,%edi
80105e82:	e8 c9 ec ff ff       	call   80104b50 <strlen>
80105e87:	89 85 ec f9 ff ff    	mov    %eax,-0x614(%ebp)
80105e8d:	89 3c 24             	mov    %edi,(%esp)
80105e90:	e8 bb ec ff ff       	call   80104b50 <strlen>
80105e95:	83 c4 10             	add    $0x10,%esp
80105e98:	39 85 ec f9 ff ff    	cmp    %eax,-0x614(%ebp)
80105e9e:	7f 98                	jg     80105e38 <sys_uniq+0x398>
80105ea0:	83 ec 0c             	sub    $0xc,%esp
80105ea3:	57                   	push   %edi
80105ea4:	e8 a7 ec ff ff       	call   80104b50 <strlen>
80105ea9:	83 c4 10             	add    $0x10,%esp
80105eac:	eb 96                	jmp    80105e44 <sys_uniq+0x3a4>
80105eae:	66 90                	xchg   %ax,%ax
                    cprintf(curr_line[i]);
80105eb0:	83 ec 0c             	sub    $0xc,%esp
            for (int i = 1; i < sentences; i++)
80105eb3:	83 c7 01             	add    $0x1,%edi
80105eb6:	83 c6 64             	add    $0x64,%esi
                    cprintf(curr_line[i]);
80105eb9:	53                   	push   %ebx
80105eba:	e8 e1 a7 ff ff       	call   801006a0 <cprintf>
                    cprintf("\n");
80105ebf:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
80105ec6:	e8 d5 a7 ff ff       	call   801006a0 <cprintf>
80105ecb:	83 c4 10             	add    $0x10,%esp
            for (int i = 1; i < sentences; i++)
80105ece:	39 bd f4 f9 ff ff    	cmp    %edi,-0x60c(%ebp)
80105ed4:	0f 85 da fd ff ff    	jne    80105cb4 <sys_uniq+0x214>
  return 0;
80105eda:	8b a5 e8 f9 ff ff    	mov    -0x618(%ebp),%esp
}
80105ee0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ee3:	31 c0                	xor    %eax,%eax
80105ee5:	5b                   	pop    %ebx
80105ee6:	5e                   	pop    %esi
80105ee7:	5f                   	pop    %edi
80105ee8:	5d                   	pop    %ebp
80105ee9:	c3                   	ret    
80105eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                    is_duplicate[i] = is_duplicate[i - 1] + 1;
80105ef0:	8b 85 f0 f9 ff ff    	mov    -0x610(%ebp),%eax
80105ef6:	8b 44 98 fc          	mov    -0x4(%eax,%ebx,4),%eax
80105efa:	89 85 ec f9 ff ff    	mov    %eax,-0x614(%ebp)
80105f00:	83 c0 01             	add    $0x1,%eax
                    continue;
80105f03:	e9 59 ff ff ff       	jmp    80105e61 <sys_uniq+0x3c1>
            for (int i = 0; i < sentences - 1; i++)
80105f08:	8b 95 e8 f9 ff ff    	mov    -0x618(%ebp),%edx
80105f0e:	8d bd 0c fa ff ff    	lea    -0x5f4(%ebp),%edi
80105f14:	be 01 00 00 00       	mov    $0x1,%esi
80105f19:	31 db                	xor    %ebx,%ebx
80105f1b:	85 d2                	test   %edx,%edx
80105f1d:	7e 30                	jle    80105f4f <sys_uniq+0x4af>
80105f1f:	90                   	nop
                if (is_duplicate[i] < is_duplicate[i + 1])
80105f20:	8b 85 f0 f9 ff ff    	mov    -0x610(%ebp),%eax
80105f26:	83 c3 01             	add    $0x1,%ebx
80105f29:	89 f1                	mov    %esi,%ecx
80105f2b:	8b 34 98             	mov    (%eax,%ebx,4),%esi
80105f2e:	39 ce                	cmp    %ecx,%esi
80105f30:	7f 12                	jg     80105f44 <sys_uniq+0x4a4>
                    cprintf("%d %s\n", is_duplicate[i], curr_line[i]);
80105f32:	83 ec 04             	sub    $0x4,%esp
80105f35:	57                   	push   %edi
80105f36:	51                   	push   %ecx
80105f37:	68 91 88 10 80       	push   $0x80108891
80105f3c:	e8 5f a7 ff ff       	call   801006a0 <cprintf>
80105f41:	83 c4 10             	add    $0x10,%esp
            for (int i = 0; i < sentences - 1; i++)
80105f44:	83 c7 64             	add    $0x64,%edi
80105f47:	39 9d e8 f9 ff ff    	cmp    %ebx,-0x618(%ebp)
80105f4d:	75 d1                	jne    80105f20 <sys_uniq+0x480>
            cprintf("%d %s\n", is_duplicate[sentences - 1], curr_line[sentences - 1]);
80105f4f:	8b 95 e8 f9 ff ff    	mov    -0x618(%ebp),%edx
80105f55:	8d 8d 0c fa ff ff    	lea    -0x5f4(%ebp),%ecx
80105f5b:	83 ec 04             	sub    $0x4,%esp
80105f5e:	6b c2 64             	imul   $0x64,%edx,%eax
80105f61:	01 c8                	add    %ecx,%eax
80105f63:	50                   	push   %eax
80105f64:	8b 85 f0 f9 ff ff    	mov    -0x610(%ebp),%eax
80105f6a:	ff 34 90             	push   (%eax,%edx,4)
80105f6d:	68 91 88 10 80       	push   $0x80108891
80105f72:	e8 29 a7 ff ff       	call   801006a0 <cprintf>
    return 0;
80105f77:	8b a5 e4 f9 ff ff    	mov    -0x61c(%ebp),%esp
}
80105f7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f80:	31 c0                	xor    %eax,%eax
80105f82:	5b                   	pop    %ebx
80105f83:	5e                   	pop    %esi
80105f84:	5f                   	pop    %edi
80105f85:	5d                   	pop    %ebp
80105f86:	c3                   	ret    
    int is_duplicate[sentences];
80105f87:	8b 85 f4 f9 ff ff    	mov    -0x60c(%ebp),%eax
80105f8d:	89 e1                	mov    %esp,%ecx
  {
80105f8f:	89 a5 e4 f9 ff ff    	mov    %esp,-0x61c(%ebp)
    int is_duplicate[sentences];
80105f95:	8d 04 85 0f 00 00 00 	lea    0xf(,%eax,4),%eax
80105f9c:	89 c2                	mov    %eax,%edx
80105f9e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105fa3:	29 c1                	sub    %eax,%ecx
80105fa5:	83 e2 f0             	and    $0xfffffff0,%edx
80105fa8:	39 cc                	cmp    %ecx,%esp
80105faa:	74 12                	je     80105fbe <sys_uniq+0x51e>
80105fac:	81 ec 00 10 00 00    	sub    $0x1000,%esp
80105fb2:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
80105fb9:	00 
80105fba:	39 cc                	cmp    %ecx,%esp
80105fbc:	75 ee                	jne    80105fac <sys_uniq+0x50c>
80105fbe:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
80105fc4:	29 d4                	sub    %edx,%esp
80105fc6:	85 d2                	test   %edx,%edx
80105fc8:	0f 85 36 01 00 00    	jne    80106104 <sys_uniq+0x664>
80105fce:	8d 44 24 03          	lea    0x3(%esp),%eax
80105fd2:	89 c2                	mov    %eax,%edx
80105fd4:	83 e0 fc             	and    $0xfffffffc,%eax
80105fd7:	c1 ea 02             	shr    $0x2,%edx
    for (int i = 1; i < sentences; i++)
80105fda:	83 bd f4 f9 ff ff 01 	cmpl   $0x1,-0x60c(%ebp)
    int is_duplicate[sentences];
80105fe1:	89 85 e8 f9 ff ff    	mov    %eax,-0x618(%ebp)
    is_duplicate[0] = 0;
80105fe7:	c7 04 95 00 00 00 00 	movl   $0x0,0x0(,%edx,4)
80105fee:	00 00 00 00 
    for (int i = 1; i < sentences; i++)
80105ff2:	0f 8e 87 00 00 00    	jle    8010607f <sys_uniq+0x5df>
80105ff8:	8d b5 0c fa ff ff    	lea    -0x5f4(%ebp),%esi
    int counter = 0, max = -1;
80105ffe:	31 db                	xor    %ebx,%ebx
80106000:	eb 44                	jmp    80106046 <sys_uniq+0x5a6>
80106002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80106008:	83 ec 0c             	sub    $0xc,%esp
8010600b:	ff b5 f0 f9 ff ff    	push   -0x610(%ebp)
80106011:	e8 3a eb ff ff       	call   80104b50 <strlen>
80106016:	83 c4 10             	add    $0x10,%esp
      if (strncmp(curr_line[i], curr_line[i - 1], max) == 0)
80106019:	83 ec 04             	sub    $0x4,%esp
8010601c:	50                   	push   %eax
8010601d:	ff b5 f0 f9 ff ff    	push   -0x610(%ebp)
80106023:	56                   	push   %esi
80106024:	e8 37 ea ff ff       	call   80104a60 <strncmp>
80106029:	83 c4 10             	add    $0x10,%esp
        counter++;
8010602c:	83 f8 01             	cmp    $0x1,%eax
8010602f:	8b 85 e8 f9 ff ff    	mov    -0x618(%ebp),%eax
80106035:	83 db ff             	sbb    $0xffffffff,%ebx
80106038:	89 1c b8             	mov    %ebx,(%eax,%edi,4)
    for (int i = 1; i < sentences; i++)
8010603b:	83 c7 01             	add    $0x1,%edi
8010603e:	39 bd f4 f9 ff ff    	cmp    %edi,-0x60c(%ebp)
80106044:	74 3f                	je     80106085 <sys_uniq+0x5e5>
      max = strlen(curr_line[i - 1]) > strlen(curr_line[i]) ? strlen(curr_line[i - 1]) : strlen(curr_line[i]);
80106046:	83 ec 0c             	sub    $0xc,%esp
80106049:	89 b5 f0 f9 ff ff    	mov    %esi,-0x610(%ebp)
8010604f:	56                   	push   %esi
80106050:	83 c6 64             	add    $0x64,%esi
80106053:	e8 f8 ea ff ff       	call   80104b50 <strlen>
80106058:	89 85 ec f9 ff ff    	mov    %eax,-0x614(%ebp)
8010605e:	89 34 24             	mov    %esi,(%esp)
80106061:	e8 ea ea ff ff       	call   80104b50 <strlen>
80106066:	83 c4 10             	add    $0x10,%esp
80106069:	39 85 ec f9 ff ff    	cmp    %eax,-0x614(%ebp)
8010606f:	7f 97                	jg     80106008 <sys_uniq+0x568>
80106071:	83 ec 0c             	sub    $0xc,%esp
80106074:	56                   	push   %esi
80106075:	e8 d6 ea ff ff       	call   80104b50 <strlen>
8010607a:	83 c4 10             	add    $0x10,%esp
8010607d:	eb 9a                	jmp    80106019 <sys_uniq+0x579>
    while (i < sentences)
8010607f:	0f 85 f2 fe ff ff    	jne    80105f77 <sys_uniq+0x4d7>
80106085:	8b bd f4 f9 ff ff    	mov    -0x60c(%ebp),%edi
8010608b:	8b 95 e8 f9 ff ff    	mov    -0x618(%ebp),%edx
    int counter = 0, max = -1;
80106091:	31 c0                	xor    %eax,%eax
80106093:	31 db                	xor    %ebx,%ebx
80106095:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010609a:	eb 14                	jmp    801060b0 <sys_uniq+0x610>
8010609c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        i++;
801060a0:	83 c3 01             	add    $0x1,%ebx
801060a3:	89 c6                	mov    %eax,%esi
    while (i < sentences)
801060a5:	39 fb                	cmp    %edi,%ebx
801060a7:	0f 8d ca fe ff ff    	jge    80105f77 <sys_uniq+0x4d7>
      if (var == is_duplicate[i])
801060ad:	8b 04 9a             	mov    (%edx,%ebx,4),%eax
801060b0:	39 c6                	cmp    %eax,%esi
801060b2:	75 ec                	jne    801060a0 <sys_uniq+0x600>
        cprintf("%s\n", curr_line[i]);
801060b4:	6b c3 64             	imul   $0x64,%ebx,%eax
801060b7:	89 95 f4 f9 ff ff    	mov    %edx,-0x60c(%ebp)
801060bd:	8d 95 0c fa ff ff    	lea    -0x5f4(%ebp),%edx
801060c3:	83 ec 08             	sub    $0x8,%esp
801060c6:	01 d0                	add    %edx,%eax
801060c8:	50                   	push   %eax
801060c9:	68 94 88 10 80       	push   $0x80108894
801060ce:	e8 cd a5 ff ff       	call   801006a0 <cprintf>
        while (i < sentences && is_duplicate[i] == var)
801060d3:	83 c4 10             	add    $0x10,%esp
801060d6:	39 df                	cmp    %ebx,%edi
801060d8:	0f 8e 99 fe ff ff    	jle    80105f77 <sys_uniq+0x4d7>
801060de:	8b 95 f4 f9 ff ff    	mov    -0x60c(%ebp),%edx
801060e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          i++;
801060e8:	83 c3 01             	add    $0x1,%ebx
        while (i < sentences && is_duplicate[i] == var)
801060eb:	39 df                	cmp    %ebx,%edi
801060ed:	0f 84 84 fe ff ff    	je     80105f77 <sys_uniq+0x4d7>
801060f3:	39 34 9a             	cmp    %esi,(%edx,%ebx,4)
801060f6:	74 f0                	je     801060e8 <sys_uniq+0x648>
801060f8:	eb ab                	jmp    801060a5 <sys_uniq+0x605>
    int is_duplicate[sentences];
801060fa:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
801060ff:	e9 fb fc ff ff       	jmp    80105dff <sys_uniq+0x35f>
    int is_duplicate[sentences];
80106104:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
80106109:	e9 c0 fe ff ff       	jmp    80105fce <sys_uniq+0x52e>
            cprintf(curr_line[1]);
8010610e:	83 ec 0c             	sub    $0xc,%esp
80106111:	8d 85 70 fa ff ff    	lea    -0x590(%ebp),%eax
80106117:	50                   	push   %eax
80106118:	e8 83 a5 ff ff       	call   801006a0 <cprintf>
            cprintf("\n");
8010611d:	c7 04 24 03 8b 10 80 	movl   $0x80108b03,(%esp)
80106124:	e8 77 a5 ff ff       	call   801006a0 <cprintf>
80106129:	83 c4 10             	add    $0x10,%esp
8010612c:	e9 a9 fd ff ff       	jmp    80105eda <sys_uniq+0x43a>
80106131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop

80106140 <sys_head>:
// return how many clock tick interrupts have occurred
// since start.
int sys_head(void)
{
80106140:	55                   	push   %ebp
80106141:	89 e5                	mov    %esp,%ebp
80106143:	57                   	push   %edi
  char *string;
  argint(0, &max_len);
  argstr(1, &string);

  int sentences = 0;
  int j = 0, k = 0;
80106144:	31 ff                	xor    %edi,%edi
{
80106146:	56                   	push   %esi
  char curr_line[15][100]; // prev_line[] = "";
  if (strlen(curr_line[0]) > 0)
  {
  }
  for (int i = 0; i < strlen(string); i++)
80106147:	31 f6                	xor    %esi,%esi
{
80106149:	53                   	push   %ebx
8010614a:	81 ec 18 06 00 00    	sub    $0x618,%esp
  cprintf("head command is getting executed in kernel mode\n");
80106150:	68 60 88 10 80       	push   $0x80108860
80106155:	e8 46 a5 ff ff       	call   801006a0 <cprintf>
  argint(0, &max_len);
8010615a:	58                   	pop    %eax
8010615b:	8d 85 04 fa ff ff    	lea    -0x5fc(%ebp),%eax
80106161:	5a                   	pop    %edx
80106162:	50                   	push   %eax
80106163:	6a 00                	push   $0x0
80106165:	e8 86 ea ff ff       	call   80104bf0 <argint>
  argstr(1, &string);
8010616a:	8d 85 08 fa ff ff    	lea    -0x5f8(%ebp),%eax
80106170:	59                   	pop    %ecx
80106171:	5b                   	pop    %ebx
80106172:	50                   	push   %eax
  int sentences = 0;
80106173:	31 db                	xor    %ebx,%ebx
  argstr(1, &string);
80106175:	6a 01                	push   $0x1
80106177:	e8 14 eb ff ff       	call   80104c90 <argstr>
  if (strlen(curr_line[0]) > 0)
8010617c:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
80106182:	89 04 24             	mov    %eax,(%esp)
80106185:	e8 c6 e9 ff ff       	call   80104b50 <strlen>
  for (int i = 0; i < strlen(string); i++)
8010618a:	8b 95 08 fa ff ff    	mov    -0x5f8(%ebp),%edx
80106190:	83 c4 10             	add    $0x10,%esp
80106193:	eb 26                	jmp    801061bb <sys_head+0x7b>
80106195:	8d 76 00             	lea    0x0(%esi),%esi
  {
    // printf(1, "i= %d j= %d k= %d\n", i, j, k);

    if (string[i] != '\n')
    {
      curr_line[j][k++] = string[i];
80106198:	89 9d f4 f9 ff ff    	mov    %ebx,-0x60c(%ebp)
8010619e:	8d 4f 01             	lea    0x1(%edi),%ecx
801061a1:	6b db 64             	imul   $0x64,%ebx,%ebx
  for (int i = 0; i < strlen(string); i++)
801061a4:	83 c6 01             	add    $0x1,%esi
801061a7:	83 eb 18             	sub    $0x18,%ebx
801061aa:	01 eb                	add    %ebp,%ebx
801061ac:	88 84 1f 24 fa ff ff 	mov    %al,-0x5dc(%edi,%ebx,1)
801061b3:	8b 9d f4 f9 ff ff    	mov    -0x60c(%ebp),%ebx
801061b9:	89 cf                	mov    %ecx,%edi
801061bb:	83 ec 0c             	sub    $0xc,%esp
801061be:	52                   	push   %edx
801061bf:	e8 8c e9 ff ff       	call   80104b50 <strlen>
801061c4:	83 c4 10             	add    $0x10,%esp
801061c7:	39 f0                	cmp    %esi,%eax
801061c9:	7e 25                	jle    801061f0 <sys_head+0xb0>
    if (string[i] != '\n')
801061cb:	8b 95 08 fa ff ff    	mov    -0x5f8(%ebp),%edx
801061d1:	0f b6 04 32          	movzbl (%edx,%esi,1),%eax
801061d5:	3c 0a                	cmp    $0xa,%al
801061d7:	75 bf                	jne    80106198 <sys_head+0x58>
    }
    else
    {
      curr_line[j][k] = '\0';
      j++;
801061d9:	8d 43 01             	lea    0x1(%ebx),%eax
      k = 0;
801061dc:	31 c9                	xor    %ecx,%ecx
      j++;
801061de:	89 85 f4 f9 ff ff    	mov    %eax,-0x60c(%ebp)
      curr_line[j][k] = '\0';
801061e4:	31 c0                	xor    %eax,%eax
801061e6:	eb b9                	jmp    801061a1 <sys_head+0x61>
801061e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ef:	90                   	nop
      sentences++;
    }
  }
  if (sentences < max_len)
801061f0:	8b 85 04 fa ff ff    	mov    -0x5fc(%ebp),%eax
801061f6:	39 d8                	cmp    %ebx,%eax
801061f8:	7f 46                	jg     80106240 <sys_head+0x100>
      cprintf("%s\n", curr_line[i]);
  }
  else
  {
    int i = 0;
    while (max_len > 0)
801061fa:	8d 9d 0c fa ff ff    	lea    -0x5f4(%ebp),%ebx
80106200:	85 c0                	test   %eax,%eax
80106202:	7e 2b                	jle    8010622f <sys_head+0xef>
80106204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
      cprintf("%s\n", curr_line[i]);
80106208:	83 ec 08             	sub    $0x8,%esp
8010620b:	53                   	push   %ebx
    while (max_len > 0)
8010620c:	83 c3 64             	add    $0x64,%ebx
      cprintf("%s\n", curr_line[i]);
8010620f:	68 94 88 10 80       	push   $0x80108894
80106214:	e8 87 a4 ff ff       	call   801006a0 <cprintf>
      i++;
      max_len--;
80106219:	8b 85 04 fa ff ff    	mov    -0x5fc(%ebp),%eax
    while (max_len > 0)
8010621f:	83 c4 10             	add    $0x10,%esp
      max_len--;
80106222:	83 e8 01             	sub    $0x1,%eax
80106225:	89 85 04 fa ff ff    	mov    %eax,-0x5fc(%ebp)
    while (max_len > 0)
8010622b:	85 c0                	test   %eax,%eax
8010622d:	7f d9                	jg     80106208 <sys_head+0xc8>
    }
  }
  return 0;
}
8010622f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106232:	31 c0                	xor    %eax,%eax
80106234:	5b                   	pop    %ebx
80106235:	5e                   	pop    %esi
80106236:	5f                   	pop    %edi
80106237:	5d                   	pop    %ebp
80106238:	c3                   	ret    
80106239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < sentences; i++)
80106240:	85 db                	test   %ebx,%ebx
80106242:	7e eb                	jle    8010622f <sys_head+0xef>
80106244:	8d b5 0c fa ff ff    	lea    -0x5f4(%ebp),%esi
8010624a:	31 ff                	xor    %edi,%edi
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("%s\n", curr_line[i]);
80106250:	83 ec 08             	sub    $0x8,%esp
    for (int i = 0; i < sentences; i++)
80106253:	83 c7 01             	add    $0x1,%edi
      cprintf("%s\n", curr_line[i]);
80106256:	56                   	push   %esi
    for (int i = 0; i < sentences; i++)
80106257:	83 c6 64             	add    $0x64,%esi
      cprintf("%s\n", curr_line[i]);
8010625a:	68 94 88 10 80       	push   $0x80108894
8010625f:	e8 3c a4 ff ff       	call   801006a0 <cprintf>
    for (int i = 0; i < sentences; i++)
80106264:	83 c4 10             	add    $0x10,%esp
80106267:	39 fb                	cmp    %edi,%ebx
80106269:	75 e5                	jne    80106250 <sys_head+0x110>
}
8010626b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010626e:	31 c0                	xor    %eax,%eax
80106270:	5b                   	pop    %ebx
80106271:	5e                   	pop    %esi
80106272:	5f                   	pop    %edi
80106273:	5d                   	pop    %ebp
80106274:	c3                   	ret    
80106275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010627c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106280 <sys_ps>:
int sys_ps(void){
80106280:	55                   	push   %ebp
80106281:	89 e5                	mov    %esp,%ebp
80106283:	83 ec 20             	sub    $0x20,%esp
  char *string;
  argstr(0, &string);
80106286:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106289:	50                   	push   %eax
8010628a:	6a 00                	push   $0x0
8010628c:	e8 ff e9 ff ff       	call   80104c90 <argstr>
  return ps(string);
80106291:	58                   	pop    %eax
80106292:	ff 75 f4             	push   -0xc(%ebp)
80106295:	e8 96 e1 ff ff       	call   80104430 <ps>
}
8010629a:	c9                   	leave  
8010629b:	c3                   	ret    
8010629c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062a0 <sys_change_priority>:
int sys_change_priority(void){
801062a0:	55                   	push   %ebp
801062a1:	89 e5                	mov    %esp,%ebp
801062a3:	83 ec 20             	sub    $0x20,%esp
  int pid;
  int priority;
  argint(0,&pid);
801062a6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062a9:	50                   	push   %eax
801062aa:	6a 00                	push   $0x0
801062ac:	e8 3f e9 ff ff       	call   80104bf0 <argint>
  argint(1,&priority);
801062b1:	58                   	pop    %eax
801062b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062b5:	5a                   	pop    %edx
801062b6:	50                   	push   %eax
801062b7:	6a 01                	push   $0x1
801062b9:	e8 32 e9 ff ff       	call   80104bf0 <argint>
  return change_priority(pid,priority);
801062be:	59                   	pop    %ecx
801062bf:	58                   	pop    %eax
801062c0:	ff 75 f4             	push   -0xc(%ebp)
801062c3:	ff 75 f0             	push   -0x10(%ebp)
801062c6:	e8 75 e2 ff ff       	call   80104540 <change_priority>
}
801062cb:	c9                   	leave  
801062cc:	c3                   	ret    
801062cd:	8d 76 00             	lea    0x0(%esi),%esi

801062d0 <sys_uptime>:
int sys_uptime(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	53                   	push   %ebx
801062d4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801062d7:	68 80 52 11 80       	push   $0x80115280
801062dc:	e8 af e5 ff ff       	call   80104890 <acquire>
  xticks = ticks;
801062e1:	8b 1d 60 52 11 80    	mov    0x80115260,%ebx
  release(&tickslock);
801062e7:	c7 04 24 80 52 11 80 	movl   $0x80115280,(%esp)
801062ee:	e8 3d e5 ff ff       	call   80104830 <release>
  return xticks;
}
801062f3:	89 d8                	mov    %ebx,%eax
801062f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062f8:	c9                   	leave  
801062f9:	c3                   	ret    

801062fa <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801062fa:	1e                   	push   %ds
  pushl %es
801062fb:	06                   	push   %es
  pushl %fs
801062fc:	0f a0                	push   %fs
  pushl %gs
801062fe:	0f a8                	push   %gs
  pushal
80106300:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106301:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106305:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106307:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106309:	54                   	push   %esp
  call trap
8010630a:	e8 c1 00 00 00       	call   801063d0 <trap>
  addl $4, %esp
8010630f:	83 c4 04             	add    $0x4,%esp

80106312 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106312:	61                   	popa   
  popl %gs
80106313:	0f a9                	pop    %gs
  popl %fs
80106315:	0f a1                	pop    %fs
  popl %es
80106317:	07                   	pop    %es
  popl %ds
80106318:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106319:	83 c4 08             	add    $0x8,%esp
  iret
8010631c:	cf                   	iret   
8010631d:	66 90                	xchg   %ax,%ax
8010631f:	90                   	nop

80106320 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106320:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106321:	31 c0                	xor    %eax,%eax
{
80106323:	89 e5                	mov    %esp,%ebp
80106325:	83 ec 08             	sub    $0x8,%esp
80106328:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010632f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106330:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106337:	c7 04 c5 c2 52 11 80 	movl   $0x8e000008,-0x7feead3e(,%eax,8)
8010633e:	08 00 00 8e 
80106342:	66 89 14 c5 c0 52 11 	mov    %dx,-0x7feead40(,%eax,8)
80106349:	80 
8010634a:	c1 ea 10             	shr    $0x10,%edx
8010634d:	66 89 14 c5 c6 52 11 	mov    %dx,-0x7feead3a(,%eax,8)
80106354:	80 
  for(i = 0; i < 256; i++)
80106355:	83 c0 01             	add    $0x1,%eax
80106358:	3d 00 01 00 00       	cmp    $0x100,%eax
8010635d:	75 d1                	jne    80106330 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010635f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106362:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106367:	c7 05 c2 54 11 80 08 	movl   $0xef000008,0x801154c2
8010636e:	00 00 ef 
  initlock(&tickslock, "time");
80106371:	68 98 88 10 80       	push   $0x80108898
80106376:	68 80 52 11 80       	push   $0x80115280
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010637b:	66 a3 c0 54 11 80    	mov    %ax,0x801154c0
80106381:	c1 e8 10             	shr    $0x10,%eax
80106384:	66 a3 c6 54 11 80    	mov    %ax,0x801154c6
  initlock(&tickslock, "time");
8010638a:	e8 31 e3 ff ff       	call   801046c0 <initlock>
}
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	c9                   	leave  
80106393:	c3                   	ret    
80106394:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010639b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010639f:	90                   	nop

801063a0 <idtinit>:

void
idtinit(void)
{
801063a0:	55                   	push   %ebp
  pd[0] = size-1;
801063a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801063a6:	89 e5                	mov    %esp,%ebp
801063a8:	83 ec 10             	sub    $0x10,%esp
801063ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801063af:	b8 c0 52 11 80       	mov    $0x801152c0,%eax
801063b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801063b8:	c1 e8 10             	shr    $0x10,%eax
801063bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801063bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801063c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801063c5:	c9                   	leave  
801063c6:	c3                   	ret    
801063c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ce:	66 90                	xchg   %ax,%ax

801063d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	57                   	push   %edi
801063d4:	56                   	push   %esi
801063d5:	53                   	push   %ebx
801063d6:	83 ec 1c             	sub    $0x1c,%esp
801063d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801063dc:	8b 43 30             	mov    0x30(%ebx),%eax
801063df:	83 f8 40             	cmp    $0x40,%eax
801063e2:	0f 84 38 01 00 00    	je     80106520 <trap+0x150>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801063e8:	83 e8 0e             	sub    $0xe,%eax
801063eb:	83 f8 31             	cmp    $0x31,%eax
801063ee:	0f 87 8c 00 00 00    	ja     80106480 <trap+0xb0>
801063f4:	ff 24 85 84 89 10 80 	jmp    *-0x7fef767c(,%eax,4)
801063fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063ff:	90                   	nop
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106400:	e8 cb d5 ff ff       	call   801039d0 <cpuid>
80106405:	85 c0                	test   %eax,%eax
80106407:	0f 84 cb 02 00 00    	je     801066d8 <trap+0x308>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
8010640d:	e8 de c4 ff ff       	call   801028f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106412:	e8 d9 d5 ff ff       	call   801039f0 <myproc>
80106417:	85 c0                	test   %eax,%eax
80106419:	74 1d                	je     80106438 <trap+0x68>
8010641b:	e8 d0 d5 ff ff       	call   801039f0 <myproc>
80106420:	8b 50 24             	mov    0x24(%eax),%edx
80106423:	85 d2                	test   %edx,%edx
80106425:	74 11                	je     80106438 <trap+0x68>
80106427:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010642b:	83 e0 03             	and    $0x3,%eax
8010642e:	66 83 f8 03          	cmp    $0x3,%ax
80106432:	0f 84 80 02 00 00    	je     801066b8 <trap+0x2e8>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106438:	e8 b3 d5 ff ff       	call   801039f0 <myproc>
8010643d:	85 c0                	test   %eax,%eax
8010643f:	74 0f                	je     80106450 <trap+0x80>
80106441:	e8 aa d5 ff ff       	call   801039f0 <myproc>
80106446:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010644a:	0f 84 b8 00 00 00    	je     80106508 <trap+0x138>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106450:	e8 9b d5 ff ff       	call   801039f0 <myproc>
80106455:	85 c0                	test   %eax,%eax
80106457:	74 1d                	je     80106476 <trap+0xa6>
80106459:	e8 92 d5 ff ff       	call   801039f0 <myproc>
8010645e:	8b 40 24             	mov    0x24(%eax),%eax
80106461:	85 c0                	test   %eax,%eax
80106463:	74 11                	je     80106476 <trap+0xa6>
80106465:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106469:	83 e0 03             	and    $0x3,%eax
8010646c:	66 83 f8 03          	cmp    $0x3,%ax
80106470:	0f 84 d7 00 00 00    	je     8010654d <trap+0x17d>
    exit();
}
80106476:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106479:	5b                   	pop    %ebx
8010647a:	5e                   	pop    %esi
8010647b:	5f                   	pop    %edi
8010647c:	5d                   	pop    %ebp
8010647d:	c3                   	ret    
8010647e:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
80106480:	e8 6b d5 ff ff       	call   801039f0 <myproc>
80106485:	85 c0                	test   %eax,%eax
80106487:	0f 84 7f 02 00 00    	je     8010670c <trap+0x33c>
8010648d:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106491:	0f 84 75 02 00 00    	je     8010670c <trap+0x33c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106497:	0f 20 d1             	mov    %cr2,%ecx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010649a:	8b 53 38             	mov    0x38(%ebx),%edx
8010649d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801064a0:	89 55 dc             	mov    %edx,-0x24(%ebp)
801064a3:	e8 28 d5 ff ff       	call   801039d0 <cpuid>
801064a8:	8b 73 30             	mov    0x30(%ebx),%esi
801064ab:	89 c7                	mov    %eax,%edi
801064ad:	8b 43 34             	mov    0x34(%ebx),%eax
801064b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801064b3:	e8 38 d5 ff ff       	call   801039f0 <myproc>
801064b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801064bb:	e8 30 d5 ff ff       	call   801039f0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064c0:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801064c3:	8b 55 dc             	mov    -0x24(%ebp),%edx
801064c6:	51                   	push   %ecx
801064c7:	52                   	push   %edx
801064c8:	57                   	push   %edi
801064c9:	ff 75 e4             	push   -0x1c(%ebp)
801064cc:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801064cd:	8b 75 e0             	mov    -0x20(%ebp),%esi
801064d0:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064d3:	56                   	push   %esi
801064d4:	ff 70 10             	push   0x10(%eax)
801064d7:	68 40 89 10 80       	push   $0x80108940
801064dc:	e8 bf a1 ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
801064e1:	83 c4 20             	add    $0x20,%esp
801064e4:	e8 07 d5 ff ff       	call   801039f0 <myproc>
801064e9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064f0:	e8 fb d4 ff ff       	call   801039f0 <myproc>
801064f5:	85 c0                	test   %eax,%eax
801064f7:	0f 85 1e ff ff ff    	jne    8010641b <trap+0x4b>
801064fd:	e9 36 ff ff ff       	jmp    80106438 <trap+0x68>
80106502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106508:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010650c:	0f 85 3e ff ff ff    	jne    80106450 <trap+0x80>
    yield();
80106512:	e8 69 dc ff ff       	call   80104180 <yield>
80106517:	e9 34 ff ff ff       	jmp    80106450 <trap+0x80>
8010651c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106520:	e8 cb d4 ff ff       	call   801039f0 <myproc>
80106525:	8b 70 24             	mov    0x24(%eax),%esi
80106528:	85 f6                	test   %esi,%esi
8010652a:	0f 85 98 01 00 00    	jne    801066c8 <trap+0x2f8>
    myproc()->tf = tf;
80106530:	e8 bb d4 ff ff       	call   801039f0 <myproc>
80106535:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106538:	e8 b3 e7 ff ff       	call   80104cf0 <syscall>
    if(myproc()->killed)
8010653d:	e8 ae d4 ff ff       	call   801039f0 <myproc>
80106542:	8b 48 24             	mov    0x24(%eax),%ecx
80106545:	85 c9                	test   %ecx,%ecx
80106547:	0f 84 29 ff ff ff    	je     80106476 <trap+0xa6>
}
8010654d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106550:	5b                   	pop    %ebx
80106551:	5e                   	pop    %esi
80106552:	5f                   	pop    %edi
80106553:	5d                   	pop    %ebp
      exit();
80106554:	e9 87 d9 ff ff       	jmp    80103ee0 <exit>
80106559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106560:	8b 7b 38             	mov    0x38(%ebx),%edi
80106563:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106567:	e8 64 d4 ff ff       	call   801039d0 <cpuid>
8010656c:	57                   	push   %edi
8010656d:	56                   	push   %esi
8010656e:	50                   	push   %eax
8010656f:	68 c0 88 10 80       	push   $0x801088c0
80106574:	e8 27 a1 ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80106579:	e8 72 c3 ff ff       	call   801028f0 <lapiceoi>
    break;
8010657e:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106581:	e8 6a d4 ff ff       	call   801039f0 <myproc>
80106586:	85 c0                	test   %eax,%eax
80106588:	0f 85 8d fe ff ff    	jne    8010641b <trap+0x4b>
8010658e:	e9 a5 fe ff ff       	jmp    80106438 <trap+0x68>
80106593:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106597:	90                   	nop
    kbdintr();
80106598:	e8 13 c2 ff ff       	call   801027b0 <kbdintr>
    lapiceoi();
8010659d:	e8 4e c3 ff ff       	call   801028f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065a2:	e8 49 d4 ff ff       	call   801039f0 <myproc>
801065a7:	85 c0                	test   %eax,%eax
801065a9:	0f 85 6c fe ff ff    	jne    8010641b <trap+0x4b>
801065af:	e9 84 fe ff ff       	jmp    80106438 <trap+0x68>
801065b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801065b8:	e8 f3 02 00 00       	call   801068b0 <uartintr>
    lapiceoi();
801065bd:	e8 2e c3 ff ff       	call   801028f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065c2:	e8 29 d4 ff ff       	call   801039f0 <myproc>
801065c7:	85 c0                	test   %eax,%eax
801065c9:	0f 85 4c fe ff ff    	jne    8010641b <trap+0x4b>
801065cf:	e9 64 fe ff ff       	jmp    80106438 <trap+0x68>
801065d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801065d8:	e8 43 bc ff ff       	call   80102220 <ideintr>
801065dd:	e9 2b fe ff ff       	jmp    8010640d <trap+0x3d>
801065e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(growstack(myproc()->pgdir, myproc()->tf->esp, myproc()->stacktop) == 0)
801065e8:	e8 03 d4 ff ff       	call   801039f0 <myproc>
801065ed:	8b b8 8c 00 00 00    	mov    0x8c(%eax),%edi
801065f3:	e8 f8 d3 ff ff       	call   801039f0 <myproc>
801065f8:	8b 40 18             	mov    0x18(%eax),%eax
801065fb:	8b 70 44             	mov    0x44(%eax),%esi
801065fe:	e8 ed d3 ff ff       	call   801039f0 <myproc>
80106603:	83 ec 04             	sub    $0x4,%esp
80106606:	57                   	push   %edi
80106607:	56                   	push   %esi
80106608:	ff 70 04             	push   0x4(%eax)
8010660b:	e8 50 17 00 00       	call   80107d60 <growstack>
80106610:	83 c4 10             	add    $0x10,%esp
80106613:	85 c0                	test   %eax,%eax
80106615:	0f 84 f7 fd ff ff    	je     80106412 <trap+0x42>
			cprintf("pid %d %s: page fault on %d eip 0x%x ",myproc()->pid, myproc()->name, mycpu()->apicid, tf->eip);
8010661b:	8b 73 38             	mov    0x38(%ebx),%esi
8010661e:	e8 4d d3 ff ff       	call   80103970 <mycpu>
80106623:	0f b6 38             	movzbl (%eax),%edi
80106626:	e8 c5 d3 ff ff       	call   801039f0 <myproc>
8010662b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010662e:	e8 bd d3 ff ff       	call   801039f0 <myproc>
80106633:	83 ec 0c             	sub    $0xc,%esp
80106636:	56                   	push   %esi
80106637:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010663a:	57                   	push   %edi
8010663b:	83 c6 6c             	add    $0x6c,%esi
8010663e:	56                   	push   %esi
8010663f:	ff 70 10             	push   0x10(%eax)
80106642:	68 e4 88 10 80       	push   $0x801088e4
80106647:	e8 54 a0 ff ff       	call   801006a0 <cprintf>
8010664c:	0f 20 d7             	mov    %cr2,%edi
			cprintf("stack 0x%x sz 0x%x addr 0x%x\n", myproc()->stacktop, myproc()->sz, rcr2());
8010664f:	83 c4 20             	add    $0x20,%esp
80106652:	e8 99 d3 ff ff       	call   801039f0 <myproc>
80106657:	8b 30                	mov    (%eax),%esi
80106659:	e8 92 d3 ff ff       	call   801039f0 <myproc>
8010665e:	57                   	push   %edi
8010665f:	56                   	push   %esi
80106660:	ff b0 8c 00 00 00    	push   0x8c(%eax)
80106666:	68 9d 88 10 80       	push   $0x8010889d
8010666b:	e8 30 a0 ff ff       	call   801006a0 <cprintf>
			if(myproc()->tf->esp > myproc()->sz)
80106670:	e8 7b d3 ff ff       	call   801039f0 <myproc>
80106675:	8b 40 18             	mov    0x18(%eax),%eax
80106678:	8b 70 44             	mov    0x44(%eax),%esi
8010667b:	e8 70 d3 ff ff       	call   801039f0 <myproc>
80106680:	83 c4 10             	add    $0x10,%esp
80106683:	3b 30                	cmp    (%eax),%esi
80106685:	0f 86 59 fe ff ff    	jbe    801064e4 <trap+0x114>
				deallocuvm(myproc()->pgdir, USERTOP, myproc()->stacktop);
8010668b:	e8 60 d3 ff ff       	call   801039f0 <myproc>
80106690:	8b b0 8c 00 00 00    	mov    0x8c(%eax),%esi
80106696:	e8 55 d3 ff ff       	call   801039f0 <myproc>
8010669b:	83 ec 04             	sub    $0x4,%esp
8010669e:	56                   	push   %esi
8010669f:	68 00 e0 d4 0d       	push   $0xdd4e000
801066a4:	ff 70 04             	push   0x4(%eax)
801066a7:	e8 04 13 00 00       	call   801079b0 <deallocuvm>
801066ac:	83 c4 10             	add    $0x10,%esp
			myproc()->killed = 1;
801066af:	e9 30 fe ff ff       	jmp    801064e4 <trap+0x114>
801066b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
801066b8:	e8 23 d8 ff ff       	call   80103ee0 <exit>
801066bd:	e9 76 fd ff ff       	jmp    80106438 <trap+0x68>
801066c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801066c8:	e8 13 d8 ff ff       	call   80103ee0 <exit>
801066cd:	e9 5e fe ff ff       	jmp    80106530 <trap+0x160>
801066d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801066d8:	83 ec 0c             	sub    $0xc,%esp
801066db:	68 80 52 11 80       	push   $0x80115280
801066e0:	e8 ab e1 ff ff       	call   80104890 <acquire>
      wakeup(&ticks);
801066e5:	c7 04 24 60 52 11 80 	movl   $0x80115260,(%esp)
      ticks++;
801066ec:	83 05 60 52 11 80 01 	addl   $0x1,0x80115260
      wakeup(&ticks);
801066f3:	e8 98 db ff ff       	call   80104290 <wakeup>
      release(&tickslock);
801066f8:	c7 04 24 80 52 11 80 	movl   $0x80115280,(%esp)
801066ff:	e8 2c e1 ff ff       	call   80104830 <release>
80106704:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106707:	e9 01 fd ff ff       	jmp    8010640d <trap+0x3d>
8010670c:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010670f:	8b 73 38             	mov    0x38(%ebx),%esi
80106712:	e8 b9 d2 ff ff       	call   801039d0 <cpuid>
80106717:	83 ec 0c             	sub    $0xc,%esp
8010671a:	57                   	push   %edi
8010671b:	56                   	push   %esi
8010671c:	50                   	push   %eax
8010671d:	ff 73 30             	push   0x30(%ebx)
80106720:	68 0c 89 10 80       	push   $0x8010890c
80106725:	e8 76 9f ff ff       	call   801006a0 <cprintf>
      panic("trap");
8010672a:	83 c4 14             	add    $0x14,%esp
8010672d:	68 bb 88 10 80       	push   $0x801088bb
80106732:	e8 49 9c ff ff       	call   80100380 <panic>
80106737:	66 90                	xchg   %ax,%ax
80106739:	66 90                	xchg   %ax,%ax
8010673b:	66 90                	xchg   %ax,%ax
8010673d:	66 90                	xchg   %ax,%ax
8010673f:	90                   	nop

80106740 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106740:	a1 c0 5a 11 80       	mov    0x80115ac0,%eax
80106745:	85 c0                	test   %eax,%eax
80106747:	74 17                	je     80106760 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106749:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010674e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010674f:	a8 01                	test   $0x1,%al
80106751:	74 0d                	je     80106760 <uartgetc+0x20>
80106753:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106758:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106759:	0f b6 c0             	movzbl %al,%eax
8010675c:	c3                   	ret    
8010675d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106765:	c3                   	ret    
80106766:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010676d:	8d 76 00             	lea    0x0(%esi),%esi

80106770 <uartinit>:
{
80106770:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106771:	31 c9                	xor    %ecx,%ecx
80106773:	89 c8                	mov    %ecx,%eax
80106775:	89 e5                	mov    %esp,%ebp
80106777:	57                   	push   %edi
80106778:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010677d:	56                   	push   %esi
8010677e:	89 fa                	mov    %edi,%edx
80106780:	53                   	push   %ebx
80106781:	83 ec 1c             	sub    $0x1c,%esp
80106784:	ee                   	out    %al,(%dx)
80106785:	be fb 03 00 00       	mov    $0x3fb,%esi
8010678a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010678f:	89 f2                	mov    %esi,%edx
80106791:	ee                   	out    %al,(%dx)
80106792:	b8 0c 00 00 00       	mov    $0xc,%eax
80106797:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010679c:	ee                   	out    %al,(%dx)
8010679d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801067a2:	89 c8                	mov    %ecx,%eax
801067a4:	89 da                	mov    %ebx,%edx
801067a6:	ee                   	out    %al,(%dx)
801067a7:	b8 03 00 00 00       	mov    $0x3,%eax
801067ac:	89 f2                	mov    %esi,%edx
801067ae:	ee                   	out    %al,(%dx)
801067af:	ba fc 03 00 00       	mov    $0x3fc,%edx
801067b4:	89 c8                	mov    %ecx,%eax
801067b6:	ee                   	out    %al,(%dx)
801067b7:	b8 01 00 00 00       	mov    $0x1,%eax
801067bc:	89 da                	mov    %ebx,%edx
801067be:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067bf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067c4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801067c5:	3c ff                	cmp    $0xff,%al
801067c7:	74 78                	je     80106841 <uartinit+0xd1>
  uart = 1;
801067c9:	c7 05 c0 5a 11 80 01 	movl   $0x1,0x80115ac0
801067d0:	00 00 00 
801067d3:	89 fa                	mov    %edi,%edx
801067d5:	ec                   	in     (%dx),%al
801067d6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067db:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801067dc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801067df:	bf 4c 8a 10 80       	mov    $0x80108a4c,%edi
801067e4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801067e9:	6a 00                	push   $0x0
801067eb:	6a 04                	push   $0x4
801067ed:	e8 6e bc ff ff       	call   80102460 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801067f2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
801067f6:	83 c4 10             	add    $0x10,%esp
801067f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106800:	a1 c0 5a 11 80       	mov    0x80115ac0,%eax
80106805:	bb 80 00 00 00       	mov    $0x80,%ebx
8010680a:	85 c0                	test   %eax,%eax
8010680c:	75 14                	jne    80106822 <uartinit+0xb2>
8010680e:	eb 23                	jmp    80106833 <uartinit+0xc3>
    microdelay(10);
80106810:	83 ec 0c             	sub    $0xc,%esp
80106813:	6a 0a                	push   $0xa
80106815:	e8 f6 c0 ff ff       	call   80102910 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010681a:	83 c4 10             	add    $0x10,%esp
8010681d:	83 eb 01             	sub    $0x1,%ebx
80106820:	74 07                	je     80106829 <uartinit+0xb9>
80106822:	89 f2                	mov    %esi,%edx
80106824:	ec                   	in     (%dx),%al
80106825:	a8 20                	test   $0x20,%al
80106827:	74 e7                	je     80106810 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106829:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010682d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106832:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106833:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106837:	83 c7 01             	add    $0x1,%edi
8010683a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010683d:	84 c0                	test   %al,%al
8010683f:	75 bf                	jne    80106800 <uartinit+0x90>
}
80106841:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106844:	5b                   	pop    %ebx
80106845:	5e                   	pop    %esi
80106846:	5f                   	pop    %edi
80106847:	5d                   	pop    %ebp
80106848:	c3                   	ret    
80106849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106850 <uartputc>:
  if(!uart)
80106850:	a1 c0 5a 11 80       	mov    0x80115ac0,%eax
80106855:	85 c0                	test   %eax,%eax
80106857:	74 47                	je     801068a0 <uartputc+0x50>
{
80106859:	55                   	push   %ebp
8010685a:	89 e5                	mov    %esp,%ebp
8010685c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010685d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106862:	53                   	push   %ebx
80106863:	bb 80 00 00 00       	mov    $0x80,%ebx
80106868:	eb 18                	jmp    80106882 <uartputc+0x32>
8010686a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106870:	83 ec 0c             	sub    $0xc,%esp
80106873:	6a 0a                	push   $0xa
80106875:	e8 96 c0 ff ff       	call   80102910 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010687a:	83 c4 10             	add    $0x10,%esp
8010687d:	83 eb 01             	sub    $0x1,%ebx
80106880:	74 07                	je     80106889 <uartputc+0x39>
80106882:	89 f2                	mov    %esi,%edx
80106884:	ec                   	in     (%dx),%al
80106885:	a8 20                	test   $0x20,%al
80106887:	74 e7                	je     80106870 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106889:	8b 45 08             	mov    0x8(%ebp),%eax
8010688c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106891:	ee                   	out    %al,(%dx)
}
80106892:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106895:	5b                   	pop    %ebx
80106896:	5e                   	pop    %esi
80106897:	5d                   	pop    %ebp
80106898:	c3                   	ret    
80106899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068a0:	c3                   	ret    
801068a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068af:	90                   	nop

801068b0 <uartintr>:

void
uartintr(void)
{
801068b0:	55                   	push   %ebp
801068b1:	89 e5                	mov    %esp,%ebp
801068b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801068b6:	68 40 67 10 80       	push   $0x80106740
801068bb:	e8 c0 9f ff ff       	call   80100880 <consoleintr>
}
801068c0:	83 c4 10             	add    $0x10,%esp
801068c3:	c9                   	leave  
801068c4:	c3                   	ret    

801068c5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $0
801068c7:	6a 00                	push   $0x0
  jmp alltraps
801068c9:	e9 2c fa ff ff       	jmp    801062fa <alltraps>

801068ce <vector1>:
.globl vector1
vector1:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $1
801068d0:	6a 01                	push   $0x1
  jmp alltraps
801068d2:	e9 23 fa ff ff       	jmp    801062fa <alltraps>

801068d7 <vector2>:
.globl vector2
vector2:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $2
801068d9:	6a 02                	push   $0x2
  jmp alltraps
801068db:	e9 1a fa ff ff       	jmp    801062fa <alltraps>

801068e0 <vector3>:
.globl vector3
vector3:
  pushl $0
801068e0:	6a 00                	push   $0x0
  pushl $3
801068e2:	6a 03                	push   $0x3
  jmp alltraps
801068e4:	e9 11 fa ff ff       	jmp    801062fa <alltraps>

801068e9 <vector4>:
.globl vector4
vector4:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $4
801068eb:	6a 04                	push   $0x4
  jmp alltraps
801068ed:	e9 08 fa ff ff       	jmp    801062fa <alltraps>

801068f2 <vector5>:
.globl vector5
vector5:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $5
801068f4:	6a 05                	push   $0x5
  jmp alltraps
801068f6:	e9 ff f9 ff ff       	jmp    801062fa <alltraps>

801068fb <vector6>:
.globl vector6
vector6:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $6
801068fd:	6a 06                	push   $0x6
  jmp alltraps
801068ff:	e9 f6 f9 ff ff       	jmp    801062fa <alltraps>

80106904 <vector7>:
.globl vector7
vector7:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $7
80106906:	6a 07                	push   $0x7
  jmp alltraps
80106908:	e9 ed f9 ff ff       	jmp    801062fa <alltraps>

8010690d <vector8>:
.globl vector8
vector8:
  pushl $8
8010690d:	6a 08                	push   $0x8
  jmp alltraps
8010690f:	e9 e6 f9 ff ff       	jmp    801062fa <alltraps>

80106914 <vector9>:
.globl vector9
vector9:
  pushl $0
80106914:	6a 00                	push   $0x0
  pushl $9
80106916:	6a 09                	push   $0x9
  jmp alltraps
80106918:	e9 dd f9 ff ff       	jmp    801062fa <alltraps>

8010691d <vector10>:
.globl vector10
vector10:
  pushl $10
8010691d:	6a 0a                	push   $0xa
  jmp alltraps
8010691f:	e9 d6 f9 ff ff       	jmp    801062fa <alltraps>

80106924 <vector11>:
.globl vector11
vector11:
  pushl $11
80106924:	6a 0b                	push   $0xb
  jmp alltraps
80106926:	e9 cf f9 ff ff       	jmp    801062fa <alltraps>

8010692b <vector12>:
.globl vector12
vector12:
  pushl $12
8010692b:	6a 0c                	push   $0xc
  jmp alltraps
8010692d:	e9 c8 f9 ff ff       	jmp    801062fa <alltraps>

80106932 <vector13>:
.globl vector13
vector13:
  pushl $13
80106932:	6a 0d                	push   $0xd
  jmp alltraps
80106934:	e9 c1 f9 ff ff       	jmp    801062fa <alltraps>

80106939 <vector14>:
.globl vector14
vector14:
  pushl $14
80106939:	6a 0e                	push   $0xe
  jmp alltraps
8010693b:	e9 ba f9 ff ff       	jmp    801062fa <alltraps>

80106940 <vector15>:
.globl vector15
vector15:
  pushl $0
80106940:	6a 00                	push   $0x0
  pushl $15
80106942:	6a 0f                	push   $0xf
  jmp alltraps
80106944:	e9 b1 f9 ff ff       	jmp    801062fa <alltraps>

80106949 <vector16>:
.globl vector16
vector16:
  pushl $0
80106949:	6a 00                	push   $0x0
  pushl $16
8010694b:	6a 10                	push   $0x10
  jmp alltraps
8010694d:	e9 a8 f9 ff ff       	jmp    801062fa <alltraps>

80106952 <vector17>:
.globl vector17
vector17:
  pushl $17
80106952:	6a 11                	push   $0x11
  jmp alltraps
80106954:	e9 a1 f9 ff ff       	jmp    801062fa <alltraps>

80106959 <vector18>:
.globl vector18
vector18:
  pushl $0
80106959:	6a 00                	push   $0x0
  pushl $18
8010695b:	6a 12                	push   $0x12
  jmp alltraps
8010695d:	e9 98 f9 ff ff       	jmp    801062fa <alltraps>

80106962 <vector19>:
.globl vector19
vector19:
  pushl $0
80106962:	6a 00                	push   $0x0
  pushl $19
80106964:	6a 13                	push   $0x13
  jmp alltraps
80106966:	e9 8f f9 ff ff       	jmp    801062fa <alltraps>

8010696b <vector20>:
.globl vector20
vector20:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $20
8010696d:	6a 14                	push   $0x14
  jmp alltraps
8010696f:	e9 86 f9 ff ff       	jmp    801062fa <alltraps>

80106974 <vector21>:
.globl vector21
vector21:
  pushl $0
80106974:	6a 00                	push   $0x0
  pushl $21
80106976:	6a 15                	push   $0x15
  jmp alltraps
80106978:	e9 7d f9 ff ff       	jmp    801062fa <alltraps>

8010697d <vector22>:
.globl vector22
vector22:
  pushl $0
8010697d:	6a 00                	push   $0x0
  pushl $22
8010697f:	6a 16                	push   $0x16
  jmp alltraps
80106981:	e9 74 f9 ff ff       	jmp    801062fa <alltraps>

80106986 <vector23>:
.globl vector23
vector23:
  pushl $0
80106986:	6a 00                	push   $0x0
  pushl $23
80106988:	6a 17                	push   $0x17
  jmp alltraps
8010698a:	e9 6b f9 ff ff       	jmp    801062fa <alltraps>

8010698f <vector24>:
.globl vector24
vector24:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $24
80106991:	6a 18                	push   $0x18
  jmp alltraps
80106993:	e9 62 f9 ff ff       	jmp    801062fa <alltraps>

80106998 <vector25>:
.globl vector25
vector25:
  pushl $0
80106998:	6a 00                	push   $0x0
  pushl $25
8010699a:	6a 19                	push   $0x19
  jmp alltraps
8010699c:	e9 59 f9 ff ff       	jmp    801062fa <alltraps>

801069a1 <vector26>:
.globl vector26
vector26:
  pushl $0
801069a1:	6a 00                	push   $0x0
  pushl $26
801069a3:	6a 1a                	push   $0x1a
  jmp alltraps
801069a5:	e9 50 f9 ff ff       	jmp    801062fa <alltraps>

801069aa <vector27>:
.globl vector27
vector27:
  pushl $0
801069aa:	6a 00                	push   $0x0
  pushl $27
801069ac:	6a 1b                	push   $0x1b
  jmp alltraps
801069ae:	e9 47 f9 ff ff       	jmp    801062fa <alltraps>

801069b3 <vector28>:
.globl vector28
vector28:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $28
801069b5:	6a 1c                	push   $0x1c
  jmp alltraps
801069b7:	e9 3e f9 ff ff       	jmp    801062fa <alltraps>

801069bc <vector29>:
.globl vector29
vector29:
  pushl $0
801069bc:	6a 00                	push   $0x0
  pushl $29
801069be:	6a 1d                	push   $0x1d
  jmp alltraps
801069c0:	e9 35 f9 ff ff       	jmp    801062fa <alltraps>

801069c5 <vector30>:
.globl vector30
vector30:
  pushl $0
801069c5:	6a 00                	push   $0x0
  pushl $30
801069c7:	6a 1e                	push   $0x1e
  jmp alltraps
801069c9:	e9 2c f9 ff ff       	jmp    801062fa <alltraps>

801069ce <vector31>:
.globl vector31
vector31:
  pushl $0
801069ce:	6a 00                	push   $0x0
  pushl $31
801069d0:	6a 1f                	push   $0x1f
  jmp alltraps
801069d2:	e9 23 f9 ff ff       	jmp    801062fa <alltraps>

801069d7 <vector32>:
.globl vector32
vector32:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $32
801069d9:	6a 20                	push   $0x20
  jmp alltraps
801069db:	e9 1a f9 ff ff       	jmp    801062fa <alltraps>

801069e0 <vector33>:
.globl vector33
vector33:
  pushl $0
801069e0:	6a 00                	push   $0x0
  pushl $33
801069e2:	6a 21                	push   $0x21
  jmp alltraps
801069e4:	e9 11 f9 ff ff       	jmp    801062fa <alltraps>

801069e9 <vector34>:
.globl vector34
vector34:
  pushl $0
801069e9:	6a 00                	push   $0x0
  pushl $34
801069eb:	6a 22                	push   $0x22
  jmp alltraps
801069ed:	e9 08 f9 ff ff       	jmp    801062fa <alltraps>

801069f2 <vector35>:
.globl vector35
vector35:
  pushl $0
801069f2:	6a 00                	push   $0x0
  pushl $35
801069f4:	6a 23                	push   $0x23
  jmp alltraps
801069f6:	e9 ff f8 ff ff       	jmp    801062fa <alltraps>

801069fb <vector36>:
.globl vector36
vector36:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $36
801069fd:	6a 24                	push   $0x24
  jmp alltraps
801069ff:	e9 f6 f8 ff ff       	jmp    801062fa <alltraps>

80106a04 <vector37>:
.globl vector37
vector37:
  pushl $0
80106a04:	6a 00                	push   $0x0
  pushl $37
80106a06:	6a 25                	push   $0x25
  jmp alltraps
80106a08:	e9 ed f8 ff ff       	jmp    801062fa <alltraps>

80106a0d <vector38>:
.globl vector38
vector38:
  pushl $0
80106a0d:	6a 00                	push   $0x0
  pushl $38
80106a0f:	6a 26                	push   $0x26
  jmp alltraps
80106a11:	e9 e4 f8 ff ff       	jmp    801062fa <alltraps>

80106a16 <vector39>:
.globl vector39
vector39:
  pushl $0
80106a16:	6a 00                	push   $0x0
  pushl $39
80106a18:	6a 27                	push   $0x27
  jmp alltraps
80106a1a:	e9 db f8 ff ff       	jmp    801062fa <alltraps>

80106a1f <vector40>:
.globl vector40
vector40:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $40
80106a21:	6a 28                	push   $0x28
  jmp alltraps
80106a23:	e9 d2 f8 ff ff       	jmp    801062fa <alltraps>

80106a28 <vector41>:
.globl vector41
vector41:
  pushl $0
80106a28:	6a 00                	push   $0x0
  pushl $41
80106a2a:	6a 29                	push   $0x29
  jmp alltraps
80106a2c:	e9 c9 f8 ff ff       	jmp    801062fa <alltraps>

80106a31 <vector42>:
.globl vector42
vector42:
  pushl $0
80106a31:	6a 00                	push   $0x0
  pushl $42
80106a33:	6a 2a                	push   $0x2a
  jmp alltraps
80106a35:	e9 c0 f8 ff ff       	jmp    801062fa <alltraps>

80106a3a <vector43>:
.globl vector43
vector43:
  pushl $0
80106a3a:	6a 00                	push   $0x0
  pushl $43
80106a3c:	6a 2b                	push   $0x2b
  jmp alltraps
80106a3e:	e9 b7 f8 ff ff       	jmp    801062fa <alltraps>

80106a43 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $44
80106a45:	6a 2c                	push   $0x2c
  jmp alltraps
80106a47:	e9 ae f8 ff ff       	jmp    801062fa <alltraps>

80106a4c <vector45>:
.globl vector45
vector45:
  pushl $0
80106a4c:	6a 00                	push   $0x0
  pushl $45
80106a4e:	6a 2d                	push   $0x2d
  jmp alltraps
80106a50:	e9 a5 f8 ff ff       	jmp    801062fa <alltraps>

80106a55 <vector46>:
.globl vector46
vector46:
  pushl $0
80106a55:	6a 00                	push   $0x0
  pushl $46
80106a57:	6a 2e                	push   $0x2e
  jmp alltraps
80106a59:	e9 9c f8 ff ff       	jmp    801062fa <alltraps>

80106a5e <vector47>:
.globl vector47
vector47:
  pushl $0
80106a5e:	6a 00                	push   $0x0
  pushl $47
80106a60:	6a 2f                	push   $0x2f
  jmp alltraps
80106a62:	e9 93 f8 ff ff       	jmp    801062fa <alltraps>

80106a67 <vector48>:
.globl vector48
vector48:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $48
80106a69:	6a 30                	push   $0x30
  jmp alltraps
80106a6b:	e9 8a f8 ff ff       	jmp    801062fa <alltraps>

80106a70 <vector49>:
.globl vector49
vector49:
  pushl $0
80106a70:	6a 00                	push   $0x0
  pushl $49
80106a72:	6a 31                	push   $0x31
  jmp alltraps
80106a74:	e9 81 f8 ff ff       	jmp    801062fa <alltraps>

80106a79 <vector50>:
.globl vector50
vector50:
  pushl $0
80106a79:	6a 00                	push   $0x0
  pushl $50
80106a7b:	6a 32                	push   $0x32
  jmp alltraps
80106a7d:	e9 78 f8 ff ff       	jmp    801062fa <alltraps>

80106a82 <vector51>:
.globl vector51
vector51:
  pushl $0
80106a82:	6a 00                	push   $0x0
  pushl $51
80106a84:	6a 33                	push   $0x33
  jmp alltraps
80106a86:	e9 6f f8 ff ff       	jmp    801062fa <alltraps>

80106a8b <vector52>:
.globl vector52
vector52:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $52
80106a8d:	6a 34                	push   $0x34
  jmp alltraps
80106a8f:	e9 66 f8 ff ff       	jmp    801062fa <alltraps>

80106a94 <vector53>:
.globl vector53
vector53:
  pushl $0
80106a94:	6a 00                	push   $0x0
  pushl $53
80106a96:	6a 35                	push   $0x35
  jmp alltraps
80106a98:	e9 5d f8 ff ff       	jmp    801062fa <alltraps>

80106a9d <vector54>:
.globl vector54
vector54:
  pushl $0
80106a9d:	6a 00                	push   $0x0
  pushl $54
80106a9f:	6a 36                	push   $0x36
  jmp alltraps
80106aa1:	e9 54 f8 ff ff       	jmp    801062fa <alltraps>

80106aa6 <vector55>:
.globl vector55
vector55:
  pushl $0
80106aa6:	6a 00                	push   $0x0
  pushl $55
80106aa8:	6a 37                	push   $0x37
  jmp alltraps
80106aaa:	e9 4b f8 ff ff       	jmp    801062fa <alltraps>

80106aaf <vector56>:
.globl vector56
vector56:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $56
80106ab1:	6a 38                	push   $0x38
  jmp alltraps
80106ab3:	e9 42 f8 ff ff       	jmp    801062fa <alltraps>

80106ab8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ab8:	6a 00                	push   $0x0
  pushl $57
80106aba:	6a 39                	push   $0x39
  jmp alltraps
80106abc:	e9 39 f8 ff ff       	jmp    801062fa <alltraps>

80106ac1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106ac1:	6a 00                	push   $0x0
  pushl $58
80106ac3:	6a 3a                	push   $0x3a
  jmp alltraps
80106ac5:	e9 30 f8 ff ff       	jmp    801062fa <alltraps>

80106aca <vector59>:
.globl vector59
vector59:
  pushl $0
80106aca:	6a 00                	push   $0x0
  pushl $59
80106acc:	6a 3b                	push   $0x3b
  jmp alltraps
80106ace:	e9 27 f8 ff ff       	jmp    801062fa <alltraps>

80106ad3 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $60
80106ad5:	6a 3c                	push   $0x3c
  jmp alltraps
80106ad7:	e9 1e f8 ff ff       	jmp    801062fa <alltraps>

80106adc <vector61>:
.globl vector61
vector61:
  pushl $0
80106adc:	6a 00                	push   $0x0
  pushl $61
80106ade:	6a 3d                	push   $0x3d
  jmp alltraps
80106ae0:	e9 15 f8 ff ff       	jmp    801062fa <alltraps>

80106ae5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106ae5:	6a 00                	push   $0x0
  pushl $62
80106ae7:	6a 3e                	push   $0x3e
  jmp alltraps
80106ae9:	e9 0c f8 ff ff       	jmp    801062fa <alltraps>

80106aee <vector63>:
.globl vector63
vector63:
  pushl $0
80106aee:	6a 00                	push   $0x0
  pushl $63
80106af0:	6a 3f                	push   $0x3f
  jmp alltraps
80106af2:	e9 03 f8 ff ff       	jmp    801062fa <alltraps>

80106af7 <vector64>:
.globl vector64
vector64:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $64
80106af9:	6a 40                	push   $0x40
  jmp alltraps
80106afb:	e9 fa f7 ff ff       	jmp    801062fa <alltraps>

80106b00 <vector65>:
.globl vector65
vector65:
  pushl $0
80106b00:	6a 00                	push   $0x0
  pushl $65
80106b02:	6a 41                	push   $0x41
  jmp alltraps
80106b04:	e9 f1 f7 ff ff       	jmp    801062fa <alltraps>

80106b09 <vector66>:
.globl vector66
vector66:
  pushl $0
80106b09:	6a 00                	push   $0x0
  pushl $66
80106b0b:	6a 42                	push   $0x42
  jmp alltraps
80106b0d:	e9 e8 f7 ff ff       	jmp    801062fa <alltraps>

80106b12 <vector67>:
.globl vector67
vector67:
  pushl $0
80106b12:	6a 00                	push   $0x0
  pushl $67
80106b14:	6a 43                	push   $0x43
  jmp alltraps
80106b16:	e9 df f7 ff ff       	jmp    801062fa <alltraps>

80106b1b <vector68>:
.globl vector68
vector68:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $68
80106b1d:	6a 44                	push   $0x44
  jmp alltraps
80106b1f:	e9 d6 f7 ff ff       	jmp    801062fa <alltraps>

80106b24 <vector69>:
.globl vector69
vector69:
  pushl $0
80106b24:	6a 00                	push   $0x0
  pushl $69
80106b26:	6a 45                	push   $0x45
  jmp alltraps
80106b28:	e9 cd f7 ff ff       	jmp    801062fa <alltraps>

80106b2d <vector70>:
.globl vector70
vector70:
  pushl $0
80106b2d:	6a 00                	push   $0x0
  pushl $70
80106b2f:	6a 46                	push   $0x46
  jmp alltraps
80106b31:	e9 c4 f7 ff ff       	jmp    801062fa <alltraps>

80106b36 <vector71>:
.globl vector71
vector71:
  pushl $0
80106b36:	6a 00                	push   $0x0
  pushl $71
80106b38:	6a 47                	push   $0x47
  jmp alltraps
80106b3a:	e9 bb f7 ff ff       	jmp    801062fa <alltraps>

80106b3f <vector72>:
.globl vector72
vector72:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $72
80106b41:	6a 48                	push   $0x48
  jmp alltraps
80106b43:	e9 b2 f7 ff ff       	jmp    801062fa <alltraps>

80106b48 <vector73>:
.globl vector73
vector73:
  pushl $0
80106b48:	6a 00                	push   $0x0
  pushl $73
80106b4a:	6a 49                	push   $0x49
  jmp alltraps
80106b4c:	e9 a9 f7 ff ff       	jmp    801062fa <alltraps>

80106b51 <vector74>:
.globl vector74
vector74:
  pushl $0
80106b51:	6a 00                	push   $0x0
  pushl $74
80106b53:	6a 4a                	push   $0x4a
  jmp alltraps
80106b55:	e9 a0 f7 ff ff       	jmp    801062fa <alltraps>

80106b5a <vector75>:
.globl vector75
vector75:
  pushl $0
80106b5a:	6a 00                	push   $0x0
  pushl $75
80106b5c:	6a 4b                	push   $0x4b
  jmp alltraps
80106b5e:	e9 97 f7 ff ff       	jmp    801062fa <alltraps>

80106b63 <vector76>:
.globl vector76
vector76:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $76
80106b65:	6a 4c                	push   $0x4c
  jmp alltraps
80106b67:	e9 8e f7 ff ff       	jmp    801062fa <alltraps>

80106b6c <vector77>:
.globl vector77
vector77:
  pushl $0
80106b6c:	6a 00                	push   $0x0
  pushl $77
80106b6e:	6a 4d                	push   $0x4d
  jmp alltraps
80106b70:	e9 85 f7 ff ff       	jmp    801062fa <alltraps>

80106b75 <vector78>:
.globl vector78
vector78:
  pushl $0
80106b75:	6a 00                	push   $0x0
  pushl $78
80106b77:	6a 4e                	push   $0x4e
  jmp alltraps
80106b79:	e9 7c f7 ff ff       	jmp    801062fa <alltraps>

80106b7e <vector79>:
.globl vector79
vector79:
  pushl $0
80106b7e:	6a 00                	push   $0x0
  pushl $79
80106b80:	6a 4f                	push   $0x4f
  jmp alltraps
80106b82:	e9 73 f7 ff ff       	jmp    801062fa <alltraps>

80106b87 <vector80>:
.globl vector80
vector80:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $80
80106b89:	6a 50                	push   $0x50
  jmp alltraps
80106b8b:	e9 6a f7 ff ff       	jmp    801062fa <alltraps>

80106b90 <vector81>:
.globl vector81
vector81:
  pushl $0
80106b90:	6a 00                	push   $0x0
  pushl $81
80106b92:	6a 51                	push   $0x51
  jmp alltraps
80106b94:	e9 61 f7 ff ff       	jmp    801062fa <alltraps>

80106b99 <vector82>:
.globl vector82
vector82:
  pushl $0
80106b99:	6a 00                	push   $0x0
  pushl $82
80106b9b:	6a 52                	push   $0x52
  jmp alltraps
80106b9d:	e9 58 f7 ff ff       	jmp    801062fa <alltraps>

80106ba2 <vector83>:
.globl vector83
vector83:
  pushl $0
80106ba2:	6a 00                	push   $0x0
  pushl $83
80106ba4:	6a 53                	push   $0x53
  jmp alltraps
80106ba6:	e9 4f f7 ff ff       	jmp    801062fa <alltraps>

80106bab <vector84>:
.globl vector84
vector84:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $84
80106bad:	6a 54                	push   $0x54
  jmp alltraps
80106baf:	e9 46 f7 ff ff       	jmp    801062fa <alltraps>

80106bb4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106bb4:	6a 00                	push   $0x0
  pushl $85
80106bb6:	6a 55                	push   $0x55
  jmp alltraps
80106bb8:	e9 3d f7 ff ff       	jmp    801062fa <alltraps>

80106bbd <vector86>:
.globl vector86
vector86:
  pushl $0
80106bbd:	6a 00                	push   $0x0
  pushl $86
80106bbf:	6a 56                	push   $0x56
  jmp alltraps
80106bc1:	e9 34 f7 ff ff       	jmp    801062fa <alltraps>

80106bc6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106bc6:	6a 00                	push   $0x0
  pushl $87
80106bc8:	6a 57                	push   $0x57
  jmp alltraps
80106bca:	e9 2b f7 ff ff       	jmp    801062fa <alltraps>

80106bcf <vector88>:
.globl vector88
vector88:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $88
80106bd1:	6a 58                	push   $0x58
  jmp alltraps
80106bd3:	e9 22 f7 ff ff       	jmp    801062fa <alltraps>

80106bd8 <vector89>:
.globl vector89
vector89:
  pushl $0
80106bd8:	6a 00                	push   $0x0
  pushl $89
80106bda:	6a 59                	push   $0x59
  jmp alltraps
80106bdc:	e9 19 f7 ff ff       	jmp    801062fa <alltraps>

80106be1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106be1:	6a 00                	push   $0x0
  pushl $90
80106be3:	6a 5a                	push   $0x5a
  jmp alltraps
80106be5:	e9 10 f7 ff ff       	jmp    801062fa <alltraps>

80106bea <vector91>:
.globl vector91
vector91:
  pushl $0
80106bea:	6a 00                	push   $0x0
  pushl $91
80106bec:	6a 5b                	push   $0x5b
  jmp alltraps
80106bee:	e9 07 f7 ff ff       	jmp    801062fa <alltraps>

80106bf3 <vector92>:
.globl vector92
vector92:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $92
80106bf5:	6a 5c                	push   $0x5c
  jmp alltraps
80106bf7:	e9 fe f6 ff ff       	jmp    801062fa <alltraps>

80106bfc <vector93>:
.globl vector93
vector93:
  pushl $0
80106bfc:	6a 00                	push   $0x0
  pushl $93
80106bfe:	6a 5d                	push   $0x5d
  jmp alltraps
80106c00:	e9 f5 f6 ff ff       	jmp    801062fa <alltraps>

80106c05 <vector94>:
.globl vector94
vector94:
  pushl $0
80106c05:	6a 00                	push   $0x0
  pushl $94
80106c07:	6a 5e                	push   $0x5e
  jmp alltraps
80106c09:	e9 ec f6 ff ff       	jmp    801062fa <alltraps>

80106c0e <vector95>:
.globl vector95
vector95:
  pushl $0
80106c0e:	6a 00                	push   $0x0
  pushl $95
80106c10:	6a 5f                	push   $0x5f
  jmp alltraps
80106c12:	e9 e3 f6 ff ff       	jmp    801062fa <alltraps>

80106c17 <vector96>:
.globl vector96
vector96:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $96
80106c19:	6a 60                	push   $0x60
  jmp alltraps
80106c1b:	e9 da f6 ff ff       	jmp    801062fa <alltraps>

80106c20 <vector97>:
.globl vector97
vector97:
  pushl $0
80106c20:	6a 00                	push   $0x0
  pushl $97
80106c22:	6a 61                	push   $0x61
  jmp alltraps
80106c24:	e9 d1 f6 ff ff       	jmp    801062fa <alltraps>

80106c29 <vector98>:
.globl vector98
vector98:
  pushl $0
80106c29:	6a 00                	push   $0x0
  pushl $98
80106c2b:	6a 62                	push   $0x62
  jmp alltraps
80106c2d:	e9 c8 f6 ff ff       	jmp    801062fa <alltraps>

80106c32 <vector99>:
.globl vector99
vector99:
  pushl $0
80106c32:	6a 00                	push   $0x0
  pushl $99
80106c34:	6a 63                	push   $0x63
  jmp alltraps
80106c36:	e9 bf f6 ff ff       	jmp    801062fa <alltraps>

80106c3b <vector100>:
.globl vector100
vector100:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $100
80106c3d:	6a 64                	push   $0x64
  jmp alltraps
80106c3f:	e9 b6 f6 ff ff       	jmp    801062fa <alltraps>

80106c44 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c44:	6a 00                	push   $0x0
  pushl $101
80106c46:	6a 65                	push   $0x65
  jmp alltraps
80106c48:	e9 ad f6 ff ff       	jmp    801062fa <alltraps>

80106c4d <vector102>:
.globl vector102
vector102:
  pushl $0
80106c4d:	6a 00                	push   $0x0
  pushl $102
80106c4f:	6a 66                	push   $0x66
  jmp alltraps
80106c51:	e9 a4 f6 ff ff       	jmp    801062fa <alltraps>

80106c56 <vector103>:
.globl vector103
vector103:
  pushl $0
80106c56:	6a 00                	push   $0x0
  pushl $103
80106c58:	6a 67                	push   $0x67
  jmp alltraps
80106c5a:	e9 9b f6 ff ff       	jmp    801062fa <alltraps>

80106c5f <vector104>:
.globl vector104
vector104:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $104
80106c61:	6a 68                	push   $0x68
  jmp alltraps
80106c63:	e9 92 f6 ff ff       	jmp    801062fa <alltraps>

80106c68 <vector105>:
.globl vector105
vector105:
  pushl $0
80106c68:	6a 00                	push   $0x0
  pushl $105
80106c6a:	6a 69                	push   $0x69
  jmp alltraps
80106c6c:	e9 89 f6 ff ff       	jmp    801062fa <alltraps>

80106c71 <vector106>:
.globl vector106
vector106:
  pushl $0
80106c71:	6a 00                	push   $0x0
  pushl $106
80106c73:	6a 6a                	push   $0x6a
  jmp alltraps
80106c75:	e9 80 f6 ff ff       	jmp    801062fa <alltraps>

80106c7a <vector107>:
.globl vector107
vector107:
  pushl $0
80106c7a:	6a 00                	push   $0x0
  pushl $107
80106c7c:	6a 6b                	push   $0x6b
  jmp alltraps
80106c7e:	e9 77 f6 ff ff       	jmp    801062fa <alltraps>

80106c83 <vector108>:
.globl vector108
vector108:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $108
80106c85:	6a 6c                	push   $0x6c
  jmp alltraps
80106c87:	e9 6e f6 ff ff       	jmp    801062fa <alltraps>

80106c8c <vector109>:
.globl vector109
vector109:
  pushl $0
80106c8c:	6a 00                	push   $0x0
  pushl $109
80106c8e:	6a 6d                	push   $0x6d
  jmp alltraps
80106c90:	e9 65 f6 ff ff       	jmp    801062fa <alltraps>

80106c95 <vector110>:
.globl vector110
vector110:
  pushl $0
80106c95:	6a 00                	push   $0x0
  pushl $110
80106c97:	6a 6e                	push   $0x6e
  jmp alltraps
80106c99:	e9 5c f6 ff ff       	jmp    801062fa <alltraps>

80106c9e <vector111>:
.globl vector111
vector111:
  pushl $0
80106c9e:	6a 00                	push   $0x0
  pushl $111
80106ca0:	6a 6f                	push   $0x6f
  jmp alltraps
80106ca2:	e9 53 f6 ff ff       	jmp    801062fa <alltraps>

80106ca7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $112
80106ca9:	6a 70                	push   $0x70
  jmp alltraps
80106cab:	e9 4a f6 ff ff       	jmp    801062fa <alltraps>

80106cb0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106cb0:	6a 00                	push   $0x0
  pushl $113
80106cb2:	6a 71                	push   $0x71
  jmp alltraps
80106cb4:	e9 41 f6 ff ff       	jmp    801062fa <alltraps>

80106cb9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106cb9:	6a 00                	push   $0x0
  pushl $114
80106cbb:	6a 72                	push   $0x72
  jmp alltraps
80106cbd:	e9 38 f6 ff ff       	jmp    801062fa <alltraps>

80106cc2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106cc2:	6a 00                	push   $0x0
  pushl $115
80106cc4:	6a 73                	push   $0x73
  jmp alltraps
80106cc6:	e9 2f f6 ff ff       	jmp    801062fa <alltraps>

80106ccb <vector116>:
.globl vector116
vector116:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $116
80106ccd:	6a 74                	push   $0x74
  jmp alltraps
80106ccf:	e9 26 f6 ff ff       	jmp    801062fa <alltraps>

80106cd4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106cd4:	6a 00                	push   $0x0
  pushl $117
80106cd6:	6a 75                	push   $0x75
  jmp alltraps
80106cd8:	e9 1d f6 ff ff       	jmp    801062fa <alltraps>

80106cdd <vector118>:
.globl vector118
vector118:
  pushl $0
80106cdd:	6a 00                	push   $0x0
  pushl $118
80106cdf:	6a 76                	push   $0x76
  jmp alltraps
80106ce1:	e9 14 f6 ff ff       	jmp    801062fa <alltraps>

80106ce6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ce6:	6a 00                	push   $0x0
  pushl $119
80106ce8:	6a 77                	push   $0x77
  jmp alltraps
80106cea:	e9 0b f6 ff ff       	jmp    801062fa <alltraps>

80106cef <vector120>:
.globl vector120
vector120:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $120
80106cf1:	6a 78                	push   $0x78
  jmp alltraps
80106cf3:	e9 02 f6 ff ff       	jmp    801062fa <alltraps>

80106cf8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106cf8:	6a 00                	push   $0x0
  pushl $121
80106cfa:	6a 79                	push   $0x79
  jmp alltraps
80106cfc:	e9 f9 f5 ff ff       	jmp    801062fa <alltraps>

80106d01 <vector122>:
.globl vector122
vector122:
  pushl $0
80106d01:	6a 00                	push   $0x0
  pushl $122
80106d03:	6a 7a                	push   $0x7a
  jmp alltraps
80106d05:	e9 f0 f5 ff ff       	jmp    801062fa <alltraps>

80106d0a <vector123>:
.globl vector123
vector123:
  pushl $0
80106d0a:	6a 00                	push   $0x0
  pushl $123
80106d0c:	6a 7b                	push   $0x7b
  jmp alltraps
80106d0e:	e9 e7 f5 ff ff       	jmp    801062fa <alltraps>

80106d13 <vector124>:
.globl vector124
vector124:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $124
80106d15:	6a 7c                	push   $0x7c
  jmp alltraps
80106d17:	e9 de f5 ff ff       	jmp    801062fa <alltraps>

80106d1c <vector125>:
.globl vector125
vector125:
  pushl $0
80106d1c:	6a 00                	push   $0x0
  pushl $125
80106d1e:	6a 7d                	push   $0x7d
  jmp alltraps
80106d20:	e9 d5 f5 ff ff       	jmp    801062fa <alltraps>

80106d25 <vector126>:
.globl vector126
vector126:
  pushl $0
80106d25:	6a 00                	push   $0x0
  pushl $126
80106d27:	6a 7e                	push   $0x7e
  jmp alltraps
80106d29:	e9 cc f5 ff ff       	jmp    801062fa <alltraps>

80106d2e <vector127>:
.globl vector127
vector127:
  pushl $0
80106d2e:	6a 00                	push   $0x0
  pushl $127
80106d30:	6a 7f                	push   $0x7f
  jmp alltraps
80106d32:	e9 c3 f5 ff ff       	jmp    801062fa <alltraps>

80106d37 <vector128>:
.globl vector128
vector128:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $128
80106d39:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106d3e:	e9 b7 f5 ff ff       	jmp    801062fa <alltraps>

80106d43 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $129
80106d45:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d4a:	e9 ab f5 ff ff       	jmp    801062fa <alltraps>

80106d4f <vector130>:
.globl vector130
vector130:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $130
80106d51:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106d56:	e9 9f f5 ff ff       	jmp    801062fa <alltraps>

80106d5b <vector131>:
.globl vector131
vector131:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $131
80106d5d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106d62:	e9 93 f5 ff ff       	jmp    801062fa <alltraps>

80106d67 <vector132>:
.globl vector132
vector132:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $132
80106d69:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106d6e:	e9 87 f5 ff ff       	jmp    801062fa <alltraps>

80106d73 <vector133>:
.globl vector133
vector133:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $133
80106d75:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106d7a:	e9 7b f5 ff ff       	jmp    801062fa <alltraps>

80106d7f <vector134>:
.globl vector134
vector134:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $134
80106d81:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106d86:	e9 6f f5 ff ff       	jmp    801062fa <alltraps>

80106d8b <vector135>:
.globl vector135
vector135:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $135
80106d8d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106d92:	e9 63 f5 ff ff       	jmp    801062fa <alltraps>

80106d97 <vector136>:
.globl vector136
vector136:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $136
80106d99:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106d9e:	e9 57 f5 ff ff       	jmp    801062fa <alltraps>

80106da3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $137
80106da5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106daa:	e9 4b f5 ff ff       	jmp    801062fa <alltraps>

80106daf <vector138>:
.globl vector138
vector138:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $138
80106db1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106db6:	e9 3f f5 ff ff       	jmp    801062fa <alltraps>

80106dbb <vector139>:
.globl vector139
vector139:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $139
80106dbd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106dc2:	e9 33 f5 ff ff       	jmp    801062fa <alltraps>

80106dc7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $140
80106dc9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106dce:	e9 27 f5 ff ff       	jmp    801062fa <alltraps>

80106dd3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $141
80106dd5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106dda:	e9 1b f5 ff ff       	jmp    801062fa <alltraps>

80106ddf <vector142>:
.globl vector142
vector142:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $142
80106de1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106de6:	e9 0f f5 ff ff       	jmp    801062fa <alltraps>

80106deb <vector143>:
.globl vector143
vector143:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $143
80106ded:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106df2:	e9 03 f5 ff ff       	jmp    801062fa <alltraps>

80106df7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $144
80106df9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106dfe:	e9 f7 f4 ff ff       	jmp    801062fa <alltraps>

80106e03 <vector145>:
.globl vector145
vector145:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $145
80106e05:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106e0a:	e9 eb f4 ff ff       	jmp    801062fa <alltraps>

80106e0f <vector146>:
.globl vector146
vector146:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $146
80106e11:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106e16:	e9 df f4 ff ff       	jmp    801062fa <alltraps>

80106e1b <vector147>:
.globl vector147
vector147:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $147
80106e1d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106e22:	e9 d3 f4 ff ff       	jmp    801062fa <alltraps>

80106e27 <vector148>:
.globl vector148
vector148:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $148
80106e29:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106e2e:	e9 c7 f4 ff ff       	jmp    801062fa <alltraps>

80106e33 <vector149>:
.globl vector149
vector149:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $149
80106e35:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106e3a:	e9 bb f4 ff ff       	jmp    801062fa <alltraps>

80106e3f <vector150>:
.globl vector150
vector150:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $150
80106e41:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e46:	e9 af f4 ff ff       	jmp    801062fa <alltraps>

80106e4b <vector151>:
.globl vector151
vector151:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $151
80106e4d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106e52:	e9 a3 f4 ff ff       	jmp    801062fa <alltraps>

80106e57 <vector152>:
.globl vector152
vector152:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $152
80106e59:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106e5e:	e9 97 f4 ff ff       	jmp    801062fa <alltraps>

80106e63 <vector153>:
.globl vector153
vector153:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $153
80106e65:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106e6a:	e9 8b f4 ff ff       	jmp    801062fa <alltraps>

80106e6f <vector154>:
.globl vector154
vector154:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $154
80106e71:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106e76:	e9 7f f4 ff ff       	jmp    801062fa <alltraps>

80106e7b <vector155>:
.globl vector155
vector155:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $155
80106e7d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106e82:	e9 73 f4 ff ff       	jmp    801062fa <alltraps>

80106e87 <vector156>:
.globl vector156
vector156:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $156
80106e89:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106e8e:	e9 67 f4 ff ff       	jmp    801062fa <alltraps>

80106e93 <vector157>:
.globl vector157
vector157:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $157
80106e95:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106e9a:	e9 5b f4 ff ff       	jmp    801062fa <alltraps>

80106e9f <vector158>:
.globl vector158
vector158:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $158
80106ea1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106ea6:	e9 4f f4 ff ff       	jmp    801062fa <alltraps>

80106eab <vector159>:
.globl vector159
vector159:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $159
80106ead:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106eb2:	e9 43 f4 ff ff       	jmp    801062fa <alltraps>

80106eb7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $160
80106eb9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106ebe:	e9 37 f4 ff ff       	jmp    801062fa <alltraps>

80106ec3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $161
80106ec5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106eca:	e9 2b f4 ff ff       	jmp    801062fa <alltraps>

80106ecf <vector162>:
.globl vector162
vector162:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $162
80106ed1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106ed6:	e9 1f f4 ff ff       	jmp    801062fa <alltraps>

80106edb <vector163>:
.globl vector163
vector163:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $163
80106edd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106ee2:	e9 13 f4 ff ff       	jmp    801062fa <alltraps>

80106ee7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $164
80106ee9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106eee:	e9 07 f4 ff ff       	jmp    801062fa <alltraps>

80106ef3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $165
80106ef5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106efa:	e9 fb f3 ff ff       	jmp    801062fa <alltraps>

80106eff <vector166>:
.globl vector166
vector166:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $166
80106f01:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106f06:	e9 ef f3 ff ff       	jmp    801062fa <alltraps>

80106f0b <vector167>:
.globl vector167
vector167:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $167
80106f0d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106f12:	e9 e3 f3 ff ff       	jmp    801062fa <alltraps>

80106f17 <vector168>:
.globl vector168
vector168:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $168
80106f19:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106f1e:	e9 d7 f3 ff ff       	jmp    801062fa <alltraps>

80106f23 <vector169>:
.globl vector169
vector169:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $169
80106f25:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106f2a:	e9 cb f3 ff ff       	jmp    801062fa <alltraps>

80106f2f <vector170>:
.globl vector170
vector170:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $170
80106f31:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106f36:	e9 bf f3 ff ff       	jmp    801062fa <alltraps>

80106f3b <vector171>:
.globl vector171
vector171:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $171
80106f3d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f42:	e9 b3 f3 ff ff       	jmp    801062fa <alltraps>

80106f47 <vector172>:
.globl vector172
vector172:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $172
80106f49:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f4e:	e9 a7 f3 ff ff       	jmp    801062fa <alltraps>

80106f53 <vector173>:
.globl vector173
vector173:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $173
80106f55:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106f5a:	e9 9b f3 ff ff       	jmp    801062fa <alltraps>

80106f5f <vector174>:
.globl vector174
vector174:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $174
80106f61:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106f66:	e9 8f f3 ff ff       	jmp    801062fa <alltraps>

80106f6b <vector175>:
.globl vector175
vector175:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $175
80106f6d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106f72:	e9 83 f3 ff ff       	jmp    801062fa <alltraps>

80106f77 <vector176>:
.globl vector176
vector176:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $176
80106f79:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f7e:	e9 77 f3 ff ff       	jmp    801062fa <alltraps>

80106f83 <vector177>:
.globl vector177
vector177:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $177
80106f85:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106f8a:	e9 6b f3 ff ff       	jmp    801062fa <alltraps>

80106f8f <vector178>:
.globl vector178
vector178:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $178
80106f91:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106f96:	e9 5f f3 ff ff       	jmp    801062fa <alltraps>

80106f9b <vector179>:
.globl vector179
vector179:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $179
80106f9d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106fa2:	e9 53 f3 ff ff       	jmp    801062fa <alltraps>

80106fa7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $180
80106fa9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106fae:	e9 47 f3 ff ff       	jmp    801062fa <alltraps>

80106fb3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $181
80106fb5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106fba:	e9 3b f3 ff ff       	jmp    801062fa <alltraps>

80106fbf <vector182>:
.globl vector182
vector182:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $182
80106fc1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106fc6:	e9 2f f3 ff ff       	jmp    801062fa <alltraps>

80106fcb <vector183>:
.globl vector183
vector183:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $183
80106fcd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106fd2:	e9 23 f3 ff ff       	jmp    801062fa <alltraps>

80106fd7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $184
80106fd9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106fde:	e9 17 f3 ff ff       	jmp    801062fa <alltraps>

80106fe3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $185
80106fe5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106fea:	e9 0b f3 ff ff       	jmp    801062fa <alltraps>

80106fef <vector186>:
.globl vector186
vector186:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $186
80106ff1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106ff6:	e9 ff f2 ff ff       	jmp    801062fa <alltraps>

80106ffb <vector187>:
.globl vector187
vector187:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $187
80106ffd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107002:	e9 f3 f2 ff ff       	jmp    801062fa <alltraps>

80107007 <vector188>:
.globl vector188
vector188:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $188
80107009:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010700e:	e9 e7 f2 ff ff       	jmp    801062fa <alltraps>

80107013 <vector189>:
.globl vector189
vector189:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $189
80107015:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010701a:	e9 db f2 ff ff       	jmp    801062fa <alltraps>

8010701f <vector190>:
.globl vector190
vector190:
  pushl $0
8010701f:	6a 00                	push   $0x0
  pushl $190
80107021:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107026:	e9 cf f2 ff ff       	jmp    801062fa <alltraps>

8010702b <vector191>:
.globl vector191
vector191:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $191
8010702d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107032:	e9 c3 f2 ff ff       	jmp    801062fa <alltraps>

80107037 <vector192>:
.globl vector192
vector192:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $192
80107039:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010703e:	e9 b7 f2 ff ff       	jmp    801062fa <alltraps>

80107043 <vector193>:
.globl vector193
vector193:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $193
80107045:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010704a:	e9 ab f2 ff ff       	jmp    801062fa <alltraps>

8010704f <vector194>:
.globl vector194
vector194:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $194
80107051:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107056:	e9 9f f2 ff ff       	jmp    801062fa <alltraps>

8010705b <vector195>:
.globl vector195
vector195:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $195
8010705d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107062:	e9 93 f2 ff ff       	jmp    801062fa <alltraps>

80107067 <vector196>:
.globl vector196
vector196:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $196
80107069:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010706e:	e9 87 f2 ff ff       	jmp    801062fa <alltraps>

80107073 <vector197>:
.globl vector197
vector197:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $197
80107075:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010707a:	e9 7b f2 ff ff       	jmp    801062fa <alltraps>

8010707f <vector198>:
.globl vector198
vector198:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $198
80107081:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107086:	e9 6f f2 ff ff       	jmp    801062fa <alltraps>

8010708b <vector199>:
.globl vector199
vector199:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $199
8010708d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107092:	e9 63 f2 ff ff       	jmp    801062fa <alltraps>

80107097 <vector200>:
.globl vector200
vector200:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $200
80107099:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010709e:	e9 57 f2 ff ff       	jmp    801062fa <alltraps>

801070a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $201
801070a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801070aa:	e9 4b f2 ff ff       	jmp    801062fa <alltraps>

801070af <vector202>:
.globl vector202
vector202:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $202
801070b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801070b6:	e9 3f f2 ff ff       	jmp    801062fa <alltraps>

801070bb <vector203>:
.globl vector203
vector203:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $203
801070bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801070c2:	e9 33 f2 ff ff       	jmp    801062fa <alltraps>

801070c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $204
801070c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801070ce:	e9 27 f2 ff ff       	jmp    801062fa <alltraps>

801070d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $205
801070d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801070da:	e9 1b f2 ff ff       	jmp    801062fa <alltraps>

801070df <vector206>:
.globl vector206
vector206:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $206
801070e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801070e6:	e9 0f f2 ff ff       	jmp    801062fa <alltraps>

801070eb <vector207>:
.globl vector207
vector207:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $207
801070ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801070f2:	e9 03 f2 ff ff       	jmp    801062fa <alltraps>

801070f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $208
801070f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801070fe:	e9 f7 f1 ff ff       	jmp    801062fa <alltraps>

80107103 <vector209>:
.globl vector209
vector209:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $209
80107105:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010710a:	e9 eb f1 ff ff       	jmp    801062fa <alltraps>

8010710f <vector210>:
.globl vector210
vector210:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $210
80107111:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107116:	e9 df f1 ff ff       	jmp    801062fa <alltraps>

8010711b <vector211>:
.globl vector211
vector211:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $211
8010711d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107122:	e9 d3 f1 ff ff       	jmp    801062fa <alltraps>

80107127 <vector212>:
.globl vector212
vector212:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $212
80107129:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010712e:	e9 c7 f1 ff ff       	jmp    801062fa <alltraps>

80107133 <vector213>:
.globl vector213
vector213:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $213
80107135:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010713a:	e9 bb f1 ff ff       	jmp    801062fa <alltraps>

8010713f <vector214>:
.globl vector214
vector214:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $214
80107141:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107146:	e9 af f1 ff ff       	jmp    801062fa <alltraps>

8010714b <vector215>:
.globl vector215
vector215:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $215
8010714d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107152:	e9 a3 f1 ff ff       	jmp    801062fa <alltraps>

80107157 <vector216>:
.globl vector216
vector216:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $216
80107159:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010715e:	e9 97 f1 ff ff       	jmp    801062fa <alltraps>

80107163 <vector217>:
.globl vector217
vector217:
  pushl $0
80107163:	6a 00                	push   $0x0
  pushl $217
80107165:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010716a:	e9 8b f1 ff ff       	jmp    801062fa <alltraps>

8010716f <vector218>:
.globl vector218
vector218:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $218
80107171:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107176:	e9 7f f1 ff ff       	jmp    801062fa <alltraps>

8010717b <vector219>:
.globl vector219
vector219:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $219
8010717d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107182:	e9 73 f1 ff ff       	jmp    801062fa <alltraps>

80107187 <vector220>:
.globl vector220
vector220:
  pushl $0
80107187:	6a 00                	push   $0x0
  pushl $220
80107189:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010718e:	e9 67 f1 ff ff       	jmp    801062fa <alltraps>

80107193 <vector221>:
.globl vector221
vector221:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $221
80107195:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010719a:	e9 5b f1 ff ff       	jmp    801062fa <alltraps>

8010719f <vector222>:
.globl vector222
vector222:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $222
801071a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801071a6:	e9 4f f1 ff ff       	jmp    801062fa <alltraps>

801071ab <vector223>:
.globl vector223
vector223:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $223
801071ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801071b2:	e9 43 f1 ff ff       	jmp    801062fa <alltraps>

801071b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $224
801071b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801071be:	e9 37 f1 ff ff       	jmp    801062fa <alltraps>

801071c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $225
801071c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801071ca:	e9 2b f1 ff ff       	jmp    801062fa <alltraps>

801071cf <vector226>:
.globl vector226
vector226:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $226
801071d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801071d6:	e9 1f f1 ff ff       	jmp    801062fa <alltraps>

801071db <vector227>:
.globl vector227
vector227:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $227
801071dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801071e2:	e9 13 f1 ff ff       	jmp    801062fa <alltraps>

801071e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $228
801071e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801071ee:	e9 07 f1 ff ff       	jmp    801062fa <alltraps>

801071f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $229
801071f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801071fa:	e9 fb f0 ff ff       	jmp    801062fa <alltraps>

801071ff <vector230>:
.globl vector230
vector230:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $230
80107201:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107206:	e9 ef f0 ff ff       	jmp    801062fa <alltraps>

8010720b <vector231>:
.globl vector231
vector231:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $231
8010720d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107212:	e9 e3 f0 ff ff       	jmp    801062fa <alltraps>

80107217 <vector232>:
.globl vector232
vector232:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $232
80107219:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010721e:	e9 d7 f0 ff ff       	jmp    801062fa <alltraps>

80107223 <vector233>:
.globl vector233
vector233:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $233
80107225:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010722a:	e9 cb f0 ff ff       	jmp    801062fa <alltraps>

8010722f <vector234>:
.globl vector234
vector234:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $234
80107231:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107236:	e9 bf f0 ff ff       	jmp    801062fa <alltraps>

8010723b <vector235>:
.globl vector235
vector235:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $235
8010723d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107242:	e9 b3 f0 ff ff       	jmp    801062fa <alltraps>

80107247 <vector236>:
.globl vector236
vector236:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $236
80107249:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010724e:	e9 a7 f0 ff ff       	jmp    801062fa <alltraps>

80107253 <vector237>:
.globl vector237
vector237:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $237
80107255:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010725a:	e9 9b f0 ff ff       	jmp    801062fa <alltraps>

8010725f <vector238>:
.globl vector238
vector238:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $238
80107261:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107266:	e9 8f f0 ff ff       	jmp    801062fa <alltraps>

8010726b <vector239>:
.globl vector239
vector239:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $239
8010726d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107272:	e9 83 f0 ff ff       	jmp    801062fa <alltraps>

80107277 <vector240>:
.globl vector240
vector240:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $240
80107279:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010727e:	e9 77 f0 ff ff       	jmp    801062fa <alltraps>

80107283 <vector241>:
.globl vector241
vector241:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $241
80107285:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010728a:	e9 6b f0 ff ff       	jmp    801062fa <alltraps>

8010728f <vector242>:
.globl vector242
vector242:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $242
80107291:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107296:	e9 5f f0 ff ff       	jmp    801062fa <alltraps>

8010729b <vector243>:
.globl vector243
vector243:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $243
8010729d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801072a2:	e9 53 f0 ff ff       	jmp    801062fa <alltraps>

801072a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $244
801072a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801072ae:	e9 47 f0 ff ff       	jmp    801062fa <alltraps>

801072b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $245
801072b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801072ba:	e9 3b f0 ff ff       	jmp    801062fa <alltraps>

801072bf <vector246>:
.globl vector246
vector246:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $246
801072c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801072c6:	e9 2f f0 ff ff       	jmp    801062fa <alltraps>

801072cb <vector247>:
.globl vector247
vector247:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $247
801072cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801072d2:	e9 23 f0 ff ff       	jmp    801062fa <alltraps>

801072d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $248
801072d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801072de:	e9 17 f0 ff ff       	jmp    801062fa <alltraps>

801072e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $249
801072e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801072ea:	e9 0b f0 ff ff       	jmp    801062fa <alltraps>

801072ef <vector250>:
.globl vector250
vector250:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $250
801072f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801072f6:	e9 ff ef ff ff       	jmp    801062fa <alltraps>

801072fb <vector251>:
.globl vector251
vector251:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $251
801072fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107302:	e9 f3 ef ff ff       	jmp    801062fa <alltraps>

80107307 <vector252>:
.globl vector252
vector252:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $252
80107309:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010730e:	e9 e7 ef ff ff       	jmp    801062fa <alltraps>

80107313 <vector253>:
.globl vector253
vector253:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $253
80107315:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010731a:	e9 db ef ff ff       	jmp    801062fa <alltraps>

8010731f <vector254>:
.globl vector254
vector254:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $254
80107321:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107326:	e9 cf ef ff ff       	jmp    801062fa <alltraps>

8010732b <vector255>:
.globl vector255
vector255:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $255
8010732d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107332:	e9 c3 ef ff ff       	jmp    801062fa <alltraps>
80107337:	66 90                	xchg   %ax,%ax
80107339:	66 90                	xchg   %ax,%ax
8010733b:	66 90                	xchg   %ax,%ax
8010733d:	66 90                	xchg   %ax,%ax
8010733f:	90                   	nop

80107340 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	56                   	push   %esi
80107345:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107347:	c1 ea 16             	shr    $0x16,%edx
{
8010734a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010734b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010734e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107351:	8b 1f                	mov    (%edi),%ebx
80107353:	f6 c3 01             	test   $0x1,%bl
80107356:	74 28                	je     80107380 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107358:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010735e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107364:	89 f0                	mov    %esi,%eax
}
80107366:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107369:	c1 e8 0a             	shr    $0xa,%eax
8010736c:	25 fc 0f 00 00       	and    $0xffc,%eax
80107371:	01 d8                	add    %ebx,%eax
}
80107373:	5b                   	pop    %ebx
80107374:	5e                   	pop    %esi
80107375:	5f                   	pop    %edi
80107376:	5d                   	pop    %ebp
80107377:	c3                   	ret    
80107378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010737f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107380:	85 c9                	test   %ecx,%ecx
80107382:	74 2c                	je     801073b0 <walkpgdir+0x70>
80107384:	e8 d7 b2 ff ff       	call   80102660 <kalloc>
80107389:	89 c3                	mov    %eax,%ebx
8010738b:	85 c0                	test   %eax,%eax
8010738d:	74 21                	je     801073b0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010738f:	83 ec 04             	sub    $0x4,%esp
80107392:	68 00 10 00 00       	push   $0x1000
80107397:	6a 00                	push   $0x0
80107399:	50                   	push   %eax
8010739a:	e8 b1 d5 ff ff       	call   80104950 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010739f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801073a5:	83 c4 10             	add    $0x10,%esp
801073a8:	83 c8 07             	or     $0x7,%eax
801073ab:	89 07                	mov    %eax,(%edi)
801073ad:	eb b5                	jmp    80107364 <walkpgdir+0x24>
801073af:	90                   	nop
}
801073b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801073b3:	31 c0                	xor    %eax,%eax
}
801073b5:	5b                   	pop    %ebx
801073b6:	5e                   	pop    %esi
801073b7:	5f                   	pop    %edi
801073b8:	5d                   	pop    %ebp
801073b9:	c3                   	ret    
801073ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801073c0:	55                   	push   %ebp
801073c1:	89 e5                	mov    %esp,%ebp
801073c3:	57                   	push   %edi
801073c4:	56                   	push   %esi
801073c5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801073c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801073cc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801073d2:	83 ec 1c             	sub    $0x1c,%esp
801073d5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801073d8:	39 d3                	cmp    %edx,%ebx
801073da:	73 49                	jae    80107425 <deallocuvm.part.0+0x65>
801073dc:	89 c7                	mov    %eax,%edi
801073de:	eb 0c                	jmp    801073ec <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801073e0:	83 c0 01             	add    $0x1,%eax
801073e3:	c1 e0 16             	shl    $0x16,%eax
801073e6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
801073e8:	39 da                	cmp    %ebx,%edx
801073ea:	76 39                	jbe    80107425 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
801073ec:	89 d8                	mov    %ebx,%eax
801073ee:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801073f1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801073f4:	f6 c1 01             	test   $0x1,%cl
801073f7:	74 e7                	je     801073e0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
801073f9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073fb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107401:	c1 ee 0a             	shr    $0xa,%esi
80107404:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010740a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107411:	85 f6                	test   %esi,%esi
80107413:	74 cb                	je     801073e0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107415:	8b 06                	mov    (%esi),%eax
80107417:	a8 01                	test   $0x1,%al
80107419:	75 15                	jne    80107430 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010741b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107421:	39 da                	cmp    %ebx,%edx
80107423:	77 c7                	ja     801073ec <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107425:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107428:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010742b:	5b                   	pop    %ebx
8010742c:	5e                   	pop    %esi
8010742d:	5f                   	pop    %edi
8010742e:	5d                   	pop    %ebp
8010742f:	c3                   	ret    
      if(pa == 0)
80107430:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107435:	74 25                	je     8010745c <deallocuvm.part.0+0x9c>
      kfree(v);
80107437:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010743a:	05 00 00 00 80       	add    $0x80000000,%eax
8010743f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107442:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107448:	50                   	push   %eax
80107449:	e8 52 b0 ff ff       	call   801024a0 <kfree>
      *pte = 0;
8010744e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107454:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107457:	83 c4 10             	add    $0x10,%esp
8010745a:	eb 8c                	jmp    801073e8 <deallocuvm.part.0+0x28>
        panic("kfree");
8010745c:	83 ec 0c             	sub    $0xc,%esp
8010745f:	68 46 82 10 80       	push   $0x80108246
80107464:	e8 17 8f ff ff       	call   80100380 <panic>
80107469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107470 <mappages>:
{
80107470:	55                   	push   %ebp
80107471:	89 e5                	mov    %esp,%ebp
80107473:	57                   	push   %edi
80107474:	56                   	push   %esi
80107475:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107476:	89 d3                	mov    %edx,%ebx
80107478:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010747e:	83 ec 1c             	sub    $0x1c,%esp
80107481:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107484:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107488:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010748d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107490:	8b 45 08             	mov    0x8(%ebp),%eax
80107493:	29 d8                	sub    %ebx,%eax
80107495:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107498:	eb 3d                	jmp    801074d7 <mappages+0x67>
8010749a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801074a0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801074a7:	c1 ea 0a             	shr    $0xa,%edx
801074aa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801074b0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801074b7:	85 c0                	test   %eax,%eax
801074b9:	74 75                	je     80107530 <mappages+0xc0>
    if(*pte & PTE_P)
801074bb:	f6 00 01             	testb  $0x1,(%eax)
801074be:	0f 85 86 00 00 00    	jne    8010754a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801074c4:	0b 75 0c             	or     0xc(%ebp),%esi
801074c7:	83 ce 01             	or     $0x1,%esi
801074ca:	89 30                	mov    %esi,(%eax)
    if(a == last)
801074cc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801074cf:	74 6f                	je     80107540 <mappages+0xd0>
    a += PGSIZE;
801074d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801074d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
801074da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801074dd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801074e0:	89 d8                	mov    %ebx,%eax
801074e2:	c1 e8 16             	shr    $0x16,%eax
801074e5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801074e8:	8b 07                	mov    (%edi),%eax
801074ea:	a8 01                	test   $0x1,%al
801074ec:	75 b2                	jne    801074a0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801074ee:	e8 6d b1 ff ff       	call   80102660 <kalloc>
801074f3:	85 c0                	test   %eax,%eax
801074f5:	74 39                	je     80107530 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801074f7:	83 ec 04             	sub    $0x4,%esp
801074fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801074fd:	68 00 10 00 00       	push   $0x1000
80107502:	6a 00                	push   $0x0
80107504:	50                   	push   %eax
80107505:	e8 46 d4 ff ff       	call   80104950 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010750a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010750d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107510:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107516:	83 c8 07             	or     $0x7,%eax
80107519:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010751b:	89 d8                	mov    %ebx,%eax
8010751d:	c1 e8 0a             	shr    $0xa,%eax
80107520:	25 fc 0f 00 00       	and    $0xffc,%eax
80107525:	01 d0                	add    %edx,%eax
80107527:	eb 92                	jmp    801074bb <mappages+0x4b>
80107529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107530:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107533:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107538:	5b                   	pop    %ebx
80107539:	5e                   	pop    %esi
8010753a:	5f                   	pop    %edi
8010753b:	5d                   	pop    %ebp
8010753c:	c3                   	ret    
8010753d:	8d 76 00             	lea    0x0(%esi),%esi
80107540:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107543:	31 c0                	xor    %eax,%eax
}
80107545:	5b                   	pop    %ebx
80107546:	5e                   	pop    %esi
80107547:	5f                   	pop    %edi
80107548:	5d                   	pop    %ebp
80107549:	c3                   	ret    
      panic("remap");
8010754a:	83 ec 0c             	sub    $0xc,%esp
8010754d:	68 54 8a 10 80       	push   $0x80108a54
80107552:	e8 29 8e ff ff       	call   80100380 <panic>
80107557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010755e:	66 90                	xchg   %ax,%ax

80107560 <seginit>:
{
80107560:	55                   	push   %ebp
80107561:	89 e5                	mov    %esp,%ebp
80107563:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107566:	e8 65 c4 ff ff       	call   801039d0 <cpuid>
  pd[0] = size-1;
8010756b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107570:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107576:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010757a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80107581:	ff 00 00 
80107584:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
8010758b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010758e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80107595:	ff 00 00 
80107598:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
8010759f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801075a2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801075a9:	ff 00 00 
801075ac:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801075b3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801075b6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801075bd:	ff 00 00 
801075c0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
801075c7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801075ca:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
801075cf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801075d3:	c1 e8 10             	shr    $0x10,%eax
801075d6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801075da:	8d 45 f2             	lea    -0xe(%ebp),%eax
801075dd:	0f 01 10             	lgdtl  (%eax)
}
801075e0:	c9                   	leave  
801075e1:	c3                   	ret    
801075e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801075f0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801075f0:	a1 c4 5a 11 80       	mov    0x80115ac4,%eax
801075f5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801075fa:	0f 22 d8             	mov    %eax,%cr3
}
801075fd:	c3                   	ret    
801075fe:	66 90                	xchg   %ax,%ax

80107600 <switchuvm>:
{
80107600:	55                   	push   %ebp
80107601:	89 e5                	mov    %esp,%ebp
80107603:	57                   	push   %edi
80107604:	56                   	push   %esi
80107605:	53                   	push   %ebx
80107606:	83 ec 1c             	sub    $0x1c,%esp
80107609:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010760c:	85 f6                	test   %esi,%esi
8010760e:	0f 84 cb 00 00 00    	je     801076df <switchuvm+0xdf>
  if(p->kstack == 0)
80107614:	8b 46 08             	mov    0x8(%esi),%eax
80107617:	85 c0                	test   %eax,%eax
80107619:	0f 84 da 00 00 00    	je     801076f9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010761f:	8b 46 04             	mov    0x4(%esi),%eax
80107622:	85 c0                	test   %eax,%eax
80107624:	0f 84 c2 00 00 00    	je     801076ec <switchuvm+0xec>
  pushcli();
8010762a:	e8 11 d1 ff ff       	call   80104740 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010762f:	e8 3c c3 ff ff       	call   80103970 <mycpu>
80107634:	89 c3                	mov    %eax,%ebx
80107636:	e8 35 c3 ff ff       	call   80103970 <mycpu>
8010763b:	89 c7                	mov    %eax,%edi
8010763d:	e8 2e c3 ff ff       	call   80103970 <mycpu>
80107642:	83 c7 08             	add    $0x8,%edi
80107645:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107648:	e8 23 c3 ff ff       	call   80103970 <mycpu>
8010764d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107650:	ba 67 00 00 00       	mov    $0x67,%edx
80107655:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010765c:	83 c0 08             	add    $0x8,%eax
8010765f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107666:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010766b:	83 c1 08             	add    $0x8,%ecx
8010766e:	c1 e8 18             	shr    $0x18,%eax
80107671:	c1 e9 10             	shr    $0x10,%ecx
80107674:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010767a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107680:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107685:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010768c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107691:	e8 da c2 ff ff       	call   80103970 <mycpu>
80107696:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010769d:	e8 ce c2 ff ff       	call   80103970 <mycpu>
801076a2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801076a6:	8b 5e 08             	mov    0x8(%esi),%ebx
801076a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801076af:	e8 bc c2 ff ff       	call   80103970 <mycpu>
801076b4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801076b7:	e8 b4 c2 ff ff       	call   80103970 <mycpu>
801076bc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801076c0:	b8 28 00 00 00       	mov    $0x28,%eax
801076c5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801076c8:	8b 46 04             	mov    0x4(%esi),%eax
801076cb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076d0:	0f 22 d8             	mov    %eax,%cr3
}
801076d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076d6:	5b                   	pop    %ebx
801076d7:	5e                   	pop    %esi
801076d8:	5f                   	pop    %edi
801076d9:	5d                   	pop    %ebp
  popcli();
801076da:	e9 b1 d0 ff ff       	jmp    80104790 <popcli>
    panic("switchuvm: no process");
801076df:	83 ec 0c             	sub    $0xc,%esp
801076e2:	68 5a 8a 10 80       	push   $0x80108a5a
801076e7:	e8 94 8c ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
801076ec:	83 ec 0c             	sub    $0xc,%esp
801076ef:	68 85 8a 10 80       	push   $0x80108a85
801076f4:	e8 87 8c ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
801076f9:	83 ec 0c             	sub    $0xc,%esp
801076fc:	68 70 8a 10 80       	push   $0x80108a70
80107701:	e8 7a 8c ff ff       	call   80100380 <panic>
80107706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010770d:	8d 76 00             	lea    0x0(%esi),%esi

80107710 <inituvm>:
{
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	57                   	push   %edi
80107714:	56                   	push   %esi
80107715:	53                   	push   %ebx
80107716:	83 ec 1c             	sub    $0x1c,%esp
80107719:	8b 45 0c             	mov    0xc(%ebp),%eax
8010771c:	8b 75 10             	mov    0x10(%ebp),%esi
8010771f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107722:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107725:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010772b:	77 4b                	ja     80107778 <inituvm+0x68>
  mem = kalloc();
8010772d:	e8 2e af ff ff       	call   80102660 <kalloc>
  memset(mem, 0, PGSIZE);
80107732:	83 ec 04             	sub    $0x4,%esp
80107735:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010773a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010773c:	6a 00                	push   $0x0
8010773e:	50                   	push   %eax
8010773f:	e8 0c d2 ff ff       	call   80104950 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107744:	58                   	pop    %eax
80107745:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010774b:	5a                   	pop    %edx
8010774c:	6a 06                	push   $0x6
8010774e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107753:	31 d2                	xor    %edx,%edx
80107755:	50                   	push   %eax
80107756:	89 f8                	mov    %edi,%eax
80107758:	e8 13 fd ff ff       	call   80107470 <mappages>
  memmove(mem, init, sz);
8010775d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107760:	89 75 10             	mov    %esi,0x10(%ebp)
80107763:	83 c4 10             	add    $0x10,%esp
80107766:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107769:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010776c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010776f:	5b                   	pop    %ebx
80107770:	5e                   	pop    %esi
80107771:	5f                   	pop    %edi
80107772:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107773:	e9 78 d2 ff ff       	jmp    801049f0 <memmove>
    panic("inituvm: more than a page");
80107778:	83 ec 0c             	sub    $0xc,%esp
8010777b:	68 99 8a 10 80       	push   $0x80108a99
80107780:	e8 fb 8b ff ff       	call   80100380 <panic>
80107785:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010778c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107790 <loaduvm>:
{
80107790:	55                   	push   %ebp
80107791:	89 e5                	mov    %esp,%ebp
80107793:	57                   	push   %edi
80107794:	56                   	push   %esi
80107795:	53                   	push   %ebx
80107796:	83 ec 1c             	sub    $0x1c,%esp
80107799:	8b 45 0c             	mov    0xc(%ebp),%eax
8010779c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010779f:	a9 ff 0f 00 00       	test   $0xfff,%eax
801077a4:	0f 85 bb 00 00 00    	jne    80107865 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801077aa:	01 f0                	add    %esi,%eax
801077ac:	89 f3                	mov    %esi,%ebx
801077ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077b1:	8b 45 14             	mov    0x14(%ebp),%eax
801077b4:	01 f0                	add    %esi,%eax
801077b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801077b9:	85 f6                	test   %esi,%esi
801077bb:	0f 84 87 00 00 00    	je     80107848 <loaduvm+0xb8>
801077c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801077c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801077cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801077ce:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
801077d0:	89 c2                	mov    %eax,%edx
801077d2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801077d5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801077d8:	f6 c2 01             	test   $0x1,%dl
801077db:	75 13                	jne    801077f0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801077dd:	83 ec 0c             	sub    $0xc,%esp
801077e0:	68 b3 8a 10 80       	push   $0x80108ab3
801077e5:	e8 96 8b ff ff       	call   80100380 <panic>
801077ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801077f0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077f3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801077f9:	25 fc 0f 00 00       	and    $0xffc,%eax
801077fe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107805:	85 c0                	test   %eax,%eax
80107807:	74 d4                	je     801077dd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107809:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010780b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010780e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107813:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107818:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010781e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107821:	29 d9                	sub    %ebx,%ecx
80107823:	05 00 00 00 80       	add    $0x80000000,%eax
80107828:	57                   	push   %edi
80107829:	51                   	push   %ecx
8010782a:	50                   	push   %eax
8010782b:	ff 75 10             	push   0x10(%ebp)
8010782e:	e8 3d a2 ff ff       	call   80101a70 <readi>
80107833:	83 c4 10             	add    $0x10,%esp
80107836:	39 f8                	cmp    %edi,%eax
80107838:	75 1e                	jne    80107858 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010783a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107840:	89 f0                	mov    %esi,%eax
80107842:	29 d8                	sub    %ebx,%eax
80107844:	39 c6                	cmp    %eax,%esi
80107846:	77 80                	ja     801077c8 <loaduvm+0x38>
}
80107848:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010784b:	31 c0                	xor    %eax,%eax
}
8010784d:	5b                   	pop    %ebx
8010784e:	5e                   	pop    %esi
8010784f:	5f                   	pop    %edi
80107850:	5d                   	pop    %ebp
80107851:	c3                   	ret    
80107852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107858:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010785b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107860:	5b                   	pop    %ebx
80107861:	5e                   	pop    %esi
80107862:	5f                   	pop    %edi
80107863:	5d                   	pop    %ebp
80107864:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107865:	83 ec 0c             	sub    $0xc,%esp
80107868:	68 5c 8b 10 80       	push   $0x80108b5c
8010786d:	e8 0e 8b ff ff       	call   80100380 <panic>
80107872:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107880 <allocuvm>:
{
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107889:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010788c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010788f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107892:	85 c0                	test   %eax,%eax
80107894:	0f 88 b6 00 00 00    	js     80107950 <allocuvm+0xd0>
  if(newsz < oldsz)
8010789a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010789d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801078a0:	0f 82 9a 00 00 00    	jb     80107940 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801078a6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801078ac:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801078b2:	39 75 10             	cmp    %esi,0x10(%ebp)
801078b5:	77 44                	ja     801078fb <allocuvm+0x7b>
801078b7:	e9 87 00 00 00       	jmp    80107943 <allocuvm+0xc3>
801078bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801078c0:	83 ec 04             	sub    $0x4,%esp
801078c3:	68 00 10 00 00       	push   $0x1000
801078c8:	6a 00                	push   $0x0
801078ca:	50                   	push   %eax
801078cb:	e8 80 d0 ff ff       	call   80104950 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801078d0:	58                   	pop    %eax
801078d1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801078d7:	5a                   	pop    %edx
801078d8:	6a 06                	push   $0x6
801078da:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078df:	89 f2                	mov    %esi,%edx
801078e1:	50                   	push   %eax
801078e2:	89 f8                	mov    %edi,%eax
801078e4:	e8 87 fb ff ff       	call   80107470 <mappages>
801078e9:	83 c4 10             	add    $0x10,%esp
801078ec:	85 c0                	test   %eax,%eax
801078ee:	78 78                	js     80107968 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801078f0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801078f6:	39 75 10             	cmp    %esi,0x10(%ebp)
801078f9:	76 48                	jbe    80107943 <allocuvm+0xc3>
    mem = kalloc();
801078fb:	e8 60 ad ff ff       	call   80102660 <kalloc>
80107900:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107902:	85 c0                	test   %eax,%eax
80107904:	75 ba                	jne    801078c0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107906:	83 ec 0c             	sub    $0xc,%esp
80107909:	68 d1 8a 10 80       	push   $0x80108ad1
8010790e:	e8 8d 8d ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107913:	8b 45 0c             	mov    0xc(%ebp),%eax
80107916:	83 c4 10             	add    $0x10,%esp
80107919:	39 45 10             	cmp    %eax,0x10(%ebp)
8010791c:	74 32                	je     80107950 <allocuvm+0xd0>
8010791e:	8b 55 10             	mov    0x10(%ebp),%edx
80107921:	89 c1                	mov    %eax,%ecx
80107923:	89 f8                	mov    %edi,%eax
80107925:	e8 96 fa ff ff       	call   801073c0 <deallocuvm.part.0>
      return 0;
8010792a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107931:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107934:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107937:	5b                   	pop    %ebx
80107938:	5e                   	pop    %esi
80107939:	5f                   	pop    %edi
8010793a:	5d                   	pop    %ebp
8010793b:	c3                   	ret    
8010793c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107940:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107943:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107946:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107949:	5b                   	pop    %ebx
8010794a:	5e                   	pop    %esi
8010794b:	5f                   	pop    %edi
8010794c:	5d                   	pop    %ebp
8010794d:	c3                   	ret    
8010794e:	66 90                	xchg   %ax,%ax
    return 0;
80107950:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107957:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010795a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010795d:	5b                   	pop    %ebx
8010795e:	5e                   	pop    %esi
8010795f:	5f                   	pop    %edi
80107960:	5d                   	pop    %ebp
80107961:	c3                   	ret    
80107962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107968:	83 ec 0c             	sub    $0xc,%esp
8010796b:	68 e9 8a 10 80       	push   $0x80108ae9
80107970:	e8 2b 8d ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107975:	8b 45 0c             	mov    0xc(%ebp),%eax
80107978:	83 c4 10             	add    $0x10,%esp
8010797b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010797e:	74 0c                	je     8010798c <allocuvm+0x10c>
80107980:	8b 55 10             	mov    0x10(%ebp),%edx
80107983:	89 c1                	mov    %eax,%ecx
80107985:	89 f8                	mov    %edi,%eax
80107987:	e8 34 fa ff ff       	call   801073c0 <deallocuvm.part.0>
      kfree(mem);
8010798c:	83 ec 0c             	sub    $0xc,%esp
8010798f:	53                   	push   %ebx
80107990:	e8 0b ab ff ff       	call   801024a0 <kfree>
      return 0;
80107995:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010799c:	83 c4 10             	add    $0x10,%esp
}
8010799f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801079a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079a5:	5b                   	pop    %ebx
801079a6:	5e                   	pop    %esi
801079a7:	5f                   	pop    %edi
801079a8:	5d                   	pop    %ebp
801079a9:	c3                   	ret    
801079aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801079b0 <deallocuvm>:
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801079b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801079b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801079bc:	39 d1                	cmp    %edx,%ecx
801079be:	73 10                	jae    801079d0 <deallocuvm+0x20>
}
801079c0:	5d                   	pop    %ebp
801079c1:	e9 fa f9 ff ff       	jmp    801073c0 <deallocuvm.part.0>
801079c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079cd:	8d 76 00             	lea    0x0(%esi),%esi
801079d0:	89 d0                	mov    %edx,%eax
801079d2:	5d                   	pop    %ebp
801079d3:	c3                   	ret    
801079d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801079df:	90                   	nop

801079e0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801079e0:	55                   	push   %ebp
801079e1:	89 e5                	mov    %esp,%ebp
801079e3:	57                   	push   %edi
801079e4:	56                   	push   %esi
801079e5:	53                   	push   %ebx
801079e6:	83 ec 0c             	sub    $0xc,%esp
801079e9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801079ec:	85 f6                	test   %esi,%esi
801079ee:	74 59                	je     80107a49 <freevm+0x69>
  if(newsz >= oldsz)
801079f0:	31 c9                	xor    %ecx,%ecx
801079f2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801079f7:	89 f0                	mov    %esi,%eax
801079f9:	89 f3                	mov    %esi,%ebx
801079fb:	e8 c0 f9 ff ff       	call   801073c0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107a00:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107a06:	eb 0f                	jmp    80107a17 <freevm+0x37>
80107a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a0f:	90                   	nop
80107a10:	83 c3 04             	add    $0x4,%ebx
80107a13:	39 df                	cmp    %ebx,%edi
80107a15:	74 23                	je     80107a3a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107a17:	8b 03                	mov    (%ebx),%eax
80107a19:	a8 01                	test   $0x1,%al
80107a1b:	74 f3                	je     80107a10 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107a1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107a22:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107a25:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107a28:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107a2d:	50                   	push   %eax
80107a2e:	e8 6d aa ff ff       	call   801024a0 <kfree>
80107a33:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107a36:	39 df                	cmp    %ebx,%edi
80107a38:	75 dd                	jne    80107a17 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107a3a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107a3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a40:	5b                   	pop    %ebx
80107a41:	5e                   	pop    %esi
80107a42:	5f                   	pop    %edi
80107a43:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107a44:	e9 57 aa ff ff       	jmp    801024a0 <kfree>
    panic("freevm: no pgdir");
80107a49:	83 ec 0c             	sub    $0xc,%esp
80107a4c:	68 05 8b 10 80       	push   $0x80108b05
80107a51:	e8 2a 89 ff ff       	call   80100380 <panic>
80107a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a5d:	8d 76 00             	lea    0x0(%esi),%esi

80107a60 <setupkvm>:
{
80107a60:	55                   	push   %ebp
80107a61:	89 e5                	mov    %esp,%ebp
80107a63:	56                   	push   %esi
80107a64:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107a65:	e8 f6 ab ff ff       	call   80102660 <kalloc>
80107a6a:	89 c6                	mov    %eax,%esi
80107a6c:	85 c0                	test   %eax,%eax
80107a6e:	74 42                	je     80107ab2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107a70:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a73:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107a78:	68 00 10 00 00       	push   $0x1000
80107a7d:	6a 00                	push   $0x0
80107a7f:	50                   	push   %eax
80107a80:	e8 cb ce ff ff       	call   80104950 <memset>
80107a85:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107a88:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a8b:	83 ec 08             	sub    $0x8,%esp
80107a8e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107a91:	ff 73 0c             	push   0xc(%ebx)
80107a94:	8b 13                	mov    (%ebx),%edx
80107a96:	50                   	push   %eax
80107a97:	29 c1                	sub    %eax,%ecx
80107a99:	89 f0                	mov    %esi,%eax
80107a9b:	e8 d0 f9 ff ff       	call   80107470 <mappages>
80107aa0:	83 c4 10             	add    $0x10,%esp
80107aa3:	85 c0                	test   %eax,%eax
80107aa5:	78 19                	js     80107ac0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107aa7:	83 c3 10             	add    $0x10,%ebx
80107aaa:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107ab0:	75 d6                	jne    80107a88 <setupkvm+0x28>
}
80107ab2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ab5:	89 f0                	mov    %esi,%eax
80107ab7:	5b                   	pop    %ebx
80107ab8:	5e                   	pop    %esi
80107ab9:	5d                   	pop    %ebp
80107aba:	c3                   	ret    
80107abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107abf:	90                   	nop
      freevm(pgdir);
80107ac0:	83 ec 0c             	sub    $0xc,%esp
80107ac3:	56                   	push   %esi
      return 0;
80107ac4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107ac6:	e8 15 ff ff ff       	call   801079e0 <freevm>
      return 0;
80107acb:	83 c4 10             	add    $0x10,%esp
}
80107ace:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ad1:	89 f0                	mov    %esi,%eax
80107ad3:	5b                   	pop    %ebx
80107ad4:	5e                   	pop    %esi
80107ad5:	5d                   	pop    %ebp
80107ad6:	c3                   	ret    
80107ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ade:	66 90                	xchg   %ax,%ax

80107ae0 <kvmalloc>:
{
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107ae6:	e8 75 ff ff ff       	call   80107a60 <setupkvm>
80107aeb:	a3 c4 5a 11 80       	mov    %eax,0x80115ac4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107af0:	05 00 00 00 80       	add    $0x80000000,%eax
80107af5:	0f 22 d8             	mov    %eax,%cr3
}
80107af8:	c9                   	leave  
80107af9:	c3                   	ret    
80107afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b00 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107b00:	55                   	push   %ebp
80107b01:	89 e5                	mov    %esp,%ebp
80107b03:	83 ec 08             	sub    $0x8,%esp
80107b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107b09:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107b0c:	89 c1                	mov    %eax,%ecx
80107b0e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107b11:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107b14:	f6 c2 01             	test   $0x1,%dl
80107b17:	75 17                	jne    80107b30 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107b19:	83 ec 0c             	sub    $0xc,%esp
80107b1c:	68 16 8b 10 80       	push   $0x80108b16
80107b21:	e8 5a 88 ff ff       	call   80100380 <panic>
80107b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b2d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107b30:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b33:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107b39:	25 fc 0f 00 00       	and    $0xffc,%eax
80107b3e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107b45:	85 c0                	test   %eax,%eax
80107b47:	74 d0                	je     80107b19 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107b49:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107b4c:	c9                   	leave  
80107b4d:	c3                   	ret    
80107b4e:	66 90                	xchg   %ax,%ax

80107b50 <setpteu>:

void setpteu(pde_t *pgdir, char *uva)
{
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	83 ec 08             	sub    $0x8,%esp
80107b56:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107b59:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107b5c:	89 c1                	mov    %eax,%ecx
80107b5e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107b61:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107b64:	f6 c2 01             	test   $0x1,%dl
80107b67:	75 17                	jne    80107b80 <setpteu+0x30>
	pte_t *pte;

	pte = walkpgdir(pgdir, uva, 0);
	if(pte == 0)
		panic("setpteu");
80107b69:	83 ec 0c             	sub    $0xc,%esp
80107b6c:	68 20 8b 10 80       	push   $0x80108b20
80107b71:	e8 0a 88 ff ff       	call   80100380 <panic>
80107b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b7d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107b80:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b83:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107b89:	25 fc 0f 00 00       	and    $0xffc,%eax
80107b8e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
	if(pte == 0)
80107b95:	85 c0                	test   %eax,%eax
80107b97:	74 d0                	je     80107b69 <setpteu+0x19>
	*pte |= PTE_U;
80107b99:	83 08 04             	orl    $0x4,(%eax)
}
80107b9c:	c9                   	leave  
80107b9d:	c3                   	ret    
80107b9e:	66 90                	xchg   %ax,%ax

80107ba0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz,uint stacktop)
{
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	57                   	push   %edi
80107ba4:	56                   	push   %esi
80107ba5:	53                   	push   %ebx
80107ba6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107ba9:	e8 b2 fe ff ff       	call   80107a60 <setupkvm>
80107bae:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107bb1:	85 c0                	test   %eax,%eax
80107bb3:	0f 84 7c 01 00 00    	je     80107d35 <copyuvm+0x195>
    return 0;
  for(i = PGSIZE; i < sz; i += PGSIZE){
80107bb9:	81 7d 0c 00 10 00 00 	cmpl   $0x1000,0xc(%ebp)
80107bc0:	0f 86 b8 00 00 00    	jbe    80107c7e <copyuvm+0xde>
80107bc6:	be 00 10 00 00       	mov    $0x1000,%esi
80107bcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bcf:	90                   	nop
  if(*pde & PTE_P){
80107bd0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107bd3:	89 f0                	mov    %esi,%eax
80107bd5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107bd8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107bdb:	a8 01                	test   $0x1,%al
80107bdd:	75 11                	jne    80107bf0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107bdf:	83 ec 0c             	sub    $0xc,%esp
80107be2:	68 28 8b 10 80       	push   $0x80108b28
80107be7:	e8 94 87 ff ff       	call   80100380 <panic>
80107bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107bf0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107bf2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107bf7:	c1 ea 0a             	shr    $0xa,%edx
80107bfa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107c00:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107c07:	85 c0                	test   %eax,%eax
80107c09:	74 d4                	je     80107bdf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107c0b:	8b 00                	mov    (%eax),%eax
80107c0d:	a8 01                	test   $0x1,%al
80107c0f:	0f 84 39 01 00 00    	je     80107d4e <copyuvm+0x1ae>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107c15:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107c17:	25 ff 0f 00 00       	and    $0xfff,%eax
80107c1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107c1f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107c25:	e8 36 aa ff ff       	call   80102660 <kalloc>
80107c2a:	89 c3                	mov    %eax,%ebx
80107c2c:	85 c0                	test   %eax,%eax
80107c2e:	0f 84 ec 00 00 00    	je     80107d20 <copyuvm+0x180>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107c34:	83 ec 04             	sub    $0x4,%esp
80107c37:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107c3d:	68 00 10 00 00       	push   $0x1000
80107c42:	57                   	push   %edi
80107c43:	50                   	push   %eax
80107c44:	e8 a7 cd ff ff       	call   801049f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107c49:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107c4f:	59                   	pop    %ecx
80107c50:	5f                   	pop    %edi
80107c51:	ff 75 e4             	push   -0x1c(%ebp)
80107c54:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107c59:	89 f2                	mov    %esi,%edx
80107c5b:	50                   	push   %eax
80107c5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c5f:	e8 0c f8 ff ff       	call   80107470 <mappages>
80107c64:	83 c4 10             	add    $0x10,%esp
80107c67:	85 c0                	test   %eax,%eax
80107c69:	0f 88 d1 00 00 00    	js     80107d40 <copyuvm+0x1a0>
  for(i = PGSIZE; i < sz; i += PGSIZE){
80107c6f:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107c75:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107c78:	0f 87 52 ff ff ff    	ja     80107bd0 <copyuvm+0x30>
      kfree(mem);
      goto bad;
    }
  }
if (stacktop == 0)
80107c7e:	8b 45 10             	mov    0x10(%ebp),%eax
80107c81:	83 e8 01             	sub    $0x1,%eax
80107c84:	3d fe df d4 0d       	cmp    $0xdd4dffe,%eax
80107c89:	0f 87 a6 00 00 00    	ja     80107d35 <copyuvm+0x195>
80107c8f:	8b 75 10             	mov    0x10(%ebp),%esi
80107c92:	eb 4d                	jmp    80107ce1 <copyuvm+0x141>
80107c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			panic("copyuvm: page not present");
		pa = PTE_ADDR(*pte);
		flags = PTE_FLAGS(*pte);
		if((mem = kalloc()) == 0)
			goto bad;
		memmove(mem, (char*)P2V(pa), PGSIZE);
80107c98:	83 ec 04             	sub    $0x4,%esp
80107c9b:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107ca1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ca4:	68 00 10 00 00       	push   $0x1000
80107ca9:	57                   	push   %edi
80107caa:	50                   	push   %eax
80107cab:	e8 40 cd ff ff       	call   801049f0 <memmove>
		if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107cb0:	58                   	pop    %eax
80107cb1:	5a                   	pop    %edx
80107cb2:	53                   	push   %ebx
80107cb3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107cb6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107cb9:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107cbe:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107cc4:	52                   	push   %edx
80107cc5:	89 f2                	mov    %esi,%edx
80107cc7:	e8 a4 f7 ff ff       	call   80107470 <mappages>
80107ccc:	83 c4 10             	add    $0x10,%esp
80107ccf:	85 c0                	test   %eax,%eax
80107cd1:	78 4d                	js     80107d20 <copyuvm+0x180>
	for(i = stacktop; i < USERTOP; i += PGSIZE){
80107cd3:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107cd9:	81 fe ff df d4 0d    	cmp    $0xdd4dfff,%esi
80107cdf:	77 54                	ja     80107d35 <copyuvm+0x195>
		if((pte = walkpgdir(pgdir, (void *) i, 1)) == 0)
80107ce1:	8b 45 08             	mov    0x8(%ebp),%eax
80107ce4:	b9 01 00 00 00       	mov    $0x1,%ecx
80107ce9:	89 f2                	mov    %esi,%edx
80107ceb:	e8 50 f6 ff ff       	call   80107340 <walkpgdir>
80107cf0:	85 c0                	test   %eax,%eax
80107cf2:	0f 84 e7 fe ff ff    	je     80107bdf <copyuvm+0x3f>
  		if(!(*pte & PTE_P))
80107cf8:	8b 18                	mov    (%eax),%ebx
80107cfa:	f6 c3 01             	test   $0x1,%bl
80107cfd:	74 4f                	je     80107d4e <copyuvm+0x1ae>
		pa = PTE_ADDR(*pte);
80107cff:	89 df                	mov    %ebx,%edi
		flags = PTE_FLAGS(*pte);
80107d01:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
		pa = PTE_ADDR(*pte);
80107d07:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
		if((mem = kalloc()) == 0)
80107d0d:	e8 4e a9 ff ff       	call   80102660 <kalloc>
80107d12:	85 c0                	test   %eax,%eax
80107d14:	75 82                	jne    80107c98 <copyuvm+0xf8>
80107d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d1d:	8d 76 00             	lea    0x0(%esi),%esi
			goto bad;
 	}
  return d;

bad:
  freevm(d);
80107d20:	83 ec 0c             	sub    $0xc,%esp
80107d23:	ff 75 e0             	push   -0x20(%ebp)
80107d26:	e8 b5 fc ff ff       	call   801079e0 <freevm>
  return 0;
80107d2b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107d32:	83 c4 10             	add    $0x10,%esp
}
80107d35:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d3b:	5b                   	pop    %ebx
80107d3c:	5e                   	pop    %esi
80107d3d:	5f                   	pop    %edi
80107d3e:	5d                   	pop    %ebp
80107d3f:	c3                   	ret    
      kfree(mem);
80107d40:	83 ec 0c             	sub    $0xc,%esp
80107d43:	53                   	push   %ebx
80107d44:	e8 57 a7 ff ff       	call   801024a0 <kfree>
      goto bad;
80107d49:	83 c4 10             	add    $0x10,%esp
80107d4c:	eb d2                	jmp    80107d20 <copyuvm+0x180>
      panic("copyuvm: page not present");
80107d4e:	83 ec 0c             	sub    $0xc,%esp
80107d51:	68 42 8b 10 80       	push   $0x80108b42
80107d56:	e8 25 86 ff ff       	call   80100380 <panic>
80107d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107d5f:	90                   	nop

80107d60 <growstack>:

int growstack(pde_t *pgdir, uint sp, uint stacktop)
{
80107d60:	55                   	push   %ebp
80107d61:	89 e5                	mov    %esp,%ebp
80107d63:	57                   	push   %edi
80107d64:	56                   	push   %esi
80107d65:	53                   	push   %ebx
80107d66:	83 ec 0c             	sub    $0xc,%esp
80107d69:	8b 5d 10             	mov    0x10(%ebp),%ebx
80107d6c:	8b 75 08             	mov    0x8(%ebp),%esi
	pte_t *pte;
	uint newTop = stacktop - PGSIZE;

	if (sp > (stacktop + PGSIZE))
80107d6f:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
80107d75:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107d78:	0f 82 02 01 00 00    	jb     80107e80 <growstack+0x120>
80107d7e:	8d bb 00 f0 ff ff    	lea    -0x1000(%ebx),%edi
		return -1;


	// don't allocate new memory if already present
	if((pte = walkpgdir(pgdir, (void *) newTop, 1)) == 0)
80107d84:	b9 01 00 00 00       	mov    $0x1,%ecx
80107d89:	89 f0                	mov    %esi,%eax
80107d8b:	89 fa                	mov    %edi,%edx
80107d8d:	e8 ae f5 ff ff       	call   80107340 <walkpgdir>
80107d92:	85 c0                	test   %eax,%eax
80107d94:	0f 84 e6 00 00 00    	je     80107e80 <growstack+0x120>
		return -1;
	if(*pte & PTE_P)
80107d9a:	f6 00 01             	testb  $0x1,(%eax)
80107d9d:	0f 85 dd 00 00 00    	jne    80107e80 <growstack+0x120>
		return -1;
	if(allocuvm(pgdir, newTop, stacktop) == 0)	
80107da3:	83 ec 04             	sub    $0x4,%esp
80107da6:	53                   	push   %ebx
80107da7:	57                   	push   %edi
80107da8:	56                   	push   %esi
80107da9:	e8 d2 fa ff ff       	call   80107880 <allocuvm>
80107dae:	83 c4 10             	add    $0x10,%esp
80107db1:	85 c0                	test   %eax,%eax
80107db3:	0f 84 c7 00 00 00    	je     80107e80 <growstack+0x120>
		return -1;

	myproc()->stacktop = myproc()->stacktop - PGSIZE;
80107db9:	e8 32 bc ff ff       	call   801039f0 <myproc>
80107dbe:	8b 98 8c 00 00 00    	mov    0x8c(%eax),%ebx
80107dc4:	e8 27 bc ff ff       	call   801039f0 <myproc>
80107dc9:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107dcf:	89 98 8c 00 00 00    	mov    %ebx,0x8c(%eax)
	setpteu(myproc()->pgdir, (char *)(myproc()->stacktop + PGSIZE));
80107dd5:	e8 16 bc ff ff       	call   801039f0 <myproc>
80107dda:	8b 98 8c 00 00 00    	mov    0x8c(%eax),%ebx
80107de0:	e8 0b bc ff ff       	call   801039f0 <myproc>
80107de5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  if(*pde & PTE_P){
80107deb:	8b 40 04             	mov    0x4(%eax),%eax
  pde = &pgdir[PDX(va)];
80107dee:	89 da                	mov    %ebx,%edx
80107df0:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107df3:	8b 04 90             	mov    (%eax,%edx,4),%eax
80107df6:	a8 01                	test   $0x1,%al
80107df8:	0f 84 89 00 00 00    	je     80107e87 <growstack+0x127>
  return &pgtab[PTX(va)];
80107dfe:	c1 eb 0a             	shr    $0xa,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e01:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107e06:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80107e0c:	8d 84 18 00 00 00 80 	lea    -0x80000000(%eax,%ebx,1),%eax
	if(pte == 0)
80107e13:	85 c0                	test   %eax,%eax
80107e15:	74 70                	je     80107e87 <growstack+0x127>
	*pte |= PTE_U;
80107e17:	83 08 04             	orl    $0x4,(%eax)
	clearpteu(myproc()->pgdir, (char *)myproc()->stacktop);
80107e1a:	e8 d1 bb ff ff       	call   801039f0 <myproc>
80107e1f:	8b 98 8c 00 00 00    	mov    0x8c(%eax),%ebx
80107e25:	e8 c6 bb ff ff       	call   801039f0 <myproc>
  if(*pde & PTE_P){
80107e2a:	8b 40 04             	mov    0x4(%eax),%eax
  pde = &pgdir[PDX(va)];
80107e2d:	89 da                	mov    %ebx,%edx
80107e2f:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107e32:	8b 04 90             	mov    (%eax,%edx,4),%eax
80107e35:	a8 01                	test   $0x1,%al
80107e37:	75 17                	jne    80107e50 <growstack+0xf0>
    panic("clearpteu");
80107e39:	83 ec 0c             	sub    $0xc,%esp
80107e3c:	68 16 8b 10 80       	push   $0x80108b16
80107e41:	e8 3a 85 ff ff       	call   80100380 <panic>
80107e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e4d:	8d 76 00             	lea    0x0(%esi),%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e55:	89 c2                	mov    %eax,%edx
  return &pgtab[PTX(va)];
80107e57:	89 d8                	mov    %ebx,%eax
80107e59:	c1 e8 0a             	shr    $0xa,%eax
80107e5c:	25 fc 0f 00 00       	and    $0xffc,%eax
80107e61:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107e68:	85 c0                	test   %eax,%eax
80107e6a:	74 cd                	je     80107e39 <growstack+0xd9>
  *pte &= ~PTE_U;
80107e6c:	83 20 fb             	andl   $0xfffffffb,(%eax)
	return 0;
80107e6f:	31 c0                	xor    %eax,%eax
}
80107e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e74:	5b                   	pop    %ebx
80107e75:	5e                   	pop    %esi
80107e76:	5f                   	pop    %edi
80107e77:	5d                   	pop    %ebp
80107e78:	c3                   	ret    
80107e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return -1;
80107e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e85:	eb ea                	jmp    80107e71 <growstack+0x111>
		panic("setpteu");
80107e87:	83 ec 0c             	sub    $0xc,%esp
80107e8a:	68 20 8b 10 80       	push   $0x80108b20
80107e8f:	e8 ec 84 ff ff       	call   80100380 <panic>
80107e94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e9f:	90                   	nop

80107ea0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107ea0:	55                   	push   %ebp
80107ea1:	89 e5                	mov    %esp,%ebp
80107ea3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107ea6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107ea9:	89 c1                	mov    %eax,%ecx
80107eab:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107eae:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107eb1:	f6 c2 01             	test   $0x1,%dl
80107eb4:	0f 84 00 01 00 00    	je     80107fba <uva2ka.cold>
  return &pgtab[PTX(va)];
80107eba:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ebd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107ec3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107ec4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107ec9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107ed0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ed2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107ed7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107eda:	05 00 00 00 80       	add    $0x80000000,%eax
80107edf:	83 fa 05             	cmp    $0x5,%edx
80107ee2:	ba 00 00 00 00       	mov    $0x0,%edx
80107ee7:	0f 45 c2             	cmovne %edx,%eax
}
80107eea:	c3                   	ret    
80107eeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107eef:	90                   	nop

80107ef0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	57                   	push   %edi
80107ef4:	56                   	push   %esi
80107ef5:	53                   	push   %ebx
80107ef6:	83 ec 0c             	sub    $0xc,%esp
80107ef9:	8b 75 14             	mov    0x14(%ebp),%esi
80107efc:	8b 45 0c             	mov    0xc(%ebp),%eax
80107eff:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107f02:	85 f6                	test   %esi,%esi
80107f04:	75 51                	jne    80107f57 <copyout+0x67>
80107f06:	e9 a5 00 00 00       	jmp    80107fb0 <copyout+0xc0>
80107f0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107f0f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107f10:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107f16:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107f1c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107f22:	74 75                	je     80107f99 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107f24:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107f26:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107f29:	29 c3                	sub    %eax,%ebx
80107f2b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f31:	39 f3                	cmp    %esi,%ebx
80107f33:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107f36:	29 f8                	sub    %edi,%eax
80107f38:	83 ec 04             	sub    $0x4,%esp
80107f3b:	01 c1                	add    %eax,%ecx
80107f3d:	53                   	push   %ebx
80107f3e:	52                   	push   %edx
80107f3f:	51                   	push   %ecx
80107f40:	e8 ab ca ff ff       	call   801049f0 <memmove>
    len -= n;
    buf += n;
80107f45:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107f48:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107f4e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107f51:	01 da                	add    %ebx,%edx
  while(len > 0){
80107f53:	29 de                	sub    %ebx,%esi
80107f55:	74 59                	je     80107fb0 <copyout+0xc0>
  if(*pde & PTE_P){
80107f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107f5a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107f5c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107f5e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107f61:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107f67:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107f6a:	f6 c1 01             	test   $0x1,%cl
80107f6d:	0f 84 4e 00 00 00    	je     80107fc1 <copyout.cold>
  return &pgtab[PTX(va)];
80107f73:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107f75:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107f7b:	c1 eb 0c             	shr    $0xc,%ebx
80107f7e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107f84:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107f8b:	89 d9                	mov    %ebx,%ecx
80107f8d:	83 e1 05             	and    $0x5,%ecx
80107f90:	83 f9 05             	cmp    $0x5,%ecx
80107f93:	0f 84 77 ff ff ff    	je     80107f10 <copyout+0x20>
  }
  return 0;
}
80107f99:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107f9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107fa1:	5b                   	pop    %ebx
80107fa2:	5e                   	pop    %esi
80107fa3:	5f                   	pop    %edi
80107fa4:	5d                   	pop    %ebp
80107fa5:	c3                   	ret    
80107fa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fad:	8d 76 00             	lea    0x0(%esi),%esi
80107fb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107fb3:	31 c0                	xor    %eax,%eax
}
80107fb5:	5b                   	pop    %ebx
80107fb6:	5e                   	pop    %esi
80107fb7:	5f                   	pop    %edi
80107fb8:	5d                   	pop    %ebp
80107fb9:	c3                   	ret    

80107fba <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107fba:	a1 00 00 00 00       	mov    0x0,%eax
80107fbf:	0f 0b                	ud2    

80107fc1 <copyout.cold>:
80107fc1:	a1 00 00 00 00       	mov    0x0,%eax
80107fc6:	0f 0b                	ud2    
