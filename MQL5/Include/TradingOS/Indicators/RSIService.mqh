//+------------------------------------------------------------------+
//| RSIService.mqh                                                   |
//+------------------------------------------------------------------+
#ifndef __RSISERVICE_MQH__
#define __RSISERVICE_MQH__

class CRSIService
{
public:

   double GetValue(const string symbol, ENUM_TIMEFRAMES timeframe)
   {
      int handle = iRSI(symbol, timeframe, 14, PRICE_CLOSE);

      if(handle == INVALID_HANDLE)
         return 0.0;

      double buffer[];

      if(CopyBuffer(handle, 0, 0, 1, buffer) <= 0)
      {
         IndicatorRelease(handle);
         return 0.0;
      }

      IndicatorRelease(handle);

      return buffer[0];
   }
};

#endif
