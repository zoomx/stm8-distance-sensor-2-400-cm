#ifndef _DS3231M_RTC_H
#define _DS3231M_RTC_H

void DS3231M_Flush(u8);
u8 DS3231M_ReadByteAdr(u8);
u8 DS3231M_ReadByte(void);
void DS3231_ReadBytes(u8, u8*, u8);
void DS3231M_WriteByte(u8, u8);
u8 DS3231M_WriteBytes(u8, u8*, u8);

#endif