//+------------------------------------------------------------------+
//| TradingOS - Dashboard.mqh (V2 - Operational Intelligence Layer)  |
//+------------------------------------------------------------------+
#ifndef __DASHBOARD_MQH__
#define __DASHBOARD_MQH__

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/Models/TradingSignal.mqh>

// Camada de apresentacao. So le MarketContext/TradingSignal e formata
// texto - nenhuma regra de negocio, nenhuma decisao operacional.
class CDashboard
{
private:

   string m_text;

   string TrendLabel(ENUM_TREND trend)
   {
      switch(trend)
      {
         case TREND_UP:   return "UP";
         case TREND_DOWN: return "DOWN";
         default:         return "SIDE";
      }
   }

   string BiasLabel(ENUM_MARKET_BIAS bias)
   {
      switch(bias)
      {
         case BIAS_BULLISH: return "BULLISH";
         case BIAS_BEARISH: return "BEARISH";
         default:            return "NEUTRAL";
      }
   }

   string StrengthLabel(double adx)
   {
      if(adx >= 25.0) return "Strong";
      if(adx >= 20.0) return "Moderate";
      return "Weak";
   }

   string MomentumLabel(double rsi)
   {
      if(rsi > 55.0) return "Bullish";
      if(rsi < 45.0) return "Bearish";
      return "Neutral";
   }

   string SessionLabel(ENUM_MARKET_SESSION session)
   {
      switch(session)
      {
         case SESSION_ASIAN:                   return "Asia";
         case SESSION_LONDON:                  return "London";
         case SESSION_NEWYORK:                 return "New York";
         case SESSION_LONDON_NEWYORK_OVERLAP:  return "Overlap";
         default:                              return "Closed";
      }
   }

   string SignalLabel(ENUM_TRADING_SIGNAL signal)
   {
      switch(signal)
      {
         case SIGNAL_BUY:  return "BUY";
         case SIGNAL_SELL: return "SELL";
         case SIGNAL_WAIT: return "WAIT";
         default:          return "NO TRADE";
      }
   }

   string ConfidenceBar(int score)
   {
      int filled = (int)MathRound(score / 10.0);
      if(filled < 0)  filled = 0;
      if(filled > 10) filled = 10;

      string bar = "";
      for(int i = 0; i < 10; i++)
         bar += (i < filled) ? "█" : "░";

      return bar;
   }

   string Confirm(bool confirmed, const string label)
   {
      return (confirmed ? "✔ " : "✘ ") + label;
   }

public:

   bool Create()
   {
      m_text = "";
      return(true);
   }

   void Clear()
   {
      m_text = "";
   }

   void Add(const string text)
   {
      m_text += text + "\n";
   }

   void Update(const MarketContext &context, const TradingSignal &signal, bool eaHealthy)
   {
      Clear();

      Add("===== TradingOS =====");
      Add("Symbol : " + context.Symbol);
      Add("");

      Add("--- MARKET ---");
      Add("Trend H4  : " + TrendLabel(context.TrendH4));
      Add("Trend H1  : " + TrendLabel(context.TrendH1));
      Add("Trend M15 : " + TrendLabel(context.TrendM15));
      Add("Strength  : " + StrengthLabel(context.AdxH4));
      Add("Momentum  : " + MomentumLabel(context.RsiH4));
      Add("Session   : " + SessionLabel(context.CurrentSession));
      Add("");

      Add("--- ASSESSMENT ---");
      Add("Bias       : " + BiasLabel(context.Assessment.Bias));
      Add("Confidence : " + ConfidenceBar(context.Assessment.ConfidenceScore));
      Add("");

      Add("=== SIGNAL: " + SignalLabel(signal.Signal) + " ===");
      Add("");

      Add("--- WHY ---");
      Add(Confirm(signal.TrendConfirmed,   "Trend Alignment"));
      Add(Confirm(signal.ADXConfirmed,     "Strong ADX"));
      Add(Confirm(signal.RSIConfirmed,     "RSI Momentum"));
      Add(Confirm(signal.SessionConfirmed, "Session"));
      Add("Reason: " + signal.Reason);
      Add("");

      Add("--- EA STATUS ---");
      Add("Status : " + (eaHealthy ? "READY" : "ERROR"));

      Show();
   }

   void Show()
   {
      Comment(m_text);
   }

   void Destroy()
   {
      Comment("");
      m_text = "";
   }
};

#endif
