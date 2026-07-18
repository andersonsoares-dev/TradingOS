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