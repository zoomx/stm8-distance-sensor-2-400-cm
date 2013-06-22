/*
Using ST Standard Peripheral Driver Library
*/ 
 #include "board.h"
 #include "delay.h"
 
 #define WR_EN             (u8)0x06    /* Write Enable */
 #define RD                (u8)0x03    /* Read Memory at 25 MHz */
 #define RD_HS             (u8)0x0B    /* Read Memory at 80 MHz */
 #define SEC_ERASE_4KB     (u8)0x20    /* Erase 4 KByte of memory array */
 #define SEC_ERASE_32KB    (u8)0x52    /* Erase 32 KByte block of memory array */
 #define SEC_ERASE_64KB    (u8)0xD8    /* Erase 64 KByte block of memory array */
 #define CHIP_ERASE        (u8)0x60    /* Erase Full Memory Array */
 #define BYTE_PROGRAM      (u8)0x02    /* To Program One Data Byte */
 #define AAI_WORD_PROGRAM  (u8)0xAD    /* Auto Address Increment Programming */
 #define RD_STAT_REG       (u8)0x05    /* Read-Status-Register */
 #define EN_WR_STAT_REG    (u8)0x50    /* Enable-Write-Status-Register */
 #define WR_STAT_REG       (u8)0x01    /* Write-Status-Register */
 #define WR_DIS            (u8)0x04    /* Write-Disable */
 #define RD_ID             (u8)0x90    /* Read-ID */
 #define RD_JEDEC_ID       (u8)0x9F    /* JEDEC ID read */
 #define EN_SY             (u8)0x70    /* Enable SO to output RY/BY# status during AAI programming */
 #define DIS_SY            (u8)0x80    /* Disable SO to output RY/BY# status during AAI programming */
 
 #define MAX_ADDRESS   0x1FFFFF
 
 void SST25VF016_Init(void)
 {
   SPI_DeInit();
   SPI_Init(SPI_FIRSTBIT_MSB, 
            SPI_BAUDRATEPRESCALER_128, 
            SPI_MODE_MASTER, 
            SPI_CLOCKPOLARITY_LOW, 
            SPI_CLOCKPHASE_1EDGE, 
            SPI_DATADIRECTION_2LINES_FULLDUPLEX, 
            SPI_NSS_SOFT, 0x07);
  SPI_Cmd(ENABLE);
 }
 
 /*
 The Read instruction, 03H, supports up to 25 MHz Read. The device outputs the data starting from the specified address location. The data output stream is continuous
through all addresses until terminated by a low to high transition on CE#. The internal address pointer will automatically increment until the highest memory address is
reached. Once the highest memory address is reached, the address pointer will automatically increment to the beginning (wrap-around) of the address space. Once the
data from address location 1FFFFFH has been read, the next output will be from address location 000000H. The Read instruction is initiated by executing an 8-bit command,
03H, followed by address bits [A23-A0]. CE# must remain active low for the duration of the Read cycle.
 */
 void SST25VF016_Read(u32 addr, u8* buffer, u16 nr_bytes)
 {
   u16 i;
   SPI_SendData(RD);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
   for(i = 0; i < nr_bytes; i++)
   {
     buffer[i] = SPI_ReceiveData();
   }
 }
 
 /*
 The High-Speed-Read instruction supporting up to 80 MHz Read is initiated by executing an 8-bit command, 0BH, followed by address bits [A23-A0] and a dummy byte. CE#
must remain active low for the duration of the High-Speed-Read cycle. See Figure 6 for the High-Speed-Read sequence. Following a dummy cycle, the High-Speed-Read instruction
outputs the data starting from the specified address location. The data output stream is continuous through all addresses until terminated by a low to high transition on
CE#. The internal address pointer will automatically increment until the highest memory address is reached. Once the highest memory address is reached, the address
pointer will automatically increment to the beginning (wraparound) of the address space. Once the data from address location 1FFFFFH has been read, the next output will be
from address location 000000H.
 */
 void SST25VF016_Read_HS(u32 addr, u8* buffer, u16 nr_bytes)
 {
   u16 i;
   SPI_SendData(RD);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
   SPI_SendData(0xFF);   /* dummy byte */
   for(i = 0; i < nr_bytes; i++)
   {
     buffer[i] = SPI_ReceiveData();
   }
 }
 
 /*
 The Byte-Program instruction programs the bits in the selected byte to the desired data. The selected byte must be in the erased state (FFH) when initiating a Program
operation. A Byte-Program instruction applied to a protected memory area will be ignored. Prior to any Write operation, the Write-Enable (WREN)
instruction must be executed. CE# must remain active low for the duration of the Byte-Program instruction. The Byte-Program instruction is initiated by executing an 8-bit command,
02H, followed by address bits [A23-A0]. Following the address, the data is input in order from MSB (bit 7) to LSB (bit 0). CE# must be driven high before the instruction is
executed. The user may poll the Busy bit in the software status register or wait TBP for the completion of the internal self-timed Byte-Program operation.
 */
 void SST25VF016_Program_Byte(u32 addr, u8 data)
 {
   SPI_SendData(WR_EN);
   SPI_SendData(BYTE_PROGRAM);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
   SPI_SendData(data);
 }
 
 /*
 The hardware end-of-write detection method eliminates the overhead of polling the Busy bit in the Software Status Register during an AAI Word program operation. The 8-bit
command, 70H, configures the Serial Output (SO) pin to indicate Flash Busy status during AAI Word programming. (see Figure 8) The 8-bit command, 70H, must be executed
prior to executing an AAI Word-Program instruction. Once an internal programming operation begins, asserting CE# will immediately drive the status of the internal flash status
on the SO pin. A “0” indicates the device is busy and a “1” indicates the device is ready for the next instruction. Deasserting CE# will return the SO pin to tri-state.
The 8-bit command, 80H, disables the Serial Output (SO) pin to output busy status during AAI-Word-program operation and return SO pin to output Software Status Register
data during AAI Word programming.
 */
 void SST25VF016_Enable_SY(void)
 {
   SPI_SendData(EN_SY);
 }
 
 void SST25VF016_Disable_SY(void)
 {
   SPI_SendData(DIS_SY);
 }
 
 /*
 The AAI program instruction allows multiple bytes of data to be programmed without re-issuing the next sequential address location. This feature decreases total programming
time when multiple bytes or entire memory array is to be programmed. An AAI Word program instruction pointing to a protected memory area will be ignored. The selected
address range must be in the erased state (FFH) when initiating an AAI Word Program operation. While within AAI Word Programming sequence, the only valid instructions
are AAI Word (ADH), RDSR (05H), or WRDI (04H). Users have three options to determine the completion of each AAI Word program cycle: hardware detection by reading
the Serial Output, software detection by polling the BUSY bit in the software status register or wait TBP. Refer to End-Of-Write Detection section for details.
Prior to any write operation, the Write-Enable (WREN) instruction must be executed. The AAI Word Program instruction is initiated by executing an 8-bit command,
ADH, followed by address bits [A23-A0]. Following the addresses, two bytes of data is input sequentially, each one from MSB (Bit 7) to LSB (Bit 0). The first byte of data (D0)
will be programmed into the initial address [A23-A1] with A0=0, the second byte of Data (D1) will be programmed into the initial address [A23-A1] with A0=1. CE# must be
driven high before the AAI Word Program instruction is executed. The user must check the BUSY status before entering the next valid command. Once the device indicates it is
no longer busy, data for the next two sequential addresses may be programmed and so on. When the last desired byte had been entered, check the busy status using the
hardware method or the RDSR instruction and execute the Write-Disable (WRDI) instruction, 04H, to terminate AAI. User must check busy status after WRDI to determine if the
device is ready for any command. See Figures 10 and 11 for AAI Word programming sequence. There is no wrap mode during AAI programming; once the
highest unprotected memory address is reached, the device will exit AAI operation and reset the Write-Enable-Latch bit (WEL = 0) and the AAI bit (AAI=0).
 */
 void SST25VF016_AAI_Word_Program(u32 addr, u8* data, u16 nr_words)
 {
   u16 i;
   SPI_SendData(WR_EN);
   SPI_SendData(AAI_WORD_PROGRAM);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
   for(i = 0; i < nr_words*2;)
   {
     SPI_SendData(data[i++]); 
     SPI_SendData(data[i++]);
   }
   SPI_SendData(WR_DIS);    /* Exit AAI mode */
 }
 
 /*
 The Sector-Erase instruction clears all bits in the selected 4KByte sector to FFH. A Sector-Erase instruction applied to
a protected memory area will be ignored. Prior to any Write operation, the Write-Enable (WREN) instruction must be
executed. CE# must remain active low for the duration of any command sequence. The Sector-Erase instruction is
initiated by executing an 8-bit command, 20H, followed by address bits [A23-A0]. Address bits [AMS-A12] (AMS=Most
Significant address) are used to determine the sector address (SAX), remaining address bits can be VIL or VIH.
CE# must be driven high before the instruction is executed. The user may poll the Busy bit in the software status register
or wait TSE for the completion of the internal self-timed Sector-Erase cycle.
 */
 void SST25VF016_Sector_Erase_4KB(u32 addr)
 {
   SPI_SendData(WR_EN);
   SPI_SendData(SEC_ERASE_4KB);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
 }
 
 /*
 The 32-KByte Block-Erase instruction clears all bits in the selected 32 KByte block to FFH. A Block-Erase instruction
applied to a protected memory area will be ignored. The 64-KByte Block-Erase instruction clears all bits in the
selected 64 KByte block to FFH. A Block-Erase instruction applied to a protected memory area will be ignored. Prior to
any Write operation, the Write-Enable (WREN) instruction must be executed. CE# must remain active low for the
duration of any command sequence. The 32-Kbyte Block- Erase instruction is initiated by executing an 8-bit command,
52H, followed by address bits [A23-A0]. Address bits [AMS-A15] (AMS = Most Significant Address) are used to
determine block address (BAX), remaining address bits can be VIL or VIH. CE# must be driven high before the instruction
is executed. The 64-Kbyte Block-Erase instruction is initiated by executing an 8-bit command D8H, followed by
address bits [A23-A0]. Address bits [AMS-A15] are used to determine block address (BAX), remaining address bits can
be VIL or VIH. CE# must be driven high before the instruction is executed. The user may poll the Busy bit in the software
status register or wait TBE for the completion of the internal self-timed 32-KByte Block-Erase or 64-KByte Block-Erase cycles.
 */
 void SST25VF016_Sector_Erase_32KB(u32 addr)
 {
   SPI_SendData(WR_EN);
   SPI_SendData(SEC_ERASE_32KB);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
 }
 
 void SST25VF016_Sector_Erase_64KB(u32 addr)
 {
   SPI_SendData(WR_EN);
   SPI_SendData(SEC_ERASE_64KB);
   SPI_SendData( (u8)(addr >> 16) );
   SPI_SendData( (u8)((addr << 16) >> 24) );
   SPI_SendData( (u8)((addr << 24) >> 24) );
 }
 
 /*
 The Chip-Erase instruction clears all bits in the device to FFH. A Chip-Erase instruction will be ignored if any of the
memory area is protected. Prior to any Write operation, the Write-Enable (WREN) instruction must be executed. CE#
must remain active low for the duration of the Chip-Erase instruction sequence. The Chip-Erase instruction is initiated
by executing an 8-bit command, 60H or C7H. CE# must be driven high before the instruction is executed. The user may
poll the Busy bit in the software status register or wait TCE for the completion of the internal self-timed Chip-Erase cycle.
 */
 void SST25VF016_Chip_Erase()
 {
   SPI_SendData(WR_EN);
   SPI_SendData(CHIP_ERASE);
 }
 
 
 /*
 The Write-Status-Register instruction writes new values to the BP3, BP2, BP1, BP0, and BPL bits of the status register.
 Executing the Write-Status-Register instruction will be ignored when WP# is low and BPL bit is set to “1”. When
the WP# is low, the BPL bit can only be set from “0” to “1” to lock-down the status register, but cannot be reset from “1”
to “0”. When WP# is high, the lock-down function of the BPL bit is disabled and the BPL, BP0, and BP1 and BP2
bits in the status register can all be changed. As long as BPL bit is set to 0 or WP# pin is driven high (VIH) prior to the
low-to-high transition of the CE# pin at the end of the WRSR instruction, the bits in the status register can all be
altered by the WRSR instruction. In this case, a single WRSR instruction can set the BPL bit to “1” to lock down
the status register as well as altering the BP0, BP1, and BP2 bits at the same time.
 */
 void SST25VF016_Write_Status_Register(u8 data)
 {
   SPI_SendData(EN_WR_STAT_REG);
   SPI_SendData(WR_STAT_REG);
   SPI_SendData(data);
 }
 
 /*
 The JEDEC Read-ID instruction identifies the device as SST25VF016B and the manufacturer as SST. The device information can be read from executing the 8-bit command,
9FH. Following the JEDEC Read-ID instruction, the 8-bit manufacturer’s ID, BFH, is output from the device. After that, a 16-bit device ID is shifted out on the SO pin. Byte 1,
BFH, identifies the manufacturer as SST. Byte 2, 25H, identifies the memory type as SPI Serial Flash. Byte 3, 41H, identifies the device as SST25VF016B. The instruction
sequence is shown in Figure 20. The JEDEC Read ID instruction is terminated by a low to high transition on CE# at any time during data output. If no other command is
issued after executing the JEDEC Read-ID instruction, issue a 00H (NOP) command before going into Standby Mode (CE#=VIH).
 */
 void SST25VF016_Read_JEDEC_ID(u8* buffer)
 {
   SPI_CS_LOW;
   DELAY_US(DELAY_60US);
   SPI_SendData(RD_JEDEC_ID);
   while(!(SPI->SR & SPI_SR_TXE));

   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   while(!(SPI->SR & SPI_SR_RXNE));
   buffer[0] = SPI_ReceiveData();
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   while(!(SPI->SR & SPI_SR_RXNE));
   buffer[1] = SPI_ReceiveData();
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   while(!(SPI->SR & SPI_SR_RXNE));
   buffer[2] = SPI_ReceiveData();
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   while(!(SPI->SR & SPI_SR_RXNE));
   DELAY_US(DELAY_60US);
   SPI_CS_HIGH;
 }
 
 /*
 The Read-ID instruction (RDID) identifies the devices as SST25VF016B and manufacturer as SST. This command is backward compatible to all SST25xFxxxA devices and
should be used as default device identification when multiple versions of SPI Serial Flash devices are used in a design. The device information can be read from executing
an 8-bit command, 90H or ABH, followed by address bits [A23-A0]. Following the Read-ID instruction, the manufacturer’s ID is located in address 00000H and the device ID is
located in address 00001H. Once the device is in Read-ID mode, the manufacturer’s and device ID output data toggles between address 00000H and 00001H until terminated
by a low to high transition on CE#.
 */
 void SST25VF016_Read_ID(u8* buffer)
 {
   SPI_CS_LOW;
   DELAY_US(DELAY_6US);
   SPI_SendData(RD_ID);
   while(!(SPI->SR & SPI_SR_TXE));
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));  

   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   while(!(SPI->SR & SPI_SR_RXNE));
   buffer[0] = SPI_ReceiveData();
   SPI_SendData(0x00);
   while(!(SPI->SR & SPI_SR_TXE));
   while(!(SPI->SR & SPI_SR_RXNE));
   buffer[1] = SPI_ReceiveData();
   DELAY_US(DELAY_6US);
   SPI_CS_HIGH;
 }