import 'package:flutter/material.dart';

const headerTitle = 80.0;
typedef OnHeaderChange = void Function(bool visible);

class MyHeaderTitle extends SliverPersistentHeaderDelegate {
  const MyHeaderTitle(this.title, this.onHeaderChange);

  final String title;
  final OnHeaderChange onHeaderChange;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChange(true);
    } else {
      onHeaderChange(false);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => headerTitle;

  @override
  // TODO: implement minExtent
  double get minExtent => headerTitle;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
