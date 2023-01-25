import 'package:campo_minado/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  // final String bombTest;

  const Teste({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste'),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ));
            },
            child: Text('Enter')),
      ),
    );
  }
}
