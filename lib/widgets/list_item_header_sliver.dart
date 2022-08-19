import 'package:flutter/material.dart';
import 'package:sliver_with_tab/controller.dart/sliver_scroll_controller.dart';
import 'package:sliver_with_tab/models/my_header.dart';
import 'package:sliver_with_tab/widgets/get_box_offset.dart';

class ListItemHeaderSliver extends StatelessWidget {
  const ListItemHeaderSliver({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SliverScrollController controller;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemsOffsets = controller.listOffSetItemHeader;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) => true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            right: size.width -
                (itemsOffsets[itemsOffsets.length - 1] -
                    itemsOffsets[itemsOffsets.length - 2]),
          ),
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.scrollControllerItemHeader,
          scrollDirection: Axis.horizontal,
          child: ValueListenableBuilder(
            valueListenable: controller.headerNotifier,
            builder: (context, MyHeader? snapshot, __) {
              return Row(
                children: List.generate(
                  controller.listCategory.length,
                  (index) {
                    return GetBoxOffset(
                      offset: (offSet) {
                        return itemsOffsets[index] = offSet.dx;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: index == snapshot!.index ? Colors.white : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          controller.listCategory[index].category,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: index == snapshot.index
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
