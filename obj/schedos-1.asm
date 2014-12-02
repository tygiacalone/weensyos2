
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200000:	b8 01 00 00 00       	mov    $0x1,%eax
  200005:	cd 32                	int    $0x32
  200007:	30 c0                	xor    %al,%al
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  200009:	ba 01 00 00 00       	mov    $0x1,%edx
  20000e:	87 15 04 80 01 00    	xchg   %edx,0x18004
	int i;
        sys_set_priority(PRIORITY);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
                while (atomic_swap(&lock, 1) != 0)
  200014:	85 d2                	test   %edx,%edx
  200016:	75 f1                	jne    200009 <start+0x9>
                   continue;
		*cursorpos++ = PRINTCHAR;
  200018:	8b 15 00 80 19 00    	mov    0x198000,%edx
  20001e:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  200023:	83 c2 02             	add    $0x2,%edx
  200026:	89 15 00 80 19 00    	mov    %edx,0x198000
  20002c:	31 d2                	xor    %edx,%edx
  20002e:	87 15 04 80 01 00    	xchg   %edx,0x18004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200034:	cd 30                	int    $0x30
start(void)
{
	int i;
        sys_set_priority(PRIORITY);

	for (i = 0; i < RUNCOUNT; i++) {
  200036:	40                   	inc    %eax
  200037:	3d 40 01 00 00       	cmp    $0x140,%eax
  20003c:	75 cb                	jne    200009 <start+0x9>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  20003e:	66 31 c0             	xor    %ax,%ax
  200041:	cd 31                	int    $0x31
  200043:	eb fe                	jmp    200043 <start+0x43>
