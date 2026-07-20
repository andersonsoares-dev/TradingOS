//+------------------------------------------------------------------+
//| TradingOS - MarketService.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __MARKET_SERVICE_MQH__
#define __MARKET_SERVICE_MQH__

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/Indicators/TrendService.mqh>
#include <TradingOS/Indicators/ATRService.mqh>
#include <TradingOS/Indicators/RSIService.mqh>

class CMarketService
{
private:

   CTrendService Trend;
   CATRService   ATR;
   CRSIService   RSI;

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

      return true;
   }
};

#endif