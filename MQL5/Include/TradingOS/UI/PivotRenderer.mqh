//+------------------------------------------------------------------+
//| TradingOS - PivotRenderer.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __PIVOT_RENDERER_MQH__
#define __PIVOT_RENDERER_MQH__

#include <TradingOS/Models/MarketContext.mqh>

// Desenha e atualiza linhas horizontais (OBJ_HLINE) para os niveis de
// Pivot ja calculados em MarketContext.CurrentPivot. Nao calcula pivos,
// nao acessa indicadores - responsabilidade exclusiva de renderizacao.
class CPivotRenderer
{
private:

   void DrawOrUpdate(const string name, double price, color clr)
   {
      if(ObjectFind(0, name) < 0)
      {
         ObjectCreate(0, name, OBJ_HLINE, 0, 0, price);
         ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
         ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_DASH);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      }
      else
      {
         ObjectSetDouble(0, name, OBJPROP_PRICE, price);
      }
   }

public:

   void Update(const MarketContext &context)
   {
      DrawOrUpdate("TradingOS_Pivot_PP", context.CurrentPivot.Pivot, clrYellow);
      DrawOrUpdate("TradingOS_Pivot_R1", context.CurrentPivot.R1,    clrDodgerBlue);
      DrawOrUpdate("TradingOS_Pivot_R2", context.CurrentPivot.R2,    clrDodgerBlue);
      DrawOrUpdate("TradingOS_Pivot_R3", context.CurrentPivot.R3,    clrDodgerBlue);
      DrawOrUpdate("TradingOS_Pivot_S1", context.CurrentPivot.S1,    clrOrangeRed);
      DrawOrUpdate("TradingOS_Pivot_S2", context.CurrentPivot.S2,    clrOrangeRed);
      DrawOrUpdate("TradingOS_Pivot_S3", context.CurrentPivot.S3,    clrOrangeRed);
   }
};

#endif
