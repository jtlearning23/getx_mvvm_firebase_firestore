import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_firebase_learning/router/router.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase for both Web and Mobile platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB-su8DQzoxZFg1Uyp72XInbS0CocUkLCc",
          authDomain: "getx-mvvm-firebase.firebaseapp.com",
          projectId: "getx-mvvm-firebase",
          storageBucket: "getx-mvvm-firebase.appspot.com",
          messagingSenderId: "153003713679",
          appId: "1:153003713679:web:0f39526922e3be87e43cfa",
          measurementId: "G-H6N3F4NWBE"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.MOVIE_LIST_SCREEN,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
