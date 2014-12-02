
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
  100014:	e8 78 02 00 00       	call   100291 <start>
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
  10009c:	a1 80 7a 10 00       	mov    0x107a80,%eax
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
  1000a6:	a1 84 7a 10 00       	mov    0x107a84,%eax
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
  1000bd:	83 b8 a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%eax)
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
  1000d3:	83 3d fc 70 10 00 01 	cmpl   $0x1,0x1070fc
  1000da:	8b 1d 58 71 10 00    	mov    0x107158,%ebx
  1000e0:	8b 0d b4 71 10 00    	mov    0x1071b4,%ecx
  1000e6:	8b 15 10 72 10 00    	mov    0x107210,%edx
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
  100134:	8b 87 f0 70 10 00    	mov    0x1070f0(%edi),%eax
  10013a:	39 c8                	cmp    %ecx,%eax
  10013c:	73 09                	jae    100147 <schedule+0xab>
  10013e:	83 bf fc 70 10 00 01 	cmpl   $0x1,0x1070fc(%edi)
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
  10015b:	39 86 94 70 10 00    	cmp    %eax,0x107094(%esi)
  100161:	75 c5                	jne    100128 <schedule+0x8c>
  100163:	83 be a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%esi)
  10016a:	75 bc                	jne    100128 <schedule+0x8c>
                           run(&proc_array[pid]);
  10016c:	83 ec 0c             	sub    $0xc,%esp
  10016f:	81 c6 4c 70 10 00    	add    $0x10704c,%esi
  100175:	56                   	push   %esi
  100176:	e8 42 04 00 00       	call   1005bd <run>

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
  10018e:	83 bb a0 70 10 00 01 	cmpl   $0x1,0x1070a0(%ebx)
  100195:	75 ee                	jne    100185 <schedule+0xe9>
              {
                 if (proc_array[pid].p_ran >= proc_array[pid].p_share)
  100197:	8d 83 4c 70 10 00    	lea    0x10704c(%ebx),%eax
  10019d:	8b 70 50             	mov    0x50(%eax),%esi
  1001a0:	8d 78 50             	lea    0x50(%eax),%edi
  1001a3:	3b b3 98 70 10 00    	cmp    0x107098(%ebx),%esi
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
  1001c3:	68 7c 0b 10 00       	push   $0x100b7c
  1001c8:	68 00 01 00 00       	push   $0x100
  1001cd:	52                   	push   %edx
  1001ce:	e8 8f 09 00 00       	call   100b62 <console_printf>
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
  1001e8:	05 4c 70 10 00       	add    $0x10704c,%eax
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
  1001f1:	8b 3d 80 7a 10 00    	mov    0x107a80,%edi
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
  10020c:	83 f8 32             	cmp    $0x32,%eax
  10020f:	74 38                	je     100249 <interrupt+0x59>
  100211:	77 0e                	ja     100221 <interrupt+0x31>
  100213:	83 f8 30             	cmp    $0x30,%eax
  100216:	74 15                	je     10022d <interrupt+0x3d>
  100218:	77 18                	ja     100232 <interrupt+0x42>
  10021a:	83 f8 20             	cmp    $0x20,%eax
  10021d:	74 6b                	je     10028a <interrupt+0x9a>
  10021f:	eb 6e                	jmp    10028f <interrupt+0x9f>
  100221:	83 f8 33             	cmp    $0x33,%eax
  100224:	74 33                	je     100259 <interrupt+0x69>
  100226:	83 f8 34             	cmp    $0x34,%eax
  100229:	74 3e                	je     100269 <interrupt+0x79>
  10022b:	eb 62                	jmp    10028f <interrupt+0x9f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  10022d:	e8 6a fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100232:	a1 80 7a 10 00       	mov    0x107a80,%eax
		current->p_exit_status = reg->reg_eax;
  100237:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10023a:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  100241:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  100244:	e8 53 fe ff ff       	call   10009c <schedule>
                // 4A set priority
	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
                current->p_priority = reg->reg_eax; //Set new priority
  100249:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10024c:	a1 80 7a 10 00       	mov    0x107a80,%eax
  100251:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  100254:	e8 43 fe ff ff       	call   10009c <schedule>

                // 4b
	case INT_SYS_USER2:
		/* Your code here (if you want). */
                current->p_share = reg->reg_eax;
  100259:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10025c:	a1 80 7a 10 00       	mov    0x107a80,%eax
  100261:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100264:	e8 33 fe ff ff       	call   10009c <schedule>

        case INT_SYS_PRINT:
                *cursorpos++ = reg->reg_eax;
  100269:	a1 00 80 19 00       	mov    0x198000,%eax
                run(current);
  10026e:	83 ec 0c             	sub    $0xc,%esp
		/* Your code here (if you want). */
                current->p_share = reg->reg_eax;
		schedule();

        case INT_SYS_PRINT:
                *cursorpos++ = reg->reg_eax;
  100271:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100274:	66 89 10             	mov    %dx,(%eax)
  100277:	83 c0 02             	add    $0x2,%eax
                run(current);
  10027a:	ff 35 80 7a 10 00    	pushl  0x107a80
		/* Your code here (if you want). */
                current->p_share = reg->reg_eax;
		schedule();

        case INT_SYS_PRINT:
                *cursorpos++ = reg->reg_eax;
  100280:	a3 00 80 19 00       	mov    %eax,0x198000
                run(current);
  100285:	e8 33 03 00 00       	call   1005bd <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10028a:	e8 0d fe ff ff       	call   10009c <schedule>
  10028f:	eb fe                	jmp    10028f <interrupt+0x9f>

00100291 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100291:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100292:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100297:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100298:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10029a:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10029b:	bb a8 70 10 00       	mov    $0x1070a8,%ebx

void
start(void)
{
	int i;
        lock = 0;
  1002a0:	c7 05 04 80 01 00 00 	movl   $0x0,0x18004
  1002a7:	00 00 00 

	// Set up hardware (schedos-x86.c)
	segments_init();
  1002aa:	e8 ed 00 00 00       	call   10039c <segments_init>
	interrupt_controller_init(0);
  1002af:	83 ec 0c             	sub    $0xc,%esp
  1002b2:	6a 00                	push   $0x0
  1002b4:	e8 de 01 00 00       	call   100497 <interrupt_controller_init>
	console_clear();
  1002b9:	e8 62 02 00 00       	call   100520 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002be:	83 c4 0c             	add    $0xc,%esp
  1002c1:	68 cc 01 00 00       	push   $0x1cc
  1002c6:	6a 00                	push   $0x0
  1002c8:	68 4c 70 10 00       	push   $0x10704c
  1002cd:	e8 2e 04 00 00       	call   100700 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002d2:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002d5:	c7 05 4c 70 10 00 00 	movl   $0x0,0x10704c
  1002dc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002df:	c7 05 a0 70 10 00 00 	movl   $0x0,0x1070a0
  1002e6:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002e9:	c7 05 a8 70 10 00 01 	movl   $0x1,0x1070a8
  1002f0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002f3:	c7 05 fc 70 10 00 00 	movl   $0x0,0x1070fc
  1002fa:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002fd:	c7 05 04 71 10 00 02 	movl   $0x2,0x107104
  100304:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100307:	c7 05 58 71 10 00 00 	movl   $0x0,0x107158
  10030e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100311:	c7 05 60 71 10 00 03 	movl   $0x3,0x107160
  100318:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10031b:	c7 05 b4 71 10 00 00 	movl   $0x0,0x1071b4
  100322:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100325:	c7 05 bc 71 10 00 04 	movl   $0x4,0x1071bc
  10032c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10032f:	c7 05 10 72 10 00 00 	movl   $0x0,0x107210
  100336:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100339:	83 ec 0c             	sub    $0xc,%esp
  10033c:	53                   	push   %ebx
  10033d:	e8 92 02 00 00       	call   1005d4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100342:	58                   	pop    %eax
  100343:	5a                   	pop    %edx
  100344:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100347:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

                // Set sharing values
                proc->p_ran = 0;
                proc->p_share = 1; //By default
  10034a:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100350:	50                   	push   %eax
  100351:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

                // Set sharing values
                proc->p_ran = 0;
                proc->p_share = 1; //By default
  100352:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100353:	e8 b8 02 00 00       	call   100610 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100358:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10035b:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)

                // Set sharing values
                proc->p_ran = 0;
  100362:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
                proc->p_share = 1; //By default
  100369:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
  100370:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100373:	83 fe 04             	cmp    $0x4,%esi
  100376:	75 c1                	jne    100339 <start+0xa8>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  100378:	83 ec 0c             	sub    $0xc,%esp
  10037b:	68 a8 70 10 00       	push   $0x1070a8
                proc->p_share = 1; //By default
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100380:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100387:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;
  10038a:	c7 05 84 7a 10 00 00 	movl   $0x0,0x107a84
  100391:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100394:	e8 24 02 00 00       	call   1005bd <run>
  100399:	90                   	nop
  10039a:	90                   	nop
  10039b:	90                   	nop

0010039c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10039c:	b8 18 72 10 00       	mov    $0x107218,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a6:	89 c2                	mov    %eax,%edx
  1003a8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003ab:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ac:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1003b1:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b4:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1003ba:	c1 e8 18             	shr    $0x18,%eax
  1003bd:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c3:	ba 80 72 10 00       	mov    $0x107280,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003c8:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003cd:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003cf:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1003d6:	68 00 
  1003d8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003df:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003e6:	c7 05 1c 72 10 00 00 	movl   $0x180000,0x10721c
  1003ed:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003f0:	66 c7 05 20 72 10 00 	movw   $0x10,0x107220
  1003f7:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f9:	66 89 0c c5 80 72 10 	mov    %cx,0x107280(,%eax,8)
  100400:	00 
  100401:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100408:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10040d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100412:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100417:	40                   	inc    %eax
  100418:	3d 00 01 00 00       	cmp    $0x100,%eax
  10041d:	75 da                	jne    1003f9 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10041f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100424:	ba 80 72 10 00       	mov    $0x107280,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100429:	66 a3 80 73 10 00    	mov    %ax,0x107380
  10042f:	c1 e8 10             	shr    $0x10,%eax
  100432:	66 a3 86 73 10 00    	mov    %ax,0x107386
  100438:	b8 30 00 00 00       	mov    $0x30,%eax
  10043d:	66 c7 05 82 73 10 00 	movw   $0x8,0x107382
  100444:	08 00 
  100446:	c6 05 84 73 10 00 00 	movb   $0x0,0x107384
  10044d:	c6 05 85 73 10 00 8e 	movb   $0x8e,0x107385

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100454:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10045b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100462:	66 89 0c c5 80 72 10 	mov    %cx,0x107280(,%eax,8)
  100469:	00 
  10046a:	c1 e9 10             	shr    $0x10,%ecx
  10046d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100472:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100477:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10047c:	40                   	inc    %eax
  10047d:	83 f8 3a             	cmp    $0x3a,%eax
  100480:	75 d2                	jne    100454 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100482:	b0 28                	mov    $0x28,%al
  100484:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10048b:	0f 00 d8             	ltr    %ax
  10048e:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100495:	5b                   	pop    %ebx
  100496:	c3                   	ret    

00100497 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100497:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100498:	b0 ff                	mov    $0xff,%al
  10049a:	57                   	push   %edi
  10049b:	56                   	push   %esi
  10049c:	53                   	push   %ebx
  10049d:	bb 21 00 00 00       	mov    $0x21,%ebx
  1004a2:	89 da                	mov    %ebx,%edx
  1004a4:	ee                   	out    %al,(%dx)
  1004a5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004aa:	89 ca                	mov    %ecx,%edx
  1004ac:	ee                   	out    %al,(%dx)
  1004ad:	be 11 00 00 00       	mov    $0x11,%esi
  1004b2:	bf 20 00 00 00       	mov    $0x20,%edi
  1004b7:	89 f0                	mov    %esi,%eax
  1004b9:	89 fa                	mov    %edi,%edx
  1004bb:	ee                   	out    %al,(%dx)
  1004bc:	b0 20                	mov    $0x20,%al
  1004be:	89 da                	mov    %ebx,%edx
  1004c0:	ee                   	out    %al,(%dx)
  1004c1:	b0 04                	mov    $0x4,%al
  1004c3:	ee                   	out    %al,(%dx)
  1004c4:	b0 03                	mov    $0x3,%al
  1004c6:	ee                   	out    %al,(%dx)
  1004c7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004cc:	89 f0                	mov    %esi,%eax
  1004ce:	89 ea                	mov    %ebp,%edx
  1004d0:	ee                   	out    %al,(%dx)
  1004d1:	b0 28                	mov    $0x28,%al
  1004d3:	89 ca                	mov    %ecx,%edx
  1004d5:	ee                   	out    %al,(%dx)
  1004d6:	b0 02                	mov    $0x2,%al
  1004d8:	ee                   	out    %al,(%dx)
  1004d9:	b0 01                	mov    $0x1,%al
  1004db:	ee                   	out    %al,(%dx)
  1004dc:	b0 68                	mov    $0x68,%al
  1004de:	89 fa                	mov    %edi,%edx
  1004e0:	ee                   	out    %al,(%dx)
  1004e1:	be 0a 00 00 00       	mov    $0xa,%esi
  1004e6:	89 f0                	mov    %esi,%eax
  1004e8:	ee                   	out    %al,(%dx)
  1004e9:	b0 68                	mov    $0x68,%al
  1004eb:	89 ea                	mov    %ebp,%edx
  1004ed:	ee                   	out    %al,(%dx)
  1004ee:	89 f0                	mov    %esi,%eax
  1004f0:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004f1:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004f6:	89 da                	mov    %ebx,%edx
  1004f8:	19 c0                	sbb    %eax,%eax
  1004fa:	f7 d0                	not    %eax
  1004fc:	05 ff 00 00 00       	add    $0xff,%eax
  100501:	ee                   	out    %al,(%dx)
  100502:	b0 ff                	mov    $0xff,%al
  100504:	89 ca                	mov    %ecx,%edx
  100506:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100507:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10050c:	74 0d                	je     10051b <interrupt_controller_init+0x84>
  10050e:	b2 43                	mov    $0x43,%dl
  100510:	b0 34                	mov    $0x34,%al
  100512:	ee                   	out    %al,(%dx)
  100513:	b0 55                	mov    $0x55,%al
  100515:	b2 40                	mov    $0x40,%dl
  100517:	ee                   	out    %al,(%dx)
  100518:	b0 02                	mov    $0x2,%al
  10051a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10051b:	5b                   	pop    %ebx
  10051c:	5e                   	pop    %esi
  10051d:	5f                   	pop    %edi
  10051e:	5d                   	pop    %ebp
  10051f:	c3                   	ret    

00100520 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100520:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100521:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100523:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100524:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10052b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10052e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100534:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10053a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10053d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100542:	75 ea                	jne    10052e <console_clear+0xe>
  100544:	be d4 03 00 00       	mov    $0x3d4,%esi
  100549:	b0 0e                	mov    $0xe,%al
  10054b:	89 f2                	mov    %esi,%edx
  10054d:	ee                   	out    %al,(%dx)
  10054e:	31 c9                	xor    %ecx,%ecx
  100550:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100555:	88 c8                	mov    %cl,%al
  100557:	89 da                	mov    %ebx,%edx
  100559:	ee                   	out    %al,(%dx)
  10055a:	b0 0f                	mov    $0xf,%al
  10055c:	89 f2                	mov    %esi,%edx
  10055e:	ee                   	out    %al,(%dx)
  10055f:	88 c8                	mov    %cl,%al
  100561:	89 da                	mov    %ebx,%edx
  100563:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100564:	5b                   	pop    %ebx
  100565:	5e                   	pop    %esi
  100566:	c3                   	ret    

00100567 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100567:	ba 64 00 00 00       	mov    $0x64,%edx
  10056c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10056d:	a8 01                	test   $0x1,%al
  10056f:	74 45                	je     1005b6 <console_read_digit+0x4f>
  100571:	b2 60                	mov    $0x60,%dl
  100573:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100574:	8d 50 fe             	lea    -0x2(%eax),%edx
  100577:	80 fa 08             	cmp    $0x8,%dl
  10057a:	77 05                	ja     100581 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10057c:	0f b6 c0             	movzbl %al,%eax
  10057f:	48                   	dec    %eax
  100580:	c3                   	ret    
	else if (data == 0x0B)
  100581:	3c 0b                	cmp    $0xb,%al
  100583:	74 35                	je     1005ba <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100585:	8d 50 b9             	lea    -0x47(%eax),%edx
  100588:	80 fa 02             	cmp    $0x2,%dl
  10058b:	77 07                	ja     100594 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10058d:	0f b6 c0             	movzbl %al,%eax
  100590:	83 e8 40             	sub    $0x40,%eax
  100593:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100594:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100597:	80 fa 02             	cmp    $0x2,%dl
  10059a:	77 07                	ja     1005a3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10059c:	0f b6 c0             	movzbl %al,%eax
  10059f:	83 e8 47             	sub    $0x47,%eax
  1005a2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1005a3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005a6:	80 fa 02             	cmp    $0x2,%dl
  1005a9:	77 07                	ja     1005b2 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005ab:	0f b6 c0             	movzbl %al,%eax
  1005ae:	83 e8 4e             	sub    $0x4e,%eax
  1005b1:	c3                   	ret    
	else if (data == 0x53)
  1005b2:	3c 53                	cmp    $0x53,%al
  1005b4:	74 04                	je     1005ba <console_read_digit+0x53>
  1005b6:	83 c8 ff             	or     $0xffffffff,%eax
  1005b9:	c3                   	ret    
  1005ba:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005bc:	c3                   	ret    

001005bd <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005bd:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005c1:	a3 80 7a 10 00       	mov    %eax,0x107a80

	asm volatile("movl %0,%%esp\n\t"
  1005c6:	83 c0 04             	add    $0x4,%eax
  1005c9:	89 c4                	mov    %eax,%esp
  1005cb:	61                   	popa   
  1005cc:	07                   	pop    %es
  1005cd:	1f                   	pop    %ds
  1005ce:	83 c4 08             	add    $0x8,%esp
  1005d1:	cf                   	iret   
  1005d2:	eb fe                	jmp    1005d2 <run+0x15>

001005d4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005d4:	53                   	push   %ebx
  1005d5:	83 ec 0c             	sub    $0xc,%esp
  1005d8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005dc:	6a 44                	push   $0x44
  1005de:	6a 00                	push   $0x0
  1005e0:	8d 43 04             	lea    0x4(%ebx),%eax
  1005e3:	50                   	push   %eax
  1005e4:	e8 17 01 00 00       	call   100700 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005e9:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005ef:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005f5:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005fb:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100601:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100608:	83 c4 18             	add    $0x18,%esp
  10060b:	5b                   	pop    %ebx
  10060c:	c3                   	ret    
  10060d:	90                   	nop
  10060e:	90                   	nop
  10060f:	90                   	nop

00100610 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100610:	55                   	push   %ebp
  100611:	57                   	push   %edi
  100612:	56                   	push   %esi
  100613:	53                   	push   %ebx
  100614:	83 ec 1c             	sub    $0x1c,%esp
  100617:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10061b:	83 f8 03             	cmp    $0x3,%eax
  10061e:	7f 04                	jg     100624 <program_loader+0x14>
  100620:	85 c0                	test   %eax,%eax
  100622:	79 02                	jns    100626 <program_loader+0x16>
  100624:	eb fe                	jmp    100624 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100626:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10062d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100633:	74 02                	je     100637 <program_loader+0x27>
  100635:	eb fe                	jmp    100635 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100637:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10063a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10063e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100640:	c1 e5 05             	shl    $0x5,%ebp
  100643:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100646:	eb 3f                	jmp    100687 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100648:	83 3b 01             	cmpl   $0x1,(%ebx)
  10064b:	75 37                	jne    100684 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10064d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100650:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100653:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100656:	01 c7                	add    %eax,%edi
	memsz += va;
  100658:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10065a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10065f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100663:	52                   	push   %edx
  100664:	89 fa                	mov    %edi,%edx
  100666:	29 c2                	sub    %eax,%edx
  100668:	52                   	push   %edx
  100669:	8b 53 04             	mov    0x4(%ebx),%edx
  10066c:	01 f2                	add    %esi,%edx
  10066e:	52                   	push   %edx
  10066f:	50                   	push   %eax
  100670:	e8 27 00 00 00       	call   10069c <memcpy>
  100675:	83 c4 10             	add    $0x10,%esp
  100678:	eb 04                	jmp    10067e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10067a:	c6 07 00             	movb   $0x0,(%edi)
  10067d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10067e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100682:	72 f6                	jb     10067a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100684:	83 c3 20             	add    $0x20,%ebx
  100687:	39 eb                	cmp    %ebp,%ebx
  100689:	72 bd                	jb     100648 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10068b:	8b 56 18             	mov    0x18(%esi),%edx
  10068e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100692:	89 10                	mov    %edx,(%eax)
}
  100694:	83 c4 1c             	add    $0x1c,%esp
  100697:	5b                   	pop    %ebx
  100698:	5e                   	pop    %esi
  100699:	5f                   	pop    %edi
  10069a:	5d                   	pop    %ebp
  10069b:	c3                   	ret    

0010069c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10069c:	56                   	push   %esi
  10069d:	31 d2                	xor    %edx,%edx
  10069f:	53                   	push   %ebx
  1006a0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006a4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006a8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006ac:	eb 08                	jmp    1006b6 <memcpy+0x1a>
		*d++ = *s++;
  1006ae:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1006b1:	4e                   	dec    %esi
  1006b2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1006b5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006b6:	85 f6                	test   %esi,%esi
  1006b8:	75 f4                	jne    1006ae <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1006ba:	5b                   	pop    %ebx
  1006bb:	5e                   	pop    %esi
  1006bc:	c3                   	ret    

001006bd <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006bd:	57                   	push   %edi
  1006be:	56                   	push   %esi
  1006bf:	53                   	push   %ebx
  1006c0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006c4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006c8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006cc:	39 c7                	cmp    %eax,%edi
  1006ce:	73 26                	jae    1006f6 <memmove+0x39>
  1006d0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006d3:	39 c6                	cmp    %eax,%esi
  1006d5:	76 1f                	jbe    1006f6 <memmove+0x39>
		s += n, d += n;
  1006d7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006da:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006dc:	eb 07                	jmp    1006e5 <memmove+0x28>
			*--d = *--s;
  1006de:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006e1:	4a                   	dec    %edx
  1006e2:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006e5:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006e6:	85 d2                	test   %edx,%edx
  1006e8:	75 f4                	jne    1006de <memmove+0x21>
  1006ea:	eb 10                	jmp    1006fc <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006ec:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006ef:	4a                   	dec    %edx
  1006f0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006f3:	41                   	inc    %ecx
  1006f4:	eb 02                	jmp    1006f8 <memmove+0x3b>
  1006f6:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006f8:	85 d2                	test   %edx,%edx
  1006fa:	75 f0                	jne    1006ec <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006fc:	5b                   	pop    %ebx
  1006fd:	5e                   	pop    %esi
  1006fe:	5f                   	pop    %edi
  1006ff:	c3                   	ret    

00100700 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100700:	53                   	push   %ebx
  100701:	8b 44 24 08          	mov    0x8(%esp),%eax
  100705:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100709:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10070d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10070f:	eb 04                	jmp    100715 <memset+0x15>
		*p++ = c;
  100711:	88 1a                	mov    %bl,(%edx)
  100713:	49                   	dec    %ecx
  100714:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100715:	85 c9                	test   %ecx,%ecx
  100717:	75 f8                	jne    100711 <memset+0x11>
		*p++ = c;
	return v;
}
  100719:	5b                   	pop    %ebx
  10071a:	c3                   	ret    

0010071b <strlen>:

size_t
strlen(const char *s)
{
  10071b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10071f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100721:	eb 01                	jmp    100724 <strlen+0x9>
		++n;
  100723:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100724:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100728:	75 f9                	jne    100723 <strlen+0x8>
		++n;
	return n;
}
  10072a:	c3                   	ret    

0010072b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10072b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10072f:	31 c0                	xor    %eax,%eax
  100731:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100735:	eb 01                	jmp    100738 <strnlen+0xd>
		++n;
  100737:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100738:	39 d0                	cmp    %edx,%eax
  10073a:	74 06                	je     100742 <strnlen+0x17>
  10073c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100740:	75 f5                	jne    100737 <strnlen+0xc>
		++n;
	return n;
}
  100742:	c3                   	ret    

00100743 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100743:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100744:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100749:	53                   	push   %ebx
  10074a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10074c:	76 05                	jbe    100753 <console_putc+0x10>
  10074e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100753:	80 fa 0a             	cmp    $0xa,%dl
  100756:	75 2c                	jne    100784 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100758:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10075e:	be 50 00 00 00       	mov    $0x50,%esi
  100763:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100765:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100768:	99                   	cltd   
  100769:	f7 fe                	idiv   %esi
  10076b:	89 de                	mov    %ebx,%esi
  10076d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10076f:	eb 07                	jmp    100778 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100771:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100774:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100775:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100778:	83 f8 50             	cmp    $0x50,%eax
  10077b:	75 f4                	jne    100771 <console_putc+0x2e>
  10077d:	29 d0                	sub    %edx,%eax
  10077f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100782:	eb 0b                	jmp    10078f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100784:	0f b6 d2             	movzbl %dl,%edx
  100787:	09 ca                	or     %ecx,%edx
  100789:	66 89 13             	mov    %dx,(%ebx)
  10078c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10078f:	5b                   	pop    %ebx
  100790:	5e                   	pop    %esi
  100791:	c3                   	ret    

00100792 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100792:	56                   	push   %esi
  100793:	53                   	push   %ebx
  100794:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100798:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10079b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10079f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1007a4:	75 04                	jne    1007aa <fill_numbuf+0x18>
  1007a6:	85 d2                	test   %edx,%edx
  1007a8:	74 10                	je     1007ba <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1007aa:	89 d0                	mov    %edx,%eax
  1007ac:	31 d2                	xor    %edx,%edx
  1007ae:	f7 f1                	div    %ecx
  1007b0:	4b                   	dec    %ebx
  1007b1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1007b4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1007b6:	89 c2                	mov    %eax,%edx
  1007b8:	eb ec                	jmp    1007a6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1007ba:	89 d8                	mov    %ebx,%eax
  1007bc:	5b                   	pop    %ebx
  1007bd:	5e                   	pop    %esi
  1007be:	c3                   	ret    

001007bf <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1007bf:	55                   	push   %ebp
  1007c0:	57                   	push   %edi
  1007c1:	56                   	push   %esi
  1007c2:	53                   	push   %ebx
  1007c3:	83 ec 38             	sub    $0x38,%esp
  1007c6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007ca:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007ce:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007d2:	e9 60 03 00 00       	jmp    100b37 <console_vprintf+0x378>
		if (*format != '%') {
  1007d7:	80 fa 25             	cmp    $0x25,%dl
  1007da:	74 13                	je     1007ef <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007dc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007e0:	0f b6 d2             	movzbl %dl,%edx
  1007e3:	89 f0                	mov    %esi,%eax
  1007e5:	e8 59 ff ff ff       	call   100743 <console_putc>
  1007ea:	e9 45 03 00 00       	jmp    100b34 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007ef:	47                   	inc    %edi
  1007f0:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007f7:	00 
  1007f8:	eb 12                	jmp    10080c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007fa:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007fb:	8a 11                	mov    (%ecx),%dl
  1007fd:	84 d2                	test   %dl,%dl
  1007ff:	74 1a                	je     10081b <console_vprintf+0x5c>
  100801:	89 e8                	mov    %ebp,%eax
  100803:	38 c2                	cmp    %al,%dl
  100805:	75 f3                	jne    1007fa <console_vprintf+0x3b>
  100807:	e9 3f 03 00 00       	jmp    100b4b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10080c:	8a 17                	mov    (%edi),%dl
  10080e:	84 d2                	test   %dl,%dl
  100810:	74 0b                	je     10081d <console_vprintf+0x5e>
  100812:	b9 a0 0b 10 00       	mov    $0x100ba0,%ecx
  100817:	89 d5                	mov    %edx,%ebp
  100819:	eb e0                	jmp    1007fb <console_vprintf+0x3c>
  10081b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10081d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100820:	3c 08                	cmp    $0x8,%al
  100822:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100829:	00 
  10082a:	76 13                	jbe    10083f <console_vprintf+0x80>
  10082c:	eb 1d                	jmp    10084b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10082e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100833:	0f be c0             	movsbl %al,%eax
  100836:	47                   	inc    %edi
  100837:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10083b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10083f:	8a 07                	mov    (%edi),%al
  100841:	8d 50 d0             	lea    -0x30(%eax),%edx
  100844:	80 fa 09             	cmp    $0x9,%dl
  100847:	76 e5                	jbe    10082e <console_vprintf+0x6f>
  100849:	eb 18                	jmp    100863 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10084b:	80 fa 2a             	cmp    $0x2a,%dl
  10084e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100855:	ff 
  100856:	75 0b                	jne    100863 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100858:	83 c3 04             	add    $0x4,%ebx
			++format;
  10085b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10085c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10085f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100863:	83 cd ff             	or     $0xffffffff,%ebp
  100866:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100869:	75 37                	jne    1008a2 <console_vprintf+0xe3>
			++format;
  10086b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10086c:	31 ed                	xor    %ebp,%ebp
  10086e:	8a 07                	mov    (%edi),%al
  100870:	8d 50 d0             	lea    -0x30(%eax),%edx
  100873:	80 fa 09             	cmp    $0x9,%dl
  100876:	76 0d                	jbe    100885 <console_vprintf+0xc6>
  100878:	eb 17                	jmp    100891 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10087a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10087d:	0f be c0             	movsbl %al,%eax
  100880:	47                   	inc    %edi
  100881:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100885:	8a 07                	mov    (%edi),%al
  100887:	8d 50 d0             	lea    -0x30(%eax),%edx
  10088a:	80 fa 09             	cmp    $0x9,%dl
  10088d:	76 eb                	jbe    10087a <console_vprintf+0xbb>
  10088f:	eb 11                	jmp    1008a2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100891:	3c 2a                	cmp    $0x2a,%al
  100893:	75 0b                	jne    1008a0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100895:	83 c3 04             	add    $0x4,%ebx
				++format;
  100898:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100899:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10089c:	85 ed                	test   %ebp,%ebp
  10089e:	79 02                	jns    1008a2 <console_vprintf+0xe3>
  1008a0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1008a2:	8a 07                	mov    (%edi),%al
  1008a4:	3c 64                	cmp    $0x64,%al
  1008a6:	74 34                	je     1008dc <console_vprintf+0x11d>
  1008a8:	7f 1d                	jg     1008c7 <console_vprintf+0x108>
  1008aa:	3c 58                	cmp    $0x58,%al
  1008ac:	0f 84 a2 00 00 00    	je     100954 <console_vprintf+0x195>
  1008b2:	3c 63                	cmp    $0x63,%al
  1008b4:	0f 84 bf 00 00 00    	je     100979 <console_vprintf+0x1ba>
  1008ba:	3c 43                	cmp    $0x43,%al
  1008bc:	0f 85 d0 00 00 00    	jne    100992 <console_vprintf+0x1d3>
  1008c2:	e9 a3 00 00 00       	jmp    10096a <console_vprintf+0x1ab>
  1008c7:	3c 75                	cmp    $0x75,%al
  1008c9:	74 4d                	je     100918 <console_vprintf+0x159>
  1008cb:	3c 78                	cmp    $0x78,%al
  1008cd:	74 5c                	je     10092b <console_vprintf+0x16c>
  1008cf:	3c 73                	cmp    $0x73,%al
  1008d1:	0f 85 bb 00 00 00    	jne    100992 <console_vprintf+0x1d3>
  1008d7:	e9 86 00 00 00       	jmp    100962 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008dc:	83 c3 04             	add    $0x4,%ebx
  1008df:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008e2:	89 d1                	mov    %edx,%ecx
  1008e4:	c1 f9 1f             	sar    $0x1f,%ecx
  1008e7:	89 0c 24             	mov    %ecx,(%esp)
  1008ea:	31 ca                	xor    %ecx,%edx
  1008ec:	55                   	push   %ebp
  1008ed:	29 ca                	sub    %ecx,%edx
  1008ef:	68 a8 0b 10 00       	push   $0x100ba8
  1008f4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008f9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008fd:	e8 90 fe ff ff       	call   100792 <fill_numbuf>
  100902:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100906:	58                   	pop    %eax
  100907:	5a                   	pop    %edx
  100908:	ba 01 00 00 00       	mov    $0x1,%edx
  10090d:	8b 04 24             	mov    (%esp),%eax
  100910:	83 e0 01             	and    $0x1,%eax
  100913:	e9 a5 00 00 00       	jmp    1009bd <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100918:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10091b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100920:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100923:	55                   	push   %ebp
  100924:	68 a8 0b 10 00       	push   $0x100ba8
  100929:	eb 11                	jmp    10093c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10092b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10092e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100931:	55                   	push   %ebp
  100932:	68 bc 0b 10 00       	push   $0x100bbc
  100937:	b9 10 00 00 00       	mov    $0x10,%ecx
  10093c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100940:	e8 4d fe ff ff       	call   100792 <fill_numbuf>
  100945:	ba 01 00 00 00       	mov    $0x1,%edx
  10094a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10094e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100950:	59                   	pop    %ecx
  100951:	59                   	pop    %ecx
  100952:	eb 69                	jmp    1009bd <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100954:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100957:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10095a:	55                   	push   %ebp
  10095b:	68 a8 0b 10 00       	push   $0x100ba8
  100960:	eb d5                	jmp    100937 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100962:	83 c3 04             	add    $0x4,%ebx
  100965:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100968:	eb 40                	jmp    1009aa <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10096a:	83 c3 04             	add    $0x4,%ebx
  10096d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100970:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100974:	e9 bd 01 00 00       	jmp    100b36 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100979:	83 c3 04             	add    $0x4,%ebx
  10097c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10097f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100983:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100988:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10098c:	88 44 24 24          	mov    %al,0x24(%esp)
  100990:	eb 27                	jmp    1009b9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100992:	84 c0                	test   %al,%al
  100994:	75 02                	jne    100998 <console_vprintf+0x1d9>
  100996:	b0 25                	mov    $0x25,%al
  100998:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10099c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1009a1:	80 3f 00             	cmpb   $0x0,(%edi)
  1009a4:	74 0a                	je     1009b0 <console_vprintf+0x1f1>
  1009a6:	8d 44 24 24          	lea    0x24(%esp),%eax
  1009aa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009ae:	eb 09                	jmp    1009b9 <console_vprintf+0x1fa>
				format--;
  1009b0:	8d 54 24 24          	lea    0x24(%esp),%edx
  1009b4:	4f                   	dec    %edi
  1009b5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009b9:	31 d2                	xor    %edx,%edx
  1009bb:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009bd:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1009bf:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009c9:	74 1f                	je     1009ea <console_vprintf+0x22b>
  1009cb:	89 04 24             	mov    %eax,(%esp)
  1009ce:	eb 01                	jmp    1009d1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009d0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009d1:	39 e9                	cmp    %ebp,%ecx
  1009d3:	74 0a                	je     1009df <console_vprintf+0x220>
  1009d5:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009d9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009dd:	75 f1                	jne    1009d0 <console_vprintf+0x211>
  1009df:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009e2:	89 0c 24             	mov    %ecx,(%esp)
  1009e5:	eb 1f                	jmp    100a06 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009e7:	42                   	inc    %edx
  1009e8:	eb 09                	jmp    1009f3 <console_vprintf+0x234>
  1009ea:	89 d1                	mov    %edx,%ecx
  1009ec:	8b 14 24             	mov    (%esp),%edx
  1009ef:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009f3:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009f7:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009fb:	75 ea                	jne    1009e7 <console_vprintf+0x228>
  1009fd:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a01:	89 14 24             	mov    %edx,(%esp)
  100a04:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a06:	85 c0                	test   %eax,%eax
  100a08:	74 0c                	je     100a16 <console_vprintf+0x257>
  100a0a:	84 d2                	test   %dl,%dl
  100a0c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a13:	00 
  100a14:	75 24                	jne    100a3a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a16:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a1b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a22:	00 
  100a23:	75 15                	jne    100a3a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a25:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a29:	83 e0 08             	and    $0x8,%eax
  100a2c:	83 f8 01             	cmp    $0x1,%eax
  100a2f:	19 c9                	sbb    %ecx,%ecx
  100a31:	f7 d1                	not    %ecx
  100a33:	83 e1 20             	and    $0x20,%ecx
  100a36:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a3a:	3b 2c 24             	cmp    (%esp),%ebp
  100a3d:	7e 0d                	jle    100a4c <console_vprintf+0x28d>
  100a3f:	84 d2                	test   %dl,%dl
  100a41:	74 40                	je     100a83 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a43:	2b 2c 24             	sub    (%esp),%ebp
  100a46:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a4a:	eb 3f                	jmp    100a8b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a4c:	84 d2                	test   %dl,%dl
  100a4e:	74 33                	je     100a83 <console_vprintf+0x2c4>
  100a50:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a54:	83 e0 06             	and    $0x6,%eax
  100a57:	83 f8 02             	cmp    $0x2,%eax
  100a5a:	75 27                	jne    100a83 <console_vprintf+0x2c4>
  100a5c:	45                   	inc    %ebp
  100a5d:	75 24                	jne    100a83 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a5f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a61:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a64:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a69:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a6c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a6f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a73:	7d 0e                	jge    100a83 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a75:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a79:	29 ca                	sub    %ecx,%edx
  100a7b:	29 c2                	sub    %eax,%edx
  100a7d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a81:	eb 08                	jmp    100a8b <console_vprintf+0x2cc>
  100a83:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a8a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a8b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a8f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a91:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a95:	2b 2c 24             	sub    (%esp),%ebp
  100a98:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a9d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aa0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100aa3:	29 c5                	sub    %eax,%ebp
  100aa5:	89 f0                	mov    %esi,%eax
  100aa7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100aaf:	eb 0f                	jmp    100ac0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100ab1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ab5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aba:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100abb:	e8 83 fc ff ff       	call   100743 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ac0:	85 ed                	test   %ebp,%ebp
  100ac2:	7e 07                	jle    100acb <console_vprintf+0x30c>
  100ac4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100ac9:	74 e6                	je     100ab1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100acb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ad0:	89 c6                	mov    %eax,%esi
  100ad2:	74 23                	je     100af7 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ad4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ad9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100add:	e8 61 fc ff ff       	call   100743 <console_putc>
  100ae2:	89 c6                	mov    %eax,%esi
  100ae4:	eb 11                	jmp    100af7 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100ae6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aea:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100aef:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100af0:	e8 4e fc ff ff       	call   100743 <console_putc>
  100af5:	eb 06                	jmp    100afd <console_vprintf+0x33e>
  100af7:	89 f0                	mov    %esi,%eax
  100af9:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100afd:	85 f6                	test   %esi,%esi
  100aff:	7f e5                	jg     100ae6 <console_vprintf+0x327>
  100b01:	8b 34 24             	mov    (%esp),%esi
  100b04:	eb 15                	jmp    100b1b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b06:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b0a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b0b:	0f b6 11             	movzbl (%ecx),%edx
  100b0e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b12:	e8 2c fc ff ff       	call   100743 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b17:	ff 44 24 04          	incl   0x4(%esp)
  100b1b:	85 f6                	test   %esi,%esi
  100b1d:	7f e7                	jg     100b06 <console_vprintf+0x347>
  100b1f:	eb 0f                	jmp    100b30 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b21:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b25:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b2a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b2b:	e8 13 fc ff ff       	call   100743 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b30:	85 ed                	test   %ebp,%ebp
  100b32:	7f ed                	jg     100b21 <console_vprintf+0x362>
  100b34:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b36:	47                   	inc    %edi
  100b37:	8a 17                	mov    (%edi),%dl
  100b39:	84 d2                	test   %dl,%dl
  100b3b:	0f 85 96 fc ff ff    	jne    1007d7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b41:	83 c4 38             	add    $0x38,%esp
  100b44:	89 f0                	mov    %esi,%eax
  100b46:	5b                   	pop    %ebx
  100b47:	5e                   	pop    %esi
  100b48:	5f                   	pop    %edi
  100b49:	5d                   	pop    %ebp
  100b4a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b4b:	81 e9 a0 0b 10 00    	sub    $0x100ba0,%ecx
  100b51:	b8 01 00 00 00       	mov    $0x1,%eax
  100b56:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b58:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b59:	09 44 24 14          	or     %eax,0x14(%esp)
  100b5d:	e9 aa fc ff ff       	jmp    10080c <console_vprintf+0x4d>

00100b62 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b62:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b66:	50                   	push   %eax
  100b67:	ff 74 24 10          	pushl  0x10(%esp)
  100b6b:	ff 74 24 10          	pushl  0x10(%esp)
  100b6f:	ff 74 24 10          	pushl  0x10(%esp)
  100b73:	e8 47 fc ff ff       	call   1007bf <console_vprintf>
  100b78:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b7b:	c3                   	ret    
