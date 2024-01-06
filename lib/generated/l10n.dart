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

  /// `تمارين متنوعة`
  String get exercise {
    return Intl.message(
      'تمارين متنوعة',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `المزيد`
  String get more {
    return Intl.message(
      'المزيد',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل التمرين`
  String get exDetails {
    return Intl.message(
      'تفاصيل التمرين',
      name: 'exDetails',
      desc: '',
      args: [],
    );
  }

  /// `التمارين`
  String get categoryEx {
    return Intl.message(
      'التمارين',
      name: 'categoryEx',
      desc: '',
      args: [],
    );
  }

  /// `جميع التمارين`
  String get allEx {
    return Intl.message(
      'جميع التمارين',
      name: 'allEx',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد تمارين`
  String get emptyList {
    return Intl.message(
      'لا يوجد تمارين',
      name: 'emptyList',
      desc: '',
      args: [],
    );
  }

  /// `بحث`
  String get search {
    return Intl.message(
      'بحث',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `قم بقتراح تمرين`
  String get suggest {
    return Intl.message(
      'قم بقتراح تمرين',
      name: 'suggest',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد تمرين بهذا الاسم`
  String get noExer {
    return Intl.message(
      'لا يوجد تمرين بهذا الاسم',
      name: 'noExer',
      desc: '',
      args: [],
    );
  }

  /// `قم بالبحث عن تمرين`
  String get searchHint {
    return Intl.message(
      'قم بالبحث عن تمرين',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `آخر المقالات`
  String get articles {
    return Intl.message(
      'آخر المقالات',
      name: 'articles',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد مقالات بهذا الإسم`
  String get noArticles {
    return Intl.message(
      'لا يوجد مقالات بهذا الإسم',
      name: 'noArticles',
      desc: '',
      args: [],
    );
  }

  /// `المقالات`
  String get articlesT {
    return Intl.message(
      'المقالات',
      name: 'articlesT',
      desc: '',
      args: [],
    );
  }

  /// `التاريخ`
  String get date {
    return Intl.message(
      'التاريخ',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `بواسطة`
  String get by {
    return Intl.message(
      'بواسطة',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل المقال`
  String get arDetails {
    return Intl.message(
      'تفاصيل المقال',
      name: 'arDetails',
      desc: '',
      args: [],
    );
  }

  /// `منتجات متنوعة`
  String get products {
    return Intl.message(
      'منتجات متنوعة',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `المتاجر`
  String get stores {
    return Intl.message(
      'المتاجر',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `عدد المنتجات`
  String get allPriducts {
    return Intl.message(
      'عدد المنتجات',
      name: 'allPriducts',
      desc: '',
      args: [],
    );
  }

  /// `منتجاتنا`
  String get ourProducts {
    return Intl.message(
      'منتجاتنا',
      name: 'ourProducts',
      desc: '',
      args: [],
    );
  }

  /// `الأفضل مبيعا`
  String get bestSeller {
    return Intl.message(
      'الأفضل مبيعا',
      name: 'bestSeller',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل المنتج`
  String get proDetails {
    return Intl.message(
      'تفاصيل المنتج',
      name: 'proDetails',
      desc: '',
      args: [],
    );
  }

  /// `الوصف`
  String get description {
    return Intl.message(
      'الوصف',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `دينار`
  String get dinar {
    return Intl.message(
      'دينار',
      name: 'dinar',
      desc: '',
      args: [],
    );
  }

  /// `شراء الآن`
  String get buyNow {
    return Intl.message(
      'شراء الآن',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `تواصل معنا`
  String get contactUs {
    return Intl.message(
      'تواصل معنا',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `خدمة الموقع معطلة`
  String get locationService {
    return Intl.message(
      'خدمة الموقع معطلة',
      name: 'locationService',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد اتصال`
  String get internet {
    return Intl.message(
      'لا يوجد اتصال',
      name: 'internet',
      desc: '',
      args: [],
    );
  }

  /// `الوصول للموقع غير مفعل`
  String get permission {
    return Intl.message(
      'الوصول للموقع غير مفعل',
      name: 'permission',
      desc: '',
      args: [],
    );
  }

  /// `أقرب جيم`
  String get gym {
    return Intl.message(
      'أقرب جيم',
      name: 'gym',
      desc: '',
      args: [],
    );
  }

  /// `د.ع/شهر`
  String get currency {
    return Intl.message(
      'د.ع/شهر',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `تحديث الموقع`
  String get update {
    return Intl.message(
      'تحديث الموقع',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `إعادة ألمحاولة`
  String get tryAgain {
    return Intl.message(
      'إعادة ألمحاولة',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `اشتراك`
  String get sub {
    return Intl.message(
      'اشتراك',
      name: 'sub',
      desc: '',
      args: [],
    );
  }

  /// `عرض على الخريطة`
  String get show {
    return Intl.message(
      'عرض على الخريطة',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد جيم بهذا الإسم`
  String get noGyms {
    return Intl.message(
      'لا يوجد جيم بهذا الإسم',
      name: 'noGyms',
      desc: '',
      args: [],
    );
  }

  /// `الأقل سعرا`
  String get lowPrice {
    return Intl.message(
      'الأقل سعرا',
      name: 'lowPrice',
      desc: '',
      args: [],
    );
  }

  /// `الأعلى سعرا`
  String get highPrice {
    return Intl.message(
      'الأعلى سعرا',
      name: 'highPrice',
      desc: '',
      args: [],
    );
  }

  /// `الأبعد`
  String get maxDistance {
    return Intl.message(
      'الأبعد',
      name: 'maxDistance',
      desc: '',
      args: [],
    );
  }

  /// `الأقرب`
  String get minDistance {
    return Intl.message(
      'الأقرب',
      name: 'minDistance',
      desc: '',
      args: [],
    );
  }

  /// `صالات الجيم`
  String get slatGym {
    return Intl.message(
      'صالات الجيم',
      name: 'slatGym',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد منتجات بهذا الإسم`
  String get noProduct {
    return Intl.message(
      'لا يوجد منتجات بهذا الإسم',
      name: 'noProduct',
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
