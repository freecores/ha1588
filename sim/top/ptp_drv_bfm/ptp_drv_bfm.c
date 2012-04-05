#include <stdio.h>

#include "svdpi.h"
#include "../dpiheader.h"
int ptp_drv_bfm_c(double fw_delay)
{
  int cpu_addr_i;
  int cpu_data_i;
  int cpu_data_o;

  // LOAD RTC PERIOD AND ACC_MODULO
  cpu_addr_i = 0x00000020;
  cpu_data_i = 0x8;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000024;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000028;
  cpu_data_i = 0x3B9ACA00;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x0000002C;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x4;
  cpu_wr(cpu_addr_i, cpu_data_i);
  // RESET RTC
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x10;
  cpu_wr(cpu_addr_i, cpu_data_i);
  // LOAD RTC SEC AND NS
  cpu_addr_i = 0x00000010;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000014;
  cpu_data_i = 0x1;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000018;
  cpu_data_i = 0x3B9AC9F6;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x0000001C;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x8;
  cpu_wr(cpu_addr_i, cpu_data_i);
  // LOAD RTC ADJ
  cpu_addr_i = 0x00000030;
  cpu_data_i = 0x100;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000038;
  cpu_data_i = 0x1;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x0000003C;
  cpu_data_i = 0x20;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x2;
  cpu_wr(cpu_addr_i, cpu_data_i);
  // READ RTC SEC AND NS
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x1;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X00000040;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X00000044;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X00000048;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X0000004C;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  // READ RTC SEC AND NS
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x0;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_addr_i = 0x00000000;
  cpu_data_i = 0x1;
  cpu_wr(cpu_addr_i, cpu_data_i);
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X00000040;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X00000044;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X00000048;
  cpu_rd(cpu_addr_i, &cpu_data_o);
  cpu_addr_i = 0X0000004C;
  cpu_rd(cpu_addr_i, &cpu_data_o);

  // READ BACK ALL REGISTERS
  for (;;)
  {
    int t;
    for (t=0; t<=0x5c; t=t+4) 
    {
      cpu_addr_i = t;
      cpu_rd(cpu_addr_i, &cpu_data_o);

      cpu_hd(10);
    }
  }

  return(0); /* Return success (required by tasks) */
}
