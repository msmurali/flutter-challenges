import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  double _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPageValue = _controller.page ?? 0.0;
      });
    });
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
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
