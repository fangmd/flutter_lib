import 'base_vm.dart';
import 'view_state.dart';

/// 列表页面 BaseViewModel
abstract class BaseListVM<T> extends BaseVM {
  List<T> datas = [];
  int index = 1; // 从 1 开始

  // 加载数据
  @override
  loadData() {
    clearData();
  }

  clearData() {
    index = 1;
    datas.clear();
  }

  // 加载数据
  loadMore();

  void updateUI() {
    if (datas.length == 0) {
      showViewState(ViewState.NO_DATA);
    } else {
      showViewState(ViewState.Idle);
    }
  }
}
