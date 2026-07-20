//+------------------------------------------------------------------+
//| ADXService.mqh                                                   |
//+------------------------------------------------------------------+
#ifndef __ADXSERVICE_MQH__
#define __ADXSERVICE_MQH__

class CADXService
{
public:

   // GetValue retorna apenas a linha principal do ADX (buffer 0).
   // +DI e -DI (buffers 1 e 2) não são implementados nesta sprint.
   double GetValue(const string symbol, ENUM_TIMEFRAMES timeframe)
   {
      int handle = iADX(symbol, timeframe, 14);

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
