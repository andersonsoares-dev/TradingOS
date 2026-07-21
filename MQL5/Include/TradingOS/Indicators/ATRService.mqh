//+------------------------------------------------------------------+
//| ATRService.mqh                                                   |
//+------------------------------------------------------------------+
#ifndef __ATRSERVICE_MQH__
#define __ATRSERVICE_MQH__

class CATRService
{
public:

   double GetValue(string symbol, ENUM_TIMEFRAMES timeframe)
   {
      int handle = iATR(symbol, timeframe, 14);

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