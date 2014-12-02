
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
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200007:	cd 33                	int    $0x33
  200009:	30 c0                	xor    %al,%al
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  20000b:	ba 01 00 00 00       	mov    $0x1,%edx
  200010:	87 15 04 80 01 00    	xchg   %edx,0x18004
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
                while (atomic_swap(&lock, 1) != 0)
  200016:	85 d2                	test   %edx,%edx
  200018:	75 f1                	jne    20000b <start+0xb>
                   continue;
		*cursorpos++ = PRINTCHAR;
  20001a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  200020:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  200025:	83 c2 02             	add    $0x2,%edx
  200028:	89 15 00 80 19 00    	mov    %edx,0x198000
  20002e:	31 d2                	xor    %edx,%edx
  200030:	87 15 04 80 01 00    	xchg   %edx,0x18004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200036:	cd 30                	int    $0x30
{
	int i;
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
  200038:	40                   	inc    %eax
  200039:	3d 40 01 00 00       	cmp    $0x140,%eax
  20003e:	75 cb                	jne    20000b <start+0xb>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200040:	66 31 c0             	xor    %ax,%ax
  200043:	cd 31                	int    $0x31
  200045:	eb fe                	jmp    200045 <start+0x45>
