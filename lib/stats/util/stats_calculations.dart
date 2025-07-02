import 'dart:core';
import 'dart:math';


class stats_calculations {

  List<int> data = [];

  stats_calculations(List<int> data) {
    this.data = List.from(data);
  }

  void setData(List<int> data) {
    this.data = List.from(data);
  }

  double mean() {
    var sum = 0.0;
    for (var x in data) {
      sum += x;
    }
    return sum / data.length;
  }

  int median() {
    List temp = List.from(data);

    temp.sort();

    return temp.length.isOdd ? temp[(temp.length / 2).truncate()]
                              : (temp[((temp.length-1)/2).truncate()] + temp[(temp.length/2).truncate()])/2.0;
  }


  int maximum() {
    return data.reduce(max);
  }

  int minimum() {
    return data.reduce(min);
  }



}

