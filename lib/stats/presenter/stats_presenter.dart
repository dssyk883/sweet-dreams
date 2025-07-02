import '../views/stats_view.dart';
import '../viewmodel/stats_viewmodel.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../api.dart';
import 'dart:convert';
import 'dart:developer';

var recentDetail= [];

class StatsPresenter {
  void onButtonPressed() {}
  set statsView(StatsView value){}
}

class BasicStatsPresenter implements StatsPresenter {
  StatsViewModel _viewModel = StatsViewModel();
  StatsView _view = StatsView();

  BasicStatsPresenter() {
    this._viewModel = _viewModel;
  }

  @override
  set statsView(StatsView value) {
    _view = value;
    this.loadDBdeets();
    // put a loading screen here
    _view.updateStats(recentDetail);
  }

  @override
  void onButtonPressed() {
    this.loadDBdeets();

    //_viewModel.testText = json.encode(recentDetail[2]);
    //_view.updateText(_viewModel.testText);
    print("there");

  }



  @override
  Future<List> loadDBdeets() async {
    final logger = Logger();	// Logging client
    final dio = Dio();	// Http client
    final client = RestClient(dio);	// Creating Http client to handle API requests

    Map<String, String> req = {"userID": "test1"};
    recentDetail = await client.getAllDetails(req);
    return recentDetail;

  }

}