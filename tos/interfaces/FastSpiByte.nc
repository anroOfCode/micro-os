/**
 * This is a natural extension of the SpiByte interface which allows fast 
 * data transfers comparable to the SpiStream interface. You may want to
 * use the following code sequence to write a buffer as fast as possible
 *
 *	uint8_t *data;
 *	uint8_t *response;
 *
 *	// start the first byte
 *	call FastSpiByte.splitWrite(data[0]);
 *	for(i = 1; i < length; ++i) {
 *	   // finish the previous one and write the next one
 *	  response[i-1] = call FastSpiByte.splitReadWrite(data[i]);
 *	}
 *	// finish the last byte
 *	response[length-1] = call FastSpiByte.splitRead();
 *
 * You can also do some useful computation (like calculate a CRC) while the
 * hardware is sending the byte.
 */
interface FastSpiByte
{
	/**
	 * Starts a split-phase SPI data transfer with the given data.
	 * A splitRead/splitReadWrite command must follow this command even 
	 * if the result is unimportant.
	 */
	async command void splitWrite(uint8_t data);

	/**
	 * Finishes the split-phase SPI data transfer by waiting till 
	 * the write command comletes and returning the received data.
	 */
	async command uint8_t splitRead();

	/**
	 * This command first reads the SPI register and then writes
	 * there the new data, then returns. 
	 */
	async command uint8_t splitReadWrite(uint8_t data);

	/**
	 * This is the standard SpiByte.write command but a little
	 * faster as we should not need to adjust the power state there.
	 * (To be consistent, this command could have be named splitWriteRead).
	 */
	async command uint8_t write(uint8_t data);
}
