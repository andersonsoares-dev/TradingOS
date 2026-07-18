//+------------------------------------------------------------------+
//| TradingOS - MarketService.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __MARKET_SERVICE_MQH__
#define __MARKET_SERVICE_MQH__

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/Indicators/TrendService.mqh>

class CMarketService
{
private:

   CTrendService Trend;

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

      return true;
   }
};

#endif