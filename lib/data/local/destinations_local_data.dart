import '../models/destination_model.dart';

class DestinationsLocalData {
  static const List<DestinationModel> destinations = [
    DestinationModel(
      name: 'SWAT',
      image: 'assets/images/destinations/swat.jpg',
      shortDescription: 'Lush valleys • Rivers • Culture',
      fullDescription:
          'Swat, often called the "Switzerland of the East", is famous for its '
          'green valleys, crystal-clear rivers, and rich cultural heritage. '
          'It offers breathtaking scenery, historic Buddhist sites, and a '
          'remarkably peaceful atmosphere. Visitors can explore the majestic '
          'Malam Jabba ski resort or the emerald waters of Mahodand Lake.',
      latitude: 35.2227,
      longitude: 72.4258,
    ),
    DestinationModel(
      name: 'NARAN',
      image: 'assets/images/destinations/naran.jpeg',
      shortDescription: 'Alpine meadows • Lake Saif-ul-Malook',
      fullDescription:
          'Naran is a scenic town in Kaghan Valley, renowned for its alpine lakes, '
          'cool climate, and stunning mountain landscapes. It serves as a perfect '
          'summer escape for families looking to explore the legendary beauty of '
          'Lake Saif-ul-Malook. The bustling local bazaar and trout-filled Kunhar '
          'River add a unique charm to this vibrant mountain hub.',
      latitude: 34.9093,
      longitude: 73.6507,
    ),
    DestinationModel(
      name: 'KAGHAN',
      image: 'assets/images/destinations/kaghan.jpeg',
      shortDescription: 'Trekking • Flora • Mountain views',
      fullDescription:
          'Kaghan Valley offers breathtaking views, extensive trekking routes, '
          'and vibrant flora and fauna, making it ideal for nature lovers. '
          'The valley is a gateway to pristine peaks and deep forest trails '
          'waiting to be discovered. Its dramatic landscapes change with every '
          'turn, offering a deep sense of serenity and adventure.',
      latitude: 34.7794,
      longitude: 73.5270,
    ),
    DestinationModel(
      name: 'DIR',
      image: 'assets/images/destinations/dir.jpeg',
      shortDescription: 'Hidden gem • Forts • Trails',
      fullDescription:
          'Dir is a peaceful northern destination known for serene landscapes, '
          'historic forts, and untouched mountain trails. This hidden gem '
          'provides a unique blend of historical mystery and rugged, '
          'natural beauty for the adventurous soul. It remains one of the few '
          'places where travelers can experience authentic mountain life in its '
          'purest, most undisturbed form.',
      latitude: 35.2012,
      longitude: 71.8755,
    ),
    DestinationModel(
      name: 'CHITRAL',
      image: 'assets/images/destinations/chitral.jpeg',
      shortDescription: 'Kalash Valley • Culture • Peaks',
      fullDescription:
          'Chitral is home to the unique Kalash culture, majestic mountain peaks, '
          'and the world-famous Shandur Polo Festival. It is a land where ancient '
          'traditions meet the awe-inspiring heights of the Hindukush range. '
          'From the shadows of Tirich Mir to the vibrant festivals of the '
          'Kalash people, every corner tells a story of heritage and resilience.',
      latitude: 35.8540,
      longitude: 71.7866,
    ),
  ];
}
