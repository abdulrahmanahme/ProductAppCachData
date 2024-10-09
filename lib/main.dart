
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/networking/dio_helper.dart';
import 'package:product_app/core/service_locator/service_locator.dart';
import 'package:product_app/feature/home/view/home_screen.dart';
import 'package:product_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initializeCache();

ServiceLocator.setup();
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Product App',
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'inter'),
          home: child,
        );
      },
      child: HomeScreen(),
    );
  }
}
