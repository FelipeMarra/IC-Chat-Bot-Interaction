import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(
          context,
          "/chat",
        ),
        child: const Text("Prox pag"),
      ),
    );
  }
}
