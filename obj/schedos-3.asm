
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
  40000b:	31 d2                	xor    %edx,%edx
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  40000d:	b8 33 09 00 00       	mov    $0x933,%eax
  400012:	cd 34                	int    $0x34
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400014:	cd 30                	int    $0x30
{
	int i;
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
  400016:	42                   	inc    %edx
  400017:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  40001d:	75 f3                	jne    400012 <start+0x12>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  40001f:	31 c0                	xor    %eax,%eax
  400021:	cd 31                	int    $0x31
  400023:	eb fe                	jmp    400023 <start+0x23>
