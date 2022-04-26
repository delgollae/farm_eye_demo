import 'package:flutter/material.dart';

class MapLocationDetailWidget extends StatelessWidget{
  final String? latitude;
  final String? longitude;

  const MapLocationDetailWidget({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Text(latitude??""),
          Text(longitude??"")
        ],
      ),
    );
  }

}