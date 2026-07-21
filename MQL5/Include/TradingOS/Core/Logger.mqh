//+------------------------------------------------------------------+
//| TradingOS - Logger                                               |
//+------------------------------------------------------------------+
#ifndef __LOGGER_MQH__
#define __LOGGER_MQH__

class CLogger
{
public:

   static void Info(string message)
   {
      Print("[INFO] ", message);
   }

   static void Warning(string message)
   {
      Print("[WARNING] ", message);
   }

   static void Error(string message)
   {
      Print("[ERROR] ", message);
   }

   static void Separator()
   {
      Print("------------------------------------------------------------");
   }
};

#endif