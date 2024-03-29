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
  String get suggest_exercise {
    return Intl.message(
      'Suggest an Exercise',
      name: 'suggest_exercise',
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

  /// `D.I`
  String get dinar {
    return Intl.message(
      'D.I',
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

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
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

  /// `Trainers`
  String get trainer {
    return Intl.message(
      'Trainers',
      name: 'trainer',
      desc: '',
      args: [],
    );
  }

  /// `Home Exercises`
  String get home_exercises {
    return Intl.message(
      'Home Exercises',
      name: 'home_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Search for Your Exercise`
  String get search_yourself {
    return Intl.message(
      'Search for Your Exercise',
      name: 'search_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Trainers Page`
  String get trainersPage {
    return Intl.message(
      'Trainers Page',
      name: 'trainersPage',
      desc: '',
      args: [],
    );
  }

  /// `No Trainers`
  String get no_trainers {
    return Intl.message(
      'No Trainers',
      name: 'no_trainers',
      desc: '',
      args: [],
    );
  }

  /// `Trainee`
  String get trainee {
    return Intl.message(
      'Trainee',
      name: 'trainee',
      desc: '',
      args: [],
    );
  }

  /// `Trainer Profile`
  String get trainer_profile {
    return Intl.message(
      'Trainer Profile',
      name: 'trainer_profile',
      desc: '',
      args: [],
    );
  }

  /// `Coach`
  String get coach {
    return Intl.message(
      'Coach',
      name: 'coach',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get money {
    return Intl.message(
      'Price',
      name: 'money',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Social Media`
  String get media {
    return Intl.message(
      'Social Media',
      name: 'media',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get achevement {
    return Intl.message(
      'Achievements',
      name: 'achevement',
      desc: '',
      args: [],
    );
  }

  /// `Working Hours`
  String get work_hour {
    return Intl.message(
      'Working Hours',
      name: 'work_hour',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `This User does not have an account on this platform`
  String get tranier_hint_social {
    return Intl.message(
      'This User does not have an account on this platform',
      name: 'tranier_hint_social',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get trainer_gallery {
    return Intl.message(
      'Gallery',
      name: 'trainer_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `After`
  String get after {
    return Intl.message(
      'After',
      name: 'after',
      desc: '',
      args: [],
    );
  }

  /// `Top Trainers`
  String get top_trainers {
    return Intl.message(
      'Top Trainers',
      name: 'top_trainers',
      desc: '',
      args: [],
    );
  }

  /// `Diet Food`
  String get diet_food {
    return Intl.message(
      'Diet Food',
      name: 'diet_food',
      desc: '',
      args: [],
    );
  }

  /// `Questions`
  String get questtion {
    return Intl.message(
      'Questions',
      name: 'questtion',
      desc: '',
      args: [],
    );
  }

  /// `No Results`
  String get no_results {
    return Intl.message(
      'No Results',
      name: 'no_results',
      desc: '',
      args: [],
    );
  }

  /// `Answers`
  String get answers {
    return Intl.message(
      'Answers',
      name: 'answers',
      desc: '',
      args: [],
    );
  }

  /// `Add Answer`
  String get add_answer {
    return Intl.message(
      'Add Answer',
      name: 'add_answer',
      desc: '',
      args: [],
    );
  }

  /// `No answers yet`
  String get no_answers {
    return Intl.message(
      'No answers yet',
      name: 'no_answers',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Answer`
  String get answer {
    return Intl.message(
      'Answer',
      name: 'answer',
      desc: '',
      args: [],
    );
  }

  /// `This question has been deleted`
  String get question_error {
    return Intl.message(
      'This question has been deleted',
      name: 'question_error',
      desc: '',
      args: [],
    );
  }

  /// `Write a new question...`
  String get write_question {
    return Intl.message(
      'Write a new question...',
      name: 'write_question',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Question added successfully`
  String get success_add {
    return Intl.message(
      'Question added successfully',
      name: 'success_add',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get success_remove {
    return Intl.message(
      'Deleted successfully',
      name: 'success_remove',
      desc: '',
      args: [],
    );
  }

  /// `Question updated successfully`
  String get success_update {
    return Intl.message(
      'Question updated successfully',
      name: 'success_update',
      desc: '',
      args: [],
    );
  }

  /// `restricted successfully`
  String get success_ban {
    return Intl.message(
      'restricted successfully',
      name: 'success_ban',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get remove_question {
    return Intl.message(
      'Delete',
      name: 'remove_question',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get comment_error {
    return Intl.message(
      'An error occurred',
      name: 'comment_error',
      desc: '',
      args: [],
    );
  }

  /// `Edit Answer`
  String get edit_answer {
    return Intl.message(
      'Edit Answer',
      name: 'edit_answer',
      desc: '',
      args: [],
    );
  }

  /// `Answer Successfully Removed`
  String get success_remove_answer {
    return Intl.message(
      'Answer Successfully Removed',
      name: 'success_remove_answer',
      desc: '',
      args: [],
    );
  }

  /// `Answer Successfully Updated`
  String get success_update_answer {
    return Intl.message(
      'Answer Successfully Updated',
      name: 'success_update_answer',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection. Some App Features May Not Work`
  String get no_internet {
    return Intl.message(
      'No Internet Connection. Some App Features May Not Work',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Internet Connection Established`
  String get internet_connection {
    return Intl.message(
      'Internet Connection Established',
      name: 'internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Ago`
  String get ago {
    return Intl.message(
      'Ago',
      name: 'ago',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get profile {
    return Intl.message(
      'Your Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `About the App`
  String get about_app {
    return Intl.message(
      'About the App',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_u {
    return Intl.message(
      'Contact Us',
      name: 'contact_u',
      desc: '',
      args: [],
    );
  }

  /// `Rate the App`
  String get rate_app {
    return Intl.message(
      'Rate the App',
      name: 'rate_app',
      desc: '',
      args: [],
    );
  }

  /// `App Instructions`
  String get how_to_use_app {
    return Intl.message(
      'App Instructions',
      name: 'how_to_use_app',
      desc: '',
      args: [],
    );
  }

  /// `Account Details`
  String get account_details {
    return Intl.message(
      'Account Details',
      name: 'account_details',
      desc: '',
      args: [],
    );
  }

  /// `years old`
  String get years {
    return Intl.message(
      'years old',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_pass {
    return Intl.message(
      'Change Password',
      name: 'change_pass',
      desc: '',
      args: [],
    );
  }

  /// `Update Your Account`
  String get update_your_account {
    return Intl.message(
      'Update Your Account',
      name: 'update_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get update_profile {
    return Intl.message(
      'Update Profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile Successfully Updated`
  String get success_update_profile {
    return Intl.message(
      'Profile Successfully Updated',
      name: 'success_update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Logged Out Successfully`
  String get success_log_out {
    return Intl.message(
      'Logged Out Successfully',
      name: 'success_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out?`
  String get log_out_question {
    return Intl.message(
      'Do you want to log out?',
      name: 'log_out_question',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get theme {
    return Intl.message(
      'Dark Mode',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic_language {
    return Intl.message(
      'Arabic',
      name: 'arabic_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english_language {
    return Intl.message(
      'English',
      name: 'english_language',
      desc: '',
      args: [],
    );
  }

  /// `Device Language`
  String get device_language {
    return Intl.message(
      'Device Language',
      name: 'device_language',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm_lang {
    return Intl.message(
      'Confirm',
      name: 'confirm_lang',
      desc: '',
      args: [],
    );
  }

  /// `Share the app`
  String get share_app {
    return Intl.message(
      'Share the app',
      name: 'share_app',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get app {
    return Intl.message(
      'App',
      name: 'app',
      desc: '',
      args: [],
    );
  }

  /// `All rights reserved`
  String get all_privay_saved {
    return Intl.message(
      'All rights reserved',
      name: 'all_privay_saved',
      desc: '',
      args: [],
    );
  }

  /// `You cannot access the admin file`
  String get admin_hint {
    return Intl.message(
      'You cannot access the admin file',
      name: 'admin_hint',
      desc: '',
      args: [],
    );
  }

  /// `User profile`
  String get user_profile {
    return Intl.message(
      'User profile',
      name: 'user_profile',
      desc: '',
      args: [],
    );
  }

  /// `Your location has been updated`
  String get success_update_location {
    return Intl.message(
      'Your location has been updated',
      name: 'success_update_location',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get profile_hint_social {
    return Intl.message(
      'None',
      name: 'profile_hint_social',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebooh {
    return Intl.message(
      'Facebook',
      name: 'facebooh',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get instgram {
    return Intl.message(
      'Instagram',
      name: 'instgram',
      desc: '',
      args: [],
    );
  }

  /// `Twitter`
  String get twiter {
    return Intl.message(
      'Twitter',
      name: 'twiter',
      desc: '',
      args: [],
    );
  }

  /// `Enter the link`
  String get enter_uri {
    return Intl.message(
      'Enter the link',
      name: 'enter_uri',
      desc: '',
      args: [],
    );
  }

  /// `Enter the number`
  String get enter_phone {
    return Intl.message(
      'Enter the number',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `My day`
  String get my_day {
    return Intl.message(
      'My day',
      name: 'my_day',
      desc: '',
      args: [],
    );
  }

  /// `Water alarm`
  String get water_alarm {
    return Intl.message(
      'Water alarm',
      name: 'water_alarm',
      desc: '',
      args: [],
    );
  }

  /// `Gym owner`
  String get gym_owner {
    return Intl.message(
      'Gym owner',
      name: 'gym_owner',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsApp {
    return Intl.message(
      'WhatsApp',
      name: 'whatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Nutritional values`
  String get values_food {
    return Intl.message(
      'Nutritional values',
      name: 'values_food',
      desc: '',
      args: [],
    );
  }

  /// `Protein calculator`
  String get protien_calculator {
    return Intl.message(
      'Protein calculator',
      name: 'protien_calculator',
      desc: '',
      args: [],
    );
  }

  /// `Nutritional supplements`
  String get nuttritions {
    return Intl.message(
      'Nutritional supplements',
      name: 'nuttritions',
      desc: '',
      args: [],
    );
  }

  /// `Choose a meal`
  String get choose_meal {
    return Intl.message(
      'Choose a meal',
      name: 'choose_meal',
      desc: '',
      args: [],
    );
  }

  /// `g`
  String get g {
    return Intl.message(
      'g',
      name: 'g',
      desc: '',
      args: [],
    );
  }

  /// `Protein`
  String get protien {
    return Intl.message(
      'Protein',
      name: 'protien',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fat {
    return Intl.message(
      'Fat',
      name: 'fat',
      desc: '',
      args: [],
    );
  }

  /// `Carbs`
  String get carb {
    return Intl.message(
      'Carbs',
      name: 'carb',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get calories {
    return Intl.message(
      'Calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Calorie`
  String get calory {
    return Intl.message(
      'Calorie',
      name: 'calory',
      desc: '',
      args: [],
    );
  }

  /// `Choose weight`
  String get choose_weight {
    return Intl.message(
      'Choose weight',
      name: 'choose_weight',
      desc: '',
      args: [],
    );
  }

  /// `Protein calculator`
  String get protein_calculator {
    return Intl.message(
      'Protein calculator',
      name: 'protein_calculator',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `cm`
  String get cm {
    return Intl.message(
      'cm',
      name: 'cm',
      desc: '',
      args: [],
    );
  }

  /// `Nutrients`
  String get nutrients {
    return Intl.message(
      'Nutrients',
      name: 'nutrients',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Purpose`
  String get exercise_purpose {
    return Intl.message(
      'Exercise Purpose',
      name: 'exercise_purpose',
      desc: '',
      args: [],
    );
  }

  /// `Weight Gain`
  String get weight_gain {
    return Intl.message(
      'Weight Gain',
      name: 'weight_gain',
      desc: '',
      args: [],
    );
  }

  /// `Weight Loss`
  String get weight_loss {
    return Intl.message(
      'Weight Loss',
      name: 'weight_loss',
      desc: '',
      args: [],
    );
  }

  /// `Weight Maintenance`
  String get weight_maintenance {
    return Intl.message(
      'Weight Maintenance',
      name: 'weight_maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Low Activity in Work and Club`
  String get low_activity {
    return Intl.message(
      'Low Activity in Work and Club',
      name: 'low_activity',
      desc: '',
      args: [],
    );
  }

  /// `Moderate Activity in Work and Club`
  String get moderate_activity {
    return Intl.message(
      'Moderate Activity in Work and Club',
      name: 'moderate_activity',
      desc: '',
      args: [],
    );
  }

  /// `High Activity in Work and Club`
  String get high_activity {
    return Intl.message(
      'High Activity in Work and Club',
      name: 'high_activity',
      desc: '',
      args: [],
    );
  }

  /// `Very Intense Activity in Work and Club`
  String get very_intense_activity {
    return Intl.message(
      'Very Intense Activity in Work and Club',
      name: 'very_intense_activity',
      desc: '',
      args: [],
    );
  }

  /// `To inquire or ask any question, please contact us:`
  String get contact_us_hint {
    return Intl.message(
      'To inquire or ask any question, please contact us:',
      name: 'contact_us_hint',
      desc: '',
      args: [],
    );
  }

  /// `Recalculate`
  String get recalculate {
    return Intl.message(
      'Recalculate',
      name: 'recalculate',
      desc: '',
      args: [],
    );
  }

  /// `Your Need`
  String get your_need {
    return Intl.message(
      'Your Need',
      name: 'your_need',
      desc: '',
      args: [],
    );
  }

  /// `Your Meals`
  String get your_meals {
    return Intl.message(
      'Your Meals',
      name: 'your_meals',
      desc: '',
      args: [],
    );
  }

  /// `Scroll vertically to remove meal`
  String get scroll_verticle_to_remove {
    return Intl.message(
      'Scroll vertically to remove meal',
      name: 'scroll_verticle_to_remove',
      desc: '',
      args: [],
    );
  }

  /// `Add Meal`
  String get add_meal {
    return Intl.message(
      'Add Meal',
      name: 'add_meal',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `No Meals`
  String get no_meals {
    return Intl.message(
      'No Meals',
      name: 'no_meals',
      desc: '',
      args: [],
    );
  }

  /// `Add Today`
  String get add_today {
    return Intl.message(
      'Add Today',
      name: 'add_today',
      desc: '',
      args: [],
    );
  }

  /// `Current day already added`
  String get add_today_hint {
    return Intl.message(
      'Current day already added',
      name: 'add_today_hint',
      desc: '',
      args: [],
    );
  }

  /// `Recalculation successful`
  String get success_recalulate {
    return Intl.message(
      'Recalculation successful',
      name: 'success_recalulate',
      desc: '',
      args: [],
    );
  }

  /// `Meal removed successfully`
  String get success_remove_meal {
    return Intl.message(
      'Meal removed successfully',
      name: 'success_remove_meal',
      desc: '',
      args: [],
    );
  }

  /// `Meal added successfully`
  String get success_add_meal {
    return Intl.message(
      'Meal added successfully',
      name: 'success_add_meal',
      desc: '',
      args: [],
    );
  }

  /// `No meal selected`
  String get add_meal_hint {
    return Intl.message(
      'No meal selected',
      name: 'add_meal_hint',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get qunatity {
    return Intl.message(
      'Quantity',
      name: 'qunatity',
      desc: '',
      args: [],
    );
  }

  /// `Add Reminder`
  String get add_reminder {
    return Intl.message(
      'Add Reminder',
      name: 'add_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `ml`
  String get ml {
    return Intl.message(
      'ml',
      name: 'ml',
      desc: '',
      args: [],
    );
  }

  /// `Auto Reminder`
  String get auto_reminder {
    return Intl.message(
      'Auto Reminder',
      name: 'auto_reminder',
      desc: '',
      args: [],
    );
  }

  /// `It's time to drink your water`
  String get time_to_drink {
    return Intl.message(
      'It\'s time to drink your water',
      name: 'time_to_drink',
      desc: '',
      args: [],
    );
  }

  /// `Reminder to drink water`
  String get reminder_to_drink {
    return Intl.message(
      'Reminder to drink water',
      name: 'reminder_to_drink',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Successfully removed`
  String get success_remove_reminder {
    return Intl.message(
      'Successfully removed',
      name: 'success_remove_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Successfully updated`
  String get success_update_reminder {
    return Intl.message(
      'Successfully updated',
      name: 'success_update_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Time must be in the future`
  String get time_is_after_error {
    return Intl.message(
      'Time must be in the future',
      name: 'time_is_after_error',
      desc: '',
      args: [],
    );
  }

  /// `Add New Section`
  String get add_new_section {
    return Intl.message(
      'Add New Section',
      name: 'add_new_section',
      desc: '',
      args: [],
    );
  }

  /// `Add New Exercise`
  String get add_new_exercise {
    return Intl.message(
      'Add New Exercise',
      name: 'add_new_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Edit Section`
  String get edit_section {
    return Intl.message(
      'Edit Section',
      name: 'edit_section',
      desc: '',
      args: [],
    );
  }

  /// `Section Name`
  String get section_name {
    return Intl.message(
      'Section Name',
      name: 'section_name',
      desc: '',
      args: [],
    );
  }

  /// `Section Order`
  String get section_order {
    return Intl.message(
      'Section Order',
      name: 'section_order',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get add_image {
    return Intl.message(
      'Add Image',
      name: 'add_image',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get change_image {
    return Intl.message(
      'Change Image',
      name: 'change_image',
      desc: '',
      args: [],
    );
  }

  /// `Added successfully`
  String get success_add_a {
    return Intl.message(
      'Added successfully',
      name: 'success_add_a',
      desc: '',
      args: [],
    );
  }

  /// `Edited successfully`
  String get success_edit_a {
    return Intl.message(
      'Edited successfully',
      name: 'success_edit_a',
      desc: '',
      args: [],
    );
  }

  /// `No image selected`
  String get image_error {
    return Intl.message(
      'No image selected',
      name: 'image_error',
      desc: '',
      args: [],
    );
  }

  /// `Add Exercise`
  String get add_exercise {
    return Intl.message(
      'Add Exercise',
      name: 'add_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Edit Exercise`
  String get edit_exercise {
    return Intl.message(
      'Edit Exercise',
      name: 'edit_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Name`
  String get exercise_name {
    return Intl.message(
      'Exercise Name',
      name: 'exercise_name',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Description`
  String get exercise_description {
    return Intl.message(
      'Exercise Description',
      name: 'exercise_description',
      desc: '',
      args: [],
    );
  }

  /// `YouTube Link`
  String get youtub_uri {
    return Intl.message(
      'YouTube Link',
      name: 'youtub_uri',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid link`
  String get youtub_uri_hint {
    return Intl.message(
      'Please enter a valid link',
      name: 'youtub_uri_hint',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message(
      'Optional',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `The exercise will be reviewed and added soon`
  String get review_suggest_exercise {
    return Intl.message(
      'The exercise will be reviewed and added soon',
      name: 'review_suggest_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Exercise suggested successfully`
  String get success_suggest_exercise {
    return Intl.message(
      'Exercise suggested successfully',
      name: 'success_suggest_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Exercises`
  String get suggested_exercises {
    return Intl.message(
      'Suggested Exercises',
      name: 'suggested_exercises',
      desc: '',
      args: [],
    );
  }

  /// `No exercises suggested yet`
  String get no_exercises_yet {
    return Intl.message(
      'No exercises suggested yet',
      name: 'no_exercises_yet',
      desc: '',
      args: [],
    );
  }

  /// `Add Article`
  String get add_article {
    return Intl.message(
      'Add Article',
      name: 'add_article',
      desc: '',
      args: [],
    );
  }

  /// `Edit Article`
  String get edit_article {
    return Intl.message(
      'Edit Article',
      name: 'edit_article',
      desc: '',
      args: [],
    );
  }

  /// `Pending Articles`
  String get penging_articles {
    return Intl.message(
      'Pending Articles',
      name: 'penging_articles',
      desc: '',
      args: [],
    );
  }

  /// `Remove Article`
  String get remove_article {
    return Intl.message(
      'Remove Article',
      name: 'remove_article',
      desc: '',
      args: [],
    );
  }

  /// `No Pending Articles`
  String get no_pending_articles {
    return Intl.message(
      'No Pending Articles',
      name: 'no_pending_articles',
      desc: '',
      args: [],
    );
  }

  /// `Article Name`
  String get article_name {
    return Intl.message(
      'Article Name',
      name: 'article_name',
      desc: '',
      args: [],
    );
  }

  /// `Article Body`
  String get article_body {
    return Intl.message(
      'Article Body',
      name: 'article_body',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Refuse`
  String get refuse {
    return Intl.message(
      'Refuse',
      name: 'refuse',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove the article ?`
  String get q_remove_article {
    return Intl.message(
      'Do you want to remove the article ?',
      name: 'q_remove_article',
      desc: '',
      args: [],
    );
  }

  /// `This article has been banned`
  String get success_banned {
    return Intl.message(
      'This article has been banned',
      name: 'success_banned',
      desc: '',
      args: [],
    );
  }

  /// `Ban Article`
  String get ban_article {
    return Intl.message(
      'Ban Article',
      name: 'ban_article',
      desc: '',
      args: [],
    );
  }

  /// `Your article has been accepted`
  String get accept_your_article {
    return Intl.message(
      'Your article has been accepted',
      name: 'accept_your_article',
      desc: '',
      args: [],
    );
  }

  /// `Your article has been refused`
  String get refuse_your_article {
    return Intl.message(
      'Your article has been refused',
      name: 'refuse_your_article',
      desc: '',
      args: [],
    );
  }

  /// `Your article has been banned`
  String get ban_your_article {
    return Intl.message(
      'Your article has been banned',
      name: 'ban_your_article',
      desc: '',
      args: [],
    );
  }

  /// `New comment on your question`
  String get new_comment_question {
    return Intl.message(
      'New comment on your question',
      name: 'new_comment_question',
      desc: '',
      args: [],
    );
  }

  /// `Your question has been banned`
  String get ban_your_question {
    return Intl.message(
      'Your question has been banned',
      name: 'ban_your_question',
      desc: '',
      args: [],
    );
  }

  /// `This question has been banned because it violates the terms`
  String get why_ban_question {
    return Intl.message(
      'This question has been banned because it violates the terms',
      name: 'why_ban_question',
      desc: '',
      args: [],
    );
  }

  /// `My Articles`
  String get your_articles {
    return Intl.message(
      'My Articles',
      name: 'your_articles',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Admin Control Panel`
  String get admin_control_panel {
    return Intl.message(
      'Admin Control Panel',
      name: 'admin_control_panel',
      desc: '',
      args: [],
    );
  }

  /// `Writer's Articles`
  String get writer_articles {
    return Intl.message(
      'Writer\'s Articles',
      name: 'writer_articles',
      desc: '',
      args: [],
    );
  }

  /// `This article has been removed`
  String get article_removed {
    return Intl.message(
      'This article has been removed',
      name: 'article_removed',
      desc: '',
      args: [],
    );
  }

  /// `All Users`
  String get all_users {
    return Intl.message(
      'All Users',
      name: 'all_users',
      desc: '',
      args: [],
    );
  }

  /// `Writers`
  String get writers {
    return Intl.message(
      'Writers',
      name: 'writers',
      desc: '',
      args: [],
    );
  }

  /// `Trainers`
  String get trainers {
    return Intl.message(
      'Trainers',
      name: 'trainers',
      desc: '',
      args: [],
    );
  }

  /// `Gym Owners`
  String get gym_owners {
    return Intl.message(
      'Gym Owners',
      name: 'gym_owners',
      desc: '',
      args: [],
    );
  }

  /// `Store Owners`
  String get store_owners {
    return Intl.message(
      'Store Owners',
      name: 'store_owners',
      desc: '',
      args: [],
    );
  }

  /// `Promotion Requests`
  String get promotion {
    return Intl.message(
      'Promotion Requests',
      name: 'promotion',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Build Store`
  String get build_store {
    return Intl.message(
      'Build Store',
      name: 'build_store',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get store_name {
    return Intl.message(
      'Store Name',
      name: 'store_name',
      desc: '',
      args: [],
    );
  }

  /// `Contact Number`
  String get store_contact {
    return Intl.message(
      'Contact Number',
      name: 'store_contact',
      desc: '',
      args: [],
    );
  }

  /// `Edit Store`
  String get edit_store {
    return Intl.message(
      'Edit Store',
      name: 'edit_store',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get add_product {
    return Intl.message(
      'Add Product',
      name: 'add_product',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get edit_product {
    return Intl.message(
      'Edit Product',
      name: 'edit_product',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get product_name {
    return Intl.message(
      'Product Name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get product_price {
    return Intl.message(
      'Product Price',
      name: 'product_price',
      desc: '',
      args: [],
    );
  }

  /// `Product Old Price`
  String get product_old_price {
    return Intl.message(
      'Product Old Price',
      name: 'product_old_price',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove the product?`
  String get remove_product_q {
    return Intl.message(
      'Do you want to remove the product?',
      name: 'remove_product_q',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get best_seller {
    return Intl.message(
      'Best Seller',
      name: 'best_seller',
      desc: '',
      args: [],
    );
  }

  /// `Product Description`
  String get product_description {
    return Intl.message(
      'Product Description',
      name: 'product_description',
      desc: '',
      args: [],
    );
  }

  /// `Product Type`
  String get product_type {
    return Intl.message(
      'Product Type',
      name: 'product_type',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get sale {
    return Intl.message(
      'Sale',
      name: 'sale',
      desc: '',
      args: [],
    );
  }

  /// `Current price cannot be greater than or equal to the old price`
  String get oldprice_hint_error {
    return Intl.message(
      'Current price cannot be greater than or equal to the old price',
      name: 'oldprice_hint_error',
      desc: '',
      args: [],
    );
  }

  /// `Product type must be selected`
  String get product_type_hint {
    return Intl.message(
      'Product type must be selected',
      name: 'product_type_hint',
      desc: '',
      args: [],
    );
  }

  /// `No products yet`
  String get no_products_yet {
    return Intl.message(
      'No products yet',
      name: 'no_products_yet',
      desc: '',
      args: [],
    );
  }

  /// `This product has been removed`
  String get product_removed {
    return Intl.message(
      'This product has been removed',
      name: 'product_removed',
      desc: '',
      args: [],
    );
  }

  /// `Add Gym`
  String get add_gym {
    return Intl.message(
      'Add Gym',
      name: 'add_gym',
      desc: '',
      args: [],
    );
  }

  /// `Edit Gym`
  String get edit_gym {
    return Intl.message(
      'Edit Gym',
      name: 'edit_gym',
      desc: '',
      args: [],
    );
  }

  /// `Gym Name`
  String get gym_name {
    return Intl.message(
      'Gym Name',
      name: 'gym_name',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get gym_description {
    return Intl.message(
      'Description',
      name: 'gym_description',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Price`
  String get price_sub {
    return Intl.message(
      'Subscription Price',
      name: 'price_sub',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get gym_location {
    return Intl.message(
      'Location',
      name: 'gym_location',
      desc: '',
      args: [],
    );
  }

  /// `New Images`
  String get new_images {
    return Intl.message(
      'New Images',
      name: 'new_images',
      desc: '',
      args: [],
    );
  }

  /// `Old Images`
  String get old_images {
    return Intl.message(
      'Old Images',
      name: 'old_images',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get add_images {
    return Intl.message(
      'Add Images',
      name: 'add_images',
      desc: '',
      args: [],
    );
  }

  /// `This gym has been removed`
  String get gym_remove_hint {
    return Intl.message(
      'This gym has been removed',
      name: 'gym_remove_hint',
      desc: '',
      args: [],
    );
  }

  /// `Locate Gym`
  String get locate_gym {
    return Intl.message(
      'Locate Gym',
      name: 'locate_gym',
      desc: '',
      args: [],
    );
  }

  /// `Location has been set`
  String get success_locate_gym {
    return Intl.message(
      'Location has been set',
      name: 'success_locate_gym',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove this gym ?`
  String get gym_removed_hint {
    return Intl.message(
      'Do you want to remove this gym ?',
      name: 'gym_removed_hint',
      desc: '',
      args: [],
    );
  }

  /// `Gym location has not been set`
  String get location_gym_hint_error {
    return Intl.message(
      'Gym location has not been set',
      name: 'location_gym_hint_error',
      desc: '',
      args: [],
    );
  }

  /// `Gym Details`
  String get gym_details {
    return Intl.message(
      'Gym Details',
      name: 'gym_details',
      desc: '',
      args: [],
    );
  }

  /// `Subscribers`
  String get subcribers {
    return Intl.message(
      'Subscribers',
      name: 'subcribers',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Date`
  String get sub_date {
    return Intl.message(
      'Subscription Date',
      name: 'sub_date',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get end_date {
    return Intl.message(
      'End Date',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `You are already subscribed to this gym`
  String get sub_hint {
    return Intl.message(
      'You are already subscribed to this gym',
      name: 'sub_hint',
      desc: '',
      args: [],
    );
  }

  /// `Zain Cash`
  String get zain_cash {
    return Intl.message(
      'Zain Cash',
      name: 'zain_cash',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get Subscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'Subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `No subscriptions yet`
  String get no_sub {
    return Intl.message(
      'No subscriptions yet',
      name: 'no_sub',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to ban this gym ?`
  String get ban_gym_q {
    return Intl.message(
      'Do you want to ban this gym ?',
      name: 'ban_gym_q',
      desc: '',
      args: [],
    );
  }

  /// `Your gym has been banned. Please contact the administrator for more information.`
  String get banned_gym_hint {
    return Intl.message(
      'Your gym has been banned. Please contact the administrator for more information.',
      name: 'banned_gym_hint',
      desc: '',
      args: [],
    );
  }

  /// `Remove Ban`
  String get no_ban {
    return Intl.message(
      'Remove Ban',
      name: 'no_ban',
      desc: '',
      args: [],
    );
  }

  /// `Ban`
  String get ban {
    return Intl.message(
      'Ban',
      name: 'ban',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove the ban ?`
  String get no_ban_question {
    return Intl.message(
      'Do you want to remove the ban ?',
      name: 'no_ban_question',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to ban this article?`
  String get ban_question {
    return Intl.message(
      'Do you want to ban this article?',
      name: 'ban_question',
      desc: '',
      args: [],
    );
  }

  /// `The ban on your gym has been lifted`
  String get no_banned_gym_hint {
    return Intl.message(
      'The ban on your gym has been lifted',
      name: 'no_banned_gym_hint',
      desc: '',
      args: [],
    );
  }

  /// `The gym has been banned`
  String get ban_sucess_gym {
    return Intl.message(
      'The gym has been banned',
      name: 'ban_sucess_gym',
      desc: '',
      args: [],
    );
  }

  /// `The ban on the gym has been lifted`
  String get no_ban_success_gym {
    return Intl.message(
      'The ban on the gym has been lifted',
      name: 'no_ban_success_gym',
      desc: '',
      args: [],
    );
  }

  /// `Renew Subscription`
  String get renew_sub {
    return Intl.message(
      'Renew Subscription',
      name: 'renew_sub',
      desc: '',
      args: [],
    );
  }

  /// `Meal Name`
  String get meal_name {
    return Intl.message(
      'Meal Name',
      name: 'meal_name',
      desc: '',
      args: [],
    );
  }

  /// `Meal Details`
  String get meal_description {
    return Intl.message(
      'Meal Details',
      name: 'meal_description',
      desc: '',
      args: [],
    );
  }

  /// `Add Meal`
  String get new_meal {
    return Intl.message(
      'Add Meal',
      name: 'new_meal',
      desc: '',
      args: [],
    );
  }

  /// `Edit Meal`
  String get edit_meal {
    return Intl.message(
      'Edit Meal',
      name: 'edit_meal',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this meal ?`
  String get remove_meal_q {
    return Intl.message(
      'Do you want to delete this meal ?',
      name: 'remove_meal_q',
      desc: '',
      args: [],
    );
  }

  /// `Banned successfully`
  String get ban_succes {
    return Intl.message(
      'Banned successfully',
      name: 'ban_succes',
      desc: '',
      args: [],
    );
  }

  /// `Ban lifted successfully`
  String get no_ban_scucess {
    return Intl.message(
      'Ban lifted successfully',
      name: 'no_ban_scucess',
      desc: '',
      args: [],
    );
  }

  /// `Your article has been banned`
  String get ban_title_food {
    return Intl.message(
      'Your article has been banned',
      name: 'ban_title_food',
      desc: '',
      args: [],
    );
  }

  /// `The ban on your article has been lifted`
  String get no_ban_title_food {
    return Intl.message(
      'The ban on your article has been lifted',
      name: 'no_ban_title_food',
      desc: '',
      args: [],
    );
  }

  /// `This article has been banned`
  String get ban_food_hint {
    return Intl.message(
      'This article has been banned',
      name: 'ban_food_hint',
      desc: '',
      args: [],
    );
  }

  /// `Update successful`
  String get update_success {
    return Intl.message(
      'Update successful',
      name: 'update_success',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add New Category`
  String get add_nutrition_classification {
    return Intl.message(
      'Add New Category',
      name: 'add_nutrition_classification',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get edit_nutrition_classification {
    return Intl.message(
      'Edit Category',
      name: 'edit_nutrition_classification',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get classification_name {
    return Intl.message(
      'Category Name',
      name: 'classification_name',
      desc: '',
      args: [],
    );
  }

  /// `Add New Value`
  String get add_new_nutirtion {
    return Intl.message(
      'Add New Value',
      name: 'add_new_nutirtion',
      desc: '',
      args: [],
    );
  }

  /// `Edit Value`
  String get edit_nutirtion {
    return Intl.message(
      'Edit Value',
      name: 'edit_nutirtion',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this value?`
  String get remove_nutirtion {
    return Intl.message(
      'Do you want to delete this value?',
      name: 'remove_nutirtion',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this category ?`
  String get category_remove_question {
    return Intl.message(
      'Do you want to delete this category ?',
      name: 'category_remove_question',
      desc: '',
      args: [],
    );
  }

  /// `Supplement Name`
  String get supplement_name {
    return Intl.message(
      'Supplement Name',
      name: 'supplement_name',
      desc: '',
      args: [],
    );
  }

  /// `Supplement Description`
  String get supplemment_description {
    return Intl.message(
      'Supplement Description',
      name: 'supplemment_description',
      desc: '',
      args: [],
    );
  }

  /// `Add Supplement`
  String get add_supplement {
    return Intl.message(
      'Add Supplement',
      name: 'add_supplement',
      desc: '',
      args: [],
    );
  }

  /// `Edit Supplement`
  String get edit_supplememt {
    return Intl.message(
      'Edit Supplement',
      name: 'edit_supplememt',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this supplement ?`
  String get supplement_remove_question {
    return Intl.message(
      'Do you want to delete this supplement ?',
      name: 'supplement_remove_question',
      desc: '',
      args: [],
    );
  }

  /// `Category deleted`
  String get category_removed {
    return Intl.message(
      'Category deleted',
      name: 'category_removed',
      desc: '',
      args: [],
    );
  }

  /// `Supplement deleted`
  String get supplement_removed {
    return Intl.message(
      'Supplement deleted',
      name: 'supplement_removed',
      desc: '',
      args: [],
    );
  }

  /// `Supplement Details`
  String get supplement_details {
    return Intl.message(
      'Supplement Details',
      name: 'supplement_details',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this exercise ?`
  String get remove_exercise_question {
    return Intl.message(
      'Do you want to delete this exercise ?',
      name: 'remove_exercise_question',
      desc: '',
      args: [],
    );
  }

  /// `Exercise deleted`
  String get exercise_removed {
    return Intl.message(
      'Exercise deleted',
      name: 'exercise_removed',
      desc: '',
      args: [],
    );
  }

  /// `No users`
  String get no_users {
    return Intl.message(
      'No users',
      name: 'no_users',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to ban this store?`
  String get ban_store_question {
    return Intl.message(
      'Do you want to ban this store?',
      name: 'ban_store_question',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove the ban from this store ?`
  String get no_ban_store_question {
    return Intl.message(
      'Do you want to remove the ban from this store ?',
      name: 'no_ban_store_question',
      desc: '',
      args: [],
    );
  }

  /// `Your store has been banned. Please contact the administrator for more information.`
  String get ban_store_hint {
    return Intl.message(
      'Your store has been banned. Please contact the administrator for more information.',
      name: 'ban_store_hint',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get store_owner_products {
    return Intl.message(
      'Products',
      name: 'store_owner_products',
      desc: '',
      args: [],
    );
  }

  /// `Profits`
  String get profits {
    return Intl.message(
      'Profits',
      name: 'profits',
      desc: '',
      args: [],
    );
  }

  /// `Your store has been banned`
  String get ban_titile_store {
    return Intl.message(
      'Your store has been banned',
      name: 'ban_titile_store',
      desc: '',
      args: [],
    );
  }

  /// `The ban on your store has been lifted`
  String get no_ban_titile_store {
    return Intl.message(
      'The ban on your store has been lifted',
      name: 'no_ban_titile_store',
      desc: '',
      args: [],
    );
  }

  /// `Banned Stores`
  String get store_banned {
    return Intl.message(
      'Banned Stores',
      name: 'store_banned',
      desc: '',
      args: [],
    );
  }

  /// `Banned Gyms`
  String get gyms_banned {
    return Intl.message(
      'Banned Gyms',
      name: 'gyms_banned',
      desc: '',
      args: [],
    );
  }

  /// `Pincode`
  String get pincode {
    return Intl.message(
      'Pincode',
      name: 'pincode',
      desc: '',
      args: [],
    );
  }

  /// `Street/Area`
  String get area {
    return Intl.message(
      'Street/Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `House Number`
  String get house_noum {
    return Intl.message(
      'House Number',
      name: 'house_noum',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get total_price {
    return Intl.message(
      'Total Price',
      name: 'total_price',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get summary_deatils {
    return Intl.message(
      'Order Details',
      name: 'summary_deatils',
      desc: '',
      args: [],
    );
  }

  /// `Submit Order`
  String get submit_order {
    return Intl.message(
      'Submit Order',
      name: 'submit_order',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed successfully`
  String get order_placed {
    return Intl.message(
      'Your order has been placed successfully',
      name: 'order_placed',
      desc: '',
      args: [],
    );
  }

  /// `View Order Details`
  String get view_rder_details {
    return Intl.message(
      'View Order Details',
      name: 'view_rder_details',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Details`
  String get purchase_details {
    return Intl.message(
      'Purchase Details',
      name: 'purchase_details',
      desc: '',
      args: [],
    );
  }

  /// `Tracking`
  String get tracking {
    return Intl.message(
      'Tracking',
      name: 'tracking',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get order_id {
    return Intl.message(
      'Order ID',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get order_date {
    return Intl.message(
      'Order Date',
      name: 'order_date',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Your order is yet to be delivered`
  String get pending_message {
    return Intl.message(
      'Your order is yet to be delivered',
      name: 'pending_message',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been delivered, you are yet to sign.`
  String get completed_message {
    return Intl.message(
      'Your order has been delivered, you are yet to sign.',
      name: 'completed_message',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been delivered and signed by you`
  String get delivered_message {
    return Intl.message(
      'Your order has been delivered and signed by you',
      name: 'delivered_message',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Order received and profits added`
  String get order_delivered {
    return Intl.message(
      'Order received and profits added',
      name: 'order_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Rate this product from 1 to 5`
  String get rating_hint {
    return Intl.message(
      'Rate this product from 1 to 5',
      name: 'rating_hint',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get back_to_home {
    return Intl.message(
      'Back to Home',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Please rate the product`
  String get rating_product_hint {
    return Intl.message(
      'Please rate the product',
      name: 'rating_product_hint',
      desc: '',
      args: [],
    );
  }

  /// `Profits Requests`
  String get profits_request {
    return Intl.message(
      'Profits Requests',
      name: 'profits_request',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this gym?`
  String get gym_remove_question {
    return Intl.message(
      'Do you want to delete this gym?',
      name: 'gym_remove_question',
      desc: '',
      args: [],
    );
  }

  /// `Buy Orders`
  String get buy_orders {
    return Intl.message(
      'Buy Orders',
      name: 'buy_orders',
      desc: '',
      args: [],
    );
  }

  /// `Promotion to`
  String get promotion_to {
    return Intl.message(
      'Promotion to',
      name: 'promotion_to',
      desc: '',
      args: [],
    );
  }

  /// `Trainer account`
  String get trainer_acount {
    return Intl.message(
      'Trainer account',
      name: 'trainer_acount',
      desc: '',
      args: [],
    );
  }

  /// `Writer account`
  String get writer_acount {
    return Intl.message(
      'Writer account',
      name: 'writer_acount',
      desc: '',
      args: [],
    );
  }

  /// `Gym owner account`
  String get gym_owner_acount {
    return Intl.message(
      'Gym owner account',
      name: 'gym_owner_acount',
      desc: '',
      args: [],
    );
  }

  /// `Store owner account`
  String get store_owner_acount {
    return Intl.message(
      'Store owner account',
      name: 'store_owner_acount',
      desc: '',
      args: [],
    );
  }

  /// `Promotion request`
  String get promotion_request {
    return Intl.message(
      'Promotion request',
      name: 'promotion_request',
      desc: '',
      args: [],
    );
  }

  /// `New promotion request`
  String get new_promtion_request {
    return Intl.message(
      'New promotion request',
      name: 'new_promtion_request',
      desc: '',
      args: [],
    );
  }

  /// `Your promotion request has been submitted`
  String get request_promotion_done {
    return Intl.message(
      'Your promotion request has been submitted',
      name: 'request_promotion_done',
      desc: '',
      args: [],
    );
  }

  /// `Request under review`
  String get promotion_reqiest_review {
    return Intl.message(
      'Request under review',
      name: 'promotion_reqiest_review',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to request a promotion for your account ?`
  String get promotion_request_question {
    return Intl.message(
      'Do you want to request a promotion for your account ?',
      name: 'promotion_request_question',
      desc: '',
      args: [],
    );
  }

  /// `Promotion request accepted`
  String get accept_request_promotion {
    return Intl.message(
      'Promotion request accepted',
      name: 'accept_request_promotion',
      desc: '',
      args: [],
    );
  }

  /// `Promotion request refused`
  String get refuse_request_promotion {
    return Intl.message(
      'Promotion request refused',
      name: 'refuse_request_promotion',
      desc: '',
      args: [],
    );
  }

  /// `Please log out and log in again to access the new features and available promotions.`
  String get logout_and_login_again {
    return Intl.message(
      'Please log out and log in again to access the new features and available promotions.',
      name: 'logout_and_login_again',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulation {
    return Intl.message(
      'Congratulations',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `Activated`
  String get subed {
    return Intl.message(
      'Activated',
      name: 'subed',
      desc: '',
      args: [],
    );
  }

  /// `Ended`
  String get ended {
    return Intl.message(
      'Ended',
      name: 'ended',
      desc: '',
      args: [],
    );
  }

  /// `Edit Trainer Details`
  String get edit_trainer {
    return Intl.message(
      'Edit Trainer Details',
      name: 'edit_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Trainer Achievements`
  String get trainer_description {
    return Intl.message(
      'Trainer Achievements',
      name: 'trainer_description',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Price`
  String get traiber_price {
    return Intl.message(
      'Subscription Price',
      name: 'traiber_price',
      desc: '',
      args: [],
    );
  }

  /// `From Hour`
  String get from_w_h {
    return Intl.message(
      'From Hour',
      name: 'from_w_h',
      desc: '',
      args: [],
    );
  }

  /// `To Hour`
  String get to_w_h {
    return Intl.message(
      'To Hour',
      name: 'to_w_h',
      desc: '',
      args: [],
    );
  }

  /// `No Trainer`
  String get no_trainer {
    return Intl.message(
      'No Trainer',
      name: 'no_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Add New Work`
  String get add_new_gallery {
    return Intl.message(
      'Add New Work',
      name: 'add_new_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Before Image`
  String get image_before {
    return Intl.message(
      'Before Image',
      name: 'image_before',
      desc: '',
      args: [],
    );
  }

  /// `After Image`
  String get image_after {
    return Intl.message(
      'After Image',
      name: 'image_after',
      desc: '',
      args: [],
    );
  }

  /// `Please select images`
  String get image_hint {
    return Intl.message(
      'Please select images',
      name: 'image_hint',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this work ?`
  String get remove_gallery_hint {
    return Intl.message(
      'Do you want to delete this work ?',
      name: 'remove_gallery_hint',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to ban this trainer ?`
  String get ban_trainer_question {
    return Intl.message(
      'Do you want to ban this trainer ?',
      name: 'ban_trainer_question',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to unban this trainer ?`
  String get no_ban_trainer_question {
    return Intl.message(
      'Do you want to unban this trainer ?',
      name: 'no_ban_trainer_question',
      desc: '',
      args: [],
    );
  }

  /// `Dear trainer, we regret to inform you that your account has been banned by the administrator. If you have any questions or concerns, please contact our support team for assistance.`
  String get ban_title_trainer {
    return Intl.message(
      'Dear trainer, we regret to inform you that your account has been banned by the administrator. If you have any questions or concerns, please contact our support team for assistance.',
      name: 'ban_title_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Dear trainer, your ban has been lifted by the administrator.`
  String get no_ban_title_trainer {
    return Intl.message(
      'Dear trainer, your ban has been lifted by the administrator.',
      name: 'no_ban_title_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Dear user, we regret to inform you that your account has been banned by the administrator. If you have any questions or concerns, please contact our support team for assistance.`
  String get ban_title_user {
    return Intl.message(
      'Dear user, we regret to inform you that your account has been banned by the administrator. If you have any questions or concerns, please contact our support team for assistance.',
      name: 'ban_title_user',
      desc: '',
      args: [],
    );
  }

  /// `Dear user, your ban has been lifted by the administrator.`
  String get no_ban_title_user {
    return Intl.message(
      'Dear user, your ban has been lifted by the administrator.',
      name: 'no_ban_title_user',
      desc: '',
      args: [],
    );
  }

  /// `This trainer has been banned !`
  String get ban_hint_admin {
    return Intl.message(
      'This trainer has been banned !',
      name: 'ban_hint_admin',
      desc: '',
      args: [],
    );
  }

  /// `Banned Trainers`
  String get banned_trainers {
    return Intl.message(
      'Banned Trainers',
      name: 'banned_trainers',
      desc: '',
      args: [],
    );
  }

  /// `You are already subscribed to this trainer.`
  String get you_sub_with_trainer {
    return Intl.message(
      'You are already subscribed to this trainer.',
      name: 'you_sub_with_trainer',
      desc: '',
      args: [],
    );
  }

  /// `A new trainee has joined your team.`
  String get new_trainee_joined {
    return Intl.message(
      'A new trainee has joined your team.',
      name: 'new_trainee_joined',
      desc: '',
      args: [],
    );
  }

  /// `Trainee Profile`
  String get trainee_profile {
    return Intl.message(
      'Trainee Profile',
      name: 'trainee_profile',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Follow-up and Data`
  String get follow_and_data {
    return Intl.message(
      'Follow-up and Data',
      name: 'follow_and_data',
      desc: '',
      args: [],
    );
  }

  /// `Diet`
  String get diet {
    return Intl.message(
      'Diet',
      name: 'diet',
      desc: '',
      args: [],
    );
  }

  /// `Training Course`
  String get training_course {
    return Intl.message(
      'Training Course',
      name: 'training_course',
      desc: '',
      args: [],
    );
  }

  /// `Add New Course`
  String get add_new_course {
    return Intl.message(
      'Add New Course',
      name: 'add_new_course',
      desc: '',
      args: [],
    );
  }

  /// `Add New Diet Course`
  String get add_new_diet_course {
    return Intl.message(
      'Add New Diet Course',
      name: 'add_new_diet_course',
      desc: '',
      args: [],
    );
  }

  /// `Add New Supplement`
  String get add_new_supplemnet {
    return Intl.message(
      'Add New Supplement',
      name: 'add_new_supplemnet',
      desc: '',
      args: [],
    );
  }

  /// `Add New Follow-up`
  String get add_new_folow {
    return Intl.message(
      'Add New Follow-up',
      name: 'add_new_folow',
      desc: '',
      args: [],
    );
  }

  /// `Course Name`
  String get course_name {
    return Intl.message(
      'Course Name',
      name: 'course_name',
      desc: '',
      args: [],
    );
  }

  /// `Course Duration in Weeks`
  String get course_duration {
    return Intl.message(
      'Course Duration in Weeks',
      name: 'course_duration',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get course_notes {
    return Intl.message(
      'Notes',
      name: 'course_notes',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get sut {
    return Intl.message(
      'Saturday',
      name: 'sut',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sun {
    return Intl.message(
      'Sunday',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get mon {
    return Intl.message(
      'Monday',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tue {
    return Intl.message(
      'Tuesday',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wed {
    return Intl.message(
      'Wednesday',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thurs {
    return Intl.message(
      'Thursday',
      name: 'thurs',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get fri {
    return Intl.message(
      'Friday',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `Repeats`
  String get num_of_repeat {
    return Intl.message(
      'Repeats',
      name: 'num_of_repeat',
      desc: '',
      args: [],
    );
  }

  /// `Sets`
  String get num_of_reps {
    return Intl.message(
      'Sets',
      name: 'num_of_reps',
      desc: '',
      args: [],
    );
  }

  /// `Please complete data for at least three days`
  String get complete_lists {
    return Intl.message(
      'Please complete data for at least three days',
      name: 'complete_lists',
      desc: '',
      args: [],
    );
  }

  /// `Weeks`
  String get weeks {
    return Intl.message(
      'Weeks',
      name: 'weeks',
      desc: '',
      args: [],
    );
  }

  /// `Course Details`
  String get course_details {
    return Intl.message(
      'Course Details',
      name: 'course_details',
      desc: '',
      args: [],
    );
  }

  /// `Course Duration`
  String get duration_course {
    return Intl.message(
      'Course Duration',
      name: 'duration_course',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Course Creation Date`
  String get course_date {
    return Intl.message(
      'Course Creation Date',
      name: 'course_date',
      desc: '',
      args: [],
    );
  }

  /// `Add New Supplement`
  String get add_new_supplement {
    return Intl.message(
      'Add New Supplement',
      name: 'add_new_supplement',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this supplement?`
  String get remove_supplement_question {
    return Intl.message(
      'Do you want to delete this supplement?',
      name: 'remove_supplement_question',
      desc: '',
      args: [],
    );
  }

  /// `Add Diet Course`
  String get add_diet_course {
    return Intl.message(
      'Add Diet Course',
      name: 'add_diet_course',
      desc: '',
      args: [],
    );
  }

  /// `Diet Name`
  String get diet_name {
    return Intl.message(
      'Diet Name',
      name: 'diet_name',
      desc: '',
      args: [],
    );
  }

  /// `Diet Duration in Weeks`
  String get diet_duration {
    return Intl.message(
      'Diet Duration in Weeks',
      name: 'diet_duration',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this diet course?`
  String get remove_diet_question {
    return Intl.message(
      'Do you want to delete this diet course?',
      name: 'remove_diet_question',
      desc: '',
      args: [],
    );
  }

  /// `Diet Course Details`
  String get diet_course_details {
    return Intl.message(
      'Diet Course Details',
      name: 'diet_course_details',
      desc: '',
      args: [],
    );
  }

  /// `Trainee Questions`
  String get questions_trainee {
    return Intl.message(
      'Trainee Questions',
      name: 'questions_trainee',
      desc: '',
      args: [],
    );
  }

  /// `The questions that trainees under your supervision should answer during the program.`
  String get questions_trainee_hint {
    return Intl.message(
      'The questions that trainees under your supervision should answer during the program.',
      name: 'questions_trainee_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add New Question`
  String get add_new_question {
    return Intl.message(
      'Add New Question',
      name: 'add_new_question',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this question?`
  String get question_remove_question {
    return Intl.message(
      'Do you want to delete this question?',
      name: 'question_remove_question',
      desc: '',
      args: [],
    );
  }

  /// `Add New Follow-up`
  String get add_new_follow {
    return Intl.message(
      'Add New Follow-up',
      name: 'add_new_follow',
      desc: '',
      args: [],
    );
  }

  /// `Follow-up Details`
  String get follow_details {
    return Intl.message(
      'Follow-up Details',
      name: 'follow_details',
      desc: '',
      args: [],
    );
  }

  /// `Answer`
  String get answer_question {
    return Intl.message(
      'Answer',
      name: 'answer_question',
      desc: '',
      args: [],
    );
  }

  /// `You are unsubscribed from the trainer.`
  String get you_unsub_with_trainer {
    return Intl.message(
      'You are unsubscribed from the trainer.',
      name: 'you_unsub_with_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to a trainer and try again.`
  String get sub_with_trainer_and_try_again {
    return Intl.message(
      'Subscribe to a trainer and try again.',
      name: 'sub_with_trainer_and_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a current body image for the trainer. It will help them assess your progress and provide more personalized guidance. This image will serve as an important reference for the trainer to understand your body details and individual needs.`
  String get image_tariner_hint {
    return Intl.message(
      'Please upload a current body image for the trainer. It will help them assess your progress and provide more personalized guidance. This image will serve as an important reference for the trainer to understand your body details and individual needs.',
      name: 'image_tariner_hint',
      desc: '',
      args: [],
    );
  }

  /// `This trainee's subscription has expired, and they need to renew the subscription first to be able to update their training course.`
  String get sub_end_waring_trainer {
    return Intl.message(
      'This trainee\'s subscription has expired, and they need to renew the subscription first to be able to update their training course.',
      name: 'sub_end_waring_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription has expired, and you need to renew the subscription to continue with this trainer's training course.`
  String get sub_end_waring_trainee {
    return Intl.message(
      'Your subscription has expired, and you need to renew the subscription to continue with this trainer\'s training course.',
      name: 'sub_end_waring_trainee',
      desc: '',
      args: [],
    );
  }

  /// `The trainee has added a new follow-up.`
  String get follow_title {
    return Intl.message(
      'The trainee has added a new follow-up.',
      name: 'follow_title',
      desc: '',
      args: [],
    );
  }

  /// `Your trainer has updated the training course.`
  String get course_title {
    return Intl.message(
      'Your trainer has updated the training course.',
      name: 'course_title',
      desc: '',
      args: [],
    );
  }

  /// `The trainee has renewed the subscription.`
  String get renew_trainee_title {
    return Intl.message(
      'The trainee has renewed the subscription.',
      name: 'renew_trainee_title',
      desc: '',
      args: [],
    );
  }

  /// `Type a message`
  String get type_a_message {
    return Intl.message(
      'Type a message',
      name: 'type_a_message',
      desc: '',
      args: [],
    );
  }

  /// `New message`
  String get new_message {
    return Intl.message(
      'New message',
      name: 'new_message',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet`
  String get no_messages_yet {
    return Intl.message(
      'No messages yet',
      name: 'no_messages_yet',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Meals`
  String get favorite_meals {
    return Intl.message(
      'Favorite Meals',
      name: 'favorite_meals',
      desc: '',
      args: [],
    );
  }

  /// `File saved successfully`
  String get success_save_excel_sheet {
    return Intl.message(
      'File saved successfully',
      name: 'success_save_excel_sheet',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Tamrini application`
  String get hello_in_tamrimni {
    return Intl.message(
      'Welcome to the Tamrini application',
      name: 'hello_in_tamrimni',
      desc: '',
      args: [],
    );
  }

  /// `Rate this trainer from 1 to 5`
  String get rating_trainer_hint {
    return Intl.message(
      'Rate this trainer from 1 to 5',
      name: 'rating_trainer_hint',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your rating`
  String get thanks_for_rating {
    return Intl.message(
      'Thank you for your rating',
      name: 'thanks_for_rating',
      desc: '',
      args: [],
    );
  }

  /// `Banners`
  String get banners {
    return Intl.message(
      'Banners',
      name: 'banners',
      desc: '',
      args: [],
    );
  }

  /// `Add New Banner`
  String get add_new_banner {
    return Intl.message(
      'Add New Banner',
      name: 'add_new_banner',
      desc: '',
      args: [],
    );
  }

  /// `Edit Banner`
  String get edit_banner {
    return Intl.message(
      'Edit Banner',
      name: 'edit_banner',
      desc: '',
      args: [],
    );
  }

  /// `Remove Banner`
  String get remove_banner {
    return Intl.message(
      'Remove Banner',
      name: 'remove_banner',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove this banner?`
  String get remove_banner_question {
    return Intl.message(
      'Do you want to remove this banner?',
      name: 'remove_banner_question',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get banner_uri {
    return Intl.message(
      'URL',
      name: 'banner_uri',
      desc: '',
      args: [],
    );
  }

  /// `You cannot edit due to a ban`
  String get no_edit_ban {
    return Intl.message(
      'You cannot edit due to a ban',
      name: 'no_edit_ban',
      desc: '',
      args: [],
    );
  }

  /// `Request Profits`
  String get request_profits {
    return Intl.message(
      'Request Profits',
      name: 'request_profits',
      desc: '',
      args: [],
    );
  }

  /// `You cannot withdraw an amount less than 1,00000 dinars`
  String get request_profits_hint {
    return Intl.message(
      'You cannot withdraw an amount less than 1,00000 dinars',
      name: 'request_profits_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please note that you can only withdraw your profits when they reach the minimum required amount, which is 1,00000. Once you achieve this amount, you will be able to easily withdraw your profits. Keep up the good work!`
  String get warning_the_user_profits {
    return Intl.message(
      'Please note that you can only withdraw your profits when they reach the minimum required amount, which is 1,00000. Once you achieve this amount, you will be able to easily withdraw your profits. Keep up the good work!',
      name: 'warning_the_user_profits',
      desc: '',
      args: [],
    );
  }

  /// `Request New Profit Withdrawal`
  String get request_profits_title {
    return Intl.message(
      'Request New Profit Withdrawal',
      name: 'request_profits_title',
      desc: '',
      args: [],
    );
  }

  /// `Profit withdrawal request accepted and profits successfully sent to your account`
  String get accept_profits {
    return Intl.message(
      'Profit withdrawal request accepted and profits successfully sent to your account',
      name: 'accept_profits',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again`
  String get error_payment {
    return Intl.message(
      'An error occurred. Please try again',
      name: 'error_payment',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful. You can now proceed with the operation`
  String get payment_success {
    return Intl.message(
      'Payment successful. You can now proceed with the operation',
      name: 'payment_success',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your payment has been successfully processed. You can now continue your subscription and enjoy personalized training sessions with your dedicated trainer. Get ready to achieve your fitness goals together!`
  String get trainer_success_payment {
    return Intl.message(
      'Congratulations! Your payment has been successfully processed. You can now continue your subscription and enjoy personalized training sessions with your dedicated trainer. Get ready to achieve your fitness goals together!',
      name: 'trainer_success_payment',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription payment has been successfully processed. You are now able to continue your subscription. You are now an official member of our gym. Get ready to embark on an exciting fitness journey with access to state-of-the-art facilities, expert trainers, and a vibrant community. Start working towards a healthier and stronger you today!`
  String get gym_success_payment {
    return Intl.message(
      'Your subscription payment has been successfully processed. You are now able to continue your subscription. You are now an official member of our gym. Get ready to embark on an exciting fitness journey with access to state-of-the-art facilities, expert trainers, and a vibrant community. Start working towards a healthier and stronger you today!',
      name: 'gym_success_payment',
      desc: '',
      args: [],
    );
  }

  /// `End Process`
  String get end_progress {
    return Intl.message(
      'End Process',
      name: 'end_progress',
      desc: '',
      args: [],
    );
  }

  /// `Payment link created successfully. You can complete the payment process and return to finalize the operation`
  String get create_payment_uri_success {
    return Intl.message(
      'Payment link created successfully. You can complete the payment process and return to finalize the operation',
      name: 'create_payment_uri_success',
      desc: '',
      args: [],
    );
  }

  /// `Payment Link`
  String get payment_uri {
    return Intl.message(
      'Payment Link',
      name: 'payment_uri',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get price {
    return Intl.message(
      'Amount',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get total_price_payment {
    return Intl.message(
      'Total Amount',
      name: 'total_price_payment',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get fees {
    return Intl.message(
      'Fees',
      name: 'fees',
      desc: '',
      args: [],
    );
  }

  /// `You will pay with Zain Cash wallet`
  String get you_will_pay_with_zain_cash {
    return Intl.message(
      'You will pay with Zain Cash wallet',
      name: 'you_will_pay_with_zain_cash',
      desc: '',
      args: [],
    );
  }

  /// `Please make the payment using the payment link first to proceed`
  String get pending_hint_payment {
    return Intl.message(
      'Please make the payment using the payment link first to proceed',
      name: 'pending_hint_payment',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Please try again`
  String get please_try_again {
    return Intl.message(
      'Please try again',
      name: 'please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful`
  String get payment_success_button {
    return Intl.message(
      'Payment Successful',
      name: 'payment_success_button',
      desc: '',
      args: [],
    );
  }

  /// `Select the meal size you want`
  String get select_meal_wieght {
    return Intl.message(
      'Select the meal size you want',
      name: 'select_meal_wieght',
      desc: '',
      args: [],
    );
  }

  /// `Tap to change the meal size`
  String get tap_to_cahnge_meal_wieght {
    return Intl.message(
      'Tap to change the meal size',
      name: 'tap_to_cahnge_meal_wieght',
      desc: '',
      args: [],
    );
  }

  /// `Please calculate your requirements before selecting meals`
  String get claculate_your_calories_before {
    return Intl.message(
      'Please calculate your requirements before selecting meals',
      name: 'claculate_your_calories_before',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the process to confirm the subscription`
  String get please_end_to_sub {
    return Intl.message(
      'Please complete the process to confirm the subscription',
      name: 'please_end_to_sub',
      desc: '',
      args: [],
    );
  }

  /// `Subscription successful`
  String get success_sub {
    return Intl.message(
      'Subscription successful',
      name: 'success_sub',
      desc: '',
      args: [],
    );
  }

  /// `You can directly add a product from the nutritional supplements section in the Health and Nutrition category`
  String get add_product_note {
    return Intl.message(
      'You can directly add a product from the nutritional supplements section in the Health and Nutrition category',
      name: 'add_product_note',
      desc: '',
      args: [],
    );
  }

  /// `Add to your store`
  String get add_to_your_store {
    return Intl.message(
      'Add to your store',
      name: 'add_to_your_store',
      desc: '',
      args: [],
    );
  }

  /// `Price cannot be zero`
  String get price_cant_be_zero {
    return Intl.message(
      'Price cannot be zero',
      name: 'price_cant_be_zero',
      desc: '',
      args: [],
    );
  }

  /// `Accept Request`
  String get accept_reqest {
    return Intl.message(
      'Accept Request',
      name: 'accept_reqest',
      desc: '',
      args: [],
    );
  }

  /// `Total Balance`
  String get total_profits {
    return Intl.message(
      'Total Balance',
      name: 'total_profits',
      desc: '',
      args: [],
    );
  }

  /// `Available Balance`
  String get avaliabe_profits {
    return Intl.message(
      'Available Balance',
      name: 'avaliabe_profits',
      desc: '',
      args: [],
    );
  }

  /// `Pending Balance`
  String get pendding_profits {
    return Intl.message(
      'Pending Balance',
      name: 'pendding_profits',
      desc: '',
      args: [],
    );
  }

  /// `Enter the desired value`
  String get enter_profits_value {
    return Intl.message(
      'Enter the desired value',
      name: 'enter_profits_value',
      desc: '',
      args: [],
    );
  }

  /// `Enter your e-wallet number`
  String get enter_your_cash_number {
    return Intl.message(
      'Enter your e-wallet number',
      name: 'enter_your_cash_number',
      desc: '',
      args: [],
    );
  }

  /// `E-Wallet`
  String get cash_number {
    return Intl.message(
      'E-Wallet',
      name: 'cash_number',
      desc: '',
      args: [],
    );
  }

  /// `Profit Withdrawal Requests`
  String get your_profit_requests {
    return Intl.message(
      'Profit Withdrawal Requests',
      name: 'your_profit_requests',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Under Review`
  String get waiting_status {
    return Intl.message(
      'Under Review',
      name: 'waiting_status',
      desc: '',
      args: [],
    );
  }

  /// `Ended`
  String get ended_status {
    return Intl.message(
      'Ended',
      name: 'ended_status',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient balance`
  String get no_enough_profits {
    return Intl.message(
      'Insufficient balance',
      name: 'no_enough_profits',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Number`
  String get cash_num {
    return Intl.message(
      'Wallet Number',
      name: 'cash_num',
      desc: '',
      args: [],
    );
  }

  /// `The exercise was transferred successfully.`
  String get success_move_exercise {
    return Intl.message(
      'The exercise was transferred successfully.',
      name: 'success_move_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to move the exercise to this category?`
  String get move_exercise_to_category {
    return Intl.message(
      'Do you want to move the exercise to this category?',
      name: 'move_exercise_to_category',
      desc: '',
      args: [],
    );
  }

  /// `Please log in first to continue.`
  String get login_first_please {
    return Intl.message(
      'Please log in first to continue.',
      name: 'login_first_please',
      desc: '',
      args: [],
    );
  }

  /// `If you choose to delete, we will delete your account from our server. \nYour application data will also be deleted and cannot be recovered.`
  String get delete_account_hint {
    return Intl.message(
      'If you choose to delete, we will delete your account from our server. \nYour application data will also be deleted and cannot be recovered.',
      name: 'delete_account_hint',
      desc: '',
      args: [],
    );
  }

  /// `Delete your account?`
  String get delete_account_question {
    return Intl.message(
      'Delete your account?',
      name: 'delete_account_question',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Please log in again to confirm the account`
  String get re_auth_account {
    return Intl.message(
      'Please log in again to confirm the account',
      name: 're_auth_account',
      desc: '',
      args: [],
    );
  }

  /// `Logo image`
  String get logo_image {
    return Intl.message(
      'Logo image',
      name: 'logo_image',
      desc: '',
      args: [],
    );
  }

  /// `new order waiting`
  String get new_order {
    return Intl.message(
      'new order waiting',
      name: 'new_order',
      desc: '',
      args: [],
    );
  }

  /// `Choose your Theme`
  String get choose_your_theme {
    return Intl.message(
      'Choose your Theme',
      name: 'choose_your_theme',
      desc: '',
      args: [],
    );
  }

  /// `Successfully ban this user`
  String get ban_user_success {
    return Intl.message(
      'Successfully ban this user',
      name: 'ban_user_success',
      desc: '',
      args: [],
    );
  }

  /// `Successfully unban this user`
  String get no_ban_user_success {
    return Intl.message(
      'Successfully unban this user',
      name: 'no_ban_user_success',
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
