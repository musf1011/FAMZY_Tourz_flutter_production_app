// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/data/models/destination_model.dart';
import 'package:flutter/material.dart';

class DestinationsProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<DestinationModel> _destinations = const [
    DestinationModel(
      id: 'swat',
      name: 'Swat',
      image: 'asset/images/River_Swat.jpg',
      shortHighlight: 'Lush valleys • Rivers • Culture',
      description:
          'Swat, often called the "Switzerland of the East", is famous for its '
          'green valleys, crystal-clear rivers, and rich cultural heritage. '
          'It offers breathtaking scenery, historic sites, and peaceful weather.',
      latitude: 35.2227,
      longitude: 72.4258,
    ),
    DestinationModel(
      id: 'naran',
      name: 'Naran',
      image: 'asset/images/met1.jpeg',
      shortHighlight: 'Alpine meadows • Lake Saif-ul-Malook',
      description:
          'Naran is a scenic town in Kaghan Valley, renowned for its alpine lakes, '
          'cool climate, and stunning mountain landscapes. A perfect summer escape.',
      latitude: 34.9093,
      longitude: 73.6507,
    ),
    DestinationModel(
      id: 'kaghan',
      name: 'Kaghan',
      image: 'asset/images/met2.jpeg',
      shortHighlight: 'Trekking • Flora • Mountain views',
      description:
          'Kaghan Valley offers breathtaking views, trekking routes, '
          'and vibrant flora and fauna, making it ideal for nature lovers.',
      latitude: 34.7794,
      longitude: 73.5270,
    ),
    DestinationModel(
      id: 'dir',
      name: 'Dir',
      image: 'asset/images/met3.jpeg',
      shortHighlight: 'Hidden gem • Forts • Trails',
      description:
          'Dir is a peaceful northern destination known for serene landscapes, '
          'historic forts, and untouched mountain trails.',
      latitude: 35.2012,
      longitude: 71.8755,
    ),
    DestinationModel(
      id: 'chitral',
      name: 'Chitral',
      image: 'asset/images/met4.jpeg',
      shortHighlight: 'Kalash Valley • Culture • Peaks',
      description:
          'Chitral is home to the unique Kalash culture, majestic peaks, '
          'and the famous Shandur Polo Festival.',
      latitude: 35.8540,
      longitude: 71.7866,
    ),
  ];

  List<DestinationModel> get destinations => _destinations;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
