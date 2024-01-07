// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get pass {
    return Intl.message(
      'Password',
      name: 'pass',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Don/'t have an acount?`
  String get create {
    return Intl.message(
      'Don/\'t have an acount?',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Create acount`
  String get create1 {
    return Intl.message(
      'Create acount',
      name: 'create1',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forget {
    return Intl.message(
      'Forget Password',
      name: 'forget',
      desc: '',
      args: [],
    );
  }

  /// `Continue without login`
  String get follow {
    return Intl.message(
      'Continue without login',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get validate {
    return Intl.message(
      'This field is required',
      name: 'validate',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmpass {
    return Intl.message(
      'Confirm Password',
      name: 'confirmpass',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Make`
  String get male {
    return Intl.message(
      'Make',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Have an acount?`
  String get haveacount {
    return Intl.message(
      'Have an acount?',
      name: 'haveacount',
      desc: '',
      args: [],
    );
  }

  /// `Type Email Address`
  String get resetEmail {
    return Intl.message(
      'Type Email Address',
      name: 'resetEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reset Email`
  String get reset {
    return Intl.message(
      'Reset Email',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Complete Register`
  String get complete {
    return Intl.message(
      'Complete Register',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Please complete Register`
  String get compelteHint {
    return Intl.message(
      'Please complete Register',
      name: 'compelteHint',
      desc: '',
      args: [],
    );
  }

  /// `please Confirm your phone number`
  String get phoneLenght {
    return Intl.message(
      'please Confirm your phone number',
      name: 'phoneLenght',
      desc: '',
      args: [],
    );
  }

  /// `please confirm the Password`
  String get passConfirm {
    return Intl.message(
      'please confirm the Password',
      name: 'passConfirm',
      desc: '',
      args: [],
    );
  }

  /// `please choose the gender`
  String get genderConfirm {
    return Intl.message(
      'please choose the gender',
      name: 'genderConfirm',
      desc: '',
      args: [],
    );
  }

  /// `please agree the privacy`
  String get privacyConfirm {
    return Intl.message(
      'please agree the privacy',
      name: 'privacyConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Please Verify your email`
  String get emailverify {
    return Intl.message(
      'Please Verify your email',
      name: 'emailverify',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Health and Nutrition`
  String get health {
    return Intl.message(
      'Health and Nutrition',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `Exercises and Fitness`
  String get exercises {
    return Intl.message(
      'Exercises and Fitness',
      name: 'exercises',
      desc: '',
      args: [],
    );
  }

  /// `Self-Development`
  String get self {
    return Intl.message(
      'Self-Development',
      name: 'self',
      desc: '',
      args: [],
    );
  }

  /// `Various Exercises`
  String get exercise {
    return Intl.message(
      'Various Exercises',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Details`
  String get exDetails {
    return Intl.message(
      'Exercise Details',
      name: 'exDetails',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get categoryEx {
    return Intl.message(
      'Exercises',
      name: 'categoryEx',
      desc: '',
      args: [],
    );
  }

  /// `All Exercises`
  String get allEx {
    return Intl.message(
      'All Exercises',
      name: 'allEx',
      desc: '',
      args: [],
    );
  }

  /// `No Exercises`
  String get emptyList {
    return Intl.message(
      'No Exercises',
      name: 'emptyList',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Suggest an Exercise`
  String get suggest {
    return Intl.message(
      'Suggest an Exercise',
      name: 'suggest',
      desc: '',
      args: [],
    );
  }

  /// `No exercise found with this name`
  String get noExer {
    return Intl.message(
      'No exercise found with this name',
      name: 'noExer',
      desc: '',
      args: [],
    );
  }

  /// `Search for an Exercise`
  String get searchHint {
    return Intl.message(
      'Search for an Exercise',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Latest Articles`
  String get articles {
    return Intl.message(
      'Latest Articles',
      name: 'articles',
      desc: '',
      args: [],
    );
  }

  /// `No articles found with this name`
  String get noArticles {
    return Intl.message(
      'No articles found with this name',
      name: 'noArticles',
      desc: '',
      args: [],
    );
  }

  /// `Articles`
  String get articlesT {
    return Intl.message(
      'Articles',
      name: 'articlesT',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get by {
    return Intl.message(
      'By',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Article Details`
  String get arDetails {
    return Intl.message(
      'Article Details',
      name: 'arDetails',
      desc: '',
      args: [],
    );
  }

  /// `Various Products`
  String get products {
    return Intl.message(
      'Various Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get stores {
    return Intl.message(
      'Stores',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `Number of Products`
  String get NumProducts {
    return Intl.message(
      'Number of Products',
      name: 'NumProducts',
      desc: '',
      args: [],
    );
  }

  /// `Our Products`
  String get ourProducts {
    return Intl.message(
      'Our Products',
      name: 'ourProducts',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get bestSeller {
    return Intl.message(
      'Best Seller',
      name: 'bestSeller',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get proDetails {
    return Intl.message(
      'Product Details',
      name: 'proDetails',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Dinar`
  String get dinar {
    return Intl.message(
      'Dinar',
      name: 'dinar',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message(
      'Buy Now',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Location Service Disabled`
  String get locationService {
    return Intl.message(
      'Location Service Disabled',
      name: 'locationService',
      desc: '',
      args: [],
    );
  }

  /// `No Connection`
  String get internet {
    return Intl.message(
      'No Connection',
      name: 'internet',
      desc: '',
      args: [],
    );
  }

  /// `Location Access Disabled`
  String get permission {
    return Intl.message(
      'Location Access Disabled',
      name: 'permission',
      desc: '',
      args: [],
    );
  }

  /// `Nearest Gym`
  String get gym {
    return Intl.message(
      'Nearest Gym',
      name: 'gym',
      desc: '',
      args: [],
    );
  }

  /// `IQD/Month`
  String get currency {
    return Intl.message(
      'IQD/Month',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Update Location`
  String get update {
    return Intl.message(
      'Update Location',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get sub {
    return Intl.message(
      'Subscribe',
      name: 'sub',
      desc: '',
      args: [],
    );
  }

  /// `Show on Map`
  String get show {
    return Intl.message(
      'Show on Map',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `No gym found with this name`
  String get noGyms {
    return Intl.message(
      'No gym found with this name',
      name: 'noGyms',
      desc: '',
      args: [],
    );
  }

  /// `Lowest Price`
  String get lowPrice {
    return Intl.message(
      'Lowest Price',
      name: 'lowPrice',
      desc: '',
      args: [],
    );
  }

  /// `Highest Price`
  String get highPrice {
    return Intl.message(
      'Highest Price',
      name: 'highPrice',
      desc: '',
      args: [],
    );
  }

  /// `Farthest`
  String get maxDistance {
    return Intl.message(
      'Farthest',
      name: 'maxDistance',
      desc: '',
      args: [],
    );
  }

  /// `Nearest`
  String get minDistance {
    return Intl.message(
      'Nearest',
      name: 'minDistance',
      desc: '',
      args: [],
    );
  }

  /// `Gyms`
  String get slatGym {
    return Intl.message(
      'Gyms',
      name: 'slatGym',
      desc: '',
      args: [],
    );
  }

  /// `No products found with this name`
  String get noProduct {
    return Intl.message(
      'No products found with this name',
      name: 'noProduct',
      desc: '',
      args: [],
    );
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get category {
    return Intl.message(
      'Categories',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `No products in this category`
  String get nocProducts {
    return Intl.message(
      'No products in this category',
      name: 'nocProducts',
      desc: '',
      args: [],
    );
  }

  /// `المدربين`
  String get trainer {
    return Intl.message(
      'المدربين',
      name: 'trainer',
      desc: '',
      args: [],
    );
  }

  /// `التمارين المنزلية`
  String get home_exercises {
    return Intl.message(
      'التمارين المنزلية',
      name: 'home_exercises',
      desc: '',
      args: [],
    );
  }

  /// `ابحث عن تمرينك`
  String get search_yourself {
    return Intl.message(
      'ابحث عن تمرينك',
      name: 'search_yourself',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
