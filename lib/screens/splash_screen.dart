import 'package:flutter/material.dart';

class SpalashScreen extends StatelessWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text("...Loading"),
      ),
    );
  }
}
