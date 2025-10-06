// ignore_for_file: file_names

import 'dart:convert';

import 'package:european_single_marriage/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static Rx<UserModel> userData = UserModel().obs;

  static Future<void> storeLocalUser(
    String key,
    Map<String, dynamic> data,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(data);
    await prefs.setString(key, jsonString);
    userData.value = UserModel.fromJson(data);
  }

  static Future<void> getLocalUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      Map<String, dynamic> data = json.decode(jsonString);
      userData.value = UserModel.fromJson(data);
    }
  }

  static Future<bool> hasLocalUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<dynamic> setUserID(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    return true;
  }

  static Future<dynamic> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userId') != null) {
      return prefs.getString('userId');
    } else {
      return false;
    }
  }

  static Future<dynamic> set(name, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('$name', value);
    return true;
  }

  static Future<String?> get(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  static Future<void> clearSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> removeLocalUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    userData.value = UserModel();
  }
}
