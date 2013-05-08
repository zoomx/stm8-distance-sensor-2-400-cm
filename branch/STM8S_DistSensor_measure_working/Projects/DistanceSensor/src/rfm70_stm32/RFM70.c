#include "rfm70.h"


///////////////////////////////////////////////////////////////////////////////
// Register initialization values and command macros //
///////////////////////////////////////////////////////////////////////////////

//************ Address definition commands
const uint8_t RFM70_cmd_adrRX0[] = { (0x20|0x0A), 0x34,0x43,0x10,0x10,0x01};
const uint8_t RFM70_cmd_adrTX[]  = { (0x20|0x10), 0x34,0x43,0x10,0x10,0x01};
const uint8_t RFM70_cmd_adrRX1[] = { (0x20|0x0B), 0x35,0x43,0x10,0x10,0x02};

//************ Bank0 register initialization commands
 const uint8_t RFM70_bank0Init[][2] = {
  // address data
  { (0x20|0x00), 0x0F }, //Disable CRC ,CRC=1byte, POWER UP, TX
  { (0x20|0x01), 0x3F }, //Enable auto acknowledgement data pipe0-5
  { (0x20|0x02), 0x3F }, //Enable RX Addresses pipe0-5
  { (0x20|0x03), 0x03 }, //RX/TX address field width 5byte
  { (0x20|0x04), 0x08 }, //x = 250 ms = 4000ms, y = 15 tries
  { (0x20|0x05), 0x17 }, //channel = 0x17
  { (0x20|0x06), 0x3F }, //air data rate-2M,out power 5dbm,setup LNA gain high (0dBM)
  { (0x20|0x07), 0x07 }, //
  { (0x20|0x08), 0x00 }, //
  { (0x20|0x09), 0x00 }, //
  { (0x20|0x0C), 0xc3 }, //LSB Addr pipe 2
  { (0x20|0x0D), 0xc4 }, //LSB Addr pipe 3
  { (0x20|0x0E), 0xc5 }, //LSB Addr pipe 4
  { (0x20|0x0F), 0xc6 }, //LSB Addr pipe 5
  { (0x20|0x11), 0x20 }, //Payload len pipe0
  { (0x20|0x12), 0x20 }, //Payload len pipe0
  { (0x20|0x13), 0x20 }, //Payload len pipe0
  { (0x20|0x14), 0x20 }, //Payload len pipe0
  { (0x20|0x15), 0x20 }, //Payload len pipe0
  { (0x20|0x16), 0x20 }, //Payload len pipe0
  { (0x20|0x17), 0x20 }, //Payload len pipe0
  { (0x20|0x1C), 0x3F }, //Enable dynamic payload legth data pipe0-5
  { (0x20|0x1D), 0x07 } //Enables Dynamic Payload Length,Enables Payload with ACK
};

//************ Bank1 register initialization commands
 const uint8_t RFM70_bank1Init[][5] = {
  // address data
  { (0x20|0x00), 0x40, 0x4B, 0x01, 0xE2 },
  { (0x20|0x01), 0xC0, 0x4B, 0x00, 0x00 },
  { (0x20|0x02), 0xD0, 0xFC, 0x8C, 0x02 },
  { (0x20|0x03), 0x99, 0x00, 0x39, 0x41 },
  { (0x20|0x04), 0xb9, 0x9E, 0x86, 0x0B }, // b9? f9?
  { (0x20|0x05), 0x24, 0x06, 0x7F, 0xA6 },
  { (0x20|0x06), 0x00, 0x00, 0x00, 0x00 },
  { (0x20|0x07), 0x00, 0x00, 0x00, 0x00 },
  { (0x20|0x08), 0x00, 0x00, 0x00, 0x00 },
  { (0x20|0x09), 0x00, 0x00, 0x00, 0x00 },
  { (0x20|0x0a), 0x00, 0x00, 0x00, 0x00 },
  { (0x20|0x0b), 0x00, 0x00, 0x00, 0x00 },
  { (0x20|0x0C), 0x00, 0x12, 0x73, 0x00 },
  { (0x20|0x0D), 0x36, 0xb4, 0x80, 0x00 }
};

//************ Bank1 register 14 initialization commands
 const uint8_t RFM70_bank1R0EInit[] = {
  // address Data...
  (0x20|0x0E), 0x41,0x20,0x08,0x04,0x81,0x20,0xCF,0xF7,0xFE,0xFF,0xFF
};

//************ other commands: { <command>, <data>, ... }
const uint8_t RFM70_cmd_switch_cfg[] = { 0x50, 0x53 }; // switch Register Bank
const uint8_t RFM70_cmd_flush_rx[] = { 0xe2, 0x00 }; // flush RX FIFO
const uint8_t RFM70_cmd_flush_tx[] = { 0xe1, 0x00 }; // flush TX FIFO
const uint8_t RFM70_cmd_activate[] = { 0x50, 0x73 }; // Activation command
const uint8_t RFM70_cmd_tog1[]={ (0x20|0x04), 0xd9 | 0x06, 0x9e, 0x86, 0x0b }; //assosciated with set1[4]!
const uint8_t RFM70_cmd_tog2[]={ (0x20|0x04), 0xd9 & ~0x06, 0x9e, 0x86, 0x0b}; //assosciated with set1[4]!


///////////////////////////////////////////////////////////////////////////////
// RFM70 initialization //
///////////////////////////////////////////////////////////////////////////////

void initRegisters() {
  int i;
  // init bank 0 registers
  selectBank(0);

  // !! The last two regs in the bank0Init list will be handled later
  for (i = 0; i < 20; i++)
    writeRegVal(RFM70_bank0Init[i][0], RFM70_bank0Init[i][1]);

  // init address registers in bank 0
  writeRegPgmBuf((uint8_t *)RFM70_cmd_adrRX0, sizeof(RFM70_cmd_adrRX0));
  writeRegPgmBuf((uint8_t *)RFM70_cmd_adrRX1, sizeof(RFM70_cmd_adrRX1));
  writeRegPgmBuf((uint8_t *)RFM70_cmd_adrTX, sizeof(RFM70_cmd_adrTX));

  // activate Feature register
  if(!readRegVal(RFM70_REG_FEATURE))
    writeRegPgmBuf((uint8_t *)RFM70_cmd_activate, sizeof(RFM70_cmd_activate));

  // now set Registers 1D and 1C
  writeRegVal(RFM70_bank0Init[22][0], RFM70_bank0Init[22][1]);
  writeRegVal(RFM70_bank0Init[21][0], RFM70_bank0Init[21][1]);

  // init bank 1 registers
  selectBank(1);

  for (i=0; i < 14; i++)
    writeRegPgmBuf((uint8_t *)RFM70_bank1Init[i], sizeof(RFM70_bank1Init[i]));

  // set ramp curve
  writeRegPgmBuf((uint8_t *)RFM70_bank1R0EInit, sizeof(RFM70_bank1R0EInit));

  // do we have to toggle some bits here like in the example code?
  writeRegPgmBuf((uint8_t *)RFM70_cmd_tog1, sizeof(RFM70_cmd_tog1));
  writeRegPgmBuf((uint8_t *)RFM70_cmd_tog2, sizeof(RFM70_cmd_tog2));


  delayMs(RFM70_END_INIT_WAIT_MS);

  //Check the ChipID
  if (readRegVal(0x08) != 0x63)
    debug(RFM70_DEBUG_WRONG_CHIP_ID);

  selectBank(0);
  setModeRX();
}

inline void Begin(uint8_t irq) {
  delayMs(RFM70_BEGIN_INIT_WAIT_MS);
  initRegisters();
  confAddrWidth(3);
}


///////////////////////////////////////////////////////////////////////////////
// RFM70 Control //
///////////////////////////////////////////////////////////////////////////////


void selectBank(uint8_t bank) {
  uint8_t tmp = readRegVal(0x07) & 0x80;
  if(bank) {
    if(!tmp)
      writeRegPgmBuf((uint8_t *)RFM70_cmd_switch_cfg, sizeof(RFM70_cmd_switch_cfg));
  }
  else {
    if(tmp)
      writeRegPgmBuf((uint8_t *)RFM70_cmd_switch_cfg, sizeof(RFM70_cmd_switch_cfg));
  }
}


void setMode(uint8_t mode) {
  if (mode)
    setModeRX();
  else
    setModeTX();
}


void setModeRX(void)
{
  uint8_t val;

  writeRegPgmBuf((uint8_t *)RFM70_cmd_flush_rx, sizeof(RFM70_cmd_flush_rx)); // Flush RX FIFO
  val = readRegVal(RFM70_REG_STATUS); // Read Status
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_STATUS, val); // Reset IRQ bits
  setPinState(CE, LOW); // RFM chip disable
  // set PRIM_RX bit to 1
  val=readRegVal(RFM70_REG_CONFIG);
  val |= RFM70_PIN_PRIM_RX;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_CONFIG, val);
  setPinState(CE, HIGH); // RFM chip enable
}

void setModeTX(void)
{
  uint8_t val;

  writeRegPgmBuf((uint8_t *)RFM70_cmd_flush_tx, sizeof(RFM70_cmd_flush_tx)); // Flush TX FIFO
  setPinState(CE, LOW); // RFM chip disable
  // set PRIM_RX bit to 0
  val=readRegVal(RFM70_REG_CONFIG);
  val &= ~RFM70_PIN_PRIM_RX;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_CONFIG, val);
  setPinState(CE, HIGH); // RFM chip enable
}



uint8_t configRxPipe(uint8_t pipe_nr, uint8_t * adr, uint8_t plLen, uint8_t en_aa) {

  uint8_t tmp;
  uint8_t nr = pipe_nr -1;

  if(plLen > 32 || nr > 5 || en_aa > 1)
        return 0;

  // write address
  if(nr<2)      // full length for rx pipe 0 an 1
    writeRegCmdBuf(RFM70_CMD_WRITE_REG | (RFM70_REG_RX_ADDR_P0 + nr), adr, sizeof(adr));
  else // only LSB for pipes 2..5
    writeRegVal(RFM70_CMD_WRITE_REG | (RFM70_REG_RX_ADDR_P0 + nr), adr[0]); //ODO:check this

  // static
  if (plLen) {
    // set payload len
    writeRegVal(RFM70_CMD_WRITE_REG | (RFM70_REG_RX_PW_P0 + nr), plLen);
        // set EN_AA bit
        tmp = readRegVal(RFM70_REG_EN_AA);
        if (en_aa)
                tmp |= 1 << nr;
        else
                tmp &= ~(1 << nr);
        writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_EN_AA, tmp);
        // clear DPL bit
        tmp = readRegVal(RFM70_REG_DYNPD);
        tmp &= ~(1 << nr);
        writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_DYNPD, tmp);
        // set Enable pipe bit
        enableRxPipe(nr);
  }
  // dynamic
  else {
    // set payload len to default
    writeRegVal(RFM70_CMD_WRITE_REG | (RFM70_REG_RX_PW_P0 + nr), 0x20);
        // set EN_AA bit
        tmp = readRegVal(RFM70_REG_EN_AA);
        tmp |= 1 << nr;
        writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_EN_AA, tmp);
        // set DPL bit
        tmp = readRegVal(RFM70_REG_DYNPD);
        tmp |= 1 << nr;
        writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_DYNPD, tmp);
        // set Enable pipe bit
        enableRxPipe(nr);
  }
  return 1;
}


void enableRxPipe(uint8_t pipe_nr) {
  uint8_t nr = pipe_nr - 1;
  if (nr > 5) return;
  uint8_t tmp;
  // set Enable pipe bit
  tmp = readRegVal(RFM70_REG_EN_RXADDR);
  tmp |= 1 << nr;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_EN_RXADDR, tmp);
}

void disableRxPipe(uint8_t pipe_nr) {
  uint8_t nr = pipe_nr - 1;
  if (nr > 5) return;
  uint8_t tmp;
  // set Enable pipe bit
  tmp = readRegVal(RFM70_REG_EN_RXADDR);
  tmp &= ~(1 << nr);
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_EN_RXADDR, tmp);

}


void configTxPipe(uint8_t * adr, uint8_t pltype) {
  // write TX address
  writeRegCmdBuf(RFM70_CMD_WRITE_REG | RFM70_REG_TX_ADDR, adr, sizeof(adr));
  // write RX0 address
  writeRegCmdBuf(RFM70_CMD_WRITE_REG | RFM70_REG_RX_ADDR_P0, adr, sizeof(adr));
  // set static or dynamic payload
  uint8_t tmp;
  tmp = readRegVal(RFM70_REG_DYNPD);
  if(pltype == TX_DPL) // dynamic
        tmp |= 1;
  else
    tmp &= ~(1 << 0);
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_DYNPD, tmp);
}


void configCRC(uint8_t crc) {
//  setPinState(CE, LOW); // RFM chip disable
  uint8_t tmp = readRegVal(RFM70_REG_CONFIG);
  //reset crc state
  tmp &= 0xF3;
  if (crc == CRC1)
    tmp |= 0x08;
  else if (crc == CRC2)
    tmp |= 0x0C;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_CONFIG, tmp);
//  setPinState(CE, HIGH); // RFM chip enable
}


void configARD(uint8_t ard) {
  if (ard > 0x0f) return;
  uint8_t tmp = readRegVal(RFM70_REG_SETUP_RETR);
  tmp &= ((ard << 4) | 0x0F);
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_SETUP_RETR, tmp);
}

void configARC(uint8_t arc) {
  if (arc > 0x0f) return;
  uint8_t tmp = readRegVal(RFM70_REG_SETUP_RETR);
  tmp &= (arc | 0xF0);
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_SETUP_RETR, tmp);
}

void configSpeed(uint8_t speed) {
  if (speed > 2 || speed < 1) return;
  uint8_t tmp = readRegVal(RFM70_REG_RF_SETUP);
  tmp &= 0xF7;
  tmp |= speed << 3;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_RF_SETUP, tmp);
}

void configLnaGain(uint8_t gain) {
  if (gain > 1) return;
  uint8_t tmp = readRegVal(RFM70_REG_RF_SETUP);
  tmp &= 0xFE;
  tmp |= gain;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_RF_SETUP, tmp);
}


void configRfPower(uint8_t pwr) {
  if (pwr > 3) return;
  uint8_t tmp = readRegVal(RFM70_REG_RF_SETUP);
  tmp &= 0xF9;
  tmp |= pwr << 1;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_RF_SETUP, tmp);
}

void confAddrWidth(uint8_t width) {
  if (width < 3 || width > 5) return;
  uint8_t tmp = readRegVal(RFM70_REG_SETUP_AW);
  tmp &= ( 0xF0 | (width - 2 ));
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_SETUP_AW, tmp);
}

void setPower(uint8_t pwr) {
  if (pwr > 1) return;
//  setPinState(CE, LOW); // RFM chip disable
  uint8_t tmp = readRegVal(RFM70_REG_CONFIG);
  tmp &= (0xFD | (pwr << 1));
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_CONFIG, tmp);
  setPinState(CE, LOW);
//  setPinState(CE, HIGH); // RFM chip enable
}

void confIRQ(uint8_t irq_pin, uint8_t reflectTX_DS, uint8_t reflectRX_DR, uint8_t reflectMAX_RT) {
//  setPinState(CE, LOW); // RFM chip disable
  uint8_t tmp = readRegVal(RFM70_REG_CONFIG) & 0x8F;
  tmp|= ((reflectTX_DS & 0x01) ^ 0x01) << 6;
  tmp|= ((reflectRX_DR & 0x01) ^ 0x01) << 5;
  tmp|= ((reflectMAX_RT & 0x01) ^ 0x01) << 4;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_CONFIG, tmp);
//  setPinState(CE, HIGH); // RFM chip enable
}

void cliAll() {
  uint8_t tmp = readRegVal(RFM70_REG_STATUS) | 0x70;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_STATUS, tmp);
}


void cliRxDr() {
  uint8_t tmp = (readRegVal(RFM70_REG_STATUS) | 0x40) & 0xCF;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_STATUS, tmp);
}

void cliTxDs() {
  uint8_t tmp = (readRegVal(RFM70_REG_STATUS) | 0x20) & 0xAF;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_STATUS, tmp);
}


void cliTimeout() {
  uint8_t tmp = (readRegVal(RFM70_REG_STATUS) | 0x10) & 0x9F;
  writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_STATUS, tmp);
}


void flushTxFIFO() {
  writeRegPgmBuf((uint8_t *)RFM70_cmd_flush_tx, sizeof(RFM70_cmd_flush_tx)); // Flush TX FIFO
}

void flushRxFIFO() {
  writeRegPgmBuf((uint8_t *)RFM70_cmd_flush_rx, sizeof(RFM70_cmd_flush_rx)); // Flush RX FIFO
}



///////////////////////////////////////////////////////////////////////////////
// RFM70 getter //
///////////////////////////////////////////////////////////////////////////////

uint8_t getMode(void) {
  return readRegVal(RFM70_REG_CONFIG) & RFM70_PIN_PRIM_RX;
}

uint8_t getCarrierDetect(void)
{
  return readRegVal(RFM70_REG_CD);
}

void setChannel(uint8_t cnum)
{
  writeRegVal( RFM70_CMD_WRITE_REG | RFM70_REG_RF_CH, cnum);
}

uint8_t getChannel(void) {
  return readRegVal(RFM70_REG_RF_CH);
}

uint8_t getPLC(void) {
  return readRegVal(RFM70_REG_OBSERVE_TX) >> 4 & 0x0F;
}

uint8_t getARC(void){
  return readRegVal(RFM70_REG_OBSERVE_TX) & 0x0F;
}

uint8_t rxDataReceived() {
  uint8_t status = readRegVal(RFM70_REG_STATUS);
  if(status & RFM70_IRQ_STATUS_RX_DR) {
        return ((status & 0x0E) >> 1) + 1;
  }
  return 0;
}

uint8_t txDataSent() {
  return readRegVal(RFM70_REG_STATUS) & RFM70_IRQ_STATUS_TX_DS;
}

uint8_t txTimeout() {
  return readRegVal(RFM70_REG_STATUS) & RFM70_IRQ_STATUS_MAX_RT;
}

uint8_t txFIFOFull() {
  return readRegVal(RFM70_REG_FIFO_STATUS) & RFM70_FIFO_STATUS_TX_FULL;
}

uint8_t txFIFOEmpty() {
  return readRegVal(RFM70_REG_FIFO_STATUS) & RFM70_FIFO_STATUS_TX_EMPTY;
}

uint8_t rxFIFOFull() {
  return readRegVal(RFM70_REG_FIFO_STATUS) & RFM70_FIFO_STATUS_RX_FULL;
}

uint8_t rxFIFOEmpty() {
  return readRegVal(RFM70_REG_FIFO_STATUS) & RFM70_FIFO_STATUS_RX_EMPTY;
}



///////////////////////////////////////////////////////////////////////////////
// RFM70 Communication //
///////////////////////////////////////////////////////////////////////////////


uint8_t readRegVal(uint8_t cmd) {
  uint8_t res;
  setPinState(CSN, LOW);
  delayMs(RFM70_CS_DELAY);
  transmitSPI(cmd);
  res=transmitSPI(0);
  setPinState(CSN, HIGH);
  delayMs(RFM70_CS_DELAY);
  return res;
}


void readRegBuf(uint8_t reg, uint8_t * buf, uint8_t len) {
  uint8_t status, byte_ctr;
  setPinState(CSN, LOW);
  delayMs(RFM70_CS_DELAY);
  status = transmitSPI(reg); // Select register to write, and read status UINT8
  for(byte_ctr = 0; byte_ctr < len; byte_ctr++)
    buf[byte_ctr] = transmitSPI(0); // Perform SPI_RW to read UINT8 from RFM70
  setPinState(CSN, HIGH);
  delayMs(RFM70_CS_DELAY);
}


void writeRegVal(uint8_t cmd, uint8_t val) {
  setPinState(CSN, LOW);
  delayMs(RFM70_CS_DELAY);
  transmitSPI(cmd);
  transmitSPI(val);
  setPinState(CSN, HIGH);
  delayMs(RFM70_CS_DELAY);
}


void writeRegPgmBuf(uint8_t * cmdbuf, uint8_t len) {
  setPinState(CSN, LOW);
  delayMs(RFM70_CS_DELAY);
  while(len--) {
    transmitSPI(*(cmdbuf++));
  }
  setPinState(CSN, HIGH);
  delayMs(RFM70_CS_DELAY);
}


void writeRegCmdBuf(uint8_t cmd, uint8_t * buf, uint8_t len) {
  setPinState(CSN, LOW);
  delayMs(RFM70_CS_DELAY);
  transmitSPI(cmd);
  while(len--) {
    transmitSPI(*(buf++));
  }
  setPinState(CSN, HIGH);
  delayMs(RFM70_CS_DELAY);
}




uint8_t sendAckPayload(uint8_t * payload, uint8_t len) {
  return sendPayload3(payload, len, -1);
}


uint8_t sendPayload2(uint8_t * payload, uint8_t len) {
  return sendPayload3(payload, len, NO_ACK);
}


uint8_t sendPayload3(uint8_t * payload, uint8_t len, uint8_t toAck)
{
  // check TX_FIFO
  uint8_t status;
  status = readRegVal(RFM70_REG_FIFO_STATUS);
  if (status & RFM70_FIFO_STATUS_TX_FULL) {
    debug(RFM70_DEBUG_FIFO_FULL);
    return 0;
  }
  // send payload
  setPinState(CSN, LOW);
  delayMs(RFM70_CS_DELAY);
  if(toAck == -1)
    transmitSPI(RFM70_CMD_W_ACK_PAYLOAD);
  else if (toAck == 0)
    transmitSPI(RFM70_CMD_W_TX_PAYLOAD_NOACK);
  else
    transmitSPI(RFM70_CMD_WR_TX_PLOAD);
  while(len--) {
    transmitSPI(*(payload++));
  }
  setPinState(CSN, HIGH);
  delayMs(RFM70_CS_DELAY);

  return 1;
}


uint8_t receivePayload(uint8_t *payload)
{
  uint8_t len;
  // check RX_FIFO
  uint8_t status;
  status = readRegVal(RFM70_REG_STATUS);
  if (status & RFM70_IRQ_STATUS_RX_DR) { // RX_DR
    //while(1) {
      uint8_t fifo_sta;
      len = readRegVal(RFM70_CMD_RX_PL_WID); // Payload width
      readRegBuf(RFM70_CMD_RD_RX_PLOAD, payload, len);
      fifo_sta = readRegVal(RFM70_REG_FIFO_STATUS);
      //if (fifo_sta & RFM70_FIFO_STATUS_RX_EMPTY) break; // read until RX_FIFO empty
    //}
        if (fifo_sta & RFM70_FIFO_STATUS_RX_EMPTY) {
        status|= 0x40 & 0xCF; // clear status bit rx_dr
    writeRegVal(RFM70_CMD_WRITE_REG | RFM70_REG_STATUS, status);
        }
    return len;
  }
  else
    return 0;
}




///////////////////////////////////////////////////////////////////////////////
// RFM70 debug //
///////////////////////////////////////////////////////////////////////////////


void debug(uint8_t token) {
	int i;
	switch(token){
	case RFM70_DEBUG_WRONG_CHIP_ID:
		DBG(("Wrong chip ID !"));
		return;
	case RFM70_DEBUG_FIFO_FULL:
		DBG(("FIFO full !"));
		return;
	case RFM70_SHOW_REGISTERS:
		selectBank(0);
		for(i=0; i<10; i++)
		{
			DBG(("%x", i));
			DBG(("= "));
			DBG(("%x", readRegVal(i)));
			DBG((", "));
		}
		selectBank(1);
		DBG(("\n\r"));
		for(i=0; i<10; i++)
		{
			DBG(("%x", i));
			DBG(("= "));
			DBG(("%x", readRegVal(i)));
			DBG((", "));
		}
		selectBank(0);
		DBG(("\n\r"));
		DBG(("17"));
		DBG(("= "));
		DBG(("%x", readRegVal(0x17)));
		DBG((", carrier: "));
		DBG(("%d", getCarrierDetect()));
		DBG(("\n\r"));
		return;
	}
}



///////////////////////////////////////////////////////////////////////////////
// RFM70 potential inline funcs
///////////////////////////////////////////////////////////////////////////////


uint8_t transmitSPI(uint8_t val) {
  uint8_t ret;
  while((SPI2->SR & 0x0002) == 0){}
  SPI2->DR = val;
  delayMs(1);
  while((SPI2->SR & 0x0001) == 0){}
  ret = SPI2->DR;
  delayMs(1);
  return ret;
}

void setPinState(uint32_t pin, uint8_t state) {
	if(state == LOW){
		GPIO_ResetBits(GPIOB, pin);
	}else{
		GPIO_SetBits(GPIOB, pin);
	}
}

void delayMs(vu32 ms) {
  if (ms) delay_ms(ms);
}


