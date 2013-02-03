module RandomMlcgC @safe() {
  provides interface Init;
  provides interface ParameterInit<uint16_t> as SeedInit;
  provides interface Random;
}
implementation
{
    uint32_t seed ;

  /* Initialize the seed from the ID of the node */
  command error_t Init.init() {
    atomic  seed = (uint32_t)(TOS_NODE_ID + 1);
    
    return SUCCESS;
  }

  /* Initialize with 16-bit seed */ 
  command error_t SeedInit.init(uint16_t s) {
    atomic  seed = (uint32_t)(s + 1);
    
    return SUCCESS;
  }

  /* Return the next 32 bit random number */
  async command uint32_t Random.rand32() {
    uint32_t mlcg,p,q;
    uint64_t tmpseed;
    atomic
      {
	tmpseed =  (uint64_t)33614U * (uint64_t)seed;
	q = tmpseed; 	/* low */
	q = q >> 1;
	p = tmpseed >> 32 ;		/* hi */
	mlcg = p + q;
        if (mlcg & 0x80000000) { 
	  mlcg = mlcg & 0x7FFFFFFF;
	  mlcg++;
	}
	seed = mlcg;
      }
    return mlcg; 
  }

  /* Return low 16 bits of next 32 bit random number */
  async command uint16_t Random.rand16() {
    return (uint16_t)call Random.rand32();
  }

#if 0
 /* Return high 16 bits of 32 bit number */
 inline uint16_t getHigh16(uint32_t num) {
    return num >> 16;
 }
#endif
}
