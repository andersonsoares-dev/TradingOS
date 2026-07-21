//+------------------------------------------------------------------+
//| TradingOS - TradingSignal.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __TRADING_SIGNAL_MQH__
#define __TRADING_SIGNAL_MQH__

#include <TradingOS/Models/MarketContext.mqh>

enum ENUM_TRADING_SIGNAL
{
   SIGNAL_BUY = 0,
   SIGNAL_SELL,
   SIGNAL_WAIT,
   SIGNAL_NO_TRADE
};

// Objeto de dominio: representa a interpretacao operacional final do
// mercado. Nao executa trades, nao conhece broker nem ordens. Reutilizavel
// por Dashboard, DecisionEngine (futuro), RiskManager (futuro), logs e
// backtests.
struct TradingSignal
{
   ENUM_TRADING_SIGNAL   Signal;
   int                   ConfidenceScore;
   ENUM_CONFIDENCE_LEVEL ConfidenceLevel;
   bool                  TrendConfirmed;
   bool                  ADXConfirmed;
   bool                  RSIConfirmed;
   bool                  SessionConfirmed;
   string                Reason;

   TradingSignal()
   {
      Signal           = SIGNAL_NO_TRADE;
      ConfidenceScore  = 0;
      ConfidenceLevel  = CONFIDENCE_LOW;
      TrendConfirmed   = false;
      ADXConfirmed     = false;
      RSIConfirmed     = false;
      SessionConfirmed = false;
      Reason           = "";
   }
};

#endif
