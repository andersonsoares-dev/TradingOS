//+------------------------------------------------------------------+
//| TradingOS v1.0                                                   |
//+------------------------------------------------------------------+
#property copyright "Anderson Soares"
#property version   "1.00"
#property strict

#include "../Include/Core/Config.mqh"
#include "../Include/Core/Logger.mqh"

#include "../Include/Services/MarketService.mqh"

#include "../Include/Models/MarketContext.mqh"
#include "../Include/UI/Dashboard.mqh"

MarketContext Context;
CMarketService Market;
CDashboard Dashboard;

//+------------------------------------------------------------------+
int OnInit()
{
   EventSetTimer(CConfig::TIMER_INTERVAL());

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

   Dashboard.Show();
}

//+------------------------------------------------------------------+
void OnTick()
{
}
//+------------------------------------------------------------------+