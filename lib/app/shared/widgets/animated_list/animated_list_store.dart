import 'package:mobx/mobx.dart';

import 'animated_list_widget.dart';

part 'animated_list_store.g.dart';

// ignore: library_private_types_in_public_api
class AnimatedListStore = _AnimatedListStoreBase with _$AnimatedListStore;

abstract class _AnimatedListStoreBase with Store {
  List<AnimatedListModel> allChilds = [];
  ObservableList<AnimatedListModel> filteredChilds = ObservableList();

  @action
  void initData(List<AnimatedListModel> childs) {
    allChilds.clear();
    filteredChilds.clear();
    allChilds.addAll(childs);
    filteredChilds.addAll(childs);
    setFilter();
  }

  String filter = "";
  @action
  void setFilter() {
    filteredChilds.clear();
    filteredChilds.addAll(
      allChilds.where(
        (element) => element.searchName.toLowerCase().trim().contains(
              filter.toLowerCase().trim(),
            ),
      ),
    );
  }
}
