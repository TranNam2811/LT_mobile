import "dart:io";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/services.dart";
import "package:meals/widgets/home.dart";
import "package:meals/widgets/home_nav_bar.dart";
import "widgets/login.dart";
import "widgets/register.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ?
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCi93_bv6i9IO-OOMASpgGfBecQ5ZrDZjk',  // current_key
          appId: '1:1074998058341:android:3b22a72aaa0ff22bccd58c',  // mobilesdk_app_id
          messagingSenderId: '1074998058341',  // project_number
          projectId: 'meal-7e551'  // project_id
      )
  ) : await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/": (context) => HomeNavBar(),
         // "/search": (context) => MySearch(),
        "/register": (context) => MyRegister(),
        //  "/login": (context) => MyLogin(),
        //"/content": (context) => MyContent(),vod
      },
    );
  }
}

