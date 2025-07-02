import '../views/test_view.dart';
import '../viewmodel/test_viewmodel.dart';
//import '../utils/test_constant.dart';
//import '../utils/test_utils.dart';

class TestPresenter {

  void onButtonPressed() {}
  set testView(TestView value){}
}

class BasicTestPresenter implements TestPresenter {
  TestViewModel _viewModel = TestViewModel();
  TestView _view = TestView();

  BasicTestPresenter() {
    this._viewModel = _viewModel;
    _loadUnit();
  }

  void _loadUnit() async {
    _view.updateText("*button has not been pressed*");
  }

  @override
  set testView(TestView value) {
    _view = value;
    _view.updateText("button has not been pressed");
  }

  @override
  void onButtonPressed() {
    _viewModel.testText = "button was pressed";
    _view.updateText(_viewModel.testText);
  }


}