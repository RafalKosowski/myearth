import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<Smog> seriesList;

  HorizontalBarChart(this.seriesList);

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    List<charts.Series<Smog,String>> series = [
      charts.Series(
        id: 'Sales',
        data: seriesList,
        domainFn: (Smog sales, _) => sales.name,
        measureFn: (Smog sales, _) => sales.standard(),
        labelAccessorFn: (Smog sales, _) =>sales.standard().toString()+"% " +sales.napis,
        colorFn: (Smog sales, _) => sales.colorBar(),
      ),
    ];
    return
      Expanded(
        child: charts.BarChart(
          series,
          animate: true,
          vertical: false,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          domainAxis: new charts.OrdinalAxisSpec(
          ),
          primaryMeasureAxis:
          new charts.NumericAxisSpec(showAxisLine: true,renderSpec: charts.NoneRenderSpec()),
        ),
      );
  }
}
class Smog {
  final String name;
  final double value;
  String napis;
  charts.Color barColor;
  final double standardOfSubstance;
  standard(){
    return num.parse(((this.value/this.standardOfSubstance)*100).toStringAsFixed(2));
  }
  colorBar(){
    if(this.standard()<=100){
      napis= "W Normie";
      return charts.ColorUtil.fromDartColor(Colors.green);
    }else{
      napis="Ponad normę";
      return charts.ColorUtil.fromDartColor(Colors.red);
    }
  }
  Smog(this.name, this.value,this.standardOfSubstance);
}