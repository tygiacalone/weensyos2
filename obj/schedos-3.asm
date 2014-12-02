
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400000:	b8 02 00 00 00       	mov    $0x2,%eax
  400005:	cd 32                	int    $0x32
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400007:	30 c0                	xor    %al,%al
  400009:	cd 33                	int    $0x33
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  40000b:	ba 01 00 00 00       	mov    $0x1,%edx
  400010:	87 15 04 80 01 00    	xchg   %edx,0x18004
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
                while (atomic_swap(&lock, 1) != 0)
  400016:	85 d2                	test   %edx,%edx
  400018:	75 f1                	jne    40000b <start+0xb>
                   continue;
		*cursorpos++ = PRINTCHAR;
  40001a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  400020:	66 c7 02 33 09       	movw   $0x933,(%edx)
  400025:	83 c2 02             	add    $0x2,%edx
  400028:	89 15 00 80 19 00    	mov    %edx,0x198000
  40002e:	31 d2                	xor    %edx,%edx
  400030:	87 15 04 80 01 00    	xchg   %edx,0x18004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400036:	cd 30                	int    $0x30
{
	int i;
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
  400038:	40                   	inc    %eax
  400039:	3d 40 01 00 00       	cmp    $0x140,%eax
  40003e:	75 cb                	jne    40000b <start+0xb>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400040:	66 31 c0             	xor    %ax,%ax
  400043:	cd 31                	int    $0x31
  400045:	eb fe                	jmp    400045 <start+0x45>
