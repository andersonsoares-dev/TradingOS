//+------------------------------------------------------------------+
//| TradingOS v1.0                                                   |
//+------------------------------------------------------------------+
#property copyright "Anderson Soares"
#property version   "1.00"
#property strict

#include <TradingOS/Core/Config.mqh>
#include <TradingOS/Core/Logger.mqh>

#include <TradingOS/Services/MarketService.mqh>
#include <TradingOS/Services/SignalBuilderService.mqh>

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/Models/TradingSignal.mqh>
#include <TradingOS/UI/Dashboard.mqh>
#include <TradingOS/UI/PivotRenderer.mqh>
MarketContext Context;
TradingSignal Signal;
CMarketService Market;
CSignalBuilderService SignalBuilder;
CDashboard Dashboard;
CPivotRenderer PivotRenderer;

//+------------------------------------------------------------------+
int OnInit()
{
   EventSetTimer(CConfig::TimerInterval());

   Context.Clear();

   Dashboard.Create();

   CLogger::Info("TradingOS iniciado.");

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();

   Dashboard.Destroy();
}

//+------------------------------------------------------------------+
void OnTimer()
{
   bool marketOk = Market.Update(Context);

   Signal = SignalBuilder.Build(Context);

   Dashboard.Update(Context, Signal, marketOk);

   PivotRenderer.Update(Context);

   Dashboard.Show();
}

//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+