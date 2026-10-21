import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: false,
            backgroundColor: AppColors.appBarBlack,
            automaticallyImplyLeading: false,
            flexibleSpace: ClipRect(
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // const CustomHomeAppBar(),
                  Column(children: [Text('Hi, GHasasn')]),
                  // Positioned(
                  //   bottom: -100,
                  //   left: 16,
                  //   right: 16.w,
                  //   child: Container(),
                  //   // child: const ProgressCard(progress: 0.7),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
