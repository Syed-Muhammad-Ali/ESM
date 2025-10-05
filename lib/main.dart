import 'package:device_preview/device_preview.dart';
import 'package:european_single_marriage/core/utils/constant/app_keys.dart';
import 'package:european_single_marriage/core/utils/theme/app_theme.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/firebase_options.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:european_single_marriage/services/applife_cycle_services.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(FirebaseService());
  await AppStorage.getLocalUser(AppKeys.userData);
  final appLifecycleReactor = AppLifecycleReactor();
  WidgetsBinding.instance.addObserver(appLifecycleReactor);
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      theme: MAppTheme.myTheme,
    );
  }
}
