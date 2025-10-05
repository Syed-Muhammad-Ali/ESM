import 'package:european_single_marriage/views/app%20screens/auth%20screens/login_screen.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/on_boarding_screen.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/register/about_yourself.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/register/basic_details.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/register/personal_details.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/register/professional_details.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/register/register.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/register/religion_details.dart';
import 'package:european_single_marriage/views/app%20screens/auth%20screens/splash_screen.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/add_friend_page.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/chat_text_page.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/dashboard.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/edit_profile.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/help_support_screen.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/matches_details.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/membership.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = "/SpalshScreen";
  static const String onBoardingScreen = "/OnBoardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String registerScreen = "/RegisterScreen";
  static const String basicDetails = "/BasicDetails";
  static const String religionDetails = "/ReligionDetails";
  static const String personalDetails = "/PersonalDetails";
  static const String professionalDetails = "/ProfessionalDetails";
  static const String aboutYourself = "/AboutYourself";
  static const String dashboardScreen = "/DashboardScreen";
  static const String matchesDetails = "/MatchesDetails";
  static const String editProfile = "/EditProfile";
  static const String membership = "/Membership";
  // static const String messageTextPage = "/MessageTextPage";
  static const String helpSupportScreen = "/HelpSupportScreen";
  static const String addFriendPage = "/addFriendPage";

  static Map<String, WidgetBuilder> get routes => {
    splashScreen: (_) => SplashScreen(),
    onBoardingScreen: (_) => OnBoardingScreen(),
    loginScreen: (_) => LoginScreen(),
    registerScreen: (_) => RegisterScreen(),
    basicDetails: (_) => BasicDetails(),
    religionDetails: (_) => ReligionDetails(),
    personalDetails: (_) => PersonalDetails(),
    professionalDetails: (_) => ProfessionalDetails(),
    aboutYourself: (_) => AboutYourself(),
    dashboardScreen: (_) => DashboardScreen(),
    matchesDetails: (_) => MatchesDetails(),
    editProfile: (_) => EditProfile(),
    membership: (_) => Membership(),
    // messageTextPage: (_) => MessageTextPage(),
    helpSupportScreen: (_) => HelpSupportScreen(),
    addFriendPage: (_) => AddFriendPage(),
  };
}
