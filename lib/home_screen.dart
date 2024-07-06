import 'package:flutter/material.dart';
import 'package:picture_of_the_day/modules/apod/apod_home.dart';

import 'utils/theme_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Picture of the Day',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          const Icon(Icons.rocket_launch_outlined, color: foreGroundColor),
          SizedBox(
            width: horizontalPadding,
          ),
        ],
      ),
      body: ApodHome(),
    );
  }
}
