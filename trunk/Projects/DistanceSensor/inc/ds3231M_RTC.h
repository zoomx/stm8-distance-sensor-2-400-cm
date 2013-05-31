#ifndef _DS3231M_RTC_H
#define _DS3231M_RTC_H

void DS3231M_Flush(void);
u8 DS3231M_ReadByte(void);
u8 DS3231M_ReadByteAdr(u8 _adr);
void DS3231M_WriteBye(u8 _adr, u8 _data);

#endif