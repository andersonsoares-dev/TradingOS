//+------------------------------------------------------------------+
//| TradingOS - MarketService.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __MARKET_SERVICE_MQH__
#define __MARKET_SERVICE_MQH__

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/Indicators/TrendService.mqh>
#include <TradingOS/Indicators/ATRService.mqh>
#include <TradingOS/Indicators/RSIService.mqh>
#include <TradingOS/Indicators/ADXService.mqh>
#include <TradingOS/Services/SessionService.mqh>
#include <TradingOS/Services/PivotService.mqh>

class CMarketService
{
private:

   CTrendService   Trend;
   CATRService     ATR;
   CRSIService     RSI;
   CADXService     ADX;
   CSessionService Session;
   CPivotService   Pivot;

public:

   bool Update(MarketContext &context)
   {
      context.Symbol = _Symbol;

      context.Bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      context.Ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

      context.Spread =
         (int)SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);

      context.LastUpdate = TimeCurrent();

      context.TrendH4 =
         Trend.GetTrend(_Symbol, PERIOD_H4);

      context.TrendH1 =
         Trend.GetTrend(_Symbol, PERIOD_H1);

      context.TrendM15 =
         Trend.GetTrend(_Symbol, PERIOD_M15);

      context.AtrH4 =
         ATR.GetValue(_Symbol, PERIOD_H4);

      context.AtrH1 =
         ATR.GetValue(_Symbol, PERIOD_H1);

      context.AtrM15 =
         ATR.GetValue(_Symbol, PERIOD_M15);

      context.RsiH4 =
         RSI.GetValue(_Symbol, PERIOD_H4);

      context.RsiH1 =
         RSI.GetValue(_Symbol, PERIOD_H1);

      context.RsiM15 =
         RSI.GetValue(_Symbol, PERIOD_M15);

      context.AdxH4 =
         ADX.GetValue(_Symbol, PERIOD_H4);

      context.AdxH1 =
         ADX.GetValue(_Symbol, PERIOD_H1);

      context.AdxM15 =
         ADX.GetValue(_Symbol, PERIOD_M15);

      context.CurrentSession =
         Session.GetSession(TimeCurrent());

      double pivotHigh  = iHigh(_Symbol, PERIOD_D1, 1);
      double pivotLow   = iLow(_Symbol, PERIOD_D1, 1);
      double pivotClose = iClose(_Symbol, PERIOD_D1, 1);

      context.CurrentPivot =
         Pivot.Calculate(pivotHigh, pivotLow, pivotClose);

      return true;
   }
};

#endif