//+------------------------------------------------------------------+
//| TradingOS - Dashboard.mqh                                        |
//+------------------------------------------------------------------+
#ifndef __DASHBOARD_MQH__
#define __DASHBOARD_MQH__

class CDashboard
{
private:

   string m_text;

public:

   void Clear()
   {
      m_text = "";
   }

   void Add(const string text)
   {
      m_text += text + "\n";
   }

   void Show()
   {
      Comment(m_text);
   }
};

#endif