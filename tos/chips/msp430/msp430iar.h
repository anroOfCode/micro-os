#ifndef _H_MSP430IAR_H
#define _H_MSP430IAR_H
/*
 * We want to remember these just in case the gcc toolchain doesn't
 * pan out.   Remember in main trunk.
 */

#ifdef WITH_IAR
/*
 * Remove any MSPGCC redefines of the IAR intrinsics, and point the GCC
 * versions at them.
 */
#undef READ_SR
#undef __get_SR_register
#define READ_SR __get_SR_register()
#undef BIC_SR
#undef __bic_SR_register
#define BIC_SR(_x) __bic_SR_register(_x)
#undef BIS_SR
#undef __bis_SR_register
#define BIS_SR(_x) __bis_SR_register(_x)
#undef __bis_SR_register_on_exit
#undef _BIS_SR_IRQ
#define _BIS_SR_IRQ(_x) __bis_SR_register_on_exit(_x)
#undef __bic_SR_register_on_exit
#undef _BIC_SR_IRQ
#define _BIC_SR_IRQ(_x) __bic_SR_register_on_exit(_x)

/*
 * Avoid gcc whining about IAR intrinsics by declaring them;
 * but mark them so the mangler script doesn't leave these bogus
 * prototypes in the source for IAR to find.
 */
#if defined(__GNUC__)
typedef volatile uint8_t tinyos_iar_msp430reg1_deleteme_t;
tinyos_iar_msp430reg1_deleteme_t __get_SR_register ();
tinyos_iar_msp430reg1_deleteme_t __bic_SR_register (uint8_t x);
tinyos_iar_msp430reg1_deleteme_t __bis_SR_register (uint8_t x);
tinyos_iar_msp430reg1_deleteme_t __bic_SR_register_on_exit (uint8_t x);
#endif		/* __GNUC__ */

/* IAR won't accept array declarations with zero elements */
#define STATIC_ARRAY_SIZE(_s) (((_s) == 0) ? 1 : (_s))

#endif		/* WITH_IAR */

#endif		/* _H_MSP430IAR_H */
