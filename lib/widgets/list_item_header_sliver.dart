import 'package:flutter/material.dart';
import 'package:sliver_with_tab/controller.dart/sliver_scroll_controller.dart';

class ListItemHeaderSliver extends StatelessWidget {
  const ListItemHeaderSliver({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SliverScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(controller.listCategory.length, (index) {
            return Container(
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == 0 ? Colors.white : null,
                borderRadius: BorderRadius.circular(16),
              ),
              width: 100,
              child: Text(
                controller.listCategory[index].category,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: index == 0 ? Colors.black : Colors.white,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
