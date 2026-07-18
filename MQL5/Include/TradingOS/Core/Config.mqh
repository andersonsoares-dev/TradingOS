//+------------------------------------------------------------------+
//| TradingOS - Config.mqh                                           |
//+------------------------------------------------------------------+
#ifndef __CONFIG_MQH__
#define __CONFIG_MQH__

class CConfig
{
public:

   //==============================================================
   // Timer
   //==============================================================
   static int TimerInterval() { return 1; }

   //==============================================================
   // Médias Móveis
   //==============================================================
   static int EmaFast() { return 20; }
   static int EmaSlow() { return 50; }
   static int EmaLong() { return 200; }

   //==============================================================
   // Indicadores
   //==============================================================
   static int RsiPeriod() { return 14; }
   static int AtrPeriod() { return 14; }
   static int AdxPeriod() { return 14; }

   //==============================================================
   // Dashboard
   //==============================================================
   static bool ShowSpread() { return true; }
   static bool ShowTime()   { return true; }
   static bool ShowTrend()  { return true; }

   //==============================================================
   // Logs
   //==============================================================
   static bool EnableLogs() { return true; }
};

#endif // __CONFIG_MQH__