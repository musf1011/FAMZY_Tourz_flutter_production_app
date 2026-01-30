// // created by: FAMZY CodeWorks

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/desstinations_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WeatherCard extends StatelessWidget {
//   const WeatherCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DestinationsProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoadingWeather) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final weather = provider.weather;

//         if (weather == null) {
//           return const SizedBox.shrink();
//         }

//         final temp = weather['temperature'];
//         final wind = weather['windspeed'];
//         final code = weather['weathercode'];

//         return Card(
//           color: AppConstants.primaryTransGColor,
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//             side: const BorderSide(color: Colors.white),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 /// Left Side Info
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Current Weather",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "🌡 Temp: $temp°C",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       "💨 Wind: $wind km/h",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       "☁ Code: $code",
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                   ],
//                 ),

//                 /// Icon Side
//                 const Icon(Icons.cloud, color: Colors.white, size: 40),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/desstinations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherBlock extends StatelessWidget {
  const WeatherBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationsProvider>();
    final weather = provider.weather;

    if (provider.isLoadingWeather) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      );
    }

    if (weather == null) return const SizedBox();

    final now = DateTime.now();
    final formattedDate = DateFormat('MMM d, yyyy').format(now);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.primaryTransGColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white, width: .5.r),
      ),
      child: Column(
        // crossAxisAlignment: .center,
        children: [
          Text(
            'Local Weather',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            formattedDate,
            style: TextStyle(color: AppConstants.whiteColorP5, fontSize: 14.sp),
          ),
          Divider(color: Colors.white24, height: 20.h),
          _WeatherRow(
            icon: Icons.thermostat,
            value: '${weather['temp']} °C',
            label: 'Temperature',
          ),
          _WeatherRow(
            icon: Icons.air,
            value: '${weather['windspeed']} km/h',
            label: 'Wind Speed',
          ),
          // _WeatherRow(
          //   icon: Icons.explore,
          //   value: '${weather['winddirection']}°',
          //   label: 'Wind Direction',
          // ),
          // UV and Precipitation
          _WeatherRow(
            icon: Icons.wb_sunny_outlined,
            value: '${weather['uv_index']}',
            label: 'UV Index',
          ),
          _WeatherRow(
            icon: Icons.umbrella_outlined,
            value: '${weather['precipitation']} mm',
            label: 'Precipitation',
          ),
          // _WeatherRow(
          //   icon: Icons.calendar_today,
          //   value: formattedDate,
          //   label: 'Today',
          // ),
          // Sunrise and Sunset
          _WeatherRow(
            icon: Icons.wb_twilight,
            value: '${weather['sunrise']}',
            label: 'Sunrise',
          ),
          _WeatherRow(
            icon: Icons.nights_stay_outlined,
            value: '${weather['sunset']}',
            label: 'Sunset',
          ),
        ],
      ),
    );
  }
}

class _WeatherRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _WeatherRow({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.transRColor, size: 24.sp),
          SizedBox(width: 10.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppConstants.whiteColorP5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
