//+------------------------------------------------------------------+
//| TradingOS v1.0                                                   |
//+------------------------------------------------------------------+
#property copyright "Anderson Soares"
#property version   "1.00"
#property strict

#include <TradingOS/Core/Config.mqh>
#include <TradingOS/Core/Logger.mqh>

#include <TradingOS/Services/MarketService.mqh>

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/UI/Dashboard.mqh>
#include <TradingOS/UI/PivotRenderer.mqh>
MarketContext Context;
CMarketService Market;
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
   Market.Update(Context);

   Dashboard.Update(Context);

   PivotRenderer.Update(Context);

   Dashboard.Show();
}

//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+