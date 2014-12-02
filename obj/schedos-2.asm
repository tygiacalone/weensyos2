
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
  30000b:	31 d2                	xor    %edx,%edx
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  30000d:	b8 32 0a 00 00       	mov    $0xa32,%eax
  300012:	cd 34                	int    $0x34
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300014:	cd 30                	int    $0x30
{
	int i;
        sys_set_priority(PRIORITY);
        sys_set_share(SHARE);

	for (i = 0; i < RUNCOUNT; i++) {
  300016:	42                   	inc    %edx
  300017:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  30001d:	75 f3                	jne    300012 <start+0x12>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  30001f:	31 c0                	xor    %eax,%eax
  300021:	cd 31                	int    $0x31
  300023:	eb fe                	jmp    300023 <start+0x23>
