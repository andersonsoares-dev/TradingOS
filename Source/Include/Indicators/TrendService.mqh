//+------------------------------------------------------------------+
//| TradingOS - TrendService.mqh                                     |
//+------------------------------------------------------------------+
#ifndef __TREND_SERVICE_MQH__
#define __TREND_SERVICE_MQH__

enum ENUM_TREND
{
   TREND_DOWN = -1,
   TREND_SIDE = 0,
   TREND_UP   = 1
};

class CTrendService
{
private:

   double GetEMA(const string symbol,
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
         return 0.0;

      double buffer[];

      if(CopyBuffer(handle,0,0,1,buffer) <= 0)
      {
         IndicatorRelease(handle);
         return 0.0;
      }

      IndicatorRelease(handle);

      return buffer[0];
   }

public:

   ENUM_TREND GetTrend(const string symbol,
                       ENUM_TIMEFRAMES timeframe)
   {
      double ema20  = GetEMA(symbol,timeframe,20);
      double ema50  = GetEMA(symbol,timeframe,50);
      double ema200 = GetEMA(symbol,timeframe,200);

      if(ema20 > ema50 && ema50 > ema200)
         return TREND_UP;

      if(ema20 < ema50 && ema50 < ema200)
         return TREND_DOWN;

      return TREND_SIDE;
   }

   string ToString(ENUM_TREND trend)
   {
      switch(trend)
      {
         case TREND_UP:
            return "UP";

         case TREND_DOWN:
            return "DOWN";

         default:
            return "SIDE";
      }
   }
};

#endif