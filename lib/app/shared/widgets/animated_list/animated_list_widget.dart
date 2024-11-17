// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'animated_list_store.dart';

enum ListType {
  LIST,
  GRID,
  LISTNOTREBUILD,
}

class AnimatedListModel {
  String searchName;
  Widget widget;
  AnimatedListModel({
    required this.searchName,
    required this.widget,
  });
}

class AnimatedListWidget extends StatefulWidget {
  final ScrollController? controller;
  final Axis scrollDirection;
  final ListType listType;
  final List<AnimatedListModel> childs;
  final List<Widget> action;
  final int crossAxisCount;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final bool withSearch;
  final double childAspectRatio;
  const AnimatedListWidget({
    super.key,
    this.controller,
    required this.listType,
    required this.childs,
    this.scrollDirection = Axis.vertical,
    this.action = const [],
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.crossAxisCount = 3,
    this.withSearch = false,
    this.childAspectRatio = 1.0,
  });

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  AnimatedListStore store = AnimatedListStore();
  @override
  void initState() {
    store.initData(widget.childs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store.initData(widget.childs);
    return Column(
      children: [
        if (widget.withSearch)
          Row(
            children: [
              Flexible(
                child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withAlpha(178),
                    ),
                    labelText: "Pesquisar",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    store.filter = value;
                    store.setFilter();
                  },
                ),
              ),
              if (widget.action.isNotEmpty) ...[
                const SizedBox(
                  width: 15,
                ),
                ...widget.action,
                const SizedBox(
                  width: 15,
                )
              ]
            ],
          ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: Observer(
          builder: (context) => listWidget(store.filteredChilds),
        )),
      ],
    );
  }

  Widget listWidget(List<AnimatedListModel> childs) {
    if (widget.listType == ListType.LISTNOTREBUILD) {
      return AnimationLimiter(
        child: SingleChildScrollView(
          controller: widget.controller,
          scrollDirection: widget.scrollDirection,
          child: Padding(
            padding: widget.padding,
            child: Column(
              children: [
                ...List.generate(
                  childs.length,
                  (index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: ScaleAnimation(
                      child: childs[index].widget,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    if (widget.listType == ListType.LIST) {
      return AnimationLimiter(
        child: ListView.separated(
          scrollDirection: widget.scrollDirection,
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          controller: widget.controller,
          padding: widget.padding,
          primary: widget.shrinkWrap ? false : null,
          shrinkWrap: widget.shrinkWrap,
          itemCount: childs.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: ScaleAnimation(
              child: childs[index].widget,
            ),
          ),
        ),
      );
    }
    return AnimationLimiter(
      child: GridView.builder(
        padding: widget.padding,
        shrinkWrap: widget.shrinkWrap,
        primary: widget.shrinkWrap ? false : null,
        controller: widget.controller,
        itemCount: childs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: widget.childAspectRatio,
        ),
        itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 375),
          columnCount: 3,
          child: ScaleAnimation(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: childs[index].widget,
            ),
          ),
        ),
      ),
    );
  }
}
