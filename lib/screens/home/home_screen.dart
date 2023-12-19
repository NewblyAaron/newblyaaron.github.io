import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildHeader(context),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        color: getRandomColor(),
                        height: 150,
                      ),
                  childCount: 20))
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height,
      flexibleSpace: buildHeaderSpace(),
    );
  }

  LayoutBuilder buildHeaderSpace() {
    return LayoutBuilder(
      builder: (context, constraints) {
        var top = constraints.biggest.height;

        bool isCollapsed() =>
            top == MediaQuery.of(context).padding.top + kToolbarHeight;

        bool mobileWidth() => constraints.maxWidth < 1000;

        return FlexibleSpaceBar(
          title: isCollapsed()
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile_picture.jpg"),
                        ),
                      ],
                    ),
                  ],
                )
              : null,
          titlePadding: EdgeInsets.zero,
          centerTitle: true,
          background: Container(
            color: Theme.of(context).primaryColor,
            child: Stack(children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(),
                child: mobileWidth()
                    ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage("assets/images/profile_picture.jpg"),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Aaron M. Serrano",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFAE296)),
                          ),
                          Text(
                            "BS Information Technology",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFFAE296)),
                          ),
                        ],
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 200,
                            backgroundImage:
                                AssetImage("assets/images/profile_picture.jpg"),
                          ),
                          SizedBox(width: 32),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aaron M. Serrano",
                                style: TextStyle(
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFAE296)),
                              ),
                              Text(
                                "BS Information Technology",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFFFAE296)),
                              ),
                            ],
                          )
                        ],
                      ),
              )
            ]),
          ),
        );
      },
    );
  }

  getRandomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
