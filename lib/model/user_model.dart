import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? mobileNo;
  String? age;
  String? dob;
  String? gender;
  String? motherTongue;
  String? eatingHabits;
  String? smokingHabits;
  String? drinkingHabits;
  String? userProfilePic;

  // Religion
  String? religion;
  String? caste;
  String? subCaste;
  bool? willingToMarryOtherCaste;

  // Personal
  String? maritalStatus;
  String? numberOfChildren;
  String? isChildrenLivingWithYou;
  String? height;
  String? familyStatus;
  String? familyType;
  String? familyValues;
  String? anyDisability;

  // Professional
  String? education;
  String? employedIn;
  String? occupation;
  String? annualIncome;
  String? workLocation;
  String? state;
  String? city;

  // About Yourself
  String? aboutYourself;
  List<String>? profileImages;

  // Meta
  int? profileStep;
  double? profileCompletion;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.age,
    this.dob,
    this.gender,
    this.motherTongue,
    this.eatingHabits,
    this.smokingHabits,
    this.drinkingHabits,
    this.userProfilePic,
    this.religion,
    this.caste,
    this.subCaste,
    this.willingToMarryOtherCaste,
    this.maritalStatus,
    this.numberOfChildren,
    this.isChildrenLivingWithYou,
    this.height,
    this.familyStatus,
    this.familyType,
    this.familyValues,
    this.anyDisability,
    this.education,
    this.employedIn,
    this.occupation,
    this.annualIncome,
    this.workLocation,
    this.state,
    this.city,
    this.aboutYourself,
    this.profileImages,
    this.profileStep,
    this.profileCompletion,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    age = json['age'];
    dob = json['dob'];
    gender = json['gender'];
    motherTongue = json['motherTongue'];
    eatingHabits = json['eatingHabits'];
    smokingHabits = json['smokingHabits'];
    drinkingHabits = json['drinkingHabits'];
    userProfilePic = json['userProfilePic'];

    religion = json['religion'];
    caste = json['caste'];
    subCaste = json['subCaste'];
    willingToMarryOtherCaste = json['willingToMarryOtherCaste'];

    maritalStatus = json['maritalStatus'];
    numberOfChildren = json['numberOfChildren'];
    isChildrenLivingWithYou = json['isChildrenLivingWithYou'];
    height = json['height'];
    familyStatus = json['familyStatus'];
    familyType = json['familyType'];
    familyValues = json['familyValues'];
    anyDisability = json['anyDisability'];

    education = json['education'];
    employedIn = json['employedIn'];
    occupation = json['occupation'];
    annualIncome = json['annualIncome'];
    workLocation = json['workLocation'];
    state = json['state'];
    city = json['city'];

    aboutYourself = json['aboutYourself'];
    profileImages =
        json['profileImages'] != null
            ? List<String>.from(json['profileImages'])
            : [];

    profileStep = json['profileStep'];
    profileCompletion =
        (json['profileCompletion'] != null)
            ? (json['profileCompletion'] as num).toDouble()
            : null;

    createdAt = json['createdAt'] is Timestamp ? json['createdAt'] : null;
    updatedAt = json['updatedAt'] is Timestamp ? json['updatedAt'] : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobileNo'] = mobileNo;
    data['age'] = age;
    data['dob'] = dob;
    data['gender'] = gender;
    data['motherTongue'] = motherTongue;
    data['eatingHabits'] = eatingHabits;
    data['smokingHabits'] = smokingHabits;
    data['drinkingHabits'] = drinkingHabits;
    data['userProfilePic'] = userProfilePic;

    data['religion'] = religion;
    data['caste'] = caste;
    data['subCaste'] = subCaste;
    data['willingToMarryOtherCaste'] = willingToMarryOtherCaste;

    data['maritalStatus'] = maritalStatus;
    data['numberOfChildren'] = numberOfChildren;
    data['isChildrenLivingWithYou'] = isChildrenLivingWithYou;
    data['height'] = height;
    data['familyStatus'] = familyStatus;
    data['familyType'] = familyType;
    data['familyValues'] = familyValues;
    data['anyDisability'] = anyDisability;

    data['education'] = education;
    data['employedIn'] = employedIn;
    data['occupation'] = occupation;
    data['annualIncome'] = annualIncome;
    data['workLocation'] = workLocation;
    data['state'] = state;
    data['city'] = city;

    data['aboutYourself'] = aboutYourself;
    data['profileImages'] = profileImages;

    data['profileStep'] = profileStep;
    data['profileCompletion'] = profileCompletion;

    data['createdAt'] = createdAt?.toDate().toIso8601String();
    data['updatedAt'] = updatedAt?.toDate().toIso8601String();

    return data;
  }

  String getCreatedAtString() {
    if (createdAt != null) {
      return createdAt!.toDate().toString();
    }
    return '';
  }

  String getUpdatedAtString() {
    if (updatedAt != null) {
      return updatedAt!.toDate().toString();
    }
    return '';
  }
}
