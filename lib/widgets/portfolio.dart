import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio')),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Portfolio')),
    );
  }
}