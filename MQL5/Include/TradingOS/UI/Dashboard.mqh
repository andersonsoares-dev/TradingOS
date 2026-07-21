//+------------------------------------------------------------------+
//| TradingOS - Dashboard.mqh                                        |
//+------------------------------------------------------------------+
#ifndef __DASHBOARD_MQH__
#define __DASHBOARD_MQH__

#include <TradingOS/Models/MarketContext.mqh>

class CDashboard
{
private:

   string m_text;

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

   void Update(const MarketContext &context)
   {
      Clear();

      Add("===== TradingOS =====");
      Add("Symbol : " + context.Symbol);
      Add("Bid    : " + DoubleToString(context.Bid,_Digits));
      Add("Ask    : " + DoubleToString(context.Ask,_Digits));
      Add("ATR H4 : " + DoubleToString(context.AtrH4,_Digits));
      Add("ATR H1 : " + DoubleToString(context.AtrH1,_Digits));
      Add("ATR M15: " + DoubleToString(context.AtrM15,_Digits));
      Add("RSI H4 : " + DoubleToString(context.RsiH4,_Digits));
      Add("RSI H1 : " + DoubleToString(context.RsiH1,_Digits));
      Add("RSI M15: " + DoubleToString(context.RsiM15,_Digits));
      Add("ADX H4 : " + DoubleToString(context.AdxH4,_Digits));
      Add("ADX H1 : " + DoubleToString(context.AdxH1,_Digits));
      Add("ADX M15: " + DoubleToString(context.AdxM15,_Digits));

      string sessionLabel = "Closed";

      switch(context.CurrentSession)
      {
         case SESSION_ASIAN:                    sessionLabel = "Asia";     break;
         case SESSION_LONDON:                   sessionLabel = "London";   break;
         case SESSION_NEWYORK:                  sessionLabel = "New York"; break;
         case SESSION_LONDON_NEWYORK_OVERLAP:   sessionLabel = "Overlap";  break;
         default:                               sessionLabel = "Closed";   break;
      }

      Add("Session: " + sessionLabel);

      Add("Pivot  : " + DoubleToString(context.CurrentPivot.Pivot,_Digits));
      Add("R1     : " + DoubleToString(context.CurrentPivot.R1,_Digits));
      Add("R2     : " + DoubleToString(context.CurrentPivot.R2,_Digits));
      Add("R3     : " + DoubleToString(context.CurrentPivot.R3,_Digits));
      Add("S1     : " + DoubleToString(context.CurrentPivot.S1,_Digits));
      Add("S2     : " + DoubleToString(context.CurrentPivot.S2,_Digits));
      Add("S3     : " + DoubleToString(context.CurrentPivot.S3,_Digits));

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