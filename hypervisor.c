#include <stdint.h>

// This function is called by your assembly vector table
void handle_trap() {
    // 1. Read the Exception Syndrome Register (ESR_EL2)
    // This tells you WHY the guest was trapped (e.g., EC 0x18 is an HVC call)
    uint64_t esr;
    __asm__ volatile ("mrs %0, esr_el2" : "=r" (esr));

    uint64_t ec = (esr >> 26) & 0x3F; // Exception Class

    // 2. The "Bridge" Logic
    if (ec == 0x18) { // HVC (Hypervisor Call)
        // Guest is asking for something. Handle it!
        // Read the "imm" value from the HVC instruction
        // Translate the request and perform it on the real hardware
    } else {
        // Log the unexpected access or force a panic
    }
}
