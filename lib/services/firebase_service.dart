// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' hide Query;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  final _db = FirebaseFirestore.instance;
  final DatabaseReference db = FirebaseDatabase.instance.ref();
  final _storage = FirebaseStorage.instance;

  /// --- SignUp With Emial ---
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String? userId;
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userId = user.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Utils.snackBar(
          "Error",
          "Email already exists. Please try a different email.",
          AppColors.red,
        );
      } else {
        Utils.snackBar(
          "Error",
          e.message ?? "Something went wrong. Please try again!",
          AppColors.red,
        );
      }
    } catch (e) {
      Utils.snackBar(
        "Error",
        "Something went wrong. Please try again!",
        AppColors.red,
      );
    }
    return userId;
  }

  /// --- SignIn With Emial ---
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String? userId;

    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userId = user.user!.uid;
    } catch (e) {
      Utils.snackBar(
        "Error",
        'Something went wrong. Please Check your email and password',
        AppColors.red,
      );
    }
    return userId;
  }

  /// --- Name Taken ---
  Future<bool> isNameTaken(String name) async {
    final snapshot =
        await _db
            .collection(AppCollections.users)
            .where('name', isEqualTo: name)
            .get();

    return snapshot.docs.isNotEmpty;
  }

  /// --- Add FirbaseFireStore Data ---
  Future<void> addDataToFirestore({
    required Map<String, dynamic> data,
    required String collection,
    required String id,
  }) async {
    try {
      await _db.collection(collection).doc(id).set(data);
    } catch (e) {
      print(e.toString());
      Utils.snackBar(
        "Error",
        'Something went wrong. Please try again!',
        AppColors.red,
      );
    }
  }

  /// --- Update FirbaseFireStore Data ---
  Future<void> updateDataToFirestore({
    required Map<String, dynamic> data,
    required String collection,
    required String id,
  }) async {
    try {
      await _db.collection(collection).doc(id).update(data);
    } catch (e) {
      Utils.snackBar(
        "Error",
        'Something went wrong. Please try again!',
        AppColors.red,
      );
    }
  }

  /// --- Get FirbaseFireStore Data ---
  Future<T?> getDataFromFirestore<T>({
    required String collection,
    String? documentId,
    Map<String, dynamic>? where,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      if (documentId != null) {
        DocumentSnapshot docSnapshot =
            await _db.collection(collection).doc(documentId).get();
        if (docSnapshot.exists) {
          return fromJson(docSnapshot.data() as Map<String, dynamic>);
        } else {
          debugPrint("Document not found");
          return null;
        }
      } else {
        CollectionReference ref = _db.collection(collection);
        Query query = ref;
        if (where != null) {
          for (var entry in where.entries) {
            final key = entry.key;
            final value = entry.value;

            if (value is Map && value.containsKey("notEqual")) {
              query = query.where(key, isNotEqualTo: value["notEqual"]);
            } else if (value is Map && value.containsKey("greaterThan")) {
              query = query.where(key, isGreaterThan: value["greaterThan"]);
            } else if (value is Map && value.containsKey("lessThan")) {
              query = query.where(key, isLessThan: value["lessThan"]);
            } else {
              query = query.where(key, isEqualTo: value);
            }
          }
        }

        final querySnapshot = await query.get();
        if (querySnapshot.docs.isNotEmpty) {
          return fromJson(
            querySnapshot.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList(),
          );
        } else {
          debugPrint("No documents found");
          return null;
        }
      }
    } catch (e) {
      log("function error : $e");
      debugPrint("Error fetching data: $e");
      Utils.snackBar("Error", 'Failed to fetch data! $e', AppColors.red);
      return null;
    }
  }

  /// --- Delete FirbaseFireStore Data ---
  Future<void> deleteDataFromFirestore({
    required String collection,
    required String id,
  }) async {
    try {
      await _db.collection(collection).doc(id).delete();
      debugPrint("Document deleted successfully from $collection/$id");
    } catch (e) {
      debugPrint("Error deleting document: $e");
      Utils.snackBar(
        "Error",
        'Something went wrong while deleting. Please try again!',
        AppColors.red,
      );
    }
  }

  /// --- Get User Data ---
  Future<UserModel?> getUserData({required String uid}) async {
    try {
      debugPrint("Fetching user data for UID: $uid");

      DocumentSnapshot doc =
          await _db.collection(AppCollections.users).doc(uid).get();

      if (doc.exists) {
        debugPrint("User data fetched successfully: ${doc.data()}");
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        debugPrint("Document does not exist for UID: $uid");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      Utils.snackBar("Error", 'Failed to fetch user data!', AppColors.red);
      return null;
    }
  }

  /// --- Logout User Data ---
  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Utils.snackBar(
        "Error",
        'Something went wrong. Please try again!',
        AppColors.red,
      );
    }
  }

  /// --- Set Status (online/offline) ---
  Future<void> setUserStatus(String userId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppCollections.users)
          .doc(userId)
          .update({"status": status, "lastSeen": FieldValue.serverTimestamp()});
      log("✅ Status updated: $status");
    } catch (e) {
      log("❌ Failed to update status: $e");
    }
  }

  /// --- Update Password FirebaseFirestore ---
  Future<void> updatePassword({
    required String uid,
    required String email,
    required String newPass,
    required String currentPass,
  }) async {
    var cred = EmailAuthProvider.credential(
      email: email,
      password: currentPass,
    );
    try {
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(cred)
          .then(
            (value) => {
              FirebaseAuth.instance.currentUser!.updatePassword(newPass),
            },
          );
      await _db.collection(AppCollections.users).doc(uid).update({
        'password': newPass,
      });
    } catch (e) {
      Utils.snackBar(
        "Error",
        'Something went wrong. Please try again!',
        AppColors.red,
      );
    }
  }

  /// --- Delete User Data ---
  Future<void> deleteUserData(String uid) async {
    final userRef = _db.collection(AppCollections.users).doc(uid);
    await userRef.delete();
  }

  /// --- Single Profile Image ---
  // Future<String> uploadProfileImage(String userId, File file) async {
  //   final ref = _storage.ref().child(
  //     'profile_images/$userId.jpg',
  //   );
  //   await ref.putFile(file);
  //   return await ref.getDownloadURL();
  // }

  /// --- Multiple Profile Image ---
  Future<String> uploadProfileImage(String fileName, File file) async {
    final ref = _storage.ref().child("profile_images/$fileName.jpg");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  /// --- Upload Image to Firebase Storage ---
  Future<String?> uploadFileToStorage({
    required File file,
    required String path,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Uploading as: ${FirebaseAuth.instance.currentUser?.uid}');

      debugPrint("Storage upload error: $e");
      Utils.snackBar("Error", "Image upload failed!", AppColors.red);
      return null;
    }
  }

  Future<void> deleteProfileImage(String userId) async {
    final ref = FirebaseStorage.instance.ref().child(
      'profile_images/$userId.jpg',
    );
    try {
      await ref.delete();
    } catch (e) {
      print('No existing image to delete: $e');
    }
  }

  // RealTime Database
  Future<void> saveToRealtimeDB({
    required String path,
    required dynamic data,
  }) async {
    await db.child(path).set(data);
  }

  /// Convert image to Base64
  Future<String> convertImageToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<List<Map<String, dynamic>>> getUsersByField({
    required String collection,
    required String field,
    required String value,
  }) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(collection)
            .where(field, isEqualTo: value)
            .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
