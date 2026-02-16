import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 200,
              itemBuilder: (context, index) {
                return const Text("Item ");
              },
            ),
          ),
        ],
      ),
    );
  }
}
