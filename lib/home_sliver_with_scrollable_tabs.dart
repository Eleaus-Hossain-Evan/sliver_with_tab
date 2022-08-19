import 'package:flutter/material.dart';
import 'package:sliver_with_tab/controller.dart/controller.dart';

import 'widgets/widgets.dart';

class HomeSliverWithTab extends StatefulWidget {
  HomeSliverWithTab({Key? key}) : super(key: key);

  @override
  _HomeSliverWithTabState createState() => _HomeSliverWithTabState();
}

class _HomeSliverWithTabState extends State<HomeSliverWithTab> {
  final controller = SliverScrollController();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Scrollbar(
          radius: const Radius.circular(8),
          notificationPredicate: (scroll) {
            controller.valueScroll.value = scroll.metrics.extentInside;
            return true;
          },
          child: ValueListenableBuilder(
            valueListenable: controller.globalOffsetValue,
            builder: (_, double valueCurrentScroll, __) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: controller.scrollControllerGlobally,
                slivers: [
                  _FlexileSpaceBarHeader(
                    valueScroll: valueCurrentScroll,
                    controller: controller,
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderSliver(controller),
                  ),
                  for (var i = 0; i < controller.listCategory.length; i++) ...[
                    SliverPersistentHeader(
                      delegate: MyHeaderTitle(
                        controller.listCategory[i].category,
                        (visible) => controller.refreshHeader(
                          i,
                          visible,
                          lastIndex: i > 0 ? i - 1 : null,
                        ),
                      ),
                    ),
                    SliverBodyItems(
                      listItem: controller.listCategory[i].products,
                    )
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

const _maxHeaderExtent = 100.0;

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  _HeaderSliver(this.controller);
  final SliverScrollController controller;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    if (percent > 0.1) {
      controller.visibleHeader.value = true;
    } else {
      controller.visibleHeader.value = false;
    }
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: _maxHeaderExtent,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      AnimatedOpacity(
                        opacity: percent > 0.1 ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        child: const Icon(Icons.arrow_back),
                      ),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: Offset(percent < .01 ? -0.18 : 0.1, 0),
                        child: const Text(
                          'Kavsoft Bakery',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: percent > 0.1
                        ? ListItemHeaderSliver(controller: controller)
                        : const SliverHeaderData(),
                  ),
                ),
                // SizedBox(height: 10),
              ],
            ),
          ),
        ),
        if (percent > 0.1)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: percent > 0.1
                  ? Container(
                      height: 0.5,
                      color: Colors.white10,
                    )
                  : null,
            ),
          )
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _FlexileSpaceBarHeader extends StatelessWidget {
  const _FlexileSpaceBarHeader({
    Key? key,
    required this.valueScroll,
    required this.controller,
  }) : super(key: key);

  final double valueScroll;
  final SliverScrollController controller;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      stretch: true,
      expandedHeight: 250,
      collapsedHeight: 0,
      toolbarHeight: 0,
      pinned: valueScroll < 90 ? true : false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            const BackgroundSliver(),
            Positioned(
              right: 10,
              top: (sizeHeight + 0) - controller.valueScroll.value,
              child: const Icon(
                Icons.favorite,
                size: 30,
              ),
            ),
            Positioned(
              left: 10,
              top: (sizeHeight + 0) - controller.valueScroll.value,
              child: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
