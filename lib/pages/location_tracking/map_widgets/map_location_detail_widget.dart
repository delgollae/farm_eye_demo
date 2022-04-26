import 'package:flutter/material.dart';

class MapLocationDetailWidet extends StatelessWidget{
  final String? latitude;
  final String? longitude;

  const MapLocationDetailWidet({Key? key, this.latitude, this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Text(latitude??""),
          Text(longitude??"")
        ],
      ),
    );
  }

}