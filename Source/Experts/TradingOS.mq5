//+------------------------------------------------------------------+
//| TradingOS v1.0                                                   |
//+------------------------------------------------------------------+
#property copyright "Anderson Soares"
#property version   "1.00"
#property strict

#include "../Include/Core/Config.mqh"
#include "../Include/Core/Logger.mqh"
#include "../Include/Indicators/TrendService.mqh"
#include "../Include/Models/MarketContext.mqh"
#include "../Include/UI/Dashboard.mqh"

MarketContext Context;
CTrendService Trend;
CDashboard Dashboard;

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

   Context.Bid        = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   Context.Ask        = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   Context.Spread     = (int)SymbolInfoInteger(_Symbol,SYMBOL_SPREAD);
   Context.LastUpdate = TimeCurrent();

   Context.TrendH4  = Trend.GetTrend(_Symbol,PERIOD_H4);
   Context.TrendH1  = Trend.GetTrend(_Symbol,PERIOD_H1);
   Context.TrendM15 = Trend.GetTrend(_Symbol,PERIOD_M15);

   Dashboard.Clear();

   Dashboard.Add("TradingOS v1.0");
   Dashboard.Add("-------------------------");
   Dashboard.Add("");

   Dashboard.Add("Symbol : " + Context.Symbol);
   Dashboard.Add("Bid    : " + DoubleToString(Context.Bid,_Digits));
   Dashboard.Add("Ask    : " + DoubleToString(Context.Ask,_Digits));
   Dashboard.Add("Spread : " + IntegerToString(Context.Spread));
   Dashboard.Add("");

   Dashboard.Add("Trend H4  : " + Trend.ToString(Context.TrendH4));
   Dashboard.Add("Trend H1  : " + Trend.ToString(Context.TrendH1));
   Dashboard.Add("Trend M15 : " + Trend.ToString(Context.TrendM15));

   Dashboard.Show();
}

//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+