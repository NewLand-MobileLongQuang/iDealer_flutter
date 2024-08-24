import 'package:flutter/material.dart';
import 'package:idealer/10_app_commons/custom/expanded_section/expanded_section.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';

class PivotColumnSelection extends StatefulWidget {
  const PivotColumnSelection({
    Key? key,
    required this.inputItems,
    required this.onItemSelected,
  }) : super(key: key);

  final List<String> inputItems;
  final Function(List<String> selectedItems) onItemSelected;

  static const double contentHeight = 150;
  static const Color fillColor = Color(0xffc0d1df);

  @override
  State<PivotColumnSelection> createState() => _PivotColumnSelectionState();
}

class _PivotColumnSelectionState extends State<PivotColumnSelection> {
  bool expanded = false;

  late List<String> leftItems;
  late List<String> rightItems;

  @override
  void initState() {
    leftItems = widget.inputItems.toList();
    rightItems = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: false,
      child: Container(
        child: Column(
          children: [
            Container(
              color: PivotColumnSelection.fillColor,
              height: 40,
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    "Xem báo cáo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      icon: Icon(expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up)),
                ],
              ),
            ),
            ExpandedSection(
              expand: expanded,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: PivotColumnSelection.contentHeight,
                      child: DragTarget<DragItem>(
                        builder: (context, candidateItems, rejectedItems) {
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: LongPressDraggable<DragItem>(
                                        data: DragItem(index, isLeft: true),
                                        feedback: Material(
                                          child: ItemWidget(
                                            text: leftItems[index],
                                            isDrag: true,
                                          ),
                                        ),
                                        child: ItemWidget(
                                          text: leftItems[index],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: leftItems.length);
                        },
                        onWillAccept: (dragItem) {
                          return dragItem?.isLeft == false;
                        },
                        onAccept: (acceptItem) {
                          String item = rightItems[acceptItem.index];
                          rightItems.removeAt(acceptItem.index);
                          leftItems.add(item);
                          leftItems = reOrder(leftItems);
                          rightItems = reOrder(rightItems);
                          widget.onItemSelected(rightItems);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: PivotColumnSelection.contentHeight,
                    width: 3,
                    color: PivotColumnSelection.fillColor,
                  ),
                  Expanded(
                    child: Container(
                      height: PivotColumnSelection.contentHeight,
                      child: DragTarget<DragItem>(
                        builder: (context, candidateItems, rejectedItems) {
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: LongPressDraggable<DragItem>(
                                        data: DragItem(index, isLeft: false),
                                        feedback: Material(
                                          child: ItemWidget(
                                            text: rightItems[index],
                                            isDrag: true,
                                          ),
                                        ),
                                        child: ItemWidget(
                                          text: rightItems[index],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: rightItems.length);
                        },
                        onWillAccept: (dragItem) {
                          if (dragItem?.isLeft != true) return false;
                          if (rightItems.length >= 4) {
                            MainGet.showToast(
                                "Chỉ tổng hợp tối đa 4 trường. Hãy chọn những trường cần thiết !");
                            return false;
                          }
                          return true;
                        },
                        onAccept: (acceptItem) {
                          String item = leftItems[acceptItem.index];
                          leftItems.removeAt(acceptItem.index);
                          rightItems.add(item);
                          leftItems = reOrder(leftItems);
                          rightItems = reOrder(rightItems);
                          widget.onItemSelected(rightItems);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> reOrder(List<String> items) {
    List<String> orderedItems = [];
    for (var element in widget.inputItems) {
      if (items.contains(element)) {
        orderedItems.add(element);
      }
    }
    return orderedItems;
  }
}

class DragItem {
  bool isLeft;
  int index;

  DragItem(this.index, {required this.isLeft});
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.text,
    this.isDrag = false,
  }) : super(key: key);

  final bool isDrag;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDrag ? 8 : 4),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(text),
    );
  }
}
