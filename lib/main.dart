import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:farm_eye_app/routes.dart' as router;

import 'pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(LoginUiApp());
  });
}

class LoginUiApp extends StatelessWidget {
  // Color _primaryColor = HexColor('#2986CC');
  // Color _accentColor = HexColor('#8A02AE');

  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  Color _primaryColor= HexColor('#651BD2');
  Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: router.ScreenRoutes.toSplashPage,
      theme: ThemeData(
          primaryColor: _primaryColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
          primaryIconTheme:  const IconThemeData(color: Colors.white)),
      home: SplashScreen(title: 'Flutter Login UI'),
    );
  }
}
