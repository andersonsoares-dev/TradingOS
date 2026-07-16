//+------------------------------------------------------------------+
//| TradingOS - Config                                               |
//+------------------------------------------------------------------+
#ifndef __CONFIG_MQH__
#define __CONFIG_MQH__

class CConfig
{
public:

   static int TIMER_INTERVAL() { return 1; }

   static int EMA_FAST() { return 20; }
   static int EMA_SLOW() { return 50; }
   static int EMA_LONG() { return 200; }

   static int RSI_PERIOD() { return 14; }
   static int ATR_PERIOD() { return 14; }
   static int ADX_PERIOD() { return 14; }

   static bool SHOW_SPREAD() { return true; }
   static bool SHOW_TIME()   { return true; }
   static bool SHOW_TREND()  { return true; }
};

#endif