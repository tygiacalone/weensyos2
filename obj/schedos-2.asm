
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300000:	b8 02 00 00 00       	mov    $0x2,%eax
  300005:	cd 32                	int    $0x32
  300007:	30 c0                	xor    %al,%al
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  300009:	ba 01 00 00 00       	mov    $0x1,%edx
  30000e:	87 15 04 80 01 00    	xchg   %edx,0x18004
	int i;
        sys_set_priority(PRIORITY);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
                while (atomic_swap(&lock, 1) != 0)
  300014:	85 d2                	test   %edx,%edx
  300016:	75 f1                	jne    300009 <start+0x9>
                   continue;
		*cursorpos++ = PRINTCHAR;
  300018:	8b 15 00 80 19 00    	mov    0x198000,%edx
  30001e:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  300023:	83 c2 02             	add    $0x2,%edx
  300026:	89 15 00 80 19 00    	mov    %edx,0x198000
  30002c:	31 d2                	xor    %edx,%edx
  30002e:	87 15 04 80 01 00    	xchg   %edx,0x18004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300034:	cd 30                	int    $0x30
start(void)
{
	int i;
        sys_set_priority(PRIORITY);

	for (i = 0; i < RUNCOUNT; i++) {
  300036:	40                   	inc    %eax
  300037:	3d 40 01 00 00       	cmp    $0x140,%eax
  30003c:	75 cb                	jne    300009 <start+0x9>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  30003e:	66 31 c0             	xor    %ax,%ax
  300041:	cd 31                	int    $0x31
  300043:	eb fe                	jmp    300043 <start+0x43>
