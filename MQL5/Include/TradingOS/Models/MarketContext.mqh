//+------------------------------------------------------------------+
//| TradingOS - MarketContext.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __MARKET_CONTEXT_MQH__
#define __MARKET_CONTEXT_MQH__

#include <TradingOS/Indicators/TrendService.mqh>
#include <TradingOS/Services/SessionService.mqh>
#include <TradingOS/Services/PivotService.mqh>

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

   double AtrH4;
   double AtrH1;
   double AtrM15;

   double RsiH4;
   double RsiH1;
   double RsiM15;

   double AdxH4;
   double AdxH1;
   double AdxM15;

   ENUM_MARKET_SESSION CurrentSession;

   PivotLevels CurrentPivot;

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

      AtrH4 = 0.0;
      AtrH1 = 0.0;
      AtrM15 = 0.0;

      RsiH4 = 0.0;
      RsiH1 = 0.0;
      RsiM15 = 0.0;

      AdxH4 = 0.0;
      AdxH1 = 0.0;
      AdxM15 = 0.0;

      CurrentSession = SESSION_CLOSED;

      CurrentPivot.Pivot = 0.0;
      CurrentPivot.R1 = 0.0;
      CurrentPivot.R2 = 0.0;
      CurrentPivot.R3 = 0.0;
      CurrentPivot.S1 = 0.0;
      CurrentPivot.S2 = 0.0;
      CurrentPivot.S3 = 0.0;
   }
};

#endif