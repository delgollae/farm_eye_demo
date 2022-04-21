import 'package:equatable/equatable.dart';

class Promo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Promo({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
      ];

  static List<Promo> promos = [
    Promo(
      id: 1,
      title: 'Number Of Visits.',
      description:
          '20 Farms, 5 DAFM',
      imageUrl:
          'https://github.com/delgollae/farm_eye_demo/blob/develop/assets/images/banner_bg_01.png',
    ),
    Promo(
      id: 2,
      title: 'Travel For Day.',
      description: '105 KM',
      imageUrl:
          'https://github.com/delgollae/farm_eye_demo/blob/develop/assets/images/banner_bg_02.png',
    ),
    Promo(
      id: 3,
      title: 'Visit Start',
      description:
      '2022-04-19 07:00 AM',
      imageUrl:
      'https://github.com/delgollae/farm_eye_demo/blob/develop/assets/images/banner_bg_01.png',
    ),
    Promo(
      id: 4,
      title: 'Number Of Samples.',
      description:
      '25 Samples',
      imageUrl:
      'https://github.com/delgollae/farm_eye_demo/blob/develop/assets/images/banner_bg_02.png',
    )
  ];
}
