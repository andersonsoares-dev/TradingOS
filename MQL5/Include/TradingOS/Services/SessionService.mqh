//+------------------------------------------------------------------+
//| TradingOS - SessionService.mqh                                   |
//+------------------------------------------------------------------+
#ifndef __SESSION_SERVICE_MQH__
#define __SESSION_SERVICE_MQH__

enum ENUM_MARKET_SESSION
{
   SESSION_CLOSED = 0,
   SESSION_ASIAN,
   SESSION_LONDON,
   SESSION_NEWYORK,
   SESSION_LONDON_NEWYORK_OVERLAP
};

class CSessionService
{
public:

   // Janelas aproximadas (hora do servidor), padrão de mercado:
   // Asian 00-09, London 08-17, New York 13-22, Overlap 13-17.
   ENUM_MARKET_SESSION GetSession(datetime currentTime)
   {
      MqlDateTime dt;
      TimeToStruct(currentTime, dt);

      int hour = dt.hour;

      bool asian   = (hour >= 0  && hour < 9);
      bool london  = (hour >= 8  && hour < 17);
      bool newyork = (hour >= 13 && hour < 22);

      if(london && newyork)
         return SESSION_LONDON_NEWYORK_OVERLAP;

      if(asian)
         return SESSION_ASIAN;

      if(london)
         return SESSION_LONDON;

      if(newyork)
         return SESSION_NEWYORK;

      return SESSION_CLOSED;
   }
};

#endif
