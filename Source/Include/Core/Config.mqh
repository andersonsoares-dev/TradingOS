//+------------------------------------------------------------------+
//| TradingOS - Config                                               |
//+------------------------------------------------------------------+
#ifndef __CONFIG_MQH__
#define __CONFIG_MQH__

class CConfig
{
public:

   //==============================================================
   // Sistema
   //==============================================================

   static const int TIMER_INTERVAL = 1;

   //==============================================================
   // Médias Móveis
   //==============================================================

   static const int EMA_FAST = 20;
   static const int EMA_SLOW = 50;
   static const int EMA_LONG = 200;

   //==============================================================
   // Indicadores
   //==============================================================

   static const int RSI_PERIOD = 14;
   static const int ATR_PERIOD = 14;
   static const int ADX_PERIOD = 14;

   //==============================================================
   // Dashboard
   //==============================================================

   static const bool SHOW_SPREAD = true;
   static const bool SHOW_TIME   = true;
   static const bool SHOW_TREND  = true;
};

#endif