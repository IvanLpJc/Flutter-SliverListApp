import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliverListPage extends StatelessWidget {
  static const route = 'sliver';
  const SliverListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => _ScrollProvider(),
          child: Stack(
            children: const [
              _MainScroll(),
              Positioned(bottom: -10, right: 0, child: _NewListButton()),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainScroll extends StatefulWidget {
  const _MainScroll();

  @override
  State<_MainScroll> createState() => _MainScrollState();
}

class _MainScrollState extends State<_MainScroll> {
  final ScrollController scrollController = ScrollController();
  double previousScroll = 0;

  final items = [
    const _ListItem('Orange', Color(0xffF08F66)),
    const _ListItem('Family', Color(0xffF2A38A)),
    const _ListItem('Subscriptions', Color(0xffF7CDD5)),
    const _ListItem('Books', Color(0xffFCEBAF)),
    const _ListItem('Orange', Color(0xffF08F66)),
    const _ListItem('Family', Color(0xffF2A38A)),
    const _ListItem('Subscriptions', Color(0xffF7CDD5)),
    const _ListItem('Books', Color(0xffFCEBAF)),
  ];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > previousScroll) {
        Provider.of<_ScrollProvider>(context, listen: false).showButton = false;
      } else {
        Provider.of<_ScrollProvider>(context, listen: false).showButton = true;
      }

      previousScroll = scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPersistentHeader(
            floating: true,
            delegate: _SliverCustomHeaderDelegate(
                maxHeight: 200,
                minHeight: 170,
                child: Container(color: Colors.white, child: const _Title()))),
        SliverList(
          delegate:
              SliverChildListDelegate([...items, const SizedBox(height: 100)]),
        ),
      ],
    );
  }
}

class _NewListButton extends StatelessWidget {
  const _NewListButton();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final showButton = Provider.of<_ScrollProvider>(context)._showButton;
    return AnimatedOpacity(
      opacity: showButton ? 1 : 0,
      duration: const Duration(milliseconds: 350),
      child: ButtonTheme(
        minWidth: width * 0.9,
        height: 80,
        child: MaterialButton(
          color: const Color(0xffED6762),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          onPressed: () {},
          child: const Text(
            'CREATE NEW LIST',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 3),
          ),
        ),
      ),
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight < minHeight ? minHeight : maxHeight;

  @override
  double get minExtent => maxHeight > minHeight ? minHeight : maxHeight;

  @override
  bool shouldRebuild(covariant _SliverCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: const Text(
            'New',
            style: TextStyle(color: Color(0xff532128), fontSize: 50),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              const SizedBox(
                width: 100,
              ),
              Positioned(
                bottom: 8,
                child: Container(
                  width: 150,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xffF7CDD5),
                  ),
                ),
              ),
              const Text(
                'List',
                style: TextStyle(
                    color: Color(0xffD93A30),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final Color color;

  const _ListItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10.0),
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class _ScrollProvider extends ChangeNotifier {
  bool _showButton = true;

  bool get showButton => _showButton;

  set showButton(bool value) {
    _showButton = value;
    notifyListeners();
  }
}
