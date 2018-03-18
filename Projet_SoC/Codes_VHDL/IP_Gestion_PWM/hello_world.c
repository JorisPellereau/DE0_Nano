#include <stdio.h>
#include "sys/alt_stdio.h"
#include "system.h"
#include <altera_avalon_pio_regs.h>
//#include <time.h>
int main()
{
 int i = 0;



  while(1) {



	  IOWR(AVALON_BARRE_0_BASE ,0, 5000);			// Selection de la frequence du PWM
	  IOWR(AVALON_BARRE_0_BASE, 1 , 5000);		// Selection duty
	  IOWR(AVALON_BARRE_0_BASE, 2 , 0x02);		// rentree verrin
	 /* usleep(1000000);
		for(i = 5000 ; i>1000 ; i=i-1000)
				{
					IOWR(AVALON_BARRE_0_BASE, 1 , i);		// Selection duty
					IOWR(AVALON_BARRE_0_BASE, 2 , 0x02);		// rentree verrin
					usleep(1000000);
				}


		for(i = 1000 ; i < 5000 ; i=i+1000)
				{
					IOWR(AVALON_BARRE_0_BASE, 1 , i);		// Selection duty
					IOWR(AVALON_BARRE_0_BASE, 2 , 0x06);		// sortie verrin
					usleep(1000000);
				}

*/


	  printf("Hello from Nios II!\n");



  }

  return 0;
}
