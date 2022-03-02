import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  double? _currentPosition;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() => _currentPosition = _pageController.page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        brightness: Brightness.dark,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Builder(
            builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: PageViewPage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PageViewPage extends StatefulWidget {
  @override
  _PageViewPageState createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  List<Widget> _pages = [];
  final PageController _controller = PageController(initialPage: 0);
  double? _currentPage = 0;

  @override
  void initState() {
    _pages = [
      Container(
        color: Colors.grey[900],
        child: Center(
          child: Icon(
            Icons.account_circle,
            size: 128.0,
          ),
        ),
      ),
      Container(
        color: Colors.grey[900],
        child: Center(
          child: Icon(
            Icons.security,
            size: 128.0,
          ),
        ),
      ),
      Container(
        color: Colors.grey[900],
        child: Center(
          child: Icon(
            Icons.graphic_eq_sharp,
            size: 128.0,
          ),
        ),
      )
    ];

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Transform(
          transform: Matrix4.rotationZ(_currentPage! - index),
          child: _pages[index],
          origin: Offset(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width),
          alignment: Alignment.bottomRight,
        );
      },
      scrollDirection: Axis.vertical,
      controller: _controller,
      itemCount: _pages.length,
    );
  }
}
