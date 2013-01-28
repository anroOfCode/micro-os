/** Interface to be implemented by any low-level component that
 * provides character output for libc-based printf in TinyOS.  The
 * component providing this interface should be wired to PutcharC from
 * $(TOSDIR)/lib/printf.
 *
 * @note On some platforms inclusion of <stdio.h> may define putchar
 * as a macro.  Any need for this should be eliminated by the
 * implementation in PutcharP.nc, so "#undef putchar" prior to your
 * use of this identifier when implementing this interface.
 *
 * @author Peter A. Bigot <pabigot@users.sourceforge.net>
 */
interface Putchar {

    /** Send the unsigned char represented by c to the output.  Return
    * -1 on error, and c if successful. */
#undef putchar
    command int putchar (int c);
}
