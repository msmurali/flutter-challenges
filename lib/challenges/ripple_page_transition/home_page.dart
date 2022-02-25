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
  final GlobalKey _btnKey = GlobalKey();

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
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'First Page',
                          style: TextStyle(
                            fontSize: 32.0,
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        ElevatedButton(
                          key: _btnKey,
                          child: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              RipplePageRoute(
                                anchor: _btnKey,
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return const SecondPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
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
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return const SecondPage();
                          },
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
