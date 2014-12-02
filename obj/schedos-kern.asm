
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
  100014:	e8 55 02 00 00       	call   10026e <start>
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
  10006d:	e8 7e 01 00 00       	call   1001f0 <interrupt>

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
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  10009c:	a1 7c 8d 10 00       	mov    0x108d7c,%eax
 *
 *****************************************************************************/

void
schedule(void)
{
  1000a1:	57                   	push   %edi
  1000a2:	56                   	push   %esi
  1000a3:	53                   	push   %ebx
	pid_t pid = current->p_pid;
  1000a4:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a6:	a1 80 8d 10 00       	mov    0x108d80,%eax
  1000ab:	85 c0                	test   %eax,%eax
  1000ad:	75 1f                	jne    1000ce <schedule+0x32>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000af:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b4:	8d 42 01             	lea    0x1(%edx),%eax
  1000b7:	99                   	cltd   
  1000b8:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ba:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000bd:	83 b8 9c 83 10 00 01 	cmpl   $0x1,0x10839c(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
				run(&proc_array[pid]);
  1000c6:	83 ec 0c             	sub    $0xc,%esp
  1000c9:	e9 1a 01 00 00       	jmp    1001e8 <schedule+0x14c>
		}

	if (scheduling_algorithm == 1)
  1000ce:	83 f8 01             	cmp    $0x1,%eax
  1000d1:	75 46                	jne    100119 <schedule+0x7d>

          while (1) {
                        // Run processes in order of schedos number.
                        for (i = 1; i < NPROCS; i++)
                        {
                          if (proc_array[i].p_state == P_RUNNABLE){
  1000d3:	83 3d f8 83 10 00 01 	cmpl   $0x1,0x1083f8
  1000da:	8b 1d 54 84 10 00    	mov    0x108454,%ebx
  1000e0:	8b 0d b0 84 10 00    	mov    0x1084b0,%ecx
  1000e6:	8b 15 0c 85 10 00    	mov    0x10850c,%edx
  1000ec:	0f 84 f0 00 00 00    	je     1001e2 <schedule+0x146>
  1000f2:	83 fb 01             	cmp    $0x1,%ebx
  1000f5:	75 0a                	jne    100101 <schedule+0x65>
  1000f7:	b8 02 00 00 00       	mov    $0x2,%eax
  1000fc:	e9 e1 00 00 00       	jmp    1001e2 <schedule+0x146>
  100101:	83 f9 01             	cmp    $0x1,%ecx
  100104:	0f 84 d3 00 00 00    	je     1001dd <schedule+0x141>
  10010a:	83 fa 01             	cmp    $0x1,%edx
  10010d:	75 e3                	jne    1000f2 <schedule+0x56>
  10010f:	b8 04 00 00 00       	mov    $0x4,%eax
  100114:	e9 c9 00 00 00       	jmp    1001e2 <schedule+0x146>
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
		}
        }

	if (scheduling_algorithm == 2)
  100119:	83 f8 02             	cmp    $0x2,%eax
  10011c:	75 5d                	jne    10017b <schedule+0xdf>
  10011e:	83 c9 ff             	or     $0xffffffff,%ecx
        {
	  int i = 0;
          unsigned int priority = 0xffffffff; // Max value

          while (1) {
                        pid = (pid + 1) % NPROCS;
  100121:	bb 05 00 00 00       	mov    $0x5,%ebx
  100126:	eb 02                	jmp    10012a <schedule+0x8e>
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
		}
        }

	if (scheduling_algorithm == 2)
  100128:	89 c1                	mov    %eax,%ecx
        {
	  int i = 0;
          unsigned int priority = 0xffffffff; // Max value

          while (1) {
                        pid = (pid + 1) % NPROCS;
  10012a:	8d 42 01             	lea    0x1(%edx),%eax
  10012d:	31 ff                	xor    %edi,%edi
  10012f:	99                   	cltd   
  100130:	f7 fb                	idiv   %ebx
  100132:	89 d6                	mov    %edx,%esi

                        // Find lowest priority value
                        for (i = 1; i < NPROCS; i++)
                        {
                          if ((proc_array[i].p_priority < priority) && proc_array[i].p_state == P_RUNNABLE)
  100134:	8b 87 ec 83 10 00    	mov    0x1083ec(%edi),%eax
  10013a:	39 c8                	cmp    %ecx,%eax
  10013c:	73 09                	jae    100147 <schedule+0xab>
  10013e:	83 bf f8 83 10 00 01 	cmpl   $0x1,0x1083f8(%edi)
  100145:	74 02                	je     100149 <schedule+0xad>
  100147:	89 c8                	mov    %ecx,%eax
  100149:	83 c7 5c             	add    $0x5c,%edi

          while (1) {
                        pid = (pid + 1) % NPROCS;

                        // Find lowest priority value
                        for (i = 1; i < NPROCS; i++)
  10014c:	81 ff 70 01 00 00    	cmp    $0x170,%edi
  100152:	74 04                	je     100158 <schedule+0xbc>
  100154:	89 c1                	mov    %eax,%ecx
  100156:	eb dc                	jmp    100134 <schedule+0x98>
                          if ((proc_array[i].p_priority < priority) && proc_array[i].p_state == P_RUNNABLE)
                            priority = proc_array[i].p_priority;
                        }

                        // Run processes with highest priority 
                        if (proc_array[pid].p_priority == priority && proc_array[pid].p_state == P_RUNNABLE)
  100158:	6b f6 5c             	imul   $0x5c,%esi,%esi
  10015b:	39 86 90 83 10 00    	cmp    %eax,0x108390(%esi)
  100161:	75 c5                	jne    100128 <schedule+0x8c>
  100163:	83 be 9c 83 10 00 01 	cmpl   $0x1,0x10839c(%esi)
  10016a:	75 bc                	jne    100128 <schedule+0x8c>
                           run(&proc_array[pid]);
  10016c:	83 ec 0c             	sub    $0xc,%esp
  10016f:	81 c6 48 83 10 00    	add    $0x108348,%esi
  100175:	56                   	push   %esi
  100176:	e8 1e 04 00 00       	call   100599 <run>

		}
        }

	if (scheduling_algorithm == 3)
  10017b:	83 f8 03             	cmp    $0x3,%eax
  10017e:	75 3c                	jne    1001bc <schedule+0x120>
        {
          while (1) {
              pid = (pid + 1) % NPROCS;
  100180:	b9 05 00 00 00       	mov    $0x5,%ecx
  100185:	8d 42 01             	lea    0x1(%edx),%eax
  100188:	99                   	cltd   
  100189:	f7 f9                	idiv   %ecx

              // Procs are skipped when they == their p_share value. Otherwise, sequential execution.
              if (proc_array[pid].p_state == P_RUNNABLE)
  10018b:	6b da 5c             	imul   $0x5c,%edx,%ebx
  10018e:	83 bb 9c 83 10 00 01 	cmpl   $0x1,0x10839c(%ebx)
  100195:	75 ee                	jne    100185 <schedule+0xe9>
              {
                 if (proc_array[pid].p_ran >= proc_array[pid].p_share)
  100197:	8d 83 48 83 10 00    	lea    0x108348(%ebx),%eax
  10019d:	8b 70 50             	mov    0x50(%eax),%esi
  1001a0:	8d 78 50             	lea    0x50(%eax),%edi
  1001a3:	3b b3 94 83 10 00    	cmp    0x108394(%ebx),%esi
  1001a9:	7c 09                	jl     1001b4 <schedule+0x118>
                   proc_array[pid].p_ran = 0; // Reset run count and skip if == 0
  1001ab:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
  1001b2:	eb d1                	jmp    100185 <schedule+0xe9>
                 else {
                    proc_array[pid].p_ran++;
  1001b4:	46                   	inc    %esi
                    run(&proc_array[pid]);
  1001b5:	83 ec 0c             	sub    $0xc,%esp
              if (proc_array[pid].p_state == P_RUNNABLE)
              {
                 if (proc_array[pid].p_ran >= proc_array[pid].p_share)
                   proc_array[pid].p_ran = 0; // Reset run count and skip if == 0
                 else {
                    proc_array[pid].p_ran++;
  1001b8:	89 37                	mov    %esi,(%edi)
  1001ba:	eb 31                	jmp    1001ed <schedule+0x151>
            }
        }


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001bc:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001c2:	50                   	push   %eax
  1001c3:	68 58 0b 10 00       	push   $0x100b58
  1001c8:	68 00 01 00 00       	push   $0x100
  1001cd:	52                   	push   %edx
  1001ce:	e8 6b 09 00 00       	call   100b3e <console_printf>
  1001d3:	83 c4 10             	add    $0x10,%esp
  1001d6:	a3 00 80 19 00       	mov    %eax,0x198000
  1001db:	eb fe                	jmp    1001db <schedule+0x13f>
  1001dd:	b8 03 00 00 00       	mov    $0x3,%eax
                            break;
                          }
                        }
			// Run the selected process
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
  1001e2:	6b c0 5c             	imul   $0x5c,%eax,%eax
  1001e5:	83 ec 0c             	sub    $0xc,%esp
  1001e8:	05 48 83 10 00       	add    $0x108348,%eax
  1001ed:	50                   	push   %eax
  1001ee:	eb 86                	jmp    100176 <schedule+0xda>

001001f0 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001f0:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001f1:	8b 3d 7c 8d 10 00    	mov    0x108d7c,%edi
  1001f7:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001fc:	56                   	push   %esi
  1001fd:	53                   	push   %ebx
  1001fe:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100202:	83 c7 04             	add    $0x4,%edi
  100205:	89 de                	mov    %ebx,%esi
  100207:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100209:	8b 43 28             	mov    0x28(%ebx),%eax
  10020c:	83 f8 31             	cmp    $0x31,%eax
  10020f:	74 1f                	je     100230 <interrupt+0x40>
  100211:	77 0c                	ja     10021f <interrupt+0x2f>
  100213:	83 f8 20             	cmp    $0x20,%eax
  100216:	74 4f                	je     100267 <interrupt+0x77>
  100218:	83 f8 30             	cmp    $0x30,%eax
  10021b:	74 0e                	je     10022b <interrupt+0x3b>
  10021d:	eb 4d                	jmp    10026c <interrupt+0x7c>
  10021f:	83 f8 32             	cmp    $0x32,%eax
  100222:	74 23                	je     100247 <interrupt+0x57>
  100224:	83 f8 33             	cmp    $0x33,%eax
  100227:	74 2e                	je     100257 <interrupt+0x67>
  100229:	eb 41                	jmp    10026c <interrupt+0x7c>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  10022b:	e8 6c fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100230:	a1 7c 8d 10 00       	mov    0x108d7c,%eax
		current->p_exit_status = reg->reg_eax;
  100235:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100238:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  10023f:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  100242:	e8 55 fe ff ff       	call   10009c <schedule>
                // 4A set priority
	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
                current->p_priority = reg->reg_eax; //Set new priority
  100247:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10024a:	a1 7c 8d 10 00       	mov    0x108d7c,%eax
  10024f:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  100252:	e8 45 fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
                current->p_share = reg->reg_eax;
  100257:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10025a:	a1 7c 8d 10 00       	mov    0x108d7c,%eax
  10025f:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100262:	e8 35 fe ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100267:	e8 30 fe ff ff       	call   10009c <schedule>
  10026c:	eb fe                	jmp    10026c <interrupt+0x7c>

0010026e <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10026e:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10026f:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100274:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100275:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100277:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100278:	bb a4 83 10 00       	mov    $0x1083a4,%ebx

void
start(void)
{
	int i;
        lock = 0;
  10027d:	c7 05 04 80 01 00 00 	movl   $0x0,0x18004
  100284:	00 00 00 

	// Set up hardware (schedos-x86.c)
	segments_init();
  100287:	e8 ec 00 00 00       	call   100378 <segments_init>
	interrupt_controller_init(0);
  10028c:	83 ec 0c             	sub    $0xc,%esp
  10028f:	6a 00                	push   $0x0
  100291:	e8 dd 01 00 00       	call   100473 <interrupt_controller_init>
	console_clear();
  100296:	e8 61 02 00 00       	call   1004fc <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10029b:	83 c4 0c             	add    $0xc,%esp
  10029e:	68 cc 01 00 00       	push   $0x1cc
  1002a3:	6a 00                	push   $0x0
  1002a5:	68 48 83 10 00       	push   $0x108348
  1002aa:	e8 2d 04 00 00       	call   1006dc <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002af:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002b2:	c7 05 48 83 10 00 00 	movl   $0x0,0x108348
  1002b9:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002bc:	c7 05 9c 83 10 00 00 	movl   $0x0,0x10839c
  1002c3:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002c6:	c7 05 a4 83 10 00 01 	movl   $0x1,0x1083a4
  1002cd:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d0:	c7 05 f8 83 10 00 00 	movl   $0x0,0x1083f8
  1002d7:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002da:	c7 05 00 84 10 00 02 	movl   $0x2,0x108400
  1002e1:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002e4:	c7 05 54 84 10 00 00 	movl   $0x0,0x108454
  1002eb:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ee:	c7 05 5c 84 10 00 03 	movl   $0x3,0x10845c
  1002f5:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002f8:	c7 05 b0 84 10 00 00 	movl   $0x0,0x1084b0
  1002ff:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100302:	c7 05 b8 84 10 00 04 	movl   $0x4,0x1084b8
  100309:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10030c:	c7 05 0c 85 10 00 00 	movl   $0x0,0x10850c
  100313:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100316:	83 ec 0c             	sub    $0xc,%esp
  100319:	53                   	push   %ebx
  10031a:	e8 91 02 00 00       	call   1005b0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10031f:	58                   	pop    %eax
  100320:	5a                   	pop    %edx
  100321:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100324:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

                // Set sharing values
                proc->p_ran = 0;
                proc->p_share = 1; //By default
  100327:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10032d:	50                   	push   %eax
  10032e:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

                // Set sharing values
                proc->p_ran = 0;
                proc->p_share = 1; //By default
  10032f:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100330:	e8 b7 02 00 00       	call   1005ec <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100335:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100338:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)

                // Set sharing values
                proc->p_ran = 0;
  10033f:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
                proc->p_share = 1; //By default
  100346:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
  10034d:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100350:	83 fe 04             	cmp    $0x4,%esi
  100353:	75 c1                	jne    100316 <start+0xa8>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);
  100355:	83 ec 0c             	sub    $0xc,%esp
  100358:	68 a4 83 10 00       	push   $0x1083a4
                proc->p_share = 1; //By default
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10035d:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100364:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;
  100367:	c7 05 80 8d 10 00 03 	movl   $0x3,0x108d80
  10036e:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100371:	e8 23 02 00 00       	call   100599 <run>
  100376:	90                   	nop
  100377:	90                   	nop

00100378 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100378:	b8 14 85 10 00       	mov    $0x108514,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10037d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100382:	89 c2                	mov    %eax,%edx
  100384:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100387:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100388:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10038d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100390:	66 a3 e6 1b 10 00    	mov    %ax,0x101be6
  100396:	c1 e8 18             	shr    $0x18,%eax
  100399:	88 15 e8 1b 10 00    	mov    %dl,0x101be8
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10039f:	ba 7c 85 10 00       	mov    $0x10857c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a4:	a2 eb 1b 10 00       	mov    %al,0x101beb
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003ab:	66 c7 05 e4 1b 10 00 	movw   $0x68,0x101be4
  1003b2:	68 00 
  1003b4:	c6 05 ea 1b 10 00 40 	movb   $0x40,0x101bea
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003bb:	c6 05 e9 1b 10 00 89 	movb   $0x89,0x101be9

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003c2:	c7 05 18 85 10 00 00 	movl   $0x180000,0x108518
  1003c9:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003cc:	66 c7 05 1c 85 10 00 	movw   $0x10,0x10851c
  1003d3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d5:	66 89 0c c5 7c 85 10 	mov    %cx,0x10857c(,%eax,8)
  1003dc:	00 
  1003dd:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003e4:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003e9:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003ee:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003f3:	40                   	inc    %eax
  1003f4:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003f9:	75 da                	jne    1003d5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003fb:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100400:	ba 7c 85 10 00       	mov    $0x10857c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100405:	66 a3 7c 86 10 00    	mov    %ax,0x10867c
  10040b:	c1 e8 10             	shr    $0x10,%eax
  10040e:	66 a3 82 86 10 00    	mov    %ax,0x108682
  100414:	b8 30 00 00 00       	mov    $0x30,%eax
  100419:	66 c7 05 7e 86 10 00 	movw   $0x8,0x10867e
  100420:	08 00 
  100422:	c6 05 80 86 10 00 00 	movb   $0x0,0x108680
  100429:	c6 05 81 86 10 00 8e 	movb   $0x8e,0x108681

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100430:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100437:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10043e:	66 89 0c c5 7c 85 10 	mov    %cx,0x10857c(,%eax,8)
  100445:	00 
  100446:	c1 e9 10             	shr    $0x10,%ecx
  100449:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10044e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100453:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100458:	40                   	inc    %eax
  100459:	83 f8 3a             	cmp    $0x3a,%eax
  10045c:	75 d2                	jne    100430 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10045e:	b0 28                	mov    $0x28,%al
  100460:	0f 01 15 ac 1b 10 00 	lgdtl  0x101bac
  100467:	0f 00 d8             	ltr    %ax
  10046a:	0f 01 1d b4 1b 10 00 	lidtl  0x101bb4
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100471:	5b                   	pop    %ebx
  100472:	c3                   	ret    

00100473 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100473:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100474:	b0 ff                	mov    $0xff,%al
  100476:	57                   	push   %edi
  100477:	56                   	push   %esi
  100478:	53                   	push   %ebx
  100479:	bb 21 00 00 00       	mov    $0x21,%ebx
  10047e:	89 da                	mov    %ebx,%edx
  100480:	ee                   	out    %al,(%dx)
  100481:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100486:	89 ca                	mov    %ecx,%edx
  100488:	ee                   	out    %al,(%dx)
  100489:	be 11 00 00 00       	mov    $0x11,%esi
  10048e:	bf 20 00 00 00       	mov    $0x20,%edi
  100493:	89 f0                	mov    %esi,%eax
  100495:	89 fa                	mov    %edi,%edx
  100497:	ee                   	out    %al,(%dx)
  100498:	b0 20                	mov    $0x20,%al
  10049a:	89 da                	mov    %ebx,%edx
  10049c:	ee                   	out    %al,(%dx)
  10049d:	b0 04                	mov    $0x4,%al
  10049f:	ee                   	out    %al,(%dx)
  1004a0:	b0 03                	mov    $0x3,%al
  1004a2:	ee                   	out    %al,(%dx)
  1004a3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004a8:	89 f0                	mov    %esi,%eax
  1004aa:	89 ea                	mov    %ebp,%edx
  1004ac:	ee                   	out    %al,(%dx)
  1004ad:	b0 28                	mov    $0x28,%al
  1004af:	89 ca                	mov    %ecx,%edx
  1004b1:	ee                   	out    %al,(%dx)
  1004b2:	b0 02                	mov    $0x2,%al
  1004b4:	ee                   	out    %al,(%dx)
  1004b5:	b0 01                	mov    $0x1,%al
  1004b7:	ee                   	out    %al,(%dx)
  1004b8:	b0 68                	mov    $0x68,%al
  1004ba:	89 fa                	mov    %edi,%edx
  1004bc:	ee                   	out    %al,(%dx)
  1004bd:	be 0a 00 00 00       	mov    $0xa,%esi
  1004c2:	89 f0                	mov    %esi,%eax
  1004c4:	ee                   	out    %al,(%dx)
  1004c5:	b0 68                	mov    $0x68,%al
  1004c7:	89 ea                	mov    %ebp,%edx
  1004c9:	ee                   	out    %al,(%dx)
  1004ca:	89 f0                	mov    %esi,%eax
  1004cc:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004cd:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004d2:	89 da                	mov    %ebx,%edx
  1004d4:	19 c0                	sbb    %eax,%eax
  1004d6:	f7 d0                	not    %eax
  1004d8:	05 ff 00 00 00       	add    $0xff,%eax
  1004dd:	ee                   	out    %al,(%dx)
  1004de:	b0 ff                	mov    $0xff,%al
  1004e0:	89 ca                	mov    %ecx,%edx
  1004e2:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004e3:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004e8:	74 0d                	je     1004f7 <interrupt_controller_init+0x84>
  1004ea:	b2 43                	mov    $0x43,%dl
  1004ec:	b0 34                	mov    $0x34,%al
  1004ee:	ee                   	out    %al,(%dx)
  1004ef:	b0 55                	mov    $0x55,%al
  1004f1:	b2 40                	mov    $0x40,%dl
  1004f3:	ee                   	out    %al,(%dx)
  1004f4:	b0 02                	mov    $0x2,%al
  1004f6:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004f7:	5b                   	pop    %ebx
  1004f8:	5e                   	pop    %esi
  1004f9:	5f                   	pop    %edi
  1004fa:	5d                   	pop    %ebp
  1004fb:	c3                   	ret    

001004fc <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004fc:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004fd:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004ff:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100500:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100507:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10050a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100510:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100516:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100519:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10051e:	75 ea                	jne    10050a <console_clear+0xe>
  100520:	be d4 03 00 00       	mov    $0x3d4,%esi
  100525:	b0 0e                	mov    $0xe,%al
  100527:	89 f2                	mov    %esi,%edx
  100529:	ee                   	out    %al,(%dx)
  10052a:	31 c9                	xor    %ecx,%ecx
  10052c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100531:	88 c8                	mov    %cl,%al
  100533:	89 da                	mov    %ebx,%edx
  100535:	ee                   	out    %al,(%dx)
  100536:	b0 0f                	mov    $0xf,%al
  100538:	89 f2                	mov    %esi,%edx
  10053a:	ee                   	out    %al,(%dx)
  10053b:	88 c8                	mov    %cl,%al
  10053d:	89 da                	mov    %ebx,%edx
  10053f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100540:	5b                   	pop    %ebx
  100541:	5e                   	pop    %esi
  100542:	c3                   	ret    

00100543 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100543:	ba 64 00 00 00       	mov    $0x64,%edx
  100548:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100549:	a8 01                	test   $0x1,%al
  10054b:	74 45                	je     100592 <console_read_digit+0x4f>
  10054d:	b2 60                	mov    $0x60,%dl
  10054f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100550:	8d 50 fe             	lea    -0x2(%eax),%edx
  100553:	80 fa 08             	cmp    $0x8,%dl
  100556:	77 05                	ja     10055d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100558:	0f b6 c0             	movzbl %al,%eax
  10055b:	48                   	dec    %eax
  10055c:	c3                   	ret    
	else if (data == 0x0B)
  10055d:	3c 0b                	cmp    $0xb,%al
  10055f:	74 35                	je     100596 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100561:	8d 50 b9             	lea    -0x47(%eax),%edx
  100564:	80 fa 02             	cmp    $0x2,%dl
  100567:	77 07                	ja     100570 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100569:	0f b6 c0             	movzbl %al,%eax
  10056c:	83 e8 40             	sub    $0x40,%eax
  10056f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100570:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100573:	80 fa 02             	cmp    $0x2,%dl
  100576:	77 07                	ja     10057f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100578:	0f b6 c0             	movzbl %al,%eax
  10057b:	83 e8 47             	sub    $0x47,%eax
  10057e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10057f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100582:	80 fa 02             	cmp    $0x2,%dl
  100585:	77 07                	ja     10058e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100587:	0f b6 c0             	movzbl %al,%eax
  10058a:	83 e8 4e             	sub    $0x4e,%eax
  10058d:	c3                   	ret    
	else if (data == 0x53)
  10058e:	3c 53                	cmp    $0x53,%al
  100590:	74 04                	je     100596 <console_read_digit+0x53>
  100592:	83 c8 ff             	or     $0xffffffff,%eax
  100595:	c3                   	ret    
  100596:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100598:	c3                   	ret    

00100599 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100599:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10059d:	a3 7c 8d 10 00       	mov    %eax,0x108d7c

	asm volatile("movl %0,%%esp\n\t"
  1005a2:	83 c0 04             	add    $0x4,%eax
  1005a5:	89 c4                	mov    %eax,%esp
  1005a7:	61                   	popa   
  1005a8:	07                   	pop    %es
  1005a9:	1f                   	pop    %ds
  1005aa:	83 c4 08             	add    $0x8,%esp
  1005ad:	cf                   	iret   
  1005ae:	eb fe                	jmp    1005ae <run+0x15>

001005b0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005b0:	53                   	push   %ebx
  1005b1:	83 ec 0c             	sub    $0xc,%esp
  1005b4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005b8:	6a 44                	push   $0x44
  1005ba:	6a 00                	push   $0x0
  1005bc:	8d 43 04             	lea    0x4(%ebx),%eax
  1005bf:	50                   	push   %eax
  1005c0:	e8 17 01 00 00       	call   1006dc <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005c5:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005cb:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005d1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005d7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005dd:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005e4:	83 c4 18             	add    $0x18,%esp
  1005e7:	5b                   	pop    %ebx
  1005e8:	c3                   	ret    
  1005e9:	90                   	nop
  1005ea:	90                   	nop
  1005eb:	90                   	nop

001005ec <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005ec:	55                   	push   %ebp
  1005ed:	57                   	push   %edi
  1005ee:	56                   	push   %esi
  1005ef:	53                   	push   %ebx
  1005f0:	83 ec 1c             	sub    $0x1c,%esp
  1005f3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005f7:	83 f8 03             	cmp    $0x3,%eax
  1005fa:	7f 04                	jg     100600 <program_loader+0x14>
  1005fc:	85 c0                	test   %eax,%eax
  1005fe:	79 02                	jns    100602 <program_loader+0x16>
  100600:	eb fe                	jmp    100600 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100602:	8b 34 c5 ec 1b 10 00 	mov    0x101bec(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100609:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10060f:	74 02                	je     100613 <program_loader+0x27>
  100611:	eb fe                	jmp    100611 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100613:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100616:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10061a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10061c:	c1 e5 05             	shl    $0x5,%ebp
  10061f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100622:	eb 3f                	jmp    100663 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100624:	83 3b 01             	cmpl   $0x1,(%ebx)
  100627:	75 37                	jne    100660 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100629:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10062c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10062f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100632:	01 c7                	add    %eax,%edi
	memsz += va;
  100634:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100636:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10063b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10063f:	52                   	push   %edx
  100640:	89 fa                	mov    %edi,%edx
  100642:	29 c2                	sub    %eax,%edx
  100644:	52                   	push   %edx
  100645:	8b 53 04             	mov    0x4(%ebx),%edx
  100648:	01 f2                	add    %esi,%edx
  10064a:	52                   	push   %edx
  10064b:	50                   	push   %eax
  10064c:	e8 27 00 00 00       	call   100678 <memcpy>
  100651:	83 c4 10             	add    $0x10,%esp
  100654:	eb 04                	jmp    10065a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100656:	c6 07 00             	movb   $0x0,(%edi)
  100659:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10065a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10065e:	72 f6                	jb     100656 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100660:	83 c3 20             	add    $0x20,%ebx
  100663:	39 eb                	cmp    %ebp,%ebx
  100665:	72 bd                	jb     100624 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100667:	8b 56 18             	mov    0x18(%esi),%edx
  10066a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10066e:	89 10                	mov    %edx,(%eax)
}
  100670:	83 c4 1c             	add    $0x1c,%esp
  100673:	5b                   	pop    %ebx
  100674:	5e                   	pop    %esi
  100675:	5f                   	pop    %edi
  100676:	5d                   	pop    %ebp
  100677:	c3                   	ret    

00100678 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100678:	56                   	push   %esi
  100679:	31 d2                	xor    %edx,%edx
  10067b:	53                   	push   %ebx
  10067c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100680:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100684:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100688:	eb 08                	jmp    100692 <memcpy+0x1a>
		*d++ = *s++;
  10068a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10068d:	4e                   	dec    %esi
  10068e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100691:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100692:	85 f6                	test   %esi,%esi
  100694:	75 f4                	jne    10068a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100696:	5b                   	pop    %ebx
  100697:	5e                   	pop    %esi
  100698:	c3                   	ret    

00100699 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100699:	57                   	push   %edi
  10069a:	56                   	push   %esi
  10069b:	53                   	push   %ebx
  10069c:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006a0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006a4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006a8:	39 c7                	cmp    %eax,%edi
  1006aa:	73 26                	jae    1006d2 <memmove+0x39>
  1006ac:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006af:	39 c6                	cmp    %eax,%esi
  1006b1:	76 1f                	jbe    1006d2 <memmove+0x39>
		s += n, d += n;
  1006b3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006b6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006b8:	eb 07                	jmp    1006c1 <memmove+0x28>
			*--d = *--s;
  1006ba:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006bd:	4a                   	dec    %edx
  1006be:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006c1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006c2:	85 d2                	test   %edx,%edx
  1006c4:	75 f4                	jne    1006ba <memmove+0x21>
  1006c6:	eb 10                	jmp    1006d8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006c8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006cb:	4a                   	dec    %edx
  1006cc:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006cf:	41                   	inc    %ecx
  1006d0:	eb 02                	jmp    1006d4 <memmove+0x3b>
  1006d2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006d4:	85 d2                	test   %edx,%edx
  1006d6:	75 f0                	jne    1006c8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006d8:	5b                   	pop    %ebx
  1006d9:	5e                   	pop    %esi
  1006da:	5f                   	pop    %edi
  1006db:	c3                   	ret    

001006dc <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006dc:	53                   	push   %ebx
  1006dd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006e1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006e5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006e9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006eb:	eb 04                	jmp    1006f1 <memset+0x15>
		*p++ = c;
  1006ed:	88 1a                	mov    %bl,(%edx)
  1006ef:	49                   	dec    %ecx
  1006f0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006f1:	85 c9                	test   %ecx,%ecx
  1006f3:	75 f8                	jne    1006ed <memset+0x11>
		*p++ = c;
	return v;
}
  1006f5:	5b                   	pop    %ebx
  1006f6:	c3                   	ret    

001006f7 <strlen>:

size_t
strlen(const char *s)
{
  1006f7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006fb:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006fd:	eb 01                	jmp    100700 <strlen+0x9>
		++n;
  1006ff:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100700:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100704:	75 f9                	jne    1006ff <strlen+0x8>
		++n;
	return n;
}
  100706:	c3                   	ret    

00100707 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100707:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10070b:	31 c0                	xor    %eax,%eax
  10070d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100711:	eb 01                	jmp    100714 <strnlen+0xd>
		++n;
  100713:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100714:	39 d0                	cmp    %edx,%eax
  100716:	74 06                	je     10071e <strnlen+0x17>
  100718:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10071c:	75 f5                	jne    100713 <strnlen+0xc>
		++n;
	return n;
}
  10071e:	c3                   	ret    

0010071f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10071f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100720:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100725:	53                   	push   %ebx
  100726:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100728:	76 05                	jbe    10072f <console_putc+0x10>
  10072a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10072f:	80 fa 0a             	cmp    $0xa,%dl
  100732:	75 2c                	jne    100760 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100734:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10073a:	be 50 00 00 00       	mov    $0x50,%esi
  10073f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100741:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100744:	99                   	cltd   
  100745:	f7 fe                	idiv   %esi
  100747:	89 de                	mov    %ebx,%esi
  100749:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10074b:	eb 07                	jmp    100754 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10074d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100750:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100751:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100754:	83 f8 50             	cmp    $0x50,%eax
  100757:	75 f4                	jne    10074d <console_putc+0x2e>
  100759:	29 d0                	sub    %edx,%eax
  10075b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10075e:	eb 0b                	jmp    10076b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100760:	0f b6 d2             	movzbl %dl,%edx
  100763:	09 ca                	or     %ecx,%edx
  100765:	66 89 13             	mov    %dx,(%ebx)
  100768:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10076b:	5b                   	pop    %ebx
  10076c:	5e                   	pop    %esi
  10076d:	c3                   	ret    

0010076e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10076e:	56                   	push   %esi
  10076f:	53                   	push   %ebx
  100770:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100774:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100777:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10077b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100780:	75 04                	jne    100786 <fill_numbuf+0x18>
  100782:	85 d2                	test   %edx,%edx
  100784:	74 10                	je     100796 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100786:	89 d0                	mov    %edx,%eax
  100788:	31 d2                	xor    %edx,%edx
  10078a:	f7 f1                	div    %ecx
  10078c:	4b                   	dec    %ebx
  10078d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100790:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100792:	89 c2                	mov    %eax,%edx
  100794:	eb ec                	jmp    100782 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100796:	89 d8                	mov    %ebx,%eax
  100798:	5b                   	pop    %ebx
  100799:	5e                   	pop    %esi
  10079a:	c3                   	ret    

0010079b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10079b:	55                   	push   %ebp
  10079c:	57                   	push   %edi
  10079d:	56                   	push   %esi
  10079e:	53                   	push   %ebx
  10079f:	83 ec 38             	sub    $0x38,%esp
  1007a2:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007a6:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007aa:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007ae:	e9 60 03 00 00       	jmp    100b13 <console_vprintf+0x378>
		if (*format != '%') {
  1007b3:	80 fa 25             	cmp    $0x25,%dl
  1007b6:	74 13                	je     1007cb <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007b8:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007bc:	0f b6 d2             	movzbl %dl,%edx
  1007bf:	89 f0                	mov    %esi,%eax
  1007c1:	e8 59 ff ff ff       	call   10071f <console_putc>
  1007c6:	e9 45 03 00 00       	jmp    100b10 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007cb:	47                   	inc    %edi
  1007cc:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007d3:	00 
  1007d4:	eb 12                	jmp    1007e8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007d6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007d7:	8a 11                	mov    (%ecx),%dl
  1007d9:	84 d2                	test   %dl,%dl
  1007db:	74 1a                	je     1007f7 <console_vprintf+0x5c>
  1007dd:	89 e8                	mov    %ebp,%eax
  1007df:	38 c2                	cmp    %al,%dl
  1007e1:	75 f3                	jne    1007d6 <console_vprintf+0x3b>
  1007e3:	e9 3f 03 00 00       	jmp    100b27 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007e8:	8a 17                	mov    (%edi),%dl
  1007ea:	84 d2                	test   %dl,%dl
  1007ec:	74 0b                	je     1007f9 <console_vprintf+0x5e>
  1007ee:	b9 7c 0b 10 00       	mov    $0x100b7c,%ecx
  1007f3:	89 d5                	mov    %edx,%ebp
  1007f5:	eb e0                	jmp    1007d7 <console_vprintf+0x3c>
  1007f7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007f9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007fc:	3c 08                	cmp    $0x8,%al
  1007fe:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100805:	00 
  100806:	76 13                	jbe    10081b <console_vprintf+0x80>
  100808:	eb 1d                	jmp    100827 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10080a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10080f:	0f be c0             	movsbl %al,%eax
  100812:	47                   	inc    %edi
  100813:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100817:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10081b:	8a 07                	mov    (%edi),%al
  10081d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100820:	80 fa 09             	cmp    $0x9,%dl
  100823:	76 e5                	jbe    10080a <console_vprintf+0x6f>
  100825:	eb 18                	jmp    10083f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100827:	80 fa 2a             	cmp    $0x2a,%dl
  10082a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100831:	ff 
  100832:	75 0b                	jne    10083f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100834:	83 c3 04             	add    $0x4,%ebx
			++format;
  100837:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100838:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10083b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10083f:	83 cd ff             	or     $0xffffffff,%ebp
  100842:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100845:	75 37                	jne    10087e <console_vprintf+0xe3>
			++format;
  100847:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100848:	31 ed                	xor    %ebp,%ebp
  10084a:	8a 07                	mov    (%edi),%al
  10084c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10084f:	80 fa 09             	cmp    $0x9,%dl
  100852:	76 0d                	jbe    100861 <console_vprintf+0xc6>
  100854:	eb 17                	jmp    10086d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100856:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100859:	0f be c0             	movsbl %al,%eax
  10085c:	47                   	inc    %edi
  10085d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100861:	8a 07                	mov    (%edi),%al
  100863:	8d 50 d0             	lea    -0x30(%eax),%edx
  100866:	80 fa 09             	cmp    $0x9,%dl
  100869:	76 eb                	jbe    100856 <console_vprintf+0xbb>
  10086b:	eb 11                	jmp    10087e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10086d:	3c 2a                	cmp    $0x2a,%al
  10086f:	75 0b                	jne    10087c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100871:	83 c3 04             	add    $0x4,%ebx
				++format;
  100874:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100875:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100878:	85 ed                	test   %ebp,%ebp
  10087a:	79 02                	jns    10087e <console_vprintf+0xe3>
  10087c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10087e:	8a 07                	mov    (%edi),%al
  100880:	3c 64                	cmp    $0x64,%al
  100882:	74 34                	je     1008b8 <console_vprintf+0x11d>
  100884:	7f 1d                	jg     1008a3 <console_vprintf+0x108>
  100886:	3c 58                	cmp    $0x58,%al
  100888:	0f 84 a2 00 00 00    	je     100930 <console_vprintf+0x195>
  10088e:	3c 63                	cmp    $0x63,%al
  100890:	0f 84 bf 00 00 00    	je     100955 <console_vprintf+0x1ba>
  100896:	3c 43                	cmp    $0x43,%al
  100898:	0f 85 d0 00 00 00    	jne    10096e <console_vprintf+0x1d3>
  10089e:	e9 a3 00 00 00       	jmp    100946 <console_vprintf+0x1ab>
  1008a3:	3c 75                	cmp    $0x75,%al
  1008a5:	74 4d                	je     1008f4 <console_vprintf+0x159>
  1008a7:	3c 78                	cmp    $0x78,%al
  1008a9:	74 5c                	je     100907 <console_vprintf+0x16c>
  1008ab:	3c 73                	cmp    $0x73,%al
  1008ad:	0f 85 bb 00 00 00    	jne    10096e <console_vprintf+0x1d3>
  1008b3:	e9 86 00 00 00       	jmp    10093e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008b8:	83 c3 04             	add    $0x4,%ebx
  1008bb:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008be:	89 d1                	mov    %edx,%ecx
  1008c0:	c1 f9 1f             	sar    $0x1f,%ecx
  1008c3:	89 0c 24             	mov    %ecx,(%esp)
  1008c6:	31 ca                	xor    %ecx,%edx
  1008c8:	55                   	push   %ebp
  1008c9:	29 ca                	sub    %ecx,%edx
  1008cb:	68 84 0b 10 00       	push   $0x100b84
  1008d0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008d5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008d9:	e8 90 fe ff ff       	call   10076e <fill_numbuf>
  1008de:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008e2:	58                   	pop    %eax
  1008e3:	5a                   	pop    %edx
  1008e4:	ba 01 00 00 00       	mov    $0x1,%edx
  1008e9:	8b 04 24             	mov    (%esp),%eax
  1008ec:	83 e0 01             	and    $0x1,%eax
  1008ef:	e9 a5 00 00 00       	jmp    100999 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008f4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008f7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008fc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008ff:	55                   	push   %ebp
  100900:	68 84 0b 10 00       	push   $0x100b84
  100905:	eb 11                	jmp    100918 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100907:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10090a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10090d:	55                   	push   %ebp
  10090e:	68 98 0b 10 00       	push   $0x100b98
  100913:	b9 10 00 00 00       	mov    $0x10,%ecx
  100918:	8d 44 24 40          	lea    0x40(%esp),%eax
  10091c:	e8 4d fe ff ff       	call   10076e <fill_numbuf>
  100921:	ba 01 00 00 00       	mov    $0x1,%edx
  100926:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10092a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10092c:	59                   	pop    %ecx
  10092d:	59                   	pop    %ecx
  10092e:	eb 69                	jmp    100999 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100930:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100933:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100936:	55                   	push   %ebp
  100937:	68 84 0b 10 00       	push   $0x100b84
  10093c:	eb d5                	jmp    100913 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10093e:	83 c3 04             	add    $0x4,%ebx
  100941:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100944:	eb 40                	jmp    100986 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100946:	83 c3 04             	add    $0x4,%ebx
  100949:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10094c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100950:	e9 bd 01 00 00       	jmp    100b12 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100955:	83 c3 04             	add    $0x4,%ebx
  100958:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10095b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10095f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100964:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100968:	88 44 24 24          	mov    %al,0x24(%esp)
  10096c:	eb 27                	jmp    100995 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10096e:	84 c0                	test   %al,%al
  100970:	75 02                	jne    100974 <console_vprintf+0x1d9>
  100972:	b0 25                	mov    $0x25,%al
  100974:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100978:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10097d:	80 3f 00             	cmpb   $0x0,(%edi)
  100980:	74 0a                	je     10098c <console_vprintf+0x1f1>
  100982:	8d 44 24 24          	lea    0x24(%esp),%eax
  100986:	89 44 24 04          	mov    %eax,0x4(%esp)
  10098a:	eb 09                	jmp    100995 <console_vprintf+0x1fa>
				format--;
  10098c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100990:	4f                   	dec    %edi
  100991:	89 54 24 04          	mov    %edx,0x4(%esp)
  100995:	31 d2                	xor    %edx,%edx
  100997:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100999:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10099b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10099e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009a5:	74 1f                	je     1009c6 <console_vprintf+0x22b>
  1009a7:	89 04 24             	mov    %eax,(%esp)
  1009aa:	eb 01                	jmp    1009ad <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009ac:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009ad:	39 e9                	cmp    %ebp,%ecx
  1009af:	74 0a                	je     1009bb <console_vprintf+0x220>
  1009b1:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009b5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009b9:	75 f1                	jne    1009ac <console_vprintf+0x211>
  1009bb:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009be:	89 0c 24             	mov    %ecx,(%esp)
  1009c1:	eb 1f                	jmp    1009e2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009c3:	42                   	inc    %edx
  1009c4:	eb 09                	jmp    1009cf <console_vprintf+0x234>
  1009c6:	89 d1                	mov    %edx,%ecx
  1009c8:	8b 14 24             	mov    (%esp),%edx
  1009cb:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009cf:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009d3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009d7:	75 ea                	jne    1009c3 <console_vprintf+0x228>
  1009d9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009dd:	89 14 24             	mov    %edx,(%esp)
  1009e0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009e2:	85 c0                	test   %eax,%eax
  1009e4:	74 0c                	je     1009f2 <console_vprintf+0x257>
  1009e6:	84 d2                	test   %dl,%dl
  1009e8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009ef:	00 
  1009f0:	75 24                	jne    100a16 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009f2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009f7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009fe:	00 
  1009ff:	75 15                	jne    100a16 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a01:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a05:	83 e0 08             	and    $0x8,%eax
  100a08:	83 f8 01             	cmp    $0x1,%eax
  100a0b:	19 c9                	sbb    %ecx,%ecx
  100a0d:	f7 d1                	not    %ecx
  100a0f:	83 e1 20             	and    $0x20,%ecx
  100a12:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a16:	3b 2c 24             	cmp    (%esp),%ebp
  100a19:	7e 0d                	jle    100a28 <console_vprintf+0x28d>
  100a1b:	84 d2                	test   %dl,%dl
  100a1d:	74 40                	je     100a5f <console_vprintf+0x2c4>
			zeros = precision - len;
  100a1f:	2b 2c 24             	sub    (%esp),%ebp
  100a22:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a26:	eb 3f                	jmp    100a67 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a28:	84 d2                	test   %dl,%dl
  100a2a:	74 33                	je     100a5f <console_vprintf+0x2c4>
  100a2c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a30:	83 e0 06             	and    $0x6,%eax
  100a33:	83 f8 02             	cmp    $0x2,%eax
  100a36:	75 27                	jne    100a5f <console_vprintf+0x2c4>
  100a38:	45                   	inc    %ebp
  100a39:	75 24                	jne    100a5f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a3b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a3d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a40:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a45:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a48:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a4b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a4f:	7d 0e                	jge    100a5f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a51:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a55:	29 ca                	sub    %ecx,%edx
  100a57:	29 c2                	sub    %eax,%edx
  100a59:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a5d:	eb 08                	jmp    100a67 <console_vprintf+0x2cc>
  100a5f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a66:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a67:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a6b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a6d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a71:	2b 2c 24             	sub    (%esp),%ebp
  100a74:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a79:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a7c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a7f:	29 c5                	sub    %eax,%ebp
  100a81:	89 f0                	mov    %esi,%eax
  100a83:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a87:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a8b:	eb 0f                	jmp    100a9c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a8d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a91:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a96:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a97:	e8 83 fc ff ff       	call   10071f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a9c:	85 ed                	test   %ebp,%ebp
  100a9e:	7e 07                	jle    100aa7 <console_vprintf+0x30c>
  100aa0:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100aa5:	74 e6                	je     100a8d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100aa7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100aac:	89 c6                	mov    %eax,%esi
  100aae:	74 23                	je     100ad3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ab0:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ab5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ab9:	e8 61 fc ff ff       	call   10071f <console_putc>
  100abe:	89 c6                	mov    %eax,%esi
  100ac0:	eb 11                	jmp    100ad3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100ac2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100acb:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100acc:	e8 4e fc ff ff       	call   10071f <console_putc>
  100ad1:	eb 06                	jmp    100ad9 <console_vprintf+0x33e>
  100ad3:	89 f0                	mov    %esi,%eax
  100ad5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ad9:	85 f6                	test   %esi,%esi
  100adb:	7f e5                	jg     100ac2 <console_vprintf+0x327>
  100add:	8b 34 24             	mov    (%esp),%esi
  100ae0:	eb 15                	jmp    100af7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ae2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ae6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100ae7:	0f b6 11             	movzbl (%ecx),%edx
  100aea:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aee:	e8 2c fc ff ff       	call   10071f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100af3:	ff 44 24 04          	incl   0x4(%esp)
  100af7:	85 f6                	test   %esi,%esi
  100af9:	7f e7                	jg     100ae2 <console_vprintf+0x347>
  100afb:	eb 0f                	jmp    100b0c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100afd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b01:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b06:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b07:	e8 13 fc ff ff       	call   10071f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b0c:	85 ed                	test   %ebp,%ebp
  100b0e:	7f ed                	jg     100afd <console_vprintf+0x362>
  100b10:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b12:	47                   	inc    %edi
  100b13:	8a 17                	mov    (%edi),%dl
  100b15:	84 d2                	test   %dl,%dl
  100b17:	0f 85 96 fc ff ff    	jne    1007b3 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b1d:	83 c4 38             	add    $0x38,%esp
  100b20:	89 f0                	mov    %esi,%eax
  100b22:	5b                   	pop    %ebx
  100b23:	5e                   	pop    %esi
  100b24:	5f                   	pop    %edi
  100b25:	5d                   	pop    %ebp
  100b26:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b27:	81 e9 7c 0b 10 00    	sub    $0x100b7c,%ecx
  100b2d:	b8 01 00 00 00       	mov    $0x1,%eax
  100b32:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b34:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b35:	09 44 24 14          	or     %eax,0x14(%esp)
  100b39:	e9 aa fc ff ff       	jmp    1007e8 <console_vprintf+0x4d>

00100b3e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b3e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b42:	50                   	push   %eax
  100b43:	ff 74 24 10          	pushl  0x10(%esp)
  100b47:	ff 74 24 10          	pushl  0x10(%esp)
  100b4b:	ff 74 24 10          	pushl  0x10(%esp)
  100b4f:	e8 47 fc ff ff       	call   10079b <console_vprintf>
  100b54:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b57:	c3                   	ret    
