/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'chart_utils.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate = true});

  factory SimpleBarChart.withTheGoods(List _theGoods, String attributeToGraph) {
    return new SimpleBarChart(
      _populateSleepData(_theGoods, attributeToGraph),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      List.from(seriesList),
      animate: animate,
    );
  }

  /// Create a sleep series with a list of dynamic data:
  static List<charts.Series<dreamStats, String>> _populateSleepData(List _theGoods, String attributeToGraph) {
    final mapOfGoods = <String, int>{};
    int i = 0;
    int j = 0;
    var attributeList = [];
    var item = "";

    for(i=0;i<_theGoods.length;i++) {
      if(attributeToGraph=="Dream Notes") {
        attributeList = _theGoods[i].dreamNotes;
      }
      if(attributeToGraph=="Sleep Notes") {
        attributeList = _theGoods[i].sleepNotes;
      }
        for(j=0;j<attributeList.length;j++) {
            item = attributeList[j];
            mapOfGoods.increment(item);
        }
    };

    var dreamDataDynamic = [
      new dreamStats('Fake',0),
    ];
    dreamDataDynamic.removeAt(0);

    int? v;
    String? k;
    for (k in mapOfGoods.keys) {
      v = mapOfGoods[k];
      dreamDataDynamic.add(new dreamStats(k,v));
    };

    return [
      new charts.Series<dreamStats, String>(
        id: 'Stats',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (dreamStats stats, _) => stats.attribute,
        measureFn: (dreamStats stats, _) => stats.amount,
        data: dreamDataDynamic,
      )
    ];
  }
}

/// dream stats Model that will be used for our passed-in dynmiac dream data and a list of which will be passed to the chart maker thing
class dreamStats {
  final String attribute;
  final int? amount;
  dreamStats(this.attribute, this.amount);
}
