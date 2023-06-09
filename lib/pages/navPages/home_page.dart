import 'package:flutter/material.dart';
import 'package:travel_app/colors.dart';
import 'package:travel_app/extensions/sized_box_extension.dart';
import 'package:travel_app/pages/navPages/my_page.dart';
import 'package:travel_app/widgets/app_large_text.dart';

import '../../widgets/explore_more_widgets.dart';
import '../../widgets/places_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // int categorieController = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TabController _controller =
        TabController(length: 3, vsync: this, initialIndex: 0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Spacing
          (size.height * 0.03).ph(),
          LargeText(text: "Discover"),
          (size.height * 0.03).ph(),

          ///Categories
          // Category Tabs
          SizedBox(
            width: size.width * .7,
            height: 30,
            child: TabBar(
              labelPadding: EdgeInsets.zero,
              labelColor: AppColors.bigTextColor,
              controller: _controller,
              labelStyle: TextStyle(
                color: AppColors.bigTextColor,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(),
              unselectedLabelColor: AppColors.textColor1,
              indicator:
                  CircleTabIndicator(color: AppColors.mainColor, radius: 3),
              tabs: const [
                Tab(
                  text: "Places",
                ),
                Tab(text: "Inspiration"),
                Tab(text: "Emotions"),
              ],
            ),
          ),
          //Category Tab Views
          SizedBox(
            width: double.infinity,
            height: size.height * 0.45,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: const [
                PlacesTabView(),
                MyPage(),
                Tab(text: "Hi 1"),
              ],
            ),
          ),
          // Spacing
          (size.height * 0.03).ph(), 
          // Explore more Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LargeText(
                text: "Explore More",
                size: 16,
                color: AppColors.textColor2,
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors.mainColor),
                ),
                onPressed: () => {},
                child: const Text("See All"),
              ),
            ],
          ),
          // Spacing
          (size.height * 0.03).ph(),
          // ListView of explore more items.
          SizedBox(
            height: size.height * 0.1,
            child: ExploreMoreItems(),
          ),
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CiclePainter(color: color, radius: radius);
  }
}

class _CiclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CiclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();

    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset _offset = Offset(
      offset.dx + configuration.size!.width / 2,
      configuration.size!.height,
    );
    canvas.drawCircle(_offset, radius, _paint);
  }
}
