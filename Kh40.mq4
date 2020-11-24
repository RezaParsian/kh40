//+------------------------------------------------------------------+
//|                                                         Kh40.mq4 |
//|                              Copyright 2020, Kh40 Software Corp. |
//|                                                  https://rp76.ir |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots 1
#property indicator_color1 clrHotPink
#property indicator_width1 2
#property indicator_type1 DRAW_LINE
//--- indicator buffers
double         em1Buffer[];

enum price_mode
  {
   open,
   colse,
   high,
   low
  };

input int range=5; //Period
input price_mode pmode; // mode
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,em1Buffer);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   double mode[];
   switch(pmode)
     {
      case  0:
         ArrayCopy(mode,open);
         break;
      case  1:
         ArrayCopy(mode,close);
         break;
      case  2:
         ArrayCopy(mode,high);
         break;
      case  3:
         ArrayCopy(mode,low);
         break;
     }

   for(int i=rates_total-prev_calculated-6; i>=0; i--)
     {
      double avg=0;
      for(int j=i+(range-1); j>=i; j--)
        {
         avg+=mode[j];
        }
      avg/=5;

      em1Buffer[i]=avg;
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
