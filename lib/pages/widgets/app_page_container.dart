import 'package:farm_eye_app/pages/home/home_widgets/app_drawer.dart';
import 'package:farm_eye_app/pages/widgets/header_widget.dart';
import 'package:farm_eye_app/utils/size_calculator.dart';
import 'package:flutter/material.dart';

class AppPageContainer extends StatelessWidget {
  final String? title;
  final Widget? body;
  final Widget? bottomWidget;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final double? appBarHeight;
  final bool? showHeaderIcon;
  final PreferredSizeWidget? appBarWidget;
  final IconData? appBarIcon;
  final bool enableDrawer;

  const AppPageContainer(
      {Key? key,
      this.title,
      this.bottomWidget,
      this.body,
      this.floatingActionButton,
      this.appBarHeight,
      this.appBarWidget,
      this.showHeaderIcon,
      this.appBarIcon,
      this.enableDrawer = false,
      this.showAppBar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtils.mqData = MediaQuery.of(context);
    ScreenUtils.screenSize = MediaQuery.of(context).size;
    // double _headerHeight = ScreenUtils.size!.height * 0.08;
    return SafeArea(
        child: Scaffold(
      appBar: showAppBar
          ? appBarWidget??HeaderWidget(
              height: appBarHeight,
              showIcon: showHeaderIcon,
              icon: appBarIcon,
            )
          : null,
      endDrawer: enableDrawer
          ? AppDrawer(
              onLogOut: () {},
            )
          : null,
      body: body ?? Container(),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ));
  }
}
