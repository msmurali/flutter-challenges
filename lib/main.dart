import 'package:flutter/material.dart';

import 'challenges/ripple_page_transition/home_page.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
