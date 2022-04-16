// This widget will draw header section of all page. Wich you will get with the project source code.

import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final bool? showIcon;
  final IconData? icon;

  const HeaderWidget({this.height, this.showIcon, this.icon, Key? key}) : super(key: key);

  // @override
  // _HeaderWidgetState createState() => _HeaderWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(height??250);
// }
//
// class _HeaderWidgetState extends State<HeaderWidget> {
  // double _height;
  // bool _showIcon;
  // IconData _icon;

  // _HeaderWidgetState(this._height, this._showIcon, this._icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return PreferredSize(
      preferredSize: Size.fromHeight(height??250),
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration:  BoxDecoration(
                gradient:  LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper:  ShapeClipper(
                [
                  Offset(width / 5, height??250),
                  Offset(width / 10 * 5, height??250 - 60),
                  Offset(width / 5 * 4, height??250 + 20),
                  Offset(width, height??250 - 18)
                ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration:  BoxDecoration(
                gradient:  LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper:  ShapeClipper(
                [
                  Offset(width / 3, height??250 + 20),
                  Offset(width / 10 * 8, height??250 - 60),
                  Offset(width / 5 * 4, height??250 - 60),
                  Offset(width, height??250 - 20)
                ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration:  BoxDecoration(
                gradient:  LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context). colorScheme.secondary,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper:  ShapeClipper(
                [
                  Offset(width / 5, height??250),
                  Offset(width / 2, height??250 - 40),
                  Offset(width / 5 * 4, height??250 - 80),
                  Offset(width, height??250 - 20)
                ]
            ),
          ),
          Visibility(
            visible: showIcon??false,
            child: SizedBox(
              height: height??250 - 40,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    top: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height-20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
