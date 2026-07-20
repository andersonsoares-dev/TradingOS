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