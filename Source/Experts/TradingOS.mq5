//+------------------------------------------------------------------+
//| TradingOS v1.0                                                   |
//+------------------------------------------------------------------+
#property copyright "Anderson Soares"
#property version   "1.00"
#property strict

#include "../Include/Core/Config.mqh"
#include "../Include/Core/Logger.mqh"
#include "../Include/Models/MarketContext.mqh"
#include "../Include/Indicators/TrendService.mqh"

MarketContext Context;
CTrendService Trend;

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   EventSetTimer(CConfig::TIMER_INTERVAL);

   Context.Clear();

   CLogger::Info("TradingOS iniciado.");

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();
   Comment("");
}

//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void OnTimer()
{
   Context.Symbol = _Symbol;

   Context.Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   Context.Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   Context.Spread = (int)SymbolInfoInteger(_Symbol,SYMBOL_SPREAD);
   Context.LastUpdate = TimeCurrent();

   Context.TrendH4  = Trend.GetTrend(_Symbol,PERIOD_H4);
   Context.TrendH1  = Trend.GetTrend(_Symbol,PERIOD_H1);
   Context.TrendM15 = Trend.GetTrend(_Symbol,PERIOD_M15);

   string painel;

   painel  = "TradingOS v1.0\n";
   painel += "-------------------------\n\n";

   painel += "Ativo : " + Context.Symbol + "\n";
   painel += "Bid   : " + DoubleToString(Context.Bid,_Digits) + "\n";
   painel += "Ask   : " + DoubleToString(Context.Ask,_Digits) + "\n";
   painel += "Spread: " + IntegerToString(Context.Spread) + "\n\n";

   painel += "Trend H4 : " + Trend.ToString(Context.TrendH4) + "\n";
   painel += "Trend H1 : " + Trend.ToString(Context.TrendH1) + "\n";
   painel += "Trend M15: " + Trend.ToString(Context.TrendM15);

   Comment(painel);
}

//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+