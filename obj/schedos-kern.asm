
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
  100014:	e8 6c 02 00 00       	call   100285 <start>
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
  10006d:	e8 97 01 00 00       	call   100209 <interrupt>

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
  10009c:	a1 48 8c 10 00       	mov    0x108c48,%eax
 *
 *****************************************************************************/

void
schedule(void)
{
  1000a1:	57                   	push   %edi
  1000a2:	56                   	push   %esi
  1000a3:	53                   	push   %ebx
	pid_t pid = current->p_pid;
  1000a4:	8b 30                	mov    (%eax),%esi

	if (scheduling_algorithm == 0)
  1000a6:	a1 4c 8c 10 00       	mov    0x108c4c,%eax
  1000ab:	85 c0                	test   %eax,%eax
  1000ad:	75 21                	jne    1000d0 <schedule+0x34>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000af:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b4:	8d 46 01             	lea    0x1(%esi),%eax
  1000b7:	99                   	cltd   
  1000b8:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ba:	6b c2 54             	imul   $0x54,%edx,%eax
{
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000bd:	89 d6                	mov    %edx,%esi

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bf:	83 b8 88 82 10 00 01 	cmpl   $0x1,0x108288(%eax)
  1000c6:	75 ec                	jne    1000b4 <schedule+0x18>
				run(&proc_array[pid]);
  1000c8:	83 ec 0c             	sub    $0xc,%esp
  1000cb:	e9 2e 01 00 00       	jmp    1001fe <schedule+0x162>
		}

	if (scheduling_algorithm == 1)
  1000d0:	83 f8 01             	cmp    $0x1,%eax
  1000d3:	75 46                	jne    10011b <schedule+0x7f>

          while (1) {
                        // Run processes in order of schedos number.
                        for (i = 1; i < NPROCS; i++)
                        {
                          if (proc_array[i].p_state == P_RUNNABLE){
  1000d5:	83 3d dc 82 10 00 01 	cmpl   $0x1,0x1082dc
  1000dc:	8b 1d 30 83 10 00    	mov    0x108330,%ebx
  1000e2:	8b 0d 84 83 10 00    	mov    0x108384,%ecx
  1000e8:	8b 15 d8 83 10 00    	mov    0x1083d8,%edx
  1000ee:	0f 84 04 01 00 00    	je     1001f8 <schedule+0x15c>
  1000f4:	83 fb 01             	cmp    $0x1,%ebx
  1000f7:	75 0a                	jne    100103 <schedule+0x67>
  1000f9:	b8 02 00 00 00       	mov    $0x2,%eax
  1000fe:	e9 f5 00 00 00       	jmp    1001f8 <schedule+0x15c>
  100103:	83 f9 01             	cmp    $0x1,%ecx
  100106:	0f 84 e7 00 00 00    	je     1001f3 <schedule+0x157>
  10010c:	83 fa 01             	cmp    $0x1,%edx
  10010f:	75 e3                	jne    1000f4 <schedule+0x58>
  100111:	b8 04 00 00 00       	mov    $0x4,%eax
  100116:	e9 dd 00 00 00       	jmp    1001f8 <schedule+0x15c>
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
		}
        }

	if (scheduling_algorithm == 2)
  10011b:	83 f8 02             	cmp    $0x2,%eax
  10011e:	75 5d                	jne    10017d <schedule+0xe1>
  100120:	83 c9 ff             	or     $0xffffffff,%ecx
        {
	  int i = 0;
          unsigned int priority = 0xffffffff; // Max value

          while (1) {
                        pid = (pid + 1) % NPROCS;
  100123:	bb 05 00 00 00       	mov    $0x5,%ebx
  100128:	eb 02                	jmp    10012c <schedule+0x90>
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
		}
        }

	if (scheduling_algorithm == 2)
  10012a:	89 c1                	mov    %eax,%ecx
        {
	  int i = 0;
          unsigned int priority = 0xffffffff; // Max value

          while (1) {
                        pid = (pid + 1) % NPROCS;
  10012c:	8d 46 01             	lea    0x1(%esi),%eax
  10012f:	31 ff                	xor    %edi,%edi
  100131:	99                   	cltd   
  100132:	f7 fb                	idiv   %ebx
  100134:	89 d6                	mov    %edx,%esi

                        // Find lowest priority value
                        for (i = 1; i < NPROCS; i++)
                        {
                          if ((proc_array[i].p_priority < priority) && proc_array[i].p_state == P_RUNNABLE)
  100136:	8b 87 d8 82 10 00    	mov    0x1082d8(%edi),%eax
  10013c:	39 c8                	cmp    %ecx,%eax
  10013e:	73 09                	jae    100149 <schedule+0xad>
  100140:	83 bf dc 82 10 00 01 	cmpl   $0x1,0x1082dc(%edi)
  100147:	74 02                	je     10014b <schedule+0xaf>
  100149:	89 c8                	mov    %ecx,%eax
  10014b:	83 c7 54             	add    $0x54,%edi

          while (1) {
                        pid = (pid + 1) % NPROCS;

                        // Find lowest priority value
                        for (i = 1; i < NPROCS; i++)
  10014e:	81 ff 50 01 00 00    	cmp    $0x150,%edi
  100154:	74 04                	je     10015a <schedule+0xbe>
  100156:	89 c1                	mov    %eax,%ecx
  100158:	eb dc                	jmp    100136 <schedule+0x9a>
                          if ((proc_array[i].p_priority < priority) && proc_array[i].p_state == P_RUNNABLE)
                            priority = proc_array[i].p_priority;
                        }

                        // Run processes with highest priority 
                        if (proc_array[pid].p_priority == priority && proc_array[pid].p_state == P_RUNNABLE)
  10015a:	6b d2 54             	imul   $0x54,%edx,%edx
  10015d:	39 82 84 82 10 00    	cmp    %eax,0x108284(%edx)
  100163:	75 c5                	jne    10012a <schedule+0x8e>
  100165:	83 ba 88 82 10 00 01 	cmpl   $0x1,0x108288(%edx)
  10016c:	75 bc                	jne    10012a <schedule+0x8e>
                           run(&proc_array[pid]);
  10016e:	83 ec 0c             	sub    $0xc,%esp
  100171:	81 c2 3c 82 10 00    	add    $0x10823c,%edx
  100177:	52                   	push   %edx
  100178:	e8 24 04 00 00       	call   1005a1 <run>

		}
        }

	if (scheduling_algorithm == 3)
  10017d:	83 f8 03             	cmp    $0x3,%eax
  100180:	75 50                	jne    1001d2 <schedule+0x136>
  100182:	83 c9 ff             	or     $0xffffffff,%ecx
        {
	  int i = 0;
          unsigned int priority = 0xffffffff; // Max value

          while (1) {
                        pid = (pid + 1) % NPROCS;
  100185:	bb 05 00 00 00       	mov    $0x5,%ebx
  10018a:	eb 02                	jmp    10018e <schedule+0xf2>
                           run(&proc_array[pid]);

		}
        }

	if (scheduling_algorithm == 3)
  10018c:	89 c1                	mov    %eax,%ecx
        {
	  int i = 0;
          unsigned int priority = 0xffffffff; // Max value

          while (1) {
                        pid = (pid + 1) % NPROCS;
  10018e:	8d 46 01             	lea    0x1(%esi),%eax
  100191:	31 ff                	xor    %edi,%edi
  100193:	99                   	cltd   
  100194:	f7 fb                	idiv   %ebx
  100196:	89 d6                	mov    %edx,%esi

                        // Find lowest priority value
                        for (i = 1; i < NPROCS; i++)
                        {
                          if ((proc_array[i].p_priority < priority) && proc_array[i].p_state == P_RUNNABLE)
  100198:	8b 87 d8 82 10 00    	mov    0x1082d8(%edi),%eax
  10019e:	39 c8                	cmp    %ecx,%eax
  1001a0:	73 09                	jae    1001ab <schedule+0x10f>
  1001a2:	83 bf dc 82 10 00 01 	cmpl   $0x1,0x1082dc(%edi)
  1001a9:	74 02                	je     1001ad <schedule+0x111>
  1001ab:	89 c8                	mov    %ecx,%eax
  1001ad:	83 c7 54             	add    $0x54,%edi

          while (1) {
                        pid = (pid + 1) % NPROCS;

                        // Find lowest priority value
                        for (i = 1; i < NPROCS; i++)
  1001b0:	81 ff 50 01 00 00    	cmp    $0x150,%edi
  1001b6:	74 04                	je     1001bc <schedule+0x120>
  1001b8:	89 c1                	mov    %eax,%ecx
  1001ba:	eb dc                	jmp    100198 <schedule+0xfc>
                          if ((proc_array[i].p_priority < priority) && proc_array[i].p_state == P_RUNNABLE)
                            priority = proc_array[i].p_priority;
                        }

                        // Run processes with highest priority 
                        if (proc_array[pid].p_priority == priority && proc_array[pid].p_state == P_RUNNABLE)
  1001bc:	6b d2 54             	imul   $0x54,%edx,%edx
  1001bf:	39 82 84 82 10 00    	cmp    %eax,0x108284(%edx)
  1001c5:	75 c5                	jne    10018c <schedule+0xf0>
  1001c7:	83 ba 88 82 10 00 01 	cmpl   $0x1,0x108288(%edx)
  1001ce:	75 bc                	jne    10018c <schedule+0xf0>
  1001d0:	eb 9c                	jmp    10016e <schedule+0xd2>
		}
        }


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001d2:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001d8:	50                   	push   %eax
  1001d9:	68 60 0b 10 00       	push   $0x100b60
  1001de:	68 00 01 00 00       	push   $0x100
  1001e3:	52                   	push   %edx
  1001e4:	e8 5d 09 00 00       	call   100b46 <console_printf>
  1001e9:	83 c4 10             	add    $0x10,%esp
  1001ec:	a3 00 80 19 00       	mov    %eax,0x198000
  1001f1:	eb fe                	jmp    1001f1 <schedule+0x155>
  1001f3:	b8 03 00 00 00       	mov    $0x3,%eax
                            break;
                          }
                        }
			// Run the selected process
			if (highest_priority_pid != 0)
				run(&proc_array[highest_priority_pid]);
  1001f8:	6b c0 54             	imul   $0x54,%eax,%eax
  1001fb:	83 ec 0c             	sub    $0xc,%esp
  1001fe:	05 3c 82 10 00       	add    $0x10823c,%eax
  100203:	50                   	push   %eax
  100204:	e9 6f ff ff ff       	jmp    100178 <schedule+0xdc>

00100209 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100209:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10020a:	8b 3d 48 8c 10 00    	mov    0x108c48,%edi
  100210:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100215:	56                   	push   %esi
  100216:	53                   	push   %ebx
  100217:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10021b:	83 c7 04             	add    $0x4,%edi
  10021e:	89 de                	mov    %ebx,%esi
  100220:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100222:	8b 43 28             	mov    0x28(%ebx),%eax
  100225:	83 f8 31             	cmp    $0x31,%eax
  100228:	74 1f                	je     100249 <interrupt+0x40>
  10022a:	77 0c                	ja     100238 <interrupt+0x2f>
  10022c:	83 f8 20             	cmp    $0x20,%eax
  10022f:	74 4d                	je     10027e <interrupt+0x75>
  100231:	83 f8 30             	cmp    $0x30,%eax
  100234:	74 0e                	je     100244 <interrupt+0x3b>
  100236:	eb 4b                	jmp    100283 <interrupt+0x7a>
  100238:	83 f8 32             	cmp    $0x32,%eax
  10023b:	74 23                	je     100260 <interrupt+0x57>
  10023d:	83 f8 33             	cmp    $0x33,%eax
  100240:	74 2e                	je     100270 <interrupt+0x67>
  100242:	eb 3f                	jmp    100283 <interrupt+0x7a>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100244:	e8 53 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100249:	a1 48 8c 10 00       	mov    0x108c48,%eax
		current->p_exit_status = reg->reg_eax;
  10024e:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100251:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
		current->p_exit_status = reg->reg_eax;
  100258:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  10025b:	e8 3c fe ff ff       	call   10009c <schedule>
                // 4A set priority
	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
                current->p_priority = reg->reg_eax; //Set new priority
  100260:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100263:	a1 48 8c 10 00       	mov    0x108c48,%eax
  100268:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  10026b:	e8 2c fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100270:	83 ec 0c             	sub    $0xc,%esp
  100273:	ff 35 48 8c 10 00    	pushl  0x108c48
  100279:	e8 23 03 00 00       	call   1005a1 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10027e:	e8 19 fe ff ff       	call   10009c <schedule>
  100283:	eb fe                	jmp    100283 <interrupt+0x7a>

00100285 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100285:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100286:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10028b:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10028c:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10028e:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10028f:	bb 90 82 10 00       	mov    $0x108290,%ebx

void
start(void)
{
	int i;
        lock = 0;
  100294:	c7 05 04 80 01 00 00 	movl   $0x0,0x18004
  10029b:	00 00 00 

	// Set up hardware (schedos-x86.c)
	segments_init();
  10029e:	e8 dd 00 00 00       	call   100380 <segments_init>
	interrupt_controller_init(0);
  1002a3:	83 ec 0c             	sub    $0xc,%esp
  1002a6:	6a 00                	push   $0x0
  1002a8:	e8 ce 01 00 00       	call   10047b <interrupt_controller_init>
	console_clear();
  1002ad:	e8 52 02 00 00       	call   100504 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002b2:	83 c4 0c             	add    $0xc,%esp
  1002b5:	68 a4 01 00 00       	push   $0x1a4
  1002ba:	6a 00                	push   $0x0
  1002bc:	68 3c 82 10 00       	push   $0x10823c
  1002c1:	e8 1e 04 00 00       	call   1006e4 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002c6:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002c9:	c7 05 3c 82 10 00 00 	movl   $0x0,0x10823c
  1002d0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d3:	c7 05 88 82 10 00 00 	movl   $0x0,0x108288
  1002da:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002dd:	c7 05 90 82 10 00 01 	movl   $0x1,0x108290
  1002e4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002e7:	c7 05 dc 82 10 00 00 	movl   $0x0,0x1082dc
  1002ee:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002f1:	c7 05 e4 82 10 00 02 	movl   $0x2,0x1082e4
  1002f8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002fb:	c7 05 30 83 10 00 00 	movl   $0x0,0x108330
  100302:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100305:	c7 05 38 83 10 00 03 	movl   $0x3,0x108338
  10030c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10030f:	c7 05 84 83 10 00 00 	movl   $0x0,0x108384
  100316:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100319:	c7 05 8c 83 10 00 04 	movl   $0x4,0x10838c
  100320:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100323:	c7 05 d8 83 10 00 00 	movl   $0x0,0x1083d8
  10032a:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10032d:	83 ec 0c             	sub    $0xc,%esp
  100330:	53                   	push   %ebx
  100331:	e8 82 02 00 00       	call   1005b8 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100336:	58                   	pop    %eax
  100337:	5a                   	pop    %edx
  100338:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10033b:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10033e:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100344:	50                   	push   %eax
  100345:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100346:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100347:	e8 a8 02 00 00       	call   1005f4 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10034c:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10034f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
  100356:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100359:	83 fe 04             	cmp    $0x4,%esi
  10035c:	75 cf                	jne    10032d <start+0xa8>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  10035e:	83 ec 0c             	sub    $0xc,%esp
  100361:	68 90 82 10 00       	push   $0x108290
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100366:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10036d:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;
  100370:	c7 05 4c 8c 10 00 00 	movl   $0x0,0x108c4c
  100377:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10037a:	e8 22 02 00 00       	call   1005a1 <run>
  10037f:	90                   	nop

00100380 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100380:	b8 e0 83 10 00       	mov    $0x1083e0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100385:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10038a:	89 c2                	mov    %eax,%edx
  10038c:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10038f:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100390:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100395:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100398:	66 a3 ee 1b 10 00    	mov    %ax,0x101bee
  10039e:	c1 e8 18             	shr    $0x18,%eax
  1003a1:	88 15 f0 1b 10 00    	mov    %dl,0x101bf0
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a7:	ba 48 84 10 00       	mov    $0x108448,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003ac:	a2 f3 1b 10 00       	mov    %al,0x101bf3
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b1:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b3:	66 c7 05 ec 1b 10 00 	movw   $0x68,0x101bec
  1003ba:	68 00 
  1003bc:	c6 05 f2 1b 10 00 40 	movb   $0x40,0x101bf2
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003c3:	c6 05 f1 1b 10 00 89 	movb   $0x89,0x101bf1

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003ca:	c7 05 e4 83 10 00 00 	movl   $0x180000,0x1083e4
  1003d1:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003d4:	66 c7 05 e8 83 10 00 	movw   $0x10,0x1083e8
  1003db:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003dd:	66 89 0c c5 48 84 10 	mov    %cx,0x108448(,%eax,8)
  1003e4:	00 
  1003e5:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003ec:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003f1:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003f6:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003fb:	40                   	inc    %eax
  1003fc:	3d 00 01 00 00       	cmp    $0x100,%eax
  100401:	75 da                	jne    1003dd <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100403:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100408:	ba 48 84 10 00       	mov    $0x108448,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10040d:	66 a3 48 85 10 00    	mov    %ax,0x108548
  100413:	c1 e8 10             	shr    $0x10,%eax
  100416:	66 a3 4e 85 10 00    	mov    %ax,0x10854e
  10041c:	b8 30 00 00 00       	mov    $0x30,%eax
  100421:	66 c7 05 4a 85 10 00 	movw   $0x8,0x10854a
  100428:	08 00 
  10042a:	c6 05 4c 85 10 00 00 	movb   $0x0,0x10854c
  100431:	c6 05 4d 85 10 00 8e 	movb   $0x8e,0x10854d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100438:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10043f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100446:	66 89 0c c5 48 84 10 	mov    %cx,0x108448(,%eax,8)
  10044d:	00 
  10044e:	c1 e9 10             	shr    $0x10,%ecx
  100451:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100456:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10045b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100460:	40                   	inc    %eax
  100461:	83 f8 3a             	cmp    $0x3a,%eax
  100464:	75 d2                	jne    100438 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100466:	b0 28                	mov    $0x28,%al
  100468:	0f 01 15 b4 1b 10 00 	lgdtl  0x101bb4
  10046f:	0f 00 d8             	ltr    %ax
  100472:	0f 01 1d bc 1b 10 00 	lidtl  0x101bbc
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100479:	5b                   	pop    %ebx
  10047a:	c3                   	ret    

0010047b <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10047b:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10047c:	b0 ff                	mov    $0xff,%al
  10047e:	57                   	push   %edi
  10047f:	56                   	push   %esi
  100480:	53                   	push   %ebx
  100481:	bb 21 00 00 00       	mov    $0x21,%ebx
  100486:	89 da                	mov    %ebx,%edx
  100488:	ee                   	out    %al,(%dx)
  100489:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10048e:	89 ca                	mov    %ecx,%edx
  100490:	ee                   	out    %al,(%dx)
  100491:	be 11 00 00 00       	mov    $0x11,%esi
  100496:	bf 20 00 00 00       	mov    $0x20,%edi
  10049b:	89 f0                	mov    %esi,%eax
  10049d:	89 fa                	mov    %edi,%edx
  10049f:	ee                   	out    %al,(%dx)
  1004a0:	b0 20                	mov    $0x20,%al
  1004a2:	89 da                	mov    %ebx,%edx
  1004a4:	ee                   	out    %al,(%dx)
  1004a5:	b0 04                	mov    $0x4,%al
  1004a7:	ee                   	out    %al,(%dx)
  1004a8:	b0 03                	mov    $0x3,%al
  1004aa:	ee                   	out    %al,(%dx)
  1004ab:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004b0:	89 f0                	mov    %esi,%eax
  1004b2:	89 ea                	mov    %ebp,%edx
  1004b4:	ee                   	out    %al,(%dx)
  1004b5:	b0 28                	mov    $0x28,%al
  1004b7:	89 ca                	mov    %ecx,%edx
  1004b9:	ee                   	out    %al,(%dx)
  1004ba:	b0 02                	mov    $0x2,%al
  1004bc:	ee                   	out    %al,(%dx)
  1004bd:	b0 01                	mov    $0x1,%al
  1004bf:	ee                   	out    %al,(%dx)
  1004c0:	b0 68                	mov    $0x68,%al
  1004c2:	89 fa                	mov    %edi,%edx
  1004c4:	ee                   	out    %al,(%dx)
  1004c5:	be 0a 00 00 00       	mov    $0xa,%esi
  1004ca:	89 f0                	mov    %esi,%eax
  1004cc:	ee                   	out    %al,(%dx)
  1004cd:	b0 68                	mov    $0x68,%al
  1004cf:	89 ea                	mov    %ebp,%edx
  1004d1:	ee                   	out    %al,(%dx)
  1004d2:	89 f0                	mov    %esi,%eax
  1004d4:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004d5:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004da:	89 da                	mov    %ebx,%edx
  1004dc:	19 c0                	sbb    %eax,%eax
  1004de:	f7 d0                	not    %eax
  1004e0:	05 ff 00 00 00       	add    $0xff,%eax
  1004e5:	ee                   	out    %al,(%dx)
  1004e6:	b0 ff                	mov    $0xff,%al
  1004e8:	89 ca                	mov    %ecx,%edx
  1004ea:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004eb:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004f0:	74 0d                	je     1004ff <interrupt_controller_init+0x84>
  1004f2:	b2 43                	mov    $0x43,%dl
  1004f4:	b0 34                	mov    $0x34,%al
  1004f6:	ee                   	out    %al,(%dx)
  1004f7:	b0 55                	mov    $0x55,%al
  1004f9:	b2 40                	mov    $0x40,%dl
  1004fb:	ee                   	out    %al,(%dx)
  1004fc:	b0 02                	mov    $0x2,%al
  1004fe:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004ff:	5b                   	pop    %ebx
  100500:	5e                   	pop    %esi
  100501:	5f                   	pop    %edi
  100502:	5d                   	pop    %ebp
  100503:	c3                   	ret    

00100504 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100504:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100505:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100507:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100508:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10050f:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100512:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100518:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10051e:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100521:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100526:	75 ea                	jne    100512 <console_clear+0xe>
  100528:	be d4 03 00 00       	mov    $0x3d4,%esi
  10052d:	b0 0e                	mov    $0xe,%al
  10052f:	89 f2                	mov    %esi,%edx
  100531:	ee                   	out    %al,(%dx)
  100532:	31 c9                	xor    %ecx,%ecx
  100534:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100539:	88 c8                	mov    %cl,%al
  10053b:	89 da                	mov    %ebx,%edx
  10053d:	ee                   	out    %al,(%dx)
  10053e:	b0 0f                	mov    $0xf,%al
  100540:	89 f2                	mov    %esi,%edx
  100542:	ee                   	out    %al,(%dx)
  100543:	88 c8                	mov    %cl,%al
  100545:	89 da                	mov    %ebx,%edx
  100547:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100548:	5b                   	pop    %ebx
  100549:	5e                   	pop    %esi
  10054a:	c3                   	ret    

0010054b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10054b:	ba 64 00 00 00       	mov    $0x64,%edx
  100550:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100551:	a8 01                	test   $0x1,%al
  100553:	74 45                	je     10059a <console_read_digit+0x4f>
  100555:	b2 60                	mov    $0x60,%dl
  100557:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100558:	8d 50 fe             	lea    -0x2(%eax),%edx
  10055b:	80 fa 08             	cmp    $0x8,%dl
  10055e:	77 05                	ja     100565 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100560:	0f b6 c0             	movzbl %al,%eax
  100563:	48                   	dec    %eax
  100564:	c3                   	ret    
	else if (data == 0x0B)
  100565:	3c 0b                	cmp    $0xb,%al
  100567:	74 35                	je     10059e <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100569:	8d 50 b9             	lea    -0x47(%eax),%edx
  10056c:	80 fa 02             	cmp    $0x2,%dl
  10056f:	77 07                	ja     100578 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100571:	0f b6 c0             	movzbl %al,%eax
  100574:	83 e8 40             	sub    $0x40,%eax
  100577:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100578:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10057b:	80 fa 02             	cmp    $0x2,%dl
  10057e:	77 07                	ja     100587 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100580:	0f b6 c0             	movzbl %al,%eax
  100583:	83 e8 47             	sub    $0x47,%eax
  100586:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100587:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10058a:	80 fa 02             	cmp    $0x2,%dl
  10058d:	77 07                	ja     100596 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10058f:	0f b6 c0             	movzbl %al,%eax
  100592:	83 e8 4e             	sub    $0x4e,%eax
  100595:	c3                   	ret    
	else if (data == 0x53)
  100596:	3c 53                	cmp    $0x53,%al
  100598:	74 04                	je     10059e <console_read_digit+0x53>
  10059a:	83 c8 ff             	or     $0xffffffff,%eax
  10059d:	c3                   	ret    
  10059e:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005a0:	c3                   	ret    

001005a1 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005a1:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005a5:	a3 48 8c 10 00       	mov    %eax,0x108c48

	asm volatile("movl %0,%%esp\n\t"
  1005aa:	83 c0 04             	add    $0x4,%eax
  1005ad:	89 c4                	mov    %eax,%esp
  1005af:	61                   	popa   
  1005b0:	07                   	pop    %es
  1005b1:	1f                   	pop    %ds
  1005b2:	83 c4 08             	add    $0x8,%esp
  1005b5:	cf                   	iret   
  1005b6:	eb fe                	jmp    1005b6 <run+0x15>

001005b8 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005b8:	53                   	push   %ebx
  1005b9:	83 ec 0c             	sub    $0xc,%esp
  1005bc:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005c0:	6a 44                	push   $0x44
  1005c2:	6a 00                	push   $0x0
  1005c4:	8d 43 04             	lea    0x4(%ebx),%eax
  1005c7:	50                   	push   %eax
  1005c8:	e8 17 01 00 00       	call   1006e4 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005cd:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005d3:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005d9:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005df:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005e5:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005ec:	83 c4 18             	add    $0x18,%esp
  1005ef:	5b                   	pop    %ebx
  1005f0:	c3                   	ret    
  1005f1:	90                   	nop
  1005f2:	90                   	nop
  1005f3:	90                   	nop

001005f4 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005f4:	55                   	push   %ebp
  1005f5:	57                   	push   %edi
  1005f6:	56                   	push   %esi
  1005f7:	53                   	push   %ebx
  1005f8:	83 ec 1c             	sub    $0x1c,%esp
  1005fb:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005ff:	83 f8 03             	cmp    $0x3,%eax
  100602:	7f 04                	jg     100608 <program_loader+0x14>
  100604:	85 c0                	test   %eax,%eax
  100606:	79 02                	jns    10060a <program_loader+0x16>
  100608:	eb fe                	jmp    100608 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10060a:	8b 34 c5 f4 1b 10 00 	mov    0x101bf4(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100611:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100617:	74 02                	je     10061b <program_loader+0x27>
  100619:	eb fe                	jmp    100619 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10061b:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10061e:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100622:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100624:	c1 e5 05             	shl    $0x5,%ebp
  100627:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10062a:	eb 3f                	jmp    10066b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  10062c:	83 3b 01             	cmpl   $0x1,(%ebx)
  10062f:	75 37                	jne    100668 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100631:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100634:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100637:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10063a:	01 c7                	add    %eax,%edi
	memsz += va;
  10063c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10063e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100643:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100647:	52                   	push   %edx
  100648:	89 fa                	mov    %edi,%edx
  10064a:	29 c2                	sub    %eax,%edx
  10064c:	52                   	push   %edx
  10064d:	8b 53 04             	mov    0x4(%ebx),%edx
  100650:	01 f2                	add    %esi,%edx
  100652:	52                   	push   %edx
  100653:	50                   	push   %eax
  100654:	e8 27 00 00 00       	call   100680 <memcpy>
  100659:	83 c4 10             	add    $0x10,%esp
  10065c:	eb 04                	jmp    100662 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10065e:	c6 07 00             	movb   $0x0,(%edi)
  100661:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100662:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100666:	72 f6                	jb     10065e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100668:	83 c3 20             	add    $0x20,%ebx
  10066b:	39 eb                	cmp    %ebp,%ebx
  10066d:	72 bd                	jb     10062c <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10066f:	8b 56 18             	mov    0x18(%esi),%edx
  100672:	8b 44 24 34          	mov    0x34(%esp),%eax
  100676:	89 10                	mov    %edx,(%eax)
}
  100678:	83 c4 1c             	add    $0x1c,%esp
  10067b:	5b                   	pop    %ebx
  10067c:	5e                   	pop    %esi
  10067d:	5f                   	pop    %edi
  10067e:	5d                   	pop    %ebp
  10067f:	c3                   	ret    

00100680 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100680:	56                   	push   %esi
  100681:	31 d2                	xor    %edx,%edx
  100683:	53                   	push   %ebx
  100684:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100688:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10068c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100690:	eb 08                	jmp    10069a <memcpy+0x1a>
		*d++ = *s++;
  100692:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100695:	4e                   	dec    %esi
  100696:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100699:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10069a:	85 f6                	test   %esi,%esi
  10069c:	75 f4                	jne    100692 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10069e:	5b                   	pop    %ebx
  10069f:	5e                   	pop    %esi
  1006a0:	c3                   	ret    

001006a1 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006a1:	57                   	push   %edi
  1006a2:	56                   	push   %esi
  1006a3:	53                   	push   %ebx
  1006a4:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006a8:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006ac:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006b0:	39 c7                	cmp    %eax,%edi
  1006b2:	73 26                	jae    1006da <memmove+0x39>
  1006b4:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006b7:	39 c6                	cmp    %eax,%esi
  1006b9:	76 1f                	jbe    1006da <memmove+0x39>
		s += n, d += n;
  1006bb:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006be:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006c0:	eb 07                	jmp    1006c9 <memmove+0x28>
			*--d = *--s;
  1006c2:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006c5:	4a                   	dec    %edx
  1006c6:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006c9:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006ca:	85 d2                	test   %edx,%edx
  1006cc:	75 f4                	jne    1006c2 <memmove+0x21>
  1006ce:	eb 10                	jmp    1006e0 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006d0:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006d3:	4a                   	dec    %edx
  1006d4:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006d7:	41                   	inc    %ecx
  1006d8:	eb 02                	jmp    1006dc <memmove+0x3b>
  1006da:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006dc:	85 d2                	test   %edx,%edx
  1006de:	75 f0                	jne    1006d0 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006e0:	5b                   	pop    %ebx
  1006e1:	5e                   	pop    %esi
  1006e2:	5f                   	pop    %edi
  1006e3:	c3                   	ret    

001006e4 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006e4:	53                   	push   %ebx
  1006e5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006e9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006ed:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006f1:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006f3:	eb 04                	jmp    1006f9 <memset+0x15>
		*p++ = c;
  1006f5:	88 1a                	mov    %bl,(%edx)
  1006f7:	49                   	dec    %ecx
  1006f8:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006f9:	85 c9                	test   %ecx,%ecx
  1006fb:	75 f8                	jne    1006f5 <memset+0x11>
		*p++ = c;
	return v;
}
  1006fd:	5b                   	pop    %ebx
  1006fe:	c3                   	ret    

001006ff <strlen>:

size_t
strlen(const char *s)
{
  1006ff:	8b 54 24 04          	mov    0x4(%esp),%edx
  100703:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100705:	eb 01                	jmp    100708 <strlen+0x9>
		++n;
  100707:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100708:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  10070c:	75 f9                	jne    100707 <strlen+0x8>
		++n;
	return n;
}
  10070e:	c3                   	ret    

0010070f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10070f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100713:	31 c0                	xor    %eax,%eax
  100715:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100719:	eb 01                	jmp    10071c <strnlen+0xd>
		++n;
  10071b:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10071c:	39 d0                	cmp    %edx,%eax
  10071e:	74 06                	je     100726 <strnlen+0x17>
  100720:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100724:	75 f5                	jne    10071b <strnlen+0xc>
		++n;
	return n;
}
  100726:	c3                   	ret    

00100727 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100727:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100728:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10072d:	53                   	push   %ebx
  10072e:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100730:	76 05                	jbe    100737 <console_putc+0x10>
  100732:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100737:	80 fa 0a             	cmp    $0xa,%dl
  10073a:	75 2c                	jne    100768 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10073c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100742:	be 50 00 00 00       	mov    $0x50,%esi
  100747:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100749:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10074c:	99                   	cltd   
  10074d:	f7 fe                	idiv   %esi
  10074f:	89 de                	mov    %ebx,%esi
  100751:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100753:	eb 07                	jmp    10075c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100755:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100758:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100759:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10075c:	83 f8 50             	cmp    $0x50,%eax
  10075f:	75 f4                	jne    100755 <console_putc+0x2e>
  100761:	29 d0                	sub    %edx,%eax
  100763:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100766:	eb 0b                	jmp    100773 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100768:	0f b6 d2             	movzbl %dl,%edx
  10076b:	09 ca                	or     %ecx,%edx
  10076d:	66 89 13             	mov    %dx,(%ebx)
  100770:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100773:	5b                   	pop    %ebx
  100774:	5e                   	pop    %esi
  100775:	c3                   	ret    

00100776 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100776:	56                   	push   %esi
  100777:	53                   	push   %ebx
  100778:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  10077c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10077f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100783:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100788:	75 04                	jne    10078e <fill_numbuf+0x18>
  10078a:	85 d2                	test   %edx,%edx
  10078c:	74 10                	je     10079e <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10078e:	89 d0                	mov    %edx,%eax
  100790:	31 d2                	xor    %edx,%edx
  100792:	f7 f1                	div    %ecx
  100794:	4b                   	dec    %ebx
  100795:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100798:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10079a:	89 c2                	mov    %eax,%edx
  10079c:	eb ec                	jmp    10078a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10079e:	89 d8                	mov    %ebx,%eax
  1007a0:	5b                   	pop    %ebx
  1007a1:	5e                   	pop    %esi
  1007a2:	c3                   	ret    

001007a3 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1007a3:	55                   	push   %ebp
  1007a4:	57                   	push   %edi
  1007a5:	56                   	push   %esi
  1007a6:	53                   	push   %ebx
  1007a7:	83 ec 38             	sub    $0x38,%esp
  1007aa:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007ae:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007b2:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007b6:	e9 60 03 00 00       	jmp    100b1b <console_vprintf+0x378>
		if (*format != '%') {
  1007bb:	80 fa 25             	cmp    $0x25,%dl
  1007be:	74 13                	je     1007d3 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007c0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007c4:	0f b6 d2             	movzbl %dl,%edx
  1007c7:	89 f0                	mov    %esi,%eax
  1007c9:	e8 59 ff ff ff       	call   100727 <console_putc>
  1007ce:	e9 45 03 00 00       	jmp    100b18 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007d3:	47                   	inc    %edi
  1007d4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007db:	00 
  1007dc:	eb 12                	jmp    1007f0 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007de:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007df:	8a 11                	mov    (%ecx),%dl
  1007e1:	84 d2                	test   %dl,%dl
  1007e3:	74 1a                	je     1007ff <console_vprintf+0x5c>
  1007e5:	89 e8                	mov    %ebp,%eax
  1007e7:	38 c2                	cmp    %al,%dl
  1007e9:	75 f3                	jne    1007de <console_vprintf+0x3b>
  1007eb:	e9 3f 03 00 00       	jmp    100b2f <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007f0:	8a 17                	mov    (%edi),%dl
  1007f2:	84 d2                	test   %dl,%dl
  1007f4:	74 0b                	je     100801 <console_vprintf+0x5e>
  1007f6:	b9 84 0b 10 00       	mov    $0x100b84,%ecx
  1007fb:	89 d5                	mov    %edx,%ebp
  1007fd:	eb e0                	jmp    1007df <console_vprintf+0x3c>
  1007ff:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100801:	8d 42 cf             	lea    -0x31(%edx),%eax
  100804:	3c 08                	cmp    $0x8,%al
  100806:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10080d:	00 
  10080e:	76 13                	jbe    100823 <console_vprintf+0x80>
  100810:	eb 1d                	jmp    10082f <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100812:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100817:	0f be c0             	movsbl %al,%eax
  10081a:	47                   	inc    %edi
  10081b:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10081f:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100823:	8a 07                	mov    (%edi),%al
  100825:	8d 50 d0             	lea    -0x30(%eax),%edx
  100828:	80 fa 09             	cmp    $0x9,%dl
  10082b:	76 e5                	jbe    100812 <console_vprintf+0x6f>
  10082d:	eb 18                	jmp    100847 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10082f:	80 fa 2a             	cmp    $0x2a,%dl
  100832:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100839:	ff 
  10083a:	75 0b                	jne    100847 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10083c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10083f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100840:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100843:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100847:	83 cd ff             	or     $0xffffffff,%ebp
  10084a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10084d:	75 37                	jne    100886 <console_vprintf+0xe3>
			++format;
  10084f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100850:	31 ed                	xor    %ebp,%ebp
  100852:	8a 07                	mov    (%edi),%al
  100854:	8d 50 d0             	lea    -0x30(%eax),%edx
  100857:	80 fa 09             	cmp    $0x9,%dl
  10085a:	76 0d                	jbe    100869 <console_vprintf+0xc6>
  10085c:	eb 17                	jmp    100875 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10085e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100861:	0f be c0             	movsbl %al,%eax
  100864:	47                   	inc    %edi
  100865:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100869:	8a 07                	mov    (%edi),%al
  10086b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10086e:	80 fa 09             	cmp    $0x9,%dl
  100871:	76 eb                	jbe    10085e <console_vprintf+0xbb>
  100873:	eb 11                	jmp    100886 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100875:	3c 2a                	cmp    $0x2a,%al
  100877:	75 0b                	jne    100884 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100879:	83 c3 04             	add    $0x4,%ebx
				++format;
  10087c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  10087d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100880:	85 ed                	test   %ebp,%ebp
  100882:	79 02                	jns    100886 <console_vprintf+0xe3>
  100884:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100886:	8a 07                	mov    (%edi),%al
  100888:	3c 64                	cmp    $0x64,%al
  10088a:	74 34                	je     1008c0 <console_vprintf+0x11d>
  10088c:	7f 1d                	jg     1008ab <console_vprintf+0x108>
  10088e:	3c 58                	cmp    $0x58,%al
  100890:	0f 84 a2 00 00 00    	je     100938 <console_vprintf+0x195>
  100896:	3c 63                	cmp    $0x63,%al
  100898:	0f 84 bf 00 00 00    	je     10095d <console_vprintf+0x1ba>
  10089e:	3c 43                	cmp    $0x43,%al
  1008a0:	0f 85 d0 00 00 00    	jne    100976 <console_vprintf+0x1d3>
  1008a6:	e9 a3 00 00 00       	jmp    10094e <console_vprintf+0x1ab>
  1008ab:	3c 75                	cmp    $0x75,%al
  1008ad:	74 4d                	je     1008fc <console_vprintf+0x159>
  1008af:	3c 78                	cmp    $0x78,%al
  1008b1:	74 5c                	je     10090f <console_vprintf+0x16c>
  1008b3:	3c 73                	cmp    $0x73,%al
  1008b5:	0f 85 bb 00 00 00    	jne    100976 <console_vprintf+0x1d3>
  1008bb:	e9 86 00 00 00       	jmp    100946 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008c0:	83 c3 04             	add    $0x4,%ebx
  1008c3:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008c6:	89 d1                	mov    %edx,%ecx
  1008c8:	c1 f9 1f             	sar    $0x1f,%ecx
  1008cb:	89 0c 24             	mov    %ecx,(%esp)
  1008ce:	31 ca                	xor    %ecx,%edx
  1008d0:	55                   	push   %ebp
  1008d1:	29 ca                	sub    %ecx,%edx
  1008d3:	68 8c 0b 10 00       	push   $0x100b8c
  1008d8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008dd:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008e1:	e8 90 fe ff ff       	call   100776 <fill_numbuf>
  1008e6:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008ea:	58                   	pop    %eax
  1008eb:	5a                   	pop    %edx
  1008ec:	ba 01 00 00 00       	mov    $0x1,%edx
  1008f1:	8b 04 24             	mov    (%esp),%eax
  1008f4:	83 e0 01             	and    $0x1,%eax
  1008f7:	e9 a5 00 00 00       	jmp    1009a1 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008fc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100904:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100907:	55                   	push   %ebp
  100908:	68 8c 0b 10 00       	push   $0x100b8c
  10090d:	eb 11                	jmp    100920 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10090f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100912:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100915:	55                   	push   %ebp
  100916:	68 a0 0b 10 00       	push   $0x100ba0
  10091b:	b9 10 00 00 00       	mov    $0x10,%ecx
  100920:	8d 44 24 40          	lea    0x40(%esp),%eax
  100924:	e8 4d fe ff ff       	call   100776 <fill_numbuf>
  100929:	ba 01 00 00 00       	mov    $0x1,%edx
  10092e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100932:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100934:	59                   	pop    %ecx
  100935:	59                   	pop    %ecx
  100936:	eb 69                	jmp    1009a1 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100938:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10093b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10093e:	55                   	push   %ebp
  10093f:	68 8c 0b 10 00       	push   $0x100b8c
  100944:	eb d5                	jmp    10091b <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100946:	83 c3 04             	add    $0x4,%ebx
  100949:	8b 43 fc             	mov    -0x4(%ebx),%eax
  10094c:	eb 40                	jmp    10098e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10094e:	83 c3 04             	add    $0x4,%ebx
  100951:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100954:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100958:	e9 bd 01 00 00       	jmp    100b1a <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10095d:	83 c3 04             	add    $0x4,%ebx
  100960:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100963:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100967:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  10096c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100970:	88 44 24 24          	mov    %al,0x24(%esp)
  100974:	eb 27                	jmp    10099d <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100976:	84 c0                	test   %al,%al
  100978:	75 02                	jne    10097c <console_vprintf+0x1d9>
  10097a:	b0 25                	mov    $0x25,%al
  10097c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100980:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100985:	80 3f 00             	cmpb   $0x0,(%edi)
  100988:	74 0a                	je     100994 <console_vprintf+0x1f1>
  10098a:	8d 44 24 24          	lea    0x24(%esp),%eax
  10098e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100992:	eb 09                	jmp    10099d <console_vprintf+0x1fa>
				format--;
  100994:	8d 54 24 24          	lea    0x24(%esp),%edx
  100998:	4f                   	dec    %edi
  100999:	89 54 24 04          	mov    %edx,0x4(%esp)
  10099d:	31 d2                	xor    %edx,%edx
  10099f:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009a1:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1009a3:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009ad:	74 1f                	je     1009ce <console_vprintf+0x22b>
  1009af:	89 04 24             	mov    %eax,(%esp)
  1009b2:	eb 01                	jmp    1009b5 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009b4:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009b5:	39 e9                	cmp    %ebp,%ecx
  1009b7:	74 0a                	je     1009c3 <console_vprintf+0x220>
  1009b9:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009bd:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009c1:	75 f1                	jne    1009b4 <console_vprintf+0x211>
  1009c3:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009c6:	89 0c 24             	mov    %ecx,(%esp)
  1009c9:	eb 1f                	jmp    1009ea <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009cb:	42                   	inc    %edx
  1009cc:	eb 09                	jmp    1009d7 <console_vprintf+0x234>
  1009ce:	89 d1                	mov    %edx,%ecx
  1009d0:	8b 14 24             	mov    (%esp),%edx
  1009d3:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009d7:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009db:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009df:	75 ea                	jne    1009cb <console_vprintf+0x228>
  1009e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009e5:	89 14 24             	mov    %edx,(%esp)
  1009e8:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009ea:	85 c0                	test   %eax,%eax
  1009ec:	74 0c                	je     1009fa <console_vprintf+0x257>
  1009ee:	84 d2                	test   %dl,%dl
  1009f0:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009f7:	00 
  1009f8:	75 24                	jne    100a1e <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009fa:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009ff:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a06:	00 
  100a07:	75 15                	jne    100a1e <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a09:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a0d:	83 e0 08             	and    $0x8,%eax
  100a10:	83 f8 01             	cmp    $0x1,%eax
  100a13:	19 c9                	sbb    %ecx,%ecx
  100a15:	f7 d1                	not    %ecx
  100a17:	83 e1 20             	and    $0x20,%ecx
  100a1a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a1e:	3b 2c 24             	cmp    (%esp),%ebp
  100a21:	7e 0d                	jle    100a30 <console_vprintf+0x28d>
  100a23:	84 d2                	test   %dl,%dl
  100a25:	74 40                	je     100a67 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a27:	2b 2c 24             	sub    (%esp),%ebp
  100a2a:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a2e:	eb 3f                	jmp    100a6f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a30:	84 d2                	test   %dl,%dl
  100a32:	74 33                	je     100a67 <console_vprintf+0x2c4>
  100a34:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a38:	83 e0 06             	and    $0x6,%eax
  100a3b:	83 f8 02             	cmp    $0x2,%eax
  100a3e:	75 27                	jne    100a67 <console_vprintf+0x2c4>
  100a40:	45                   	inc    %ebp
  100a41:	75 24                	jne    100a67 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a43:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a45:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a48:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a4d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a50:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a53:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a57:	7d 0e                	jge    100a67 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a59:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a5d:	29 ca                	sub    %ecx,%edx
  100a5f:	29 c2                	sub    %eax,%edx
  100a61:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a65:	eb 08                	jmp    100a6f <console_vprintf+0x2cc>
  100a67:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a6e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a6f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a73:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a75:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a79:	2b 2c 24             	sub    (%esp),%ebp
  100a7c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a81:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a84:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a87:	29 c5                	sub    %eax,%ebp
  100a89:	89 f0                	mov    %esi,%eax
  100a8b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a8f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a93:	eb 0f                	jmp    100aa4 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a95:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a99:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a9e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a9f:	e8 83 fc ff ff       	call   100727 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aa4:	85 ed                	test   %ebp,%ebp
  100aa6:	7e 07                	jle    100aaf <console_vprintf+0x30c>
  100aa8:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100aad:	74 e6                	je     100a95 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100aaf:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ab4:	89 c6                	mov    %eax,%esi
  100ab6:	74 23                	je     100adb <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ab8:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100abd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac1:	e8 61 fc ff ff       	call   100727 <console_putc>
  100ac6:	89 c6                	mov    %eax,%esi
  100ac8:	eb 11                	jmp    100adb <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100aca:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ace:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ad3:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100ad4:	e8 4e fc ff ff       	call   100727 <console_putc>
  100ad9:	eb 06                	jmp    100ae1 <console_vprintf+0x33e>
  100adb:	89 f0                	mov    %esi,%eax
  100add:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ae1:	85 f6                	test   %esi,%esi
  100ae3:	7f e5                	jg     100aca <console_vprintf+0x327>
  100ae5:	8b 34 24             	mov    (%esp),%esi
  100ae8:	eb 15                	jmp    100aff <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100aea:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100aee:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100aef:	0f b6 11             	movzbl (%ecx),%edx
  100af2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100af6:	e8 2c fc ff ff       	call   100727 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100afb:	ff 44 24 04          	incl   0x4(%esp)
  100aff:	85 f6                	test   %esi,%esi
  100b01:	7f e7                	jg     100aea <console_vprintf+0x347>
  100b03:	eb 0f                	jmp    100b14 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b05:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b09:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b0e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b0f:	e8 13 fc ff ff       	call   100727 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b14:	85 ed                	test   %ebp,%ebp
  100b16:	7f ed                	jg     100b05 <console_vprintf+0x362>
  100b18:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b1a:	47                   	inc    %edi
  100b1b:	8a 17                	mov    (%edi),%dl
  100b1d:	84 d2                	test   %dl,%dl
  100b1f:	0f 85 96 fc ff ff    	jne    1007bb <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b25:	83 c4 38             	add    $0x38,%esp
  100b28:	89 f0                	mov    %esi,%eax
  100b2a:	5b                   	pop    %ebx
  100b2b:	5e                   	pop    %esi
  100b2c:	5f                   	pop    %edi
  100b2d:	5d                   	pop    %ebp
  100b2e:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b2f:	81 e9 84 0b 10 00    	sub    $0x100b84,%ecx
  100b35:	b8 01 00 00 00       	mov    $0x1,%eax
  100b3a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b3c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b3d:	09 44 24 14          	or     %eax,0x14(%esp)
  100b41:	e9 aa fc ff ff       	jmp    1007f0 <console_vprintf+0x4d>

00100b46 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b46:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b4a:	50                   	push   %eax
  100b4b:	ff 74 24 10          	pushl  0x10(%esp)
  100b4f:	ff 74 24 10          	pushl  0x10(%esp)
  100b53:	ff 74 24 10          	pushl  0x10(%esp)
  100b57:	e8 47 fc ff ff       	call   1007a3 <console_vprintf>
  100b5c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b5f:	c3                   	ret    
