#ifndef _DS3231M_RTC_H
#define _DS3231M_RTC_H

extern u8 RTC_sec;
extern u8 RTC_min;
extern u8 RTC_hour;
extern u8 RTC_day;
extern u8 RTC_date;
extern u8 RTC_month;
extern u8 RTC_year;
extern s16 RTC_temp;

void DS3231M_Flush(u8);
u8 DS3231M_GetTime(void);
u8 DS3231M_GetDate(void);
u8 DS3231M_GetTemperature(void);
u8 DS3231M_SetTime(void);
u8 DS3231M_SetDate(void);
u8 DS3231M_EnableOsc(void);
u8 DS3231M_DisableOsc(void);
u8 DS3231M_EnableBBSQW(void);
u8 DS3231M_DisableBBSQW(void);
u8 DS3231M_ConvertTemp(void);
u8 DS3231M_SetINTCN(void);
u8 DS3231M_ResetINTCN(void);
u8 DS3231M_EnableAlarm1Intr(void);
u8 DS3231M_DisableAlarm1Intr(void);
u8 DS3231M_EnableAlarm2Intr(void);
u8 DS3231M_DisableAlarm2Intr(void);
u8 DS3231M_GetOscStopFlag(void);
u8 DS3231M_ResetOscStopFlag(void);
u8 DS3231M_Enable32KHzOut(void);
u8 DS3231M_Disable32KHzOut(void);
u8 DS3231M_ResetAlarm1(void);
u8 DS3231M_ResetAlarm2(void);
u8 DS3231M_GetBusyFlag(void);


#endif