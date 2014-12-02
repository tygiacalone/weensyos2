
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
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300007:	b0 04                	mov    $0x4,%al
  300009:	cd 33                	int    $0x33
  30000b:	30 c0                	xor    %al,%al
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  30000d:	ba 01 00 00 00       	mov    $0x1,%edx
  300012:	87 15 04 80 01 00    	xchg   %edx,0x18004
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
                while (atomic_swap(&lock, 1) != 0)
  300018:	85 d2                	test   %edx,%edx
  30001a:	75 f1                	jne    30000d <start+0xd>
                   continue;
		*cursorpos++ = PRINTCHAR;
  30001c:	8b 15 00 80 19 00    	mov    0x198000,%edx
  300022:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  300027:	83 c2 02             	add    $0x2,%edx
  30002a:	89 15 00 80 19 00    	mov    %edx,0x198000
  300030:	31 d2                	xor    %edx,%edx
  300032:	87 15 04 80 01 00    	xchg   %edx,0x18004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300038:	cd 30                	int    $0x30
{
	int i;
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
  30003a:	40                   	inc    %eax
  30003b:	3d 40 01 00 00       	cmp    $0x140,%eax
  300040:	75 cb                	jne    30000d <start+0xd>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300042:	66 31 c0             	xor    %ax,%ax
  300045:	cd 31                	int    $0x31
  300047:	eb fe                	jmp    300047 <start+0x47>
