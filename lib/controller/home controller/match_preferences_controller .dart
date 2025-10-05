import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchPreferencesController extends GetxController {
  RxInt selectedTab = 0.obs;
  
  void selectTab(int index) {
    selectedTab.value = index;
  }

  RxList<String> tabs =
      [
        'Match Preferences',
        'Basic Details',
        'Religious Details',
        'Professional Details',
        'Location Details',
        'Family Details',
      ].obs;

  // Match Preferences
  RxMap<String, bool> matchFilters =
      <String, bool>{
        "All Matches": false,
        "Newly Joined": false,
        "Viewed You": false,
        "Shortlisted You": false,
        "Viewed By You": false,
        "Shortlisted By You": false,
        "Sent Request": false,
        "Receive Request": false,
        "Accepted Request": false,
      }.obs;

  void toggleFilter(String key, bool? value) {
    if (value != null) {
      matchFilters[key] = value;
    }
  }

  // Basic Details
  Rx<RangeValues> ageRange = RangeValues(18, 60).obs;
  RxSet<String> selectedHeights = <String>{}.obs;

  void updateAgeRange(RangeValues values) {
    ageRange.value = values;
  }

  void toggleSelection(String label) {
    if (selectedHeights.contains(label)) {
    } else {
      selectedHeights.add(label);
    }
  }
}
