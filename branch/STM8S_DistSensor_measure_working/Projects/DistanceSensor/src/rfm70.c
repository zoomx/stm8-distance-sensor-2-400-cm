//**************************************************************************
//
//! \mainpage rfm70
//!
//! C interface library for the HopeRF RFM70 4.3 GHz transceiver module
//!
//! \image html RFM70-D.jpg
//! \image rtf RFM70-D.jpg
//!
//! \author 
//!    Wouter van Ooijen (wouter@voti.nl)
//!
//! \version
//!    V1.02 (2011-12-31)
//!
//! \par Introduction
//!
//! The RFM70 module from HopeRF (www.hoperf.com) is a small and cheap
//! transceiver (transmitter + receiver) module for the license-free
//! 4.3 MHz frequency band. This module is intended for short range
//! communication, for instance within a room. 
//! Typical applications are wires mouses and keybords, 
//! and garage door openers.
//! In open air a distance of 
//! 50 .. 100 m is possible, but this is strictly line-of-sight: even 
//! the leaves of a single tree can obstruct the signal.
//!
//! The two main files in this libary, rfm70.h and rfm70.c,
//! are target independent. 
//! However, rfm70.c included by a file that must be provided
//! by the user. 
//! This file must provide macro's for initializing and accessing the
//! I/O pins that connect to the RFM70 module, and for
//! delays of a specified number of milliseconds and microseconds.
//! A template for this file is provided.
//!
//! \par Files
//! - rfm70.h
//! - rfm70.c
//! - rfm70-config.h
//!
//!
//! \par License
//!
//! The files in this library are licensed under the zlib license, 
//! which rougly says: when you redistribute the *source* you must 
//! keep the copyright notice intact. Otherwise you can use these files
//! any way you like, including getting rich from selling applications.
//! But don't complain to me when it does not work (OTOH, contructive
//! comments are appreciated!).
//!
//! \par ToDo: bugs, notes, pitfalls, todo, known problems, etc
//!
//! - pictures for power
//! - document (other) files
//! - PIC18F examples, Cortex C examples, Arduino
//! - write 5 bytes when address <5 bytes?
//! - check and improve rtf documentation
//! - check CE cycling requirements
//! - descriptions for the other files
//! - add write ack payload for pipe N
//! - add 'report package has been sent'
//! - application: thermometer
//! - application: test signal strength
//! - application: asynch serial through the air
//!
//
//***************************************************************************//

//***************************************************************************//
//
// COPYRIGHT NOTICE (zlib license)
//
// Loosely based on the example application provided by HopeRF
//
// (c) Wouter van Ooijen - wouter@voti.nl
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source distribution.
//
//***************************************************************************//

//***************************************************************************//
//
//! \page revision information
//!
//! \par ToDo: bugs, notes, pitfalls, todo, known problems, etc
//!
//! - pictures for power
//! - document (other) files
//! - PIC18F examples, Cortex C examples, Arduino
//! - write 5 bytes when address <5 bytes?
//! - check and improve rtf documentation
//! - check CE cycling requirements
//! - descriptions for the other files
//! - add write ack payload for pipe N
//! - add 'report package has been sent'
//! - application: thermometer
//! - application: test signal strength
//! - application: asynch serial through the air
//! 
//! \par release notes
//!
//! V1.02 (2011-12-31)
//! Arduino added
//!
//! V1.01 (2011-12-26)
//! some minor documentation and webpage changes, no code changes
//!
//! V1.00 (2011-12-24)
//! first release
//! 
//
//***************************************************************************//

//***************************************************************************//
//
//! \page overview RFM70 overview
//!
//! \image html smd-pins.jpg
//! \image rtf smd-pins.jpg
//!
//! The RFM70 is a small module (PCB with some components, ~ 18 x 26 mm) 
//! that implements a transciever for the license-free 4.3 GHz band. 
//! The module contains a small antenna on the PCB, 
//! there is no provision for an external antenna.
//! Two versions of the module exist, one with 
//! pins and one without. The pins are on a 1.28 mm grid, which is twice the
//! density of a standard DIL package. The module requires 1.9 .. 3.6 Volt
//! for its power, 3.3 Volt seems to be the preferred operating voltage. 
//! It is NOT designed to run at 5.0 Volt. 
//! According to the datasheet that maximum 'typical' operating current 
//! is 23 mA.
//!
//! Note that 'licence free' means that certain well-described use of this 
//! frequency band is allowd without a license. 
//! The RFM70 is designed to be compatible with the requirements for such 
//! use, but it is the responsibility of anyone who sells a product that
//! to make sure that it complies with such rules.
//!
//! The main component of an RFM70 module is the RF70 chip (hidden beneath
//! the black blob). The manufacturer provides separate datasheets for both 
//! the RF70 chip and the RFM70 module. 
//! The two datasheets seem to be the same, except for the physical 
//! and pinout information which is of course different for the chip
//! and the module, so you can probably ignore the RF70 chip datasheet.
//! The RFM70 module datasheet can currently be found at 
//! http://www.hoperf.com/upload/rf/RFM70.pdf
//!
//! The RFM70 module is intended for short-range communication,
//! like wireless computer peripherals (mouse, keyboard, tablet, ect.)
//! keyfobs (car opener, garage door opener, motorized fence opener - 
//! some cryptografy will probably be required for such applications)
//! and toys. In a line of sight situation a maximum range of 50 .. 100 m
//! is possible. Indoors communication within a single room will generally
//! be OK (unless you have a very large room..) but passing even a single
//! wall can be a problem.
//!
//! An RFM70 module must be used with a microcontroller that initializes
//! and operates the module. By itself the module can not be used as a
//! 'wireless wire', although such a mode could be implemented in the
//! microcontroller. The interface between the RFM70 and the microcontroller
//! is a standard 4-PIN SPI interface (MISO, MOSI, CLCK, CSN) plus a CE
//! (Chip Enable) pin. The module also provides an IRQ pin that could be used
//! to speed up the detection of certain events within the module. 
//! The library does not used this pin. 
//! The SPI input pins are 5V-tolerant, so provided that
//! the high level as output by the module is accpetable to the 
//! microcontroller no glue circuitry is needed to interface to a 
//! microcontroller that runs from 5 Volt. (Except for course for a 
//! regulator that provides the 3.3 Volt to power the RFM70.)
//!
//! An RFM70 module operates in the 4.3 GHz band. 
//! Within that band a frequency can be selected in 1 MHz steps. 
//! RFM70 modules can communicate only when they use the same frequency.
//!
//! The RFM70 module operates on a packet basis. 
//! Each packet has a destination address.
//! By default the address is a 5 byte value, but a 4 or 3 byte
//! address can also be configured. 
//! For succesfull communication the RFM70 modules that are involved must
//! be configured for the same address length, and the receiving
//! module(s) must have one of their so-called pipes configured
//! for the address used by the transmitter.
//!
//! An RFM70 contains 6 so-called data pipes that can receive packages.
//! Each pipe has an address, and will receive only messages
//! for that address.
//! Pipes 0 and 1 have a full (up to 5 bytes) address. 
//! For pipes 2 .. 6 only the least significant byte can be
//! configured, the other bytes are copied from the address of pipe 1.
//! The length of the address (3, 4 or 5 bytes) is the same for 
//! transmission and for all 6 receive data pipes.
//!
//! A packet contains 1 .. 32 user data bytes. 
//! The packet length can either be fixed or flexible.
//! When the packet length is fixed each receiving pipe is configured
//! with its packet length. The length of a package that is sent is 
//! determined by the number of bytes written into the transmit buffer,
//! and it it must match the length configured for the receiving pipe.
//! When the packet length is flexible the length of a package is again
//! determined by the number of bytes written into the transmit, but in
//! this case this number is transmitted in the message, and on the
//! receiving side it can be retrieved by the R_RX_PL_WID command
//! (rfm70_channel_payload_size function).
//!
//! The simple way to send a package is without acknowledgement.
//! The RFM70 just transmits the package and considers it done.
//! It can be received by zero, one, or multiple RFM70 modules, but
//! the sending modules does not care and has no way of knowing.
//! For this simple mode of communication the involved RFM70's
//! - must be configured for the same channel frequency
//! - must use the same address length
//! - the receiving RFM70 must have a receive pipe configured
//!   for the same address as used by the transmitting RFM70
//!
//! Alternatively a package can be sent with acknowledgement and
//! (if necessary) retransmission. 
//! In this case the RFM70 will send the message, and consider it
//! done only when it receives an acknowledge for it.
//! If it does not receive an acknowledge within a fixed amount of
//! time it will re-transmit the package, up to a set maximum.
//! A receiving RFM70 can automatically send an acknowledgement
//! for a successfully received package. 
//! For this to work the same requirements as for simple unacknowledged
//! communicatiobn apply, and additionally on both RFM70's
//! - CRC must be enabled (length 1 or 2) on both modules
//! - receive data pipe 0 must be configured for the same address 
//!   as the module uses for transmitting
//!
//! The automatic retransmission provided by the RFM70 uses a fixed
//! retransmission timout, which is probly fine for correcting an 
//! occasional packet loss due to interference from other 4.3 GHz sources,
//! but it is potentially inefective when the interference is caused by
//! another RFM70 that uses the same timout! In such cases the 
//! microcontroller should implemnet its own retransmission scheme,
//! with for instance a random timeout, and maybe an exponential 
//! backoff.
//! 
//
//***************************************************************************//

//***************************************************************************//
//
//! \page hardware RFM70 hardware interface
//!
//! \image html smd-pins.jpg
//! \image rtf smd-pins.jpg
//!
//! The RFM70 uses a standard 4-wire SPI interface.
//! It also provides an active low interrupt pin, which could be used to
//! avoid polling. This library does not use the interrupt pin.
//! The RFM70 also has a CE (chip enable) input, which must be de-asserted
//! to put the chip in standby or power-down mode, and must be cycled
//! to switch between receive and transmit mode. Hence the interface
//! uses 5 data pins, plus ground and power (3.3V):
//! - GND : common ground
//! - VDD : 3.3V power
//! - CE : Chip Enable, active high, microcontoller output
//! - CSN : Chip Select Negative, active low, microcontoller output
//! - SCK : Serial ClocK, microcontoller output
//! - MOSI : Master Out Slave In, microcontoller output
//! - MISO : Master In Slave Out, microcontoller input
//! - IRQ : Interrupt ReQuest, not used
//!
//! When the microcontroller operates at 3.3 Volt (or lower, 
//! the RFM70 datasheet claims operation down to 1.9 Volt) all lines, 
//! including power,  
//! can be connected directly to the microcontroller. 
//! If you are experimenting and want to protect yourself against
//! problems when you accidentally configure the pin connected to MISO
//! as output, you could insert a suitable series resistor in this line.
//! 2k2 seems to be a good choice.
//!
//! When the microcontroller operates at 5 Volt there are three possible issues:
//! - power : the RFM70 operates at 1.9 .. 3.3 Volt, so the 5 Volt must somehow
//!   be reduced to a voltage within this range
//! - data from the microcontroller to the RFM70 : no problem here, the
//!   RFM70 inputs are 5 Volt tolerant. 
//!   As explained, a series resistor in the MISO line might be a good idea.
//! - data from RFM70 to the microcontroller : in most cases this will not 
//!   be a problem, but you might want to check the minimum voltage required
//!   by your microcontroller to reliably detect a logic 1. For instance a 
//!   PIC requires ~ 2.0 Volt on a TTL level input, but 0.8 * VDD on a
//!   Schmitt Trigger input! And you must consider this at the maximum VDD 
//!   for the microcontroller, which can be 5.5 Volt when delivered by 
//!   an 7805 or an USB port.
//!
//! There are various ways to create a 3.3 Volt supply for the RFM70 from a
//! 5 Volt supply. I prefer to use a low-drop low-quiecent
//! current 3.3 Volt linear regulator. Read the datasheet of the regulator
//! carefully: some put very stringent requirements on the value and impedance
//! of the decoupling capacitors. My favourite is the Microchip MCP1702, 
//! which has a low quiecent current (5 uA maximum), and is stable with 
//! only 1 uF input an output capacitors of any type 
//! (ceramic, tantalum, aluminium electrolytic).
//!
//! TBW: picture
//!
//! A crude way to create the power for the RFM70 is to use a 
//! resistor divider. I would do this only in an experimental
//! setup on my desk, never in a final product.
//! The source impedance of the divider causes a drop in the 
//! voltage when the RFM70 uses more current.
//! This drop can be reduced by lowering the resistor values, but at
//! the cost of a higher current through the resistors. The RFM70
//! can operate down to 1.9 Volt, but at that level the microcontroller 
//! might not reliably recognise a logic 1 from the RFM70. Another issue
//! is the dissipation in the resistors. The circuit below is a compromise.
//! It uses three equal-valued resistors because I don't stock many
//! different resistor values.
//! The idle current through the resistors is 83 mA at 5.5 Volt, in
//! this situation the RFM70 gets 3.7 Volt. That is slightly high, but
//! probably not a big problem.
//! When the RFM70 draws its maximum current of 23 mA when the 
//! microcontroller's power is at 4.5 Volt the RFM70 still gets 2.6 Volt. 
//! You might want to double-check that the microcontroller accepts ~ 2 Volt
//! as a logic 1. 
//!
//! TBW: picture
//! 
//
//***************************************************************************//

#include "board.h"
#include "delay.h"

#define RFM70_SCK_1    BOARD_SCK_1  
#define RFM70_SCK_0    BOARD_SCK_0  
#define RFM70_MOSI_1   BOARD_MOSI_1 
#define RFM70_MOSI_0   BOARD_MOSI_0 
#define RFM70_MISO     BOARD_MISO                            
#define RFM70_CSN_1    BOARD_CSN_1
#define RFM70_CSN_0    BOARD_CSN_0 
#define RFM70_CE_1     BOARD_CE_1
#define RFM70_CE_0     BOARD_CE_0 

//#define WAIT_50MS { \
//  while(DELAY_50MS_FLAG == FALSE);  \
//  DELAY_50MS_FLAG = FALSE;          \
//}

//#define WAIT_1US { /* @ 16MHz clock */
//  _asm("NOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\nNOP\n") 
//}

// RFM70 SPI read and write commands
#define RFM70_CMD_READ_REG            0x00
#define RFM70_CMD_WRITE_REG           0x20

//interrupt status
#define STATUS_RX_DR    0x40
#define STATUS_TX_DS    0x20
#define STATUS_MAX_RT   0x10

#define STATUS_TX_FULL  0x01

//FIFO_STATUS
#define FIFO_STATUS_TX_REUSE  0x40
#define FIFO_STATUS_TX_FULL   0x20
#define FIFO_STATUS_TX_EMPTY  0x10

#define FIFO_STATUS_RX_FULL   0x02
#define FIFO_STATUS_RX_EMPTY  0x01

//! version of this rfm70 library
//
//! \ingroup highlevel
#define RFM70_LIB_VERSION "V1.02 (2011-12-31)"

//! maximum number of data bytes in a (received or transmitted) rfm70 packet
//
//! \ingroup highlevel
#define RFM70_MAX_PACKET_LEN  32

//! type of rfm70 (transmit or receive) buffer
//
//! \ingroup highlevel
typedef u8 rfm70_buffer [ RFM70_MAX_PACKET_LEN ];


//***************************************************************************//
//
// RFM70 SPI commands
//
//***************************************************************************//

//! \addtogroup lowlevel
//! @{

//! SPI comamnd to read a received payload
#define RFM70_CMD_R_RX_PAYLOAD         0x61

//! SPI command to write a payload to be sent
#define RFM70_CMD_W_TX_PAYLOAD         0xA0

//! SPI command to empty the transmit queue
#define RFM70_CMD_FLUSH_TX             0xE1

//! SPI command to empty the receive queue
#define RFM70_CMD_FLUSH_RX             0xE2

//! SPI command to start continuous retransmission
#define RFM70_CMD_REUSE_TX_PL          0xE3

//! SPI command to write a payload to be sent without auto-acknowledgement
#define RFM70_CMD_W_TX_PAYLOAD_NOACK   0xB0

//! SPI command to write the payload to be transmitted with an ack
#define RFM70_CMD_W_ACK_PAYLOAD        0xA8

//! SPI command to toggle register bank or toggle extended functions
#define RFM70_CMD_ACTIVATE             0x50

//! SPI command to read the payload length for the top payload in the FIFO
#define RFM70_CMD_R_RX_PL_WID          0x60

//! SPI 'no peration', can be used to read the status register
#define RFM70_CMD_NOP                  0xFF

//***************************************************************************//
//
// RFM70 register addresses
//
//***************************************************************************//

//! CONFIG : rfm70 configuration register
//
//! Bits (0 = LSB):
//! - 7 : reserved, must be 0
//! - 6 : 1 masks RX_DR (see...) from IRQ pin, 0 allows
//! - 5 : 1 masks RX_DS (see...) from IRQ pin, 0 allows
//! - 4 : 1 masks MAX_RT (see...) from IRQ pin, 0 allows
//! - 3 : 1 enables CRC (forced high when EN_AA != 0)
//! - 2 : 0 = 1 byte CRC, 1 = 2 byte CRC
//! - 1 : 0 = power down, 1 = power up
//! - 0 : 0 = transmit mode, 1 = receive mode
#define RFM70_REG_CONFIG               0x00

//! EN_AA : enable auto ack on pipes
//
//! Bits (0 = LSB):
//! - 7, 6 : reserved, must be 00
//! - 5 : 0 disables auto ack on pipe 5, 1 enables
//! - 4 : 0 disables auto ack on pipe 4, 1 enables
//! - 3 : 0 disables auto ack on pipe 3, 1 enables
//! - 2 : 0 disables auto ack on pipe 2, 1 enables
//! - 1 : 0 disables auto ack on pipe 1, 1 enables
//! - 0 : 0 disables auto ack on pipe 0, 1 enables
#define RFM70_REG_EN_AA                0x01

//! EN_RXADDR : enable receive pipes
//
//! Bits (0 = LSB):
//! - 7, 6 : reserved, must be 00
//! - 5 : 0 disables receive pipe 5, 1 enables
//! - 4 : 0 disables receive pipe 4, 1 enables
//! - 3 : 0 disables receive pipe 3, 1 enables
//! - 2 : 0 disables receive pipe 2, 1 enables
//! - 1 : 0 disables receive pipe 1, 1 enables
//! - 0 : 0 disables receive pipe 0, 1 enables
#define RFM70_REG_EN_RXADDR            0x02

//! SETUP_AW : set address length
//
//! Bits (0 = LSB):
//! - 7 .. 2 : reserved, must be 000000
//! - 1 .. 0 : 00 = illegal, 01 = 3 bytes, 10 = 4 bytes, 11 = 5 bytes
#define RFM70_REG_SETUP_AW             0x03

//! SETUP_RETR : retransmission settings
//
//! Bits (0 = LSB):
//! - 7 .. 4 : delay between (re) transmissions, ( n + 1 ) * 250 us
//! - 3 .. 0 : max number of retransmissions, 0 disableles retransmissions
#define RFM70_REG_SETUP_RETR           0x04

//! RF_CH : RF channel (frequency)
//
//! The RF channel frequency is 2.4 MHz + n * 1 MHz.
#define RFM70_REG_RF_CH                0x05

//! RF_SETUP : RF setup: data rate, transmit power, LNA
//
//! Bits (0 = LSB):
//! - 7 .. 4 : reserved, must be 0011
//! - 3 : air data rate, 0 = 1 Mbps, 1 = 2 Mbps
//! - 2 .. 1 : transmit power, 00 = -10 dBm, 01 = -5 dBm, 10 = 0 dBm, 11 = 5 dBm
//! - 0 : LNA gain, 0 = - 20 dB (low gain), 1 = standard
#define RFM70_REG_RF_SETUP             0x06

//! STATUS : status register
//
//! The value of this register is also clocked out
//! while a SPI command is clocked in.
//!
//! Bits (0 = LSB):
//! - 7 : active register bank, 0 = bank 0, 1 = bank 1
//! - 6 : data available, 0 = RX FIFO not empty, 1 = RX FIFO empty
//! - 5 : data sent, 0 = no packet sent, 1 = packet has been sent
//! - 4 : 1 = maximum number of retransmissions reached
//! - 3 .. 1 : data pipe of the message at the RX queue head
//! - 0 : TX FIFO full: 0 = TX FIFO not full, 1 = TX FIFO full
//!
//! Bits 6,5,4 are cleared by writing a 1 (!) in that position.
//! When bit 4 is set this will block any communication.
//! When auto retransmission is enabled bit 5 will be set only
//! after the acknowledge has been received.
#define RFM70_REG_STATUS               0x07

//! OBSERVE_TX : lost and retransmitted packets
//
//! Bits (0 = LSB):
//! - 7 .. 4 : counts number of lost packets
//! - 3 .. 0 : counts retranmits 
//! The lost packets counter will not increment beyond 15. 
//! It is reset by writing to the channel frequency register.
//!
//! The retransmits counter can not increment beyond 15 because
//! the maximum number of transmissions is 15. This counter
//! is reset when the transmission of a new packet starts.
#define RFM70_REG_OBSERVE_TX           0x08

//! CD : carrier detect
//
//! Bits (0 = LSB):
//! - 7 .. 1 : reserved
//! - 1 : carrier detect
#define RFM70_REG_CD                   0x09

//! RX_ADDR_PO : receive address for data pipe 0, 5 bytes
//
//! This is the (up to) 5 byte receive address for data pipe 0.
//! For auto acknowledgement to work this address must be 
//! the same as the transmit address.
#define RFM70_REG_RX_ADDR_P0           0x0A

//! RX_ADDR_P1 : receive address for data pipe 1, 5 bytes
//
//! This is the (up to) 5 byte receive address for data pipe 1.
//! The higher bytes (all but the LSB) are also used in
//! the receive addresses of data pipes 2 .. 5.
#define RFM70_REG_RX_ADDR_P1           0x0B

//! RX_ADDR_P2 : receive address for data pipe 2, 1 byte
//
//! This is the LSB of the receive address for data pipe 2.
//! The higher bytes are copied from the receive address of
//! data pipe 1.
#define RFM70_REG_RX_ADDR_P2           0x0C

//! RX_ADDR_P3 : receive address for data pipe 3, 1 byte
//
//! This is the LSB of the receive address for data pipe 3.
//! The higher bytes are copied from the receive address of
//! data pipe 1.
#define RFM70_REG_RX_ADDR_P3           0x0D

//! RX_ADDR_P4 : receive address for data pipe 4, 1 byte
//
//! This is the LSB of the receive address for data pipe 4.
//! The higher bytes are copied from the receive address of
//! data pipe 1.
#define RFM70_REG_RX_ADDR_P4           0x0E

//! RX_ADDR_P5 : receive address for data pipe 5, 1 byte
//
//! This is the LSB of the receive address for data pipe 2.
//! The higher bytes are copied from the receive address of
//! data pipe 5.
#define RFM70_REG_RX_ADDR_P5           0x0F

//! TX_ADDR : tranmsit adress, 5 bytes
//
//! This is the (up to) 5 byte adress used in transmitted packets.
//! For auto acknowledgement to work this address must be 
//! the same as the pipe 0 receive address.
#define RFM70_REG_TX_ADDR              0x10

//! RX_PW_P0 : number of bytes in package received into pipe 0
//
//! This is the number of data bytes in the message at
//! the head of receive pipe 0.
#define RFM70_REG_RX_PW_P0             0x11

//! RX_PW_P1 : number of bytes in package received into pipe 1
//
//! This is the number of data bytes in the message at
//! the head of receive pipe 1.
#define RFM70_REG_RX_PW_P1             0x12

//! RX_PW_P2 : number of bytes in package received into pipe 2
//
//! This is the number of data bytes in the message at
//! the head of receive pipe 2.
#define RFM70_REG_RX_PW_P2             0x13

//! RX_PW_P3 : number of bytes in package received into pipe 3
//
//! This is the number of data bytes in the message at
//! the head of receive pipe 3.
#define RFM70_REG_RX_PW_P3             0x14

//! RX_PW_P4 : number of bytes in package received into pipe 4
//
//! This is the number of data bytes in the message at
//! the head of receive pipe 4.
#define RFM70_REG_RX_PW_P4             0x15

//! RX_PW_P5 : number of bytes in package received into pipe 5
//
//! This is the number of data bytes in the message at
//! the head of receive pipe 5.
#define RFM70_REG_RX_PW_P5             0x16

//! FIFO_STATUS : receive and transmit FIFO status (readonly)
//
//! Bits (0 = LSB):
//! - 7   : reserved, only 0 allowed
//! - 6   : high = re-use last transmitted packet
//! - 5   : high = transmit FIFO is full
//! - 4   : high = transmit FIFO is empty
//! - 3:2 : reserved, only 0 allowed
//! - 1   : high = receive FIFO is full
//! - 0   : high = receive FIFO is empty
#define RFM70_REG_FIFO_STATUS          0x17

//! DYNPD: dynamic payload flags
//
//! Bits (0 = LSB):
//! - 7:6 : reserved, only 00 allowed
//! - 5   : high = dynamic payload enabled on data pipe 5
//! - 4   : high = dynamic payload enabled on data pipe 4
//! - 3   : high = dynamic payload enabled on data pipe 3
//! - 2   : high = dynamic payload enabled on data pipe 2
//! - 1   : high = dynamic payload enabled on data pipe 1
//! - 0   : high = dynamic payload enabled on data pipe 0
//! Setting dynamic payload on pipe x requires EN_DPL 
//! (in the special features flags register) and ENAA_Px.
#define RFM70_REG_DYNPD                0x1C

//! FEATURE: special fature flags
//
//! Bits (0 = LSB):
//! - 7:3 : reserved, only 00000 allowed
//! - 2   : (EN_DPL) high = enable dynamic payload length
//! - 1   : (EN_ACK_PAY) high = enable payload with ack
//! - 0   : (EN_DYN_ACK) high = enables W_TX_PAYLOAD_NOACK command 
#define RFM70_REG_FEATURE              0x1D

// Bank0 register initialization values
#define BANK0_ENTRIES 10
const u8 Bank0_Reg[ BANK0_ENTRIES ][ 2 ] = {
   {  0, 0x0F }, /* receive, enabled, CRC 2, enable interupts*/
   {  1, 0x3F }, /* auto-ack on all pipes enabled*/
   {  2, 0x03 }, /* Enable pipes 0 and 1*/
   {  3, 0x03 }, /* 5 bytes addresses*/
   {  4, 0xff }, /* auto retransmission delay 4000 ms, 15 times*/
   {  5, 0x0A }, /* channel 10*/
   {  6 ,0x37 }, /* data rate 1Mbit, power 5dbm, LNA gain high*/
   {  7, 0x07 }, /* why write this at all?? but seems required to work...*/
   {  8, 0x00 }, /* clear Tx packet counters*/
   { 23, 0x00 } /* fifo status*/ 
};

   // default receive address data pipe 0:
   // just a bunch of bytes, nothing magical
const u8 RX0_Address[] = { 0x34, 0x43, 0x10, 0x10, 0x01 };
// magic bank1 register initialization values
const u32 Bank1_Reg0_13[] = { 
   0xE2014B40,
   0x00004BC0,
   0x028CFCD0,
   0x41390099,
   0x0B869Ef9,
   0xA67F0624,
   0x00000000,
   0x00000000,
   0x00000000,
   0x00000000,
   0x00000000,
   0x00000000,
   0x00127300,
   0x36B48000 };   
   
   // more magic bank1 register initialization values
const u8 Bank1_Reg14[] = {0x41, 0x20, 0x08, 0x04, 0x81, 0x20, 0xCF, 0xF7, 0xFE, 0xFF, 0xFF };

u8 rfm70_receive_next_pipe(void);
u8 rfm70_receive_next_length(void);
void rfm70_init_bank1(void);
void rfm70_mode_receive(void);

u8 rfm70_SPI_RW( u8 value )
{
   u8 i;
   for( i =0 ; i < 8; i++ )
   {
      //RFM70_WAIT_US( 1 );
      //WAIT_1US;
	  delay_10us(1);
      if(value & 0x80)
        RFM70_MOSI_1;
      else
        RFM70_MOSI_0;
      //RFM70_MOSI( value & 0x80  );      
      value = (value << 1);    // shift next bit into MSB..
      
      //RFM70_WAIT_US( 1 );
      //WAIT_1US;
	  delay_10us(1);
      RFM70_SCK_1;          
      value |= RFM70_MISO;     // capture current MISO bit
      
      //RFM70_WAIT_US( 1 );
      //WAIT_1US;
	  delay_10us(1);
      RFM70_SCK_0;
      //RFM70_WAIT_US( 1 );
      //WAIT_1US;
	  delay_10us(1);
  }
  return value;
}

void rfm70_register_write( u8 reg, u8 value )
{
   if( reg < RFM70_CMD_WRITE_REG )
   {
      reg |= RFM70_CMD_WRITE_REG;      
   }  
   RFM70_CSN_0;                // CSN low, init SPI transaction
   (void)rfm70_SPI_RW( reg );    // select register
   (void)rfm70_SPI_RW( value );  // ..and write value to it..
   RFM70_CSN_1;                // CSN high again
}

u8 rfm70_register_read( u8 reg )
{
   u8 value;
   if( reg < RFM70_CMD_WRITE_REG )
   {
      reg |= RFM70_CMD_READ_REG;       
   }  
   RFM70_CSN_0;               // CSN low, initialize SPI communication...
   (void)rfm70_SPI_RW( reg );   // Select register to read from..
   value = rfm70_SPI_RW( 0 );   // ..then read register value
   RFM70_CSN_1;               // CSN high, terminate SPI communication
   return value;                 // return register value
}

void rfm70_buffer_read(u8 reg, u8 *pBuf, u8 length)
{
   u8 i;
   if( reg < RFM70_CMD_WRITE_REG )
   {
      reg |= RFM70_CMD_READ_REG;       
   }  
   RFM70_CSN_0;                   // Set CSN 0
   (void)rfm70_SPI_RW( reg );       // Select register to write
   for( i = 0; i < length; i++ )
   {    // read all bytes
      *pBuf++ = rfm70_SPI_RW( 0 );  // read one byte from RFM70
   }
   RFM70_CSN_1;                   // Set CSN high again
}

void rfm70_buffer_write(s8 reg, const u8 *pBuf, u8 length)
{
   u8 i;
   if( reg < RFM70_CMD_WRITE_REG )
   {
      reg |= RFM70_CMD_WRITE_REG;      
   }  
   RFM70_CSN_0;                     // Set CSN low, init SPI tranaction
   (void)rfm70_SPI_RW( reg );         // Select register to write tio write
   for( i = 0; i < length; i++ )
   {      // write all bytes in buffer(*pBuf)
      (void)rfm70_SPI_RW( *pBuf++ );  // write one byte
   }   
   RFM70_CSN_1;                     // Set CSN high again
}

void rfm70_bank( u8 b )
{
   u8 st = 0x80 & rfm70_register_read( RFM70_REG_STATUS );
   if(( st &&( b == 0 )) || (( st == 0 ) && b ))
   {
      rfm70_register_write( RFM70_CMD_ACTIVATE, 0x53 );
   }
}
   
   // initialize bank1 like in the example code.
   // don't ask why, just do it
void rfm70_init_bank1()
{
   u8 i, j;
   u8 WriteArr[ 12 ];
        
   rfm70_bank( 1 );
   
   for( i = 0; i <= 8; i++ )
   { //reverse!
      for( j = 0; j < 4; j++ )
      {
         WriteArr[ j ]=( Bank1_Reg0_13[ i ]>>(8*(j) ) )&0xff;
      }  
      rfm70_buffer_write( i,WriteArr, 4 );
   }

   for( i = 9; i <= 13; i++ )
   {
      for( j = 0; j < 4; j++ )
      {
         WriteArr[ j ]=( Bank1_Reg0_13[ i ]>>(8*(3-j) ) )&0xff;
      }
      rfm70_buffer_write( i, WriteArr, 4 );
   }

   rfm70_buffer_write( 14, Bank1_Reg14, 11 );

   //toggle REG4<25,26>
   for(j=0;j<4;j++)
   {
      WriteArr[ j ]=( Bank1_Reg0_13[ 4 ]>>(8*(j) ) )&0xff;
   } 

   WriteArr[ 0 ] = WriteArr[ 0 ] | 0x06;
   rfm70_buffer_write( 4, WriteArr, 4);

   WriteArr[ 0 ] = WriteArr[ 0 ] & 0xf9;
   rfm70_buffer_write( 4, WriteArr,4);

   rfm70_bank( 0 );
}

u8 rfm70_is_present()
{
   u8 st1, st2; 
   st1 = rfm70_register_read( RFM70_REG_STATUS );
   rfm70_register_write( RFM70_CMD_ACTIVATE, 0x53 );
   st2 = rfm70_register_read( RFM70_REG_STATUS );
   rfm70_register_write( RFM70_CMD_ACTIVATE, 0x53 );
   return ( st1 ^ st2 ) == 0x80;
}

void rfm70_mode_receive()
{
   u8 value;
   
   // flush receive queue 
   rfm70_register_write( RFM70_CMD_FLUSH_RX, 0 );
   
   // clear interrupt status
   value = rfm70_register_read( RFM70_REG_STATUS );
   rfm70_register_write( RFM70_REG_STATUS ,value );
   
   // switch to receive mode
   RFM70_CE_0;
   value = rfm70_register_read( RFM70_REG_CONFIG );
   value |= 0x01; // set RX bit
   value |= 0x02; // set PWR_UP bit
   rfm70_register_write( RFM70_REG_CONFIG, value );
   RFM70_CE_1;
}

void rfm70_mode_transmit()
{
   u8 value;
   
   // flush transmit queue
   rfm70_register_write( RFM70_CMD_FLUSH_TX, 0);
   
   // clear interrupt status
   value = rfm70_register_read( RFM70_REG_STATUS );
   rfm70_register_write( RFM70_REG_STATUS ,value );
   
   // switch to transmit mode
   RFM70_CE_0;
   value = rfm70_register_read( RFM70_REG_CONFIG );
   value &= 0xFE; // clear RX bit
   value |= 0x02; // set PWR_UP bit
   rfm70_register_write( RFM70_REG_CONFIG, value );
   RFM70_CE_1;
}

void rfm70_mode_standby()
{
   u8 value;
   RFM70_CE_0;
   value = rfm70_register_read( RFM70_REG_CONFIG );
   value |= 0x02; // set PWR_UP bit
   rfm70_register_write( RFM70_REG_CONFIG, value );
}

void rfm70_mode_powerdown()
{
   u8 value;
   RFM70_CE_0;
   value = rfm70_register_read( RFM70_REG_CONFIG );
   value &= 0xFD; // clear PWR_UP bit
   rfm70_register_write( RFM70_REG_CONFIG, value );
}

void rfm70_channel( u8 ch )
{
  // MSB must be 0
  rfm70_register_write( RFM70_REG_RF_CH, ch & 0x7E );
}

void rfm70_air_data_rate( u8 rate )
{
   u8 value; 
   RFM70_CE_0;
   value = rfm70_register_read( RFM70_REG_RF_SETUP );
   value &= 0xF7;
   if( rate > 1 )
   {
      value |= 0x08;  
   }
   rfm70_register_write( RFM70_REG_RF_SETUP, value );
   RFM70_CE_1;
}

void rfm70_crc_length( u8 len )
{
   u8 val;
   if( len > 2 )
   {
      len = 2;
   }   
   val = rfm70_register_read( RFM70_REG_CONFIG );
   if( len == 0 )
   {
      val &= 0xF3;
      rfm70_register_write( RFM70_REG_EN_AA, 0 );
      rfm70_register_write( RFM70_REG_CONFIG, val );
   } 
   else 
   {
     rfm70_register_write( RFM70_REG_EN_AA, 0x3F );
     val &= 0xFB;
     if( val == 2 )
     {
       val |= 0x04; 
     }   
      rfm70_register_write( RFM70_REG_CONFIG, val );
   }  
}

void rfm70_address_length( u8 len )
{
   if( len > 5 )
   {
      len = 5;
   }
   if( len < 3 )
   {
      len = 3;    
   }
   rfm70_register_write( RFM70_REG_SETUP_AW, len - 2  );   
}

u8 rfm70_transmit_fifo_full()
{
  u8 s;
  s = rfm70_register_read( RFM70_REG_FIFO_STATUS );
  return ( s & FIFO_STATUS_TX_FULL ) != 0;
}
    
u8 rfm70_receive_fifo_empty()
{
  u8 s;
  s = rfm70_register_read( RFM70_REG_FIFO_STATUS );
  return ( s & FIFO_STATUS_RX_EMPTY ) != 0;
}

void rfm70_receive_address_p0( const u8 address[ 5 ] )
{
   rfm70_buffer_write( RFM70_REG_RX_ADDR_P0, address, 5 );  
}

void rfm70_receive_address_p1( const u8 address[ 5 ] )
{
   rfm70_buffer_write( RFM70_REG_RX_ADDR_P1, address, 5 );  
}

void rfm70_receive_address_pn( u8 channel, u8 address )
{
   rfm70_register_write( RFM70_REG_RX_ADDR_P0 + channel, address ); 
}

void rfm70_transmit_address( const u8 *address )
{
   rfm70_buffer_write( RFM70_REG_TX_ADDR, address, 5 );   
} 

u8 rfm70_retransmit_count()
{
   return rfm70_register_read( RFM70_REG_OBSERVE_TX ) & 0x0F;   
}

u8 rfm70_lost_packets_count()
{
   return ( rfm70_register_read( RFM70_REG_OBSERVE_TX ) >> 4 ) & 0x0F;   
}

void rfm70_pipe_autoack( u8 pipe, u8 enabled )
{
   u8 val = rfm70_register_read( RFM70_REG_EN_AA ); 
   if( pipe > 5 )
   { 
      pipe = 5; 
   }   
   if( enabled )
   {
      val |= 1 << pipe;
   } else {
      val &= ~ ( 1 << pipe );
   }
   rfm70_register_write( RFM70_REG_EN_AA, val ); 
}

void rfm70_pipe_enable( u8 pipe, u8 enabled )
{
   u8 val = rfm70_register_read( RFM70_REG_EN_RXADDR ); 
   if( pipe > 5 )
   { 
      pipe = 5; 
   }   
   if( enabled )
   {
      val |= 1 << pipe;
   } else 
   {
      val &= ~ ( 1 << pipe );
   }
   rfm70_register_write( RFM70_REG_EN_RXADDR, val ); 
}

void rfm70_lost_packets_reset()
{
   u8 val = rfm70_register_read( RFM70_REG_RF_CH );  
   rfm70_register_write( RFM70_REG_RF_CH, val );    
}

void rfm70_retransmit_delay_attempts( u8 d, u8 n )
{
   rfm70_register_write(RFM70_REG_SETUP_RETR, ( n & 0x0F ) | (( d & 0x0F ) << 4 ));
}

void rfm70_lna_high()
{
   u8 val = rfm70_register_read( RFM70_REG_RF_SETUP ); 
   val |= 0x01;
   rfm70_register_write( RFM70_REG_RF_SETUP, val ); 
}

void rfm70_lna_low()
{
   u8 val = rfm70_register_read( RFM70_REG_RF_SETUP ); 
   val &= 0xFE;
   rfm70_register_write( RFM70_REG_RF_SETUP, val ); 
}

void rfm70_power( u8 level )
{
   u8 val;
   if( level > 3 )
   { 
       level = 3; 
   }
   RFM70_CE_0;
   val = rfm70_register_read( RFM70_REG_RF_SETUP ); 
   val &= 0x09; 
   val |= 0x30;
   val |= ( level << 1 );
   rfm70_register_write( RFM70_REG_RF_SETUP, val ); 
   RFM70_CE_1;
}

void rfm70_channel_payload_size( u8 channel, u8 size )
{
   u8 val;
   if( size > 32 )
   {
      size = 32;
   }
   val = rfm70_register_read( RFM70_REG_DYNPD );  
   if( size == 0 )
   {
      val |= 1 << channel;
   } else 
   {
      val &= ~ ( 1 << channel );
   }    
   rfm70_register_write( RFM70_REG_DYNPD, val );
   rfm70_register_write( RFM70_REG_RX_PW_P0 + channel, size );  
}

void rfm70_transmit_message(const u8 *buf, u8 length)
{
   if( length > 32 )
   {
      length = 32;
   }
   rfm70_buffer_write( RFM70_CMD_W_TX_PAYLOAD, buf, length );
}
    
void rfm70_transmit_message_once(const u8 *buf, u8 length)
{
   if( length > 32 )
   {
      length = 32;
   }
   rfm70_buffer_write( RFM70_CMD_W_TX_PAYLOAD_NOACK, buf, length );
}

u8 rfm70_receive_next_pipe()
{
   u8 status = rfm70_register_read( RFM70_REG_STATUS ); 
   return ( status >> 1 ) & 0x07;
}

u8 rfm70_receive_next_length()
{
   return rfm70_register_read( RFM70_CMD_R_RX_PL_WID );
}

u8 rfm70_receive(u8 * pipe, u8 *buf, u8 * length)
{
   u8 p = rfm70_receive_next_pipe();
   if( p == 0x07 )
   {
      return 0;
   }   
   *pipe = p;
   *length = rfm70_receive_next_length();
   rfm70_buffer_read( RFM70_CMD_R_RX_PAYLOAD, buf, * length );
   return 1;
}
    
void rfm70_init()
{
   u8 i;

   RFM70_CE_0;
   RFM70_CSN_1;
   RFM70_SCK_0;
   RFM70_MOSI_0;

   // delay at least 50ms.
   // the example code says so, but why??
   //RFM70_WAIT_MS( 50 );
   //WAIT_50MS;
   delay_ms(50);

   // write array of default init settings
   rfm70_bank( 0 );
   for( i = 0; i < BANK0_ENTRIES; i++ )
   {
     rfm70_register_write( Bank0_Reg[ i ][0], Bank0_Reg[ i ][1] );
   }

   rfm70_receive_address_p0( RX0_Address );
   rfm70_receive_address_p1( RX0_Address );
   rfm70_transmit_address( RX0_Address );

   // enable the extra features
   i = rfm70_register_read(29);
   if( i == 0 )
   { // only when the extra features are not yet activated!
      rfm70_register_write( RFM70_CMD_ACTIVATE, 0x73 );
   }
   
   // select dynamic payload length data pipe5\4\3\2\1\0
   rfm70_register_write( 28, 0x3F ); 
   
   // select Dynamic Payload Length, Payload with ACK, W_TX_PAYLOAD_NOACK
   rfm70_register_write( 29, 0x07 );  
   
   // dynamic payload sizing on channels 0 and 1
   rfm70_channel_payload_size( 0, 0 );
   rfm70_channel_payload_size( 1, 0 );

   rfm70_init_bank1();
   //RFM70_WAIT_MS( 50 ); 
   //WAIT_50MS;
   delay_ms(50);
   rfm70_mode_receive();
}




