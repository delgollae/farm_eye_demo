import 'package:farm_eye_app/constants.dart';
import 'package:farm_eye_app/routes.dart';
import 'package:farm_eye_app/utils/size_calculator.dart';
import 'package:flutter/material.dart';

class ServiceGridItem extends StatelessWidget {
  const ServiceGridItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    this.id,
    this.onTap,
    this.item,
  }) : super(key: key);

  final String? id;
  final String title;
  final String icon;
  final Color color;
  final VoidCallback? onTap;
  final item;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          _onServiceTap(context, this);
        }
      },
      child:
      // Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     AspectRatio(
      //       aspectRatio: 1,
      //       child:
      InkWell(
        // borderRadius: BorderRadius.circular(UI.BORDER_RADIUS * 2),
        highlightColor: color,
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else {
            _onServiceTap(context, this);
          }
        },
        child: Card(
          child: Container(
            // padding: EdgeInsets.all(screen.width * 0.05),
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: AppColors.greyF5.withOpacity(0.29), //color of shadow
              //     spreadRadius: 3, //spread radius
              //     blurRadius: 6, // blur radius
              //     offset: Offset(0, 2), // changes position of shadow
              //   )
              // ],
              // color: AppColors.greyF5,
              borderRadius: BorderRadius.circular(UI.BORDER_RADIUS * 2),
              // border: Border.all(
              //   color: AppColors.black.withOpacity(0.2),
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  height: getCalculatedWidth(context, 50),
                  width: getCalculatedWidth(context, 50),
                ),
                const SizedBox(
                  height: UI.PADDING,
                ),
                Text(
                  title,
                  // style: TextStyles.greyTextStyle10pt,
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  softWrap: false,
                ),
              ],
            ),
            // child: CachedNetworkImage(
            //   imageUrl: ApiConstants.resourceUrl + icon,
            //   fit: BoxFit.fitHeight,
            //   placeholder: (context, url) => CenterLoader(),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // ),
          ),
        ),
      ),
      //   ),
      //
      // ],
      // ),
    );
  }

  void _onServiceTap(BuildContext context, ServiceGridItem thisItem) {
    switch (thisItem.id) {
      case "1":
        Navigator.pushNamed(context, ScreenRoutes.toFarmEyeMapPage);
        break;
      case "2":
        // Navigator.pushNamed(context, ScreenRoutes.toCardListScreen);
        break;
      case "3":
        // Navigator.pushNamed(context, ScreenRoutes.toCardPaymentScreen);
        break;
      case "4":
        // Navigator.pushNamed(context, ScreenRoutes.toBankTransferScreen);
        break;
    }
    // pushScreen(
    //   context,
    //   ScreenRoutes.toBillerCategoryScreen,
    //   arguments: {'item': thisItem},
    // );
  }
}