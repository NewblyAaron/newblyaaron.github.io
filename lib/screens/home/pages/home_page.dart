import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.8,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Welcome to my GitHub Page!"),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      color: getRandomColor(),
                      height: 150,
                    ),
                childCount: 10))
      ],
    );
  }

  getRandomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
