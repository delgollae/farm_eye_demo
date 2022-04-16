import 'package:farm_eye_app/assets.dart';
import 'package:farm_eye_app/constants.dart';
import 'package:farm_eye_app/models/home_icon.dart';
import 'package:farm_eye_app/pages/home/home_widgets/service_grid_item.dart';
import 'package:farm_eye_app/pages/widgets/app_page_container.dart';
import 'package:farm_eye_app/styles/app_color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeIcon> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataList = [
      HomeIcon(name: 'Select Farm', icon: placeholder, id: 1),
      HomeIcon(name: 'Start Soil Sampling', icon: sample, id: 2),
      HomeIcon(name: 'Dispatches &\nWork Orders', icon: note, id: 3),
      HomeIcon(name: 'Advance Settings', icon: settings, id: 4)
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppPageContainer(
        appBarHeight: 100,
        showHeaderIcon: false,
        enableDrawer: true,
        appBarIcon: Icons.house_rounded,
        body: SingleChildScrollView(
            child: Stack(children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Colors.white),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Mr. Donald Trump',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Former President',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: (screen.width / screen.height) * 1.8,
                      crossAxisSpacing: UI.PADDING,
                      mainAxisSpacing: UI.PADDING,
                      children: dataList.map((c) {
                        return ServiceGridItem(
                          icon: c.icon??"",
                          title: c.name??"",
                          color: Colors.black,
                          id: c.id.toString(),
                          item: c,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ])));
  }
}
