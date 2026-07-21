//+------------------------------------------------------------------+
//| TradingOS - SignalBuilderService.mqh                             |
//+------------------------------------------------------------------+
#ifndef __SIGNAL_BUILDER_SERVICE_MQH__
#define __SIGNAL_BUILDER_SERVICE_MQH__

#include <TradingOS/Models/MarketContext.mqh>
#include <TradingOS/Models/TradingSignal.mqh>

// Interpreta o MarketContext ja preenchido (incluindo o MarketAssessment
// ja calculado em context.Assessment) e produz um TradingSignal. Nao
// acessa broker, nao calcula indicadores, nao desenha objetos, nao
// escreve logs, nao altera MarketContext (parametro const &).
//
// Nota de design: o prompt desta sprint descreve a entrada como
// "MarketContext + MarketAssessment" separadamente, mas o MarketAssessment
// ja vive dentro de MarketContext.Assessment desde a Sprint 6.1 - passar
// os dois separadamente duplicaria o mesmo dado. Build() recebe apenas
// o MarketContext.
class CSignalBuilderService
{
private:

   bool DirectionAligned(ENUM_TREND trend, bool bullish, bool bearish)
   {
      if(bullish) return (trend == TREND_UP);
      if(bearish) return (trend == TREND_DOWN);
      return false;
   }

public:

   TradingSignal Build(const MarketContext &context)
   {
      TradingSignal signal;

      bool bullish = (context.Assessment.Bias == BIAS_BULLISH);
      bool bearish = (context.Assessment.Bias == BIAS_BEARISH);

      signal.TrendConfirmed =
            DirectionAligned(context.TrendH4, bullish, bearish)
         && DirectionAligned(context.TrendH1, bullish, bearish);

      signal.ADXConfirmed =
            (context.AdxH4 >= 25.0)
         && (context.AdxH1 >= 25.0);

      if(bullish)
         signal.RSIConfirmed = (context.RsiH4 > 50.0) && (context.RsiH1 > 50.0);
      else if(bearish)
         signal.RSIConfirmed = (context.RsiH4 < 50.0) && (context.RsiH1 < 50.0);
      else
         signal.RSIConfirmed = false;

      signal.SessionConfirmed =
            (context.CurrentSession == SESSION_LONDON)
         || (context.CurrentSession == SESSION_NEWYORK)
         || (context.CurrentSession == SESSION_LONDON_NEWYORK_OVERLAP);

      signal.ConfidenceScore = context.Assessment.ConfidenceScore;
      signal.ConfidenceLevel = context.Assessment.ConfidenceLevel;

      int confirmations = 0;
      if(signal.TrendConfirmed)   confirmations++;
      if(signal.ADXConfirmed)     confirmations++;
      if(signal.RSIConfirmed)     confirmations++;
      if(signal.SessionConfirmed) confirmations++;

      bool highConfidence = (signal.ConfidenceLevel == CONFIDENCE_HIGH);

      if((bullish || bearish) && confirmations == 4 && highConfidence)
      {
         signal.Signal = bullish ? SIGNAL_BUY : SIGNAL_SELL;
         signal.Reason = "Trend, ADX, RSI and Session all confirmed with high confidence.";
      }
      else if((bullish || bearish) && confirmations >= 2)
      {
         signal.Signal = SIGNAL_WAIT;
         signal.Reason = "Directional bias present, confirmations incomplete.";
      }
      else
      {
         signal.Signal = SIGNAL_NO_TRADE;
         signal.Reason = "Insufficient alignment for a directional signal.";
      }

      return signal;
   }
};

#endif
