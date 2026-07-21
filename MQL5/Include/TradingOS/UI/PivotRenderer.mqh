//+------------------------------------------------------------------+
//| TradingOS - PivotRenderer.mqh                                    |
//+------------------------------------------------------------------+
#ifndef __PIVOT_RENDERER_MQH__
#define __PIVOT_RENDERER_MQH__

#include <TradingOS/Models/MarketContext.mqh>

// Desenha e atualiza linhas horizontais (OBJ_HLINE) + rotulos (OBJ_TEXT)
// para os niveis de Pivot e para a maxima/minima do dia anterior, ja
// disponiveis em MarketContext. Nao calcula pivos, nao acessa indicadores
// - responsabilidade exclusiva de renderizacao.
class CPivotRenderer
{
private:

   void DrawLine(const string name, double price, color clr)
   {
      if(ObjectFind(0, name) < 0)
      {
         ObjectCreate(0, name, OBJ_HLINE, 0, 0, price);
         ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
         ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      }
      else
      {
         ObjectSetDouble(0, name, OBJPROP_PRICE, price);
      }
   }

   void DrawLabel(const string name, const string levelName, double price, color clr)
   {
      datetime labelTime = TimeCurrent() + PeriodSeconds() * 10;

      if(ObjectFind(0, name) < 0)
      {
         ObjectCreate(0, name, OBJ_TEXT, 0, labelTime, price);
         ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
         ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
         ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 8);
      }
      else
      {
         ObjectMove(0, name, 0, labelTime, price);
      }

      ObjectSetString(0, name, OBJPROP_TEXT,
         levelName + " : " + DoubleToString(price, _Digits));
   }

   void DrawLevel(const string prefix, const string levelName, double price, color clr)
   {
      DrawLine(prefix + "_Line", price, clr);
      DrawLabel(prefix + "_Label", levelName, price, clr);
   }

   void RemoveLevel(const string prefix)
   {
      ObjectDelete(0, prefix + "_Line");
      ObjectDelete(0, prefix + "_Label");
   }

public:

   void Update(const MarketContext &context)
   {
      DrawLevel("TradingOS_Pivot_PP", "PP", context.CurrentPivot.Pivot, clrYellow);
      DrawLevel("TradingOS_Pivot_R1", "R1", context.CurrentPivot.R1,    clrLimeGreen);
      DrawLevel("TradingOS_Pivot_R2", "R2", context.CurrentPivot.R2,    clrLimeGreen);
      DrawLevel("TradingOS_Pivot_R3", "R3", context.CurrentPivot.R3,    clrLimeGreen);
      DrawLevel("TradingOS_Pivot_S1", "S1", context.CurrentPivot.S1,    clrOrangeRed);
      DrawLevel("TradingOS_Pivot_S2", "S2", context.CurrentPivot.S2,    clrOrangeRed);
      DrawLevel("TradingOS_Pivot_S3", "S3", context.CurrentPivot.S3,    clrOrangeRed);

      DrawLevel("TradingOS_Pivot_YH", "YH", context.PreviousDayHigh,    clrAqua);
      DrawLevel("TradingOS_Pivot_YL", "YL", context.PreviousDayLow,     clrMagenta);
   }

   // Remove todas as linhas e rotulos criados por este renderer. Deve ser
   // chamado em OnDeinit() para nao deixar objetos orfaos no grafico apos
   // a remocao do EA.
   void Destroy()
   {
      RemoveLevel("TradingOS_Pivot_PP");
      RemoveLevel("TradingOS_Pivot_R1");
      RemoveLevel("TradingOS_Pivot_R2");
      RemoveLevel("TradingOS_Pivot_R3");
      RemoveLevel("TradingOS_Pivot_S1");
      RemoveLevel("TradingOS_Pivot_S2");
      RemoveLevel("TradingOS_Pivot_S3");
      RemoveLevel("TradingOS_Pivot_YH");
      RemoveLevel("TradingOS_Pivot_YL");

      // Objetos orfaos da 1a versao do PivotRenderer (antes de existirem
      // rotulos/sufixo _Line), quando os nomes eram sem sufixo e o estilo
      // era tracejado. Limpeza definitiva de migracao.
      ObjectDelete(0, "TradingOS_Pivot_PP");
      ObjectDelete(0, "TradingOS_Pivot_R1");
      ObjectDelete(0, "TradingOS_Pivot_R2");
      ObjectDelete(0, "TradingOS_Pivot_R3");
      ObjectDelete(0, "TradingOS_Pivot_S1");
      ObjectDelete(0, "TradingOS_Pivot_S2");
      ObjectDelete(0, "TradingOS_Pivot_S3");
   }
};

#endif
