import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppLifecycleReactor extends WidgetsBindingObserver {
  final FirebaseService firebaseService = Get.find<FirebaseService>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (state == AppLifecycleState.resumed) {
      await firebaseService.setUserStatus(user.uid, "online");
    } else {
      await firebaseService.setUserStatus(user.uid, "offline");
    }
  }
}
