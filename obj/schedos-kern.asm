
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 98 01 00 00       	call   1001b1 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 ce 00 00 00       	call   100140 <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	53                   	push   %ebx
  10009d:	83 ec 08             	sub    $0x8,%esp
	pid_t pid = current->p_pid;
  1000a0:	a1 dc 79 10 00       	mov    0x1079dc,%eax
  1000a5:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a7:	a1 e0 79 10 00       	mov    0x1079e0,%eax
  1000ac:	85 c0                	test   %eax,%eax
  1000ae:	75 1c                	jne    1000cc <schedule+0x30>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b0:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b5:	8d 42 01             	lea    0x1(%edx),%eax
  1000b8:	99                   	cltd   
  1000b9:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bb:	6b c2 50             	imul   $0x50,%edx,%eax
  1000be:	83 b8 2c 70 10 00 01 	cmpl   $0x1,0x10702c(%eax)
  1000c5:	75 ee                	jne    1000b5 <schedule+0x19>
				run(&proc_array[pid]);
  1000c7:	83 ec 0c             	sub    $0xc,%esp
  1000ca:	eb 69                	jmp    100135 <schedule+0x99>
		}

	if (scheduling_algorithm == 1)
  1000cc:	83 f8 01             	cmp    $0x1,%eax
  1000cf:	75 38                	jne    100109 <schedule+0x6d>

          while (1) {
                        // Run processes in order of schedos number.
                        for (i = 1; i < NPROCS; i++)
                        {
                          if (proc_array[i].p_state == P_RUNNABLE){
  1000d1:	83 3d 7c 70 10 00 01 	cmpl   $0x1,0x10707c
  1000d8:	8b 1d cc 70 10 00    	mov    0x1070cc,%ebx
  1000de:	8b 0d 1c 71 10 00    	mov    0x10711c,%ecx
  1000e4:	8b 15 6c 71 10 00    	mov    0x10716c,%edx
  1000ea:	74 43                	je     10012f <schedule+0x93>
  1000ec:	83 fb 01             	cmp    $0x1,%ebx
  1000ef:	75 07                	jne    1000f8 <schedule+0x5c>
  1000f1:	b8 02 00 00 00       	mov    $0x2,%eax
  1000f6:	eb 37                	jmp    10012f <schedule+0x93>
  1000f8:	83 f9 01             	cmp    $0x1,%ecx
  1000fb:	74 2d                	je     10012a <schedule+0x8e>
  1000fd:	83 fa 01             	cmp    $0x1,%edx
  100100:	75 ea                	jne    1000ec <schedule+0x50>
  100102:	b8 04 00 00 00       	mov    $0x4,%eax
  100107:	eb 26                	jmp    10012f <schedule+0x93>
				run(&proc_array[highest_priority_pid]);
		}
        }

	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100109:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10010f:	50                   	push   %eax
  100110:	68 84 0a 10 00       	push   $0x100a84
  100115:	68 00 01 00 00       	push   $0x100
  10011a:	52                   	push   %edx
  10011b:	e8 4a 09 00 00       	call   100a6a <console_printf>
  100120:	83 c4 10             	add    $0x10,%esp
  100123:	a3 00 80 19 00       	mov    %eax,0x198000
  100128:	eb fe                	jmp    100128 <schedule+0x8c>
  10012a:	b8 03 00 00 00       	mov    $0x3,%eax
                            break;
                          }
                        }
			// Run the selected process
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
  10012f:	6b c0 50             	imul   $0x50,%eax,%eax
  100132:	83 ec 0c             	sub    $0xc,%esp
  100135:	05 e4 6f 10 00       	add    $0x106fe4,%eax
  10013a:	50                   	push   %eax
  10013b:	e8 85 03 00 00       	call   1004c5 <run>

00100140 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100140:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100141:	a1 dc 79 10 00       	mov    0x1079dc,%eax
  100146:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10014b:	56                   	push   %esi
  10014c:	53                   	push   %ebx
  10014d:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100151:	8d 78 04             	lea    0x4(%eax),%edi
  100154:	89 de                	mov    %ebx,%esi
  100156:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100158:	8b 53 28             	mov    0x28(%ebx),%edx
  10015b:	83 fa 31             	cmp    $0x31,%edx
  10015e:	74 1f                	je     10017f <interrupt+0x3f>
  100160:	77 0c                	ja     10016e <interrupt+0x2e>
  100162:	83 fa 20             	cmp    $0x20,%edx
  100165:	74 43                	je     1001aa <interrupt+0x6a>
  100167:	83 fa 30             	cmp    $0x30,%edx
  10016a:	74 0e                	je     10017a <interrupt+0x3a>
  10016c:	eb 41                	jmp    1001af <interrupt+0x6f>
  10016e:	83 fa 32             	cmp    $0x32,%edx
  100171:	74 23                	je     100196 <interrupt+0x56>
  100173:	83 fa 33             	cmp    $0x33,%edx
  100176:	74 29                	je     1001a1 <interrupt+0x61>
  100178:	eb 35                	jmp    1001af <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  10017a:	e8 1d ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10017f:	a1 dc 79 10 00       	mov    0x1079dc,%eax
		current->p_exit_status = reg->reg_eax;
  100184:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100187:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10018e:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100191:	e8 06 ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  100196:	83 ec 0c             	sub    $0xc,%esp
  100199:	ff 35 dc 79 10 00    	pushl  0x1079dc
  10019f:	eb 04                	jmp    1001a5 <interrupt+0x65>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001a1:	83 ec 0c             	sub    $0xc,%esp
  1001a4:	50                   	push   %eax
  1001a5:	e8 1b 03 00 00       	call   1004c5 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001aa:	e8 ed fe ff ff       	call   10009c <schedule>
  1001af:	eb fe                	jmp    1001af <interrupt+0x6f>

001001b1 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001b1:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001b2:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001b7:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001b8:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001ba:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001bb:	bb 34 70 10 00       	mov    $0x107034,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001c0:	e8 df 00 00 00       	call   1002a4 <segments_init>
	interrupt_controller_init(0);
  1001c5:	83 ec 0c             	sub    $0xc,%esp
  1001c8:	6a 00                	push   $0x0
  1001ca:	e8 d0 01 00 00       	call   10039f <interrupt_controller_init>
	console_clear();
  1001cf:	e8 54 02 00 00       	call   100428 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001d4:	83 c4 0c             	add    $0xc,%esp
  1001d7:	68 90 01 00 00       	push   $0x190
  1001dc:	6a 00                	push   $0x0
  1001de:	68 e4 6f 10 00       	push   $0x106fe4
  1001e3:	e8 20 04 00 00       	call   100608 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001e8:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001eb:	c7 05 e4 6f 10 00 00 	movl   $0x0,0x106fe4
  1001f2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001f5:	c7 05 2c 70 10 00 00 	movl   $0x0,0x10702c
  1001fc:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001ff:	c7 05 34 70 10 00 01 	movl   $0x1,0x107034
  100206:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100209:	c7 05 7c 70 10 00 00 	movl   $0x0,0x10707c
  100210:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100213:	c7 05 84 70 10 00 02 	movl   $0x2,0x107084
  10021a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10021d:	c7 05 cc 70 10 00 00 	movl   $0x0,0x1070cc
  100224:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100227:	c7 05 d4 70 10 00 03 	movl   $0x3,0x1070d4
  10022e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100231:	c7 05 1c 71 10 00 00 	movl   $0x0,0x10711c
  100238:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10023b:	c7 05 24 71 10 00 04 	movl   $0x4,0x107124
  100242:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100245:	c7 05 6c 71 10 00 00 	movl   $0x0,0x10716c
  10024c:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10024f:	83 ec 0c             	sub    $0xc,%esp
  100252:	53                   	push   %ebx
  100253:	e8 84 02 00 00       	call   1004dc <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100258:	58                   	pop    %eax
  100259:	5a                   	pop    %edx
  10025a:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10025d:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100260:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100266:	50                   	push   %eax
  100267:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100268:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100269:	e8 aa 02 00 00       	call   100518 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10026e:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100271:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100278:	83 c3 50             	add    $0x50,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10027b:	83 fe 04             	cmp    $0x4,%esi
  10027e:	75 cf                	jne    10024f <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 1;

	// Switch to the first process.
	run(&proc_array[1]);
  100280:	83 ec 0c             	sub    $0xc,%esp
  100283:	68 34 70 10 00       	push   $0x107034
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100288:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10028f:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 1;
  100292:	c7 05 e0 79 10 00 01 	movl   $0x1,0x1079e0
  100299:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10029c:	e8 24 02 00 00       	call   1004c5 <run>
  1002a1:	90                   	nop
  1002a2:	90                   	nop
  1002a3:	90                   	nop

001002a4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002a4:	b8 74 71 10 00       	mov    $0x107174,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002a9:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ae:	89 c2                	mov    %eax,%edx
  1002b0:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002b3:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002b4:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002b9:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002bc:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002c2:	c1 e8 18             	shr    $0x18,%eax
  1002c5:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002cb:	ba dc 71 10 00       	mov    $0x1071dc,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002d0:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002d5:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002d7:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002de:	68 00 
  1002e0:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002e7:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002ee:	c7 05 78 71 10 00 00 	movl   $0x180000,0x107178
  1002f5:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002f8:	66 c7 05 7c 71 10 00 	movw   $0x10,0x10717c
  1002ff:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100301:	66 89 0c c5 dc 71 10 	mov    %cx,0x1071dc(,%eax,8)
  100308:	00 
  100309:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100310:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100315:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10031a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10031f:	40                   	inc    %eax
  100320:	3d 00 01 00 00       	cmp    $0x100,%eax
  100325:	75 da                	jne    100301 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100327:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10032c:	ba dc 71 10 00       	mov    $0x1071dc,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100331:	66 a3 dc 72 10 00    	mov    %ax,0x1072dc
  100337:	c1 e8 10             	shr    $0x10,%eax
  10033a:	66 a3 e2 72 10 00    	mov    %ax,0x1072e2
  100340:	b8 30 00 00 00       	mov    $0x30,%eax
  100345:	66 c7 05 de 72 10 00 	movw   $0x8,0x1072de
  10034c:	08 00 
  10034e:	c6 05 e0 72 10 00 00 	movb   $0x0,0x1072e0
  100355:	c6 05 e1 72 10 00 8e 	movb   $0x8e,0x1072e1

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10035c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100363:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10036a:	66 89 0c c5 dc 71 10 	mov    %cx,0x1071dc(,%eax,8)
  100371:	00 
  100372:	c1 e9 10             	shr    $0x10,%ecx
  100375:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10037a:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10037f:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100384:	40                   	inc    %eax
  100385:	83 f8 3a             	cmp    $0x3a,%eax
  100388:	75 d2                	jne    10035c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10038a:	b0 28                	mov    $0x28,%al
  10038c:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100393:	0f 00 d8             	ltr    %ax
  100396:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10039d:	5b                   	pop    %ebx
  10039e:	c3                   	ret    

0010039f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10039f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003a0:	b0 ff                	mov    $0xff,%al
  1003a2:	57                   	push   %edi
  1003a3:	56                   	push   %esi
  1003a4:	53                   	push   %ebx
  1003a5:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003aa:	89 da                	mov    %ebx,%edx
  1003ac:	ee                   	out    %al,(%dx)
  1003ad:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003b2:	89 ca                	mov    %ecx,%edx
  1003b4:	ee                   	out    %al,(%dx)
  1003b5:	be 11 00 00 00       	mov    $0x11,%esi
  1003ba:	bf 20 00 00 00       	mov    $0x20,%edi
  1003bf:	89 f0                	mov    %esi,%eax
  1003c1:	89 fa                	mov    %edi,%edx
  1003c3:	ee                   	out    %al,(%dx)
  1003c4:	b0 20                	mov    $0x20,%al
  1003c6:	89 da                	mov    %ebx,%edx
  1003c8:	ee                   	out    %al,(%dx)
  1003c9:	b0 04                	mov    $0x4,%al
  1003cb:	ee                   	out    %al,(%dx)
  1003cc:	b0 03                	mov    $0x3,%al
  1003ce:	ee                   	out    %al,(%dx)
  1003cf:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003d4:	89 f0                	mov    %esi,%eax
  1003d6:	89 ea                	mov    %ebp,%edx
  1003d8:	ee                   	out    %al,(%dx)
  1003d9:	b0 28                	mov    $0x28,%al
  1003db:	89 ca                	mov    %ecx,%edx
  1003dd:	ee                   	out    %al,(%dx)
  1003de:	b0 02                	mov    $0x2,%al
  1003e0:	ee                   	out    %al,(%dx)
  1003e1:	b0 01                	mov    $0x1,%al
  1003e3:	ee                   	out    %al,(%dx)
  1003e4:	b0 68                	mov    $0x68,%al
  1003e6:	89 fa                	mov    %edi,%edx
  1003e8:	ee                   	out    %al,(%dx)
  1003e9:	be 0a 00 00 00       	mov    $0xa,%esi
  1003ee:	89 f0                	mov    %esi,%eax
  1003f0:	ee                   	out    %al,(%dx)
  1003f1:	b0 68                	mov    $0x68,%al
  1003f3:	89 ea                	mov    %ebp,%edx
  1003f5:	ee                   	out    %al,(%dx)
  1003f6:	89 f0                	mov    %esi,%eax
  1003f8:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003f9:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003fe:	89 da                	mov    %ebx,%edx
  100400:	19 c0                	sbb    %eax,%eax
  100402:	f7 d0                	not    %eax
  100404:	05 ff 00 00 00       	add    $0xff,%eax
  100409:	ee                   	out    %al,(%dx)
  10040a:	b0 ff                	mov    $0xff,%al
  10040c:	89 ca                	mov    %ecx,%edx
  10040e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10040f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100414:	74 0d                	je     100423 <interrupt_controller_init+0x84>
  100416:	b2 43                	mov    $0x43,%dl
  100418:	b0 34                	mov    $0x34,%al
  10041a:	ee                   	out    %al,(%dx)
  10041b:	b0 9c                	mov    $0x9c,%al
  10041d:	b2 40                	mov    $0x40,%dl
  10041f:	ee                   	out    %al,(%dx)
  100420:	b0 2e                	mov    $0x2e,%al
  100422:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100423:	5b                   	pop    %ebx
  100424:	5e                   	pop    %esi
  100425:	5f                   	pop    %edi
  100426:	5d                   	pop    %ebp
  100427:	c3                   	ret    

00100428 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100428:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100429:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10042b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10042c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100433:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100436:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10043c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100442:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100445:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10044a:	75 ea                	jne    100436 <console_clear+0xe>
  10044c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100451:	b0 0e                	mov    $0xe,%al
  100453:	89 f2                	mov    %esi,%edx
  100455:	ee                   	out    %al,(%dx)
  100456:	31 c9                	xor    %ecx,%ecx
  100458:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10045d:	88 c8                	mov    %cl,%al
  10045f:	89 da                	mov    %ebx,%edx
  100461:	ee                   	out    %al,(%dx)
  100462:	b0 0f                	mov    $0xf,%al
  100464:	89 f2                	mov    %esi,%edx
  100466:	ee                   	out    %al,(%dx)
  100467:	88 c8                	mov    %cl,%al
  100469:	89 da                	mov    %ebx,%edx
  10046b:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10046c:	5b                   	pop    %ebx
  10046d:	5e                   	pop    %esi
  10046e:	c3                   	ret    

0010046f <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10046f:	ba 64 00 00 00       	mov    $0x64,%edx
  100474:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100475:	a8 01                	test   $0x1,%al
  100477:	74 45                	je     1004be <console_read_digit+0x4f>
  100479:	b2 60                	mov    $0x60,%dl
  10047b:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10047c:	8d 50 fe             	lea    -0x2(%eax),%edx
  10047f:	80 fa 08             	cmp    $0x8,%dl
  100482:	77 05                	ja     100489 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100484:	0f b6 c0             	movzbl %al,%eax
  100487:	48                   	dec    %eax
  100488:	c3                   	ret    
	else if (data == 0x0B)
  100489:	3c 0b                	cmp    $0xb,%al
  10048b:	74 35                	je     1004c2 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10048d:	8d 50 b9             	lea    -0x47(%eax),%edx
  100490:	80 fa 02             	cmp    $0x2,%dl
  100493:	77 07                	ja     10049c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100495:	0f b6 c0             	movzbl %al,%eax
  100498:	83 e8 40             	sub    $0x40,%eax
  10049b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10049c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10049f:	80 fa 02             	cmp    $0x2,%dl
  1004a2:	77 07                	ja     1004ab <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004a4:	0f b6 c0             	movzbl %al,%eax
  1004a7:	83 e8 47             	sub    $0x47,%eax
  1004aa:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004ab:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004ae:	80 fa 02             	cmp    $0x2,%dl
  1004b1:	77 07                	ja     1004ba <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004b3:	0f b6 c0             	movzbl %al,%eax
  1004b6:	83 e8 4e             	sub    $0x4e,%eax
  1004b9:	c3                   	ret    
	else if (data == 0x53)
  1004ba:	3c 53                	cmp    $0x53,%al
  1004bc:	74 04                	je     1004c2 <console_read_digit+0x53>
  1004be:	83 c8 ff             	or     $0xffffffff,%eax
  1004c1:	c3                   	ret    
  1004c2:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004c4:	c3                   	ret    

001004c5 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004c5:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004c9:	a3 dc 79 10 00       	mov    %eax,0x1079dc

	asm volatile("movl %0,%%esp\n\t"
  1004ce:	83 c0 04             	add    $0x4,%eax
  1004d1:	89 c4                	mov    %eax,%esp
  1004d3:	61                   	popa   
  1004d4:	07                   	pop    %es
  1004d5:	1f                   	pop    %ds
  1004d6:	83 c4 08             	add    $0x8,%esp
  1004d9:	cf                   	iret   
  1004da:	eb fe                	jmp    1004da <run+0x15>

001004dc <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004dc:	53                   	push   %ebx
  1004dd:	83 ec 0c             	sub    $0xc,%esp
  1004e0:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004e4:	6a 44                	push   $0x44
  1004e6:	6a 00                	push   $0x0
  1004e8:	8d 43 04             	lea    0x4(%ebx),%eax
  1004eb:	50                   	push   %eax
  1004ec:	e8 17 01 00 00       	call   100608 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004f1:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004f7:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004fd:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100503:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100509:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100510:	83 c4 18             	add    $0x18,%esp
  100513:	5b                   	pop    %ebx
  100514:	c3                   	ret    
  100515:	90                   	nop
  100516:	90                   	nop
  100517:	90                   	nop

00100518 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100518:	55                   	push   %ebp
  100519:	57                   	push   %edi
  10051a:	56                   	push   %esi
  10051b:	53                   	push   %ebx
  10051c:	83 ec 1c             	sub    $0x1c,%esp
  10051f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100523:	83 f8 03             	cmp    $0x3,%eax
  100526:	7f 04                	jg     10052c <program_loader+0x14>
  100528:	85 c0                	test   %eax,%eax
  10052a:	79 02                	jns    10052e <program_loader+0x16>
  10052c:	eb fe                	jmp    10052c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10052e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100535:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10053b:	74 02                	je     10053f <program_loader+0x27>
  10053d:	eb fe                	jmp    10053d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10053f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100542:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100546:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100548:	c1 e5 05             	shl    $0x5,%ebp
  10054b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10054e:	eb 3f                	jmp    10058f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100550:	83 3b 01             	cmpl   $0x1,(%ebx)
  100553:	75 37                	jne    10058c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100555:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100558:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10055b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10055e:	01 c7                	add    %eax,%edi
	memsz += va;
  100560:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100562:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100567:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10056b:	52                   	push   %edx
  10056c:	89 fa                	mov    %edi,%edx
  10056e:	29 c2                	sub    %eax,%edx
  100570:	52                   	push   %edx
  100571:	8b 53 04             	mov    0x4(%ebx),%edx
  100574:	01 f2                	add    %esi,%edx
  100576:	52                   	push   %edx
  100577:	50                   	push   %eax
  100578:	e8 27 00 00 00       	call   1005a4 <memcpy>
  10057d:	83 c4 10             	add    $0x10,%esp
  100580:	eb 04                	jmp    100586 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100582:	c6 07 00             	movb   $0x0,(%edi)
  100585:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100586:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10058a:	72 f6                	jb     100582 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10058c:	83 c3 20             	add    $0x20,%ebx
  10058f:	39 eb                	cmp    %ebp,%ebx
  100591:	72 bd                	jb     100550 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100593:	8b 56 18             	mov    0x18(%esi),%edx
  100596:	8b 44 24 34          	mov    0x34(%esp),%eax
  10059a:	89 10                	mov    %edx,(%eax)
}
  10059c:	83 c4 1c             	add    $0x1c,%esp
  10059f:	5b                   	pop    %ebx
  1005a0:	5e                   	pop    %esi
  1005a1:	5f                   	pop    %edi
  1005a2:	5d                   	pop    %ebp
  1005a3:	c3                   	ret    

001005a4 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005a4:	56                   	push   %esi
  1005a5:	31 d2                	xor    %edx,%edx
  1005a7:	53                   	push   %ebx
  1005a8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005ac:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005b0:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005b4:	eb 08                	jmp    1005be <memcpy+0x1a>
		*d++ = *s++;
  1005b6:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005b9:	4e                   	dec    %esi
  1005ba:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005bd:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005be:	85 f6                	test   %esi,%esi
  1005c0:	75 f4                	jne    1005b6 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005c2:	5b                   	pop    %ebx
  1005c3:	5e                   	pop    %esi
  1005c4:	c3                   	ret    

001005c5 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005c5:	57                   	push   %edi
  1005c6:	56                   	push   %esi
  1005c7:	53                   	push   %ebx
  1005c8:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005cc:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005d0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005d4:	39 c7                	cmp    %eax,%edi
  1005d6:	73 26                	jae    1005fe <memmove+0x39>
  1005d8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005db:	39 c6                	cmp    %eax,%esi
  1005dd:	76 1f                	jbe    1005fe <memmove+0x39>
		s += n, d += n;
  1005df:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005e2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005e4:	eb 07                	jmp    1005ed <memmove+0x28>
			*--d = *--s;
  1005e6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005e9:	4a                   	dec    %edx
  1005ea:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005ed:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005ee:	85 d2                	test   %edx,%edx
  1005f0:	75 f4                	jne    1005e6 <memmove+0x21>
  1005f2:	eb 10                	jmp    100604 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005f4:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005f7:	4a                   	dec    %edx
  1005f8:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005fb:	41                   	inc    %ecx
  1005fc:	eb 02                	jmp    100600 <memmove+0x3b>
  1005fe:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100600:	85 d2                	test   %edx,%edx
  100602:	75 f0                	jne    1005f4 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100604:	5b                   	pop    %ebx
  100605:	5e                   	pop    %esi
  100606:	5f                   	pop    %edi
  100607:	c3                   	ret    

00100608 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100608:	53                   	push   %ebx
  100609:	8b 44 24 08          	mov    0x8(%esp),%eax
  10060d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100611:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100615:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100617:	eb 04                	jmp    10061d <memset+0x15>
		*p++ = c;
  100619:	88 1a                	mov    %bl,(%edx)
  10061b:	49                   	dec    %ecx
  10061c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10061d:	85 c9                	test   %ecx,%ecx
  10061f:	75 f8                	jne    100619 <memset+0x11>
		*p++ = c;
	return v;
}
  100621:	5b                   	pop    %ebx
  100622:	c3                   	ret    

00100623 <strlen>:

size_t
strlen(const char *s)
{
  100623:	8b 54 24 04          	mov    0x4(%esp),%edx
  100627:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100629:	eb 01                	jmp    10062c <strlen+0x9>
		++n;
  10062b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10062c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100630:	75 f9                	jne    10062b <strlen+0x8>
		++n;
	return n;
}
  100632:	c3                   	ret    

00100633 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100633:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100637:	31 c0                	xor    %eax,%eax
  100639:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10063d:	eb 01                	jmp    100640 <strnlen+0xd>
		++n;
  10063f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100640:	39 d0                	cmp    %edx,%eax
  100642:	74 06                	je     10064a <strnlen+0x17>
  100644:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100648:	75 f5                	jne    10063f <strnlen+0xc>
		++n;
	return n;
}
  10064a:	c3                   	ret    

0010064b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10064b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10064c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100651:	53                   	push   %ebx
  100652:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100654:	76 05                	jbe    10065b <console_putc+0x10>
  100656:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10065b:	80 fa 0a             	cmp    $0xa,%dl
  10065e:	75 2c                	jne    10068c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100660:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100666:	be 50 00 00 00       	mov    $0x50,%esi
  10066b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10066d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100670:	99                   	cltd   
  100671:	f7 fe                	idiv   %esi
  100673:	89 de                	mov    %ebx,%esi
  100675:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100677:	eb 07                	jmp    100680 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100679:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10067c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10067d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100680:	83 f8 50             	cmp    $0x50,%eax
  100683:	75 f4                	jne    100679 <console_putc+0x2e>
  100685:	29 d0                	sub    %edx,%eax
  100687:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10068a:	eb 0b                	jmp    100697 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10068c:	0f b6 d2             	movzbl %dl,%edx
  10068f:	09 ca                	or     %ecx,%edx
  100691:	66 89 13             	mov    %dx,(%ebx)
  100694:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100697:	5b                   	pop    %ebx
  100698:	5e                   	pop    %esi
  100699:	c3                   	ret    

0010069a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10069a:	56                   	push   %esi
  10069b:	53                   	push   %ebx
  10069c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006a0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006a3:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006a7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006ac:	75 04                	jne    1006b2 <fill_numbuf+0x18>
  1006ae:	85 d2                	test   %edx,%edx
  1006b0:	74 10                	je     1006c2 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006b2:	89 d0                	mov    %edx,%eax
  1006b4:	31 d2                	xor    %edx,%edx
  1006b6:	f7 f1                	div    %ecx
  1006b8:	4b                   	dec    %ebx
  1006b9:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006bc:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006be:	89 c2                	mov    %eax,%edx
  1006c0:	eb ec                	jmp    1006ae <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006c2:	89 d8                	mov    %ebx,%eax
  1006c4:	5b                   	pop    %ebx
  1006c5:	5e                   	pop    %esi
  1006c6:	c3                   	ret    

001006c7 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006c7:	55                   	push   %ebp
  1006c8:	57                   	push   %edi
  1006c9:	56                   	push   %esi
  1006ca:	53                   	push   %ebx
  1006cb:	83 ec 38             	sub    $0x38,%esp
  1006ce:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006d2:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006d6:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006da:	e9 60 03 00 00       	jmp    100a3f <console_vprintf+0x378>
		if (*format != '%') {
  1006df:	80 fa 25             	cmp    $0x25,%dl
  1006e2:	74 13                	je     1006f7 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006e4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006e8:	0f b6 d2             	movzbl %dl,%edx
  1006eb:	89 f0                	mov    %esi,%eax
  1006ed:	e8 59 ff ff ff       	call   10064b <console_putc>
  1006f2:	e9 45 03 00 00       	jmp    100a3c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006f7:	47                   	inc    %edi
  1006f8:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006ff:	00 
  100700:	eb 12                	jmp    100714 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100702:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100703:	8a 11                	mov    (%ecx),%dl
  100705:	84 d2                	test   %dl,%dl
  100707:	74 1a                	je     100723 <console_vprintf+0x5c>
  100709:	89 e8                	mov    %ebp,%eax
  10070b:	38 c2                	cmp    %al,%dl
  10070d:	75 f3                	jne    100702 <console_vprintf+0x3b>
  10070f:	e9 3f 03 00 00       	jmp    100a53 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100714:	8a 17                	mov    (%edi),%dl
  100716:	84 d2                	test   %dl,%dl
  100718:	74 0b                	je     100725 <console_vprintf+0x5e>
  10071a:	b9 a8 0a 10 00       	mov    $0x100aa8,%ecx
  10071f:	89 d5                	mov    %edx,%ebp
  100721:	eb e0                	jmp    100703 <console_vprintf+0x3c>
  100723:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100725:	8d 42 cf             	lea    -0x31(%edx),%eax
  100728:	3c 08                	cmp    $0x8,%al
  10072a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100731:	00 
  100732:	76 13                	jbe    100747 <console_vprintf+0x80>
  100734:	eb 1d                	jmp    100753 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100736:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10073b:	0f be c0             	movsbl %al,%eax
  10073e:	47                   	inc    %edi
  10073f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100743:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100747:	8a 07                	mov    (%edi),%al
  100749:	8d 50 d0             	lea    -0x30(%eax),%edx
  10074c:	80 fa 09             	cmp    $0x9,%dl
  10074f:	76 e5                	jbe    100736 <console_vprintf+0x6f>
  100751:	eb 18                	jmp    10076b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100753:	80 fa 2a             	cmp    $0x2a,%dl
  100756:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10075d:	ff 
  10075e:	75 0b                	jne    10076b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100760:	83 c3 04             	add    $0x4,%ebx
			++format;
  100763:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100764:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100767:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10076b:	83 cd ff             	or     $0xffffffff,%ebp
  10076e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100771:	75 37                	jne    1007aa <console_vprintf+0xe3>
			++format;
  100773:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100774:	31 ed                	xor    %ebp,%ebp
  100776:	8a 07                	mov    (%edi),%al
  100778:	8d 50 d0             	lea    -0x30(%eax),%edx
  10077b:	80 fa 09             	cmp    $0x9,%dl
  10077e:	76 0d                	jbe    10078d <console_vprintf+0xc6>
  100780:	eb 17                	jmp    100799 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100782:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100785:	0f be c0             	movsbl %al,%eax
  100788:	47                   	inc    %edi
  100789:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10078d:	8a 07                	mov    (%edi),%al
  10078f:	8d 50 d0             	lea    -0x30(%eax),%edx
  100792:	80 fa 09             	cmp    $0x9,%dl
  100795:	76 eb                	jbe    100782 <console_vprintf+0xbb>
  100797:	eb 11                	jmp    1007aa <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100799:	3c 2a                	cmp    $0x2a,%al
  10079b:	75 0b                	jne    1007a8 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10079d:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007a0:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007a1:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007a4:	85 ed                	test   %ebp,%ebp
  1007a6:	79 02                	jns    1007aa <console_vprintf+0xe3>
  1007a8:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007aa:	8a 07                	mov    (%edi),%al
  1007ac:	3c 64                	cmp    $0x64,%al
  1007ae:	74 34                	je     1007e4 <console_vprintf+0x11d>
  1007b0:	7f 1d                	jg     1007cf <console_vprintf+0x108>
  1007b2:	3c 58                	cmp    $0x58,%al
  1007b4:	0f 84 a2 00 00 00    	je     10085c <console_vprintf+0x195>
  1007ba:	3c 63                	cmp    $0x63,%al
  1007bc:	0f 84 bf 00 00 00    	je     100881 <console_vprintf+0x1ba>
  1007c2:	3c 43                	cmp    $0x43,%al
  1007c4:	0f 85 d0 00 00 00    	jne    10089a <console_vprintf+0x1d3>
  1007ca:	e9 a3 00 00 00       	jmp    100872 <console_vprintf+0x1ab>
  1007cf:	3c 75                	cmp    $0x75,%al
  1007d1:	74 4d                	je     100820 <console_vprintf+0x159>
  1007d3:	3c 78                	cmp    $0x78,%al
  1007d5:	74 5c                	je     100833 <console_vprintf+0x16c>
  1007d7:	3c 73                	cmp    $0x73,%al
  1007d9:	0f 85 bb 00 00 00    	jne    10089a <console_vprintf+0x1d3>
  1007df:	e9 86 00 00 00       	jmp    10086a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007e4:	83 c3 04             	add    $0x4,%ebx
  1007e7:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007ea:	89 d1                	mov    %edx,%ecx
  1007ec:	c1 f9 1f             	sar    $0x1f,%ecx
  1007ef:	89 0c 24             	mov    %ecx,(%esp)
  1007f2:	31 ca                	xor    %ecx,%edx
  1007f4:	55                   	push   %ebp
  1007f5:	29 ca                	sub    %ecx,%edx
  1007f7:	68 b0 0a 10 00       	push   $0x100ab0
  1007fc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100801:	8d 44 24 40          	lea    0x40(%esp),%eax
  100805:	e8 90 fe ff ff       	call   10069a <fill_numbuf>
  10080a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10080e:	58                   	pop    %eax
  10080f:	5a                   	pop    %edx
  100810:	ba 01 00 00 00       	mov    $0x1,%edx
  100815:	8b 04 24             	mov    (%esp),%eax
  100818:	83 e0 01             	and    $0x1,%eax
  10081b:	e9 a5 00 00 00       	jmp    1008c5 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100820:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100823:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100828:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10082b:	55                   	push   %ebp
  10082c:	68 b0 0a 10 00       	push   $0x100ab0
  100831:	eb 11                	jmp    100844 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100833:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100836:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100839:	55                   	push   %ebp
  10083a:	68 c4 0a 10 00       	push   $0x100ac4
  10083f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100844:	8d 44 24 40          	lea    0x40(%esp),%eax
  100848:	e8 4d fe ff ff       	call   10069a <fill_numbuf>
  10084d:	ba 01 00 00 00       	mov    $0x1,%edx
  100852:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100856:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100858:	59                   	pop    %ecx
  100859:	59                   	pop    %ecx
  10085a:	eb 69                	jmp    1008c5 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10085c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10085f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100862:	55                   	push   %ebp
  100863:	68 b0 0a 10 00       	push   $0x100ab0
  100868:	eb d5                	jmp    10083f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10086a:	83 c3 04             	add    $0x4,%ebx
  10086d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100870:	eb 40                	jmp    1008b2 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100872:	83 c3 04             	add    $0x4,%ebx
  100875:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100878:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10087c:	e9 bd 01 00 00       	jmp    100a3e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100881:	83 c3 04             	add    $0x4,%ebx
  100884:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100887:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10088b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100890:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100894:	88 44 24 24          	mov    %al,0x24(%esp)
  100898:	eb 27                	jmp    1008c1 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10089a:	84 c0                	test   %al,%al
  10089c:	75 02                	jne    1008a0 <console_vprintf+0x1d9>
  10089e:	b0 25                	mov    $0x25,%al
  1008a0:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008a4:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008a9:	80 3f 00             	cmpb   $0x0,(%edi)
  1008ac:	74 0a                	je     1008b8 <console_vprintf+0x1f1>
  1008ae:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008b6:	eb 09                	jmp    1008c1 <console_vprintf+0x1fa>
				format--;
  1008b8:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008bc:	4f                   	dec    %edi
  1008bd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008c1:	31 d2                	xor    %edx,%edx
  1008c3:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008c5:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008c7:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008d1:	74 1f                	je     1008f2 <console_vprintf+0x22b>
  1008d3:	89 04 24             	mov    %eax,(%esp)
  1008d6:	eb 01                	jmp    1008d9 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008d8:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008d9:	39 e9                	cmp    %ebp,%ecx
  1008db:	74 0a                	je     1008e7 <console_vprintf+0x220>
  1008dd:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008e1:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008e5:	75 f1                	jne    1008d8 <console_vprintf+0x211>
  1008e7:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008ea:	89 0c 24             	mov    %ecx,(%esp)
  1008ed:	eb 1f                	jmp    10090e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008ef:	42                   	inc    %edx
  1008f0:	eb 09                	jmp    1008fb <console_vprintf+0x234>
  1008f2:	89 d1                	mov    %edx,%ecx
  1008f4:	8b 14 24             	mov    (%esp),%edx
  1008f7:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008fb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008ff:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100903:	75 ea                	jne    1008ef <console_vprintf+0x228>
  100905:	8b 44 24 08          	mov    0x8(%esp),%eax
  100909:	89 14 24             	mov    %edx,(%esp)
  10090c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10090e:	85 c0                	test   %eax,%eax
  100910:	74 0c                	je     10091e <console_vprintf+0x257>
  100912:	84 d2                	test   %dl,%dl
  100914:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10091b:	00 
  10091c:	75 24                	jne    100942 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10091e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100923:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10092a:	00 
  10092b:	75 15                	jne    100942 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10092d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100931:	83 e0 08             	and    $0x8,%eax
  100934:	83 f8 01             	cmp    $0x1,%eax
  100937:	19 c9                	sbb    %ecx,%ecx
  100939:	f7 d1                	not    %ecx
  10093b:	83 e1 20             	and    $0x20,%ecx
  10093e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100942:	3b 2c 24             	cmp    (%esp),%ebp
  100945:	7e 0d                	jle    100954 <console_vprintf+0x28d>
  100947:	84 d2                	test   %dl,%dl
  100949:	74 40                	je     10098b <console_vprintf+0x2c4>
			zeros = precision - len;
  10094b:	2b 2c 24             	sub    (%esp),%ebp
  10094e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100952:	eb 3f                	jmp    100993 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100954:	84 d2                	test   %dl,%dl
  100956:	74 33                	je     10098b <console_vprintf+0x2c4>
  100958:	8b 44 24 14          	mov    0x14(%esp),%eax
  10095c:	83 e0 06             	and    $0x6,%eax
  10095f:	83 f8 02             	cmp    $0x2,%eax
  100962:	75 27                	jne    10098b <console_vprintf+0x2c4>
  100964:	45                   	inc    %ebp
  100965:	75 24                	jne    10098b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100967:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100969:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  10096c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100971:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100974:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100977:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10097b:	7d 0e                	jge    10098b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  10097d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100981:	29 ca                	sub    %ecx,%edx
  100983:	29 c2                	sub    %eax,%edx
  100985:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100989:	eb 08                	jmp    100993 <console_vprintf+0x2cc>
  10098b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100992:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100993:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100997:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100999:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10099d:	2b 2c 24             	sub    (%esp),%ebp
  1009a0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009a5:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a8:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009ab:	29 c5                	sub    %eax,%ebp
  1009ad:	89 f0                	mov    %esi,%eax
  1009af:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009b7:	eb 0f                	jmp    1009c8 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009b9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009bd:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009c2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009c3:	e8 83 fc ff ff       	call   10064b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009c8:	85 ed                	test   %ebp,%ebp
  1009ca:	7e 07                	jle    1009d3 <console_vprintf+0x30c>
  1009cc:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009d1:	74 e6                	je     1009b9 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009d3:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009d8:	89 c6                	mov    %eax,%esi
  1009da:	74 23                	je     1009ff <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009dc:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009e1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009e5:	e8 61 fc ff ff       	call   10064b <console_putc>
  1009ea:	89 c6                	mov    %eax,%esi
  1009ec:	eb 11                	jmp    1009ff <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009ee:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009f2:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009f7:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009f8:	e8 4e fc ff ff       	call   10064b <console_putc>
  1009fd:	eb 06                	jmp    100a05 <console_vprintf+0x33e>
  1009ff:	89 f0                	mov    %esi,%eax
  100a01:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a05:	85 f6                	test   %esi,%esi
  100a07:	7f e5                	jg     1009ee <console_vprintf+0x327>
  100a09:	8b 34 24             	mov    (%esp),%esi
  100a0c:	eb 15                	jmp    100a23 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a0e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a12:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a13:	0f b6 11             	movzbl (%ecx),%edx
  100a16:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a1a:	e8 2c fc ff ff       	call   10064b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a1f:	ff 44 24 04          	incl   0x4(%esp)
  100a23:	85 f6                	test   %esi,%esi
  100a25:	7f e7                	jg     100a0e <console_vprintf+0x347>
  100a27:	eb 0f                	jmp    100a38 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a29:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a2d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a32:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a33:	e8 13 fc ff ff       	call   10064b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a38:	85 ed                	test   %ebp,%ebp
  100a3a:	7f ed                	jg     100a29 <console_vprintf+0x362>
  100a3c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a3e:	47                   	inc    %edi
  100a3f:	8a 17                	mov    (%edi),%dl
  100a41:	84 d2                	test   %dl,%dl
  100a43:	0f 85 96 fc ff ff    	jne    1006df <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a49:	83 c4 38             	add    $0x38,%esp
  100a4c:	89 f0                	mov    %esi,%eax
  100a4e:	5b                   	pop    %ebx
  100a4f:	5e                   	pop    %esi
  100a50:	5f                   	pop    %edi
  100a51:	5d                   	pop    %ebp
  100a52:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a53:	81 e9 a8 0a 10 00    	sub    $0x100aa8,%ecx
  100a59:	b8 01 00 00 00       	mov    $0x1,%eax
  100a5e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a60:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a61:	09 44 24 14          	or     %eax,0x14(%esp)
  100a65:	e9 aa fc ff ff       	jmp    100714 <console_vprintf+0x4d>

00100a6a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a6a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a6e:	50                   	push   %eax
  100a6f:	ff 74 24 10          	pushl  0x10(%esp)
  100a73:	ff 74 24 10          	pushl  0x10(%esp)
  100a77:	ff 74 24 10          	pushl  0x10(%esp)
  100a7b:	e8 47 fc ff ff       	call   1006c7 <console_vprintf>
  100a80:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a83:	c3                   	ret    
