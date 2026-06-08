// boot.S - The entry point for our Hypervisor
.section .text.boot
.global _start

_start:
    // 1. Setup a stack pointer for EL2 (Hypervisor level)
    ldr x0, =0x80000000     // Point stack to a safe area in RAM
    msr sp_el2, x0          // Set the stack pointer

    // 2. Configure HCR_EL2 (Hypervisor Configuration Register)
    // We set bit 31 (VM) to 1 to enable Stage-2 translation 
    // and route exceptions to EL2.
    mov x0, #(1 << 31)      
    msr hcr_el2, x0

    // 3. Setup a Vector Table (The "Interception" Hub)
    // Every time the guest OS tries to do something, it will 
    // trigger an exception that jumps here.
    ldr x0, =vector_table
    msr vbar_el2, x0

    // 4. Branch to our main C function
    bl main_hypervisor_loop

// A simple dummy vector table
.align 11
vector_table:
    // This is where the hardware will jump when an exception happens.
    // For now, we just loop infinitely.
    b . 

.global main_hypervisor_loop
main_hypervisor_loop:
    // Your hypervisor logic will live here.
    wfi                     // Wait for interrupt
    b main_hypervisor_loop
