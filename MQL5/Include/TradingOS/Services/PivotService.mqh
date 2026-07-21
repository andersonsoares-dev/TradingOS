//+------------------------------------------------------------------+
//| TradingOS - PivotService.mqh                                     |
//+------------------------------------------------------------------+
#ifndef __PIVOT_SERVICE_MQH__
#define __PIVOT_SERVICE_MQH__

struct PivotLevels
{
   double Pivot;
   double R1;
   double R2;
   double R3;
   double S1;
   double S2;
   double S3;
};

class CPivotService
{
public:

   // Pivot Point Classico. Entrada pura (High/Low/Close) — sem acesso a
   // MarketContext, Dashboard, indicadores, ordens, historico ou series.
   PivotLevels Calculate(double high, double low, double close)
   {
      PivotLevels levels;

      levels.Pivot = (high + low + close) / 3.0;

      levels.R1 = (2.0 * levels.Pivot) - low;
      levels.S1 = (2.0 * levels.Pivot) - high;

      levels.R2 = levels.Pivot + (high - low);
      levels.S2 = levels.Pivot - (high - low);

      levels.R3 = high + 2.0 * (levels.Pivot - low);
      levels.S3 = low - 2.0 * (high - levels.Pivot);

      return levels;
   }
};

#endif
