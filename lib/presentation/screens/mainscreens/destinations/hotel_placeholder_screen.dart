// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';

class HotelPlaceholderScreen extends StatelessWidget {
  const HotelPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final destination = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Center(
        child: Text(
          // 'Hotels in $destination\nComing Soon ✈️',
          'Hotels in this destination\nComing Soon ✈️',
          textAlign: TextAlign.center,
          style: AppConstants.screenTitleTextStyle,
        ),
      ),
    );
  }
}
