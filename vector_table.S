// vector_table.S - The "Trap" Interceptor
.global vector_table
.align 11
vector_table:
    // This is the entry for "Synchronous" exceptions (where traps happen)
    // 1. Save all general purpose registers
    sub sp, sp, #256
    stp x0, x1, [sp, #0]
    // ... (repeat for all x registers) ...

    // 2. Call the C trap handler
    bl handle_trap

    // 3. Restore registers and return to guest
    ldp x0, x1, [sp, #0]
    // ...
    add sp, sp, #256
    eret // The magic instruction that returns to the guest
