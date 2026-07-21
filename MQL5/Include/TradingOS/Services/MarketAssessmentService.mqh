//+------------------------------------------------------------------+
//| TradingOS - MarketAssessmentService.mqh                          |
//+------------------------------------------------------------------+
#ifndef __MARKET_ASSESSMENT_SERVICE_MQH__
#define __MARKET_ASSESSMENT_SERVICE_MQH__

#include <TradingOS/Models/MarketContext.mqh>

// Recebe o MarketContext ja preenchido (Trend/ADX/RSI). Nao acessa o
// broker, nao usa Symbol nem Timeframe - trabalha somente sobre valores
// ja calculados por outros servicos. Confidence NAO implementado nesta
// sprint (ver Docs/BACKLOG.md).
class CMarketAssessmentService
{
private:

   double TrendScore(ENUM_TREND trend)
   {
      if(trend == TREND_UP)   return 1.0;
      if(trend == TREND_DOWN) return -1.0;
      return 0.0;
   }

   double AdxNorm(double adx)
   {
      double capped = MathMin(adx, 50.0);
      return capped / 50.0;
   }

   double RsiSignal(double rsi)
   {
      return (rsi - 50.0) / 50.0;
   }

   double TFScore(ENUM_TREND trend, double adx, double rsi)
   {
      return TrendScore(trend) * AdxNorm(adx) * 0.7
           + RsiSignal(rsi) * 0.3;
   }

public:

   MarketAssessment Calculate(const MarketContext &context)
   {
      MarketAssessment assessment;

      double scoreH4  = TFScore(context.TrendH4,  context.AdxH4,  context.RsiH4);
      double scoreH1  = TFScore(context.TrendH1,  context.AdxH1,  context.RsiH1);
      double scoreM15 = TFScore(context.TrendM15, context.AdxM15, context.RsiM15);

      double weighted = (scoreH4 * 0.5) + (scoreH1 * 0.3) + (scoreM15 * 0.2);

      double rawScore = 100.0 * weighted;

      if(rawScore > 100.0)  rawScore = 100.0;
      if(rawScore < -100.0) rawScore = -100.0;

      assessment.Score = (int)MathRound(rawScore);

      if(assessment.Score >= 20)
         assessment.Bias = BIAS_BULLISH;
      else if(assessment.Score <= -20)
         assessment.Bias = BIAS_BEARISH;
      else
         assessment.Bias = BIAS_NEUTRAL;

      return assessment;
   }
};

#endif
