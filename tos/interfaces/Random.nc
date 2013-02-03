interface Random
{
    /** 
     * Produces a 32-bit pseudorandom number. 
     * @return Returns the 32-bit pseudorandom number.
     */
  async command uint32_t rand32();

    /** 
     * Produces a 32-bit pseudorandom number. 
     * @return Returns low 16 bits of the pseudorandom number.
     */
  async command uint16_t rand16();

}

    
