import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pages = [];
  final PageController _controller = PageController(initialPage: 0);
  double? _currentPage = 0;

  @override
  void initState() {
    _pages = [
      Container(
        color: Colors.green,
        child: const Center(
          child: Icon(
            Icons.account_circle,
            size: 128.0,
          ),
        ),
      ),
      Container(
        color: Colors.blue,
        child: const Center(
          child: Icon(
            Icons.security,
            size: 128.0,
          ),
        ),
      ),
      Container(
        color: Colors.brown,
        child: const Center(
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
                child: SizedBox.square(
                  dimension: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: _pageBuilder,
                    scrollDirection: Axis.vertical,
                    controller: _controller,
                    itemCount: _pages.length,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _pageBuilder(context, index) {
    if (_currentPage!.floor() + 1 == index) {
      return Transform.rotate(
        child: Container(
          child: _pages[index],
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2.0),
          ),
        ),
        angle: pi * (_currentPage! - index),
        alignment: Alignment.topRight,
      );
    } else if (_currentPage!.floor() == index) {
      return Transform.rotate(
        child: Container(
          child: _pages[index],
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2.0),
          ),
        ),
        angle: pi * (_currentPage! - index),
        alignment: Alignment.bottomRight,
      );
    } else {
      return Transform.rotate(
        angle: pi * (_currentPage! - index),
        alignment: Alignment.topRight,
        child: Container(
          child: _pages[index],
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2.0),
          ),
        ),
      );
    }
  }
}
