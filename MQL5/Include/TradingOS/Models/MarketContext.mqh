//+------------------------------------------------------------------+
//| TradingOS - MarketContext.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __MARKET_CONTEXT_MQH__
#define __MARKET_CONTEXT_MQH__

#include <TradingOS/Indicators/TrendService.mqh>

struct MarketContext
{
   string Symbol;

   double Bid;
   double Ask;
   int    Spread;

   datetime LastUpdate;

   ENUM_TREND TrendH4;
   ENUM_TREND TrendH1;
   ENUM_TREND TrendM15;

   void Clear()
   {
      Symbol = "";

      Bid = 0.0;
      Ask = 0.0;
      Spread = 0;

      LastUpdate = 0;

      TrendH4 = TREND_SIDE;
      TrendH1 = TREND_SIDE;
      TrendM15 = TREND_SIDE;
   }
};

#endif