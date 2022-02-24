import 'package:flutter/material.dart';

import 'ripple_page_route.dart';
import 'second_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        brightness: Brightness.dark,
      ),
      home: SafeArea(
        child: Builder(
          builder: (context) {
            return Stack(
              children: [
                Scaffold(
                  body: const Center(
                    child: Text(
                      'First Page',
                      style: TextStyle(
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton(
                    key: _fabKey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RipplePageRoute(
                          page: const SecondPage(),
                          anchor: _fabKey,
                        ),
                      );
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
