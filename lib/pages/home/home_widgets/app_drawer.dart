import 'package:farm_eye_app/constants.dart';
import 'package:farm_eye_app/pages/home/home_widgets/drawer_item.dart';
import 'package:farm_eye_app/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
    @required this.onLogOut,
  }) : super(key: key);

  final VoidCallback? onLogOut;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String appVersion = "";
  List<DrawerItem> _tilesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tilesList= [DrawerItem(
        title: "Location", prefix: Icon(Icons.my_location), onTap: () {}),
        DrawerItem(
            title: "Email", prefix: Icon(Icons.email), onTap: () {}),
        DrawerItem(
            title: "Phone}", prefix: Icon(Icons.phone), onTap: () {})];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Container(
      decoration:BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).accentColor.withOpacity(0.5),
              ]
          )
      ) ,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
              ),
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text("Farm Eye Map",
                style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _tilesList
                .map((_item) =>
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: UI.PADDING_2X),
                  // padding: EdgeInsets.symmetric(vertical: UI.PADDING),
                  child: ListTile(
                    trailing: _item.prefix,
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _item.title,
                        style: Theme.of(context).textTheme.blackTextStyle14pt,
                      ),
                    ),
                    onTap: _item.onTap,
                  ),
                ))
                .toList(),
          ),
        ],
      ),
    ),);
  }
}
