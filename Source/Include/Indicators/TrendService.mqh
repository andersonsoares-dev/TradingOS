//+------------------------------------------------------------------+
//| TradingOS - Trend Service                                        |
//+------------------------------------------------------------------+
#ifndef __TREND_SERVICE_MQH__
#define __TREND_SERVICE_MQH__

enum ENUM_TREND
{
   TREND_STRONG_DOWN = -2,
   TREND_DOWN        = -1,
   TREND_SIDE        = 0,
   TREND_UP          = 1,
   TREND_STRONG_UP   = 2
};

class CTrendService
{
private:

   double GetEMA(string symbol,
                 ENUM_TIMEFRAMES timeframe,
                 int period)
   {
      int handle = iMA(symbol,
                       timeframe,
                       period,
                       0,
                       MODE_EMA,
                       PRICE_CLOSE);

      if(handle == INVALID_HANDLE)
         return 0;

      double buffer[];

      if(CopyBuffer(handle,0,0,1,buffer) <= 0)
      {
         IndicatorRelease(handle);
         return 0;
      }

      IndicatorRelease(handle);

      return buffer[0];
   }

public:

   ENUM_TREND GetTrend(string symbol,
                       ENUM_TIMEFRAMES timeframe)
   {
      double ema20  = GetEMA(symbol,timeframe,20);
      double ema50  = GetEMA(symbol,timeframe,50);
      double ema200 = GetEMA(symbol,timeframe,200);

      if(ema20 > ema50 && ema50 > ema200)
         return TREND_STRONG_UP;

      if(ema20 > ema50)
         return TREND_UP;

      if(ema20 < ema50 && ema50 < ema200)
         return TREND_STRONG_DOWN;

      if(ema20 < ema50)
         return TREND_DOWN;

      return TREND_SIDE;
   }

   string ToString(ENUM_TREND trend)
   {
      switch(trend)
      {
         case TREND_STRONG_UP:
            return "Strong Up";

         case TREND_UP:
            return "Up";

         case TREND_SIDE:
            return "Side";

         case TREND_DOWN:
            return "Down";

         case TREND_STRONG_DOWN:
            return "Strong Down";
      }

      return "Unknown";
   }
};

#endif