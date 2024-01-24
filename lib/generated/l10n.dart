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

  /// `Question deleted successfully`
  String get success_remove {
    return Intl.message(
      'Question deleted successfully',
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

  /// `Question restricted successfully`
  String get success_ban {
    return Intl.message(
      'Question restricted successfully',
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
  String get edit_question {
    return Intl.message(
      'Edit',
      name: 'edit_question',
      desc: '',
      args: [],
    );
  }

  /// `Restrict`
  String get ban_question {
    return Intl.message(
      'Restrict',
      name: 'ban_question',
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

  /// `Carbohydrates`
  String get carb {
    return Intl.message(
      'Carbohydrates',
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

  /// `إعادة الحساب`
  String get recalculate {
    return Intl.message(
      'إعادة الحساب',
      name: 'recalculate',
      desc: '',
      args: [],
    );
  }

  /// `باقي احتياجك`
  String get your_need {
    return Intl.message(
      'باقي احتياجك',
      name: 'your_need',
      desc: '',
      args: [],
    );
  }

  /// `وجباتك`
  String get your_meals {
    return Intl.message(
      'وجباتك',
      name: 'your_meals',
      desc: '',
      args: [],
    );
  }

  /// `اسجب الوجبة أفقيا للحذف`
  String get scroll_verticle_to_remove {
    return Intl.message(
      'اسجب الوجبة أفقيا للحذف',
      name: 'scroll_verticle_to_remove',
      desc: '',
      args: [],
    );
  }

  /// `اضافة وجبة`
  String get add_meal {
    return Intl.message(
      'اضافة وجبة',
      name: 'add_meal',
      desc: '',
      args: [],
    );
  }

  /// `حفظ`
  String get save {
    return Intl.message(
      'حفظ',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد وجبات`
  String get no_meals {
    return Intl.message(
      'لا يوجد وجبات',
      name: 'no_meals',
      desc: '',
      args: [],
    );
  }

  /// `إضافة اليوم الحالي`
  String get add_today {
    return Intl.message(
      'إضافة اليوم الحالي',
      name: 'add_today',
      desc: '',
      args: [],
    );
  }

  /// `اليوم الحالي مضاف بالفعل`
  String get add_today_hint {
    return Intl.message(
      'اليوم الحالي مضاف بالفعل',
      name: 'add_today_hint',
      desc: '',
      args: [],
    );
  }

  /// `تمت إعادة الحساب بنجاح`
  String get success_recalulate {
    return Intl.message(
      'تمت إعادة الحساب بنجاح',
      name: 'success_recalulate',
      desc: '',
      args: [],
    );
  }

  /// `تمت حذف الوجبة بنجاح`
  String get success_remove_meal {
    return Intl.message(
      'تمت حذف الوجبة بنجاح',
      name: 'success_remove_meal',
      desc: '',
      args: [],
    );
  }

  /// `تمت إضافة الوجبة بنجاح`
  String get success_add_meal {
    return Intl.message(
      'تمت إضافة الوجبة بنجاح',
      name: 'success_add_meal',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم اختيار وجبة`
  String get add_meal_hint {
    return Intl.message(
      'لم يتم اختيار وجبة',
      name: 'add_meal_hint',
      desc: '',
      args: [],
    );
  }

  /// `تذكير`
  String get reminder {
    return Intl.message(
      'تذكير',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `التاريخ`
  String get history {
    return Intl.message(
      'التاريخ',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `الوقت`
  String get time {
    return Intl.message(
      'الوقت',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `الكمية`
  String get qunatity {
    return Intl.message(
      'الكمية',
      name: 'qunatity',
      desc: '',
      args: [],
    );
  }

  /// `إضافة تذكير`
  String get add_reminder {
    return Intl.message(
      'إضافة تذكير',
      name: 'add_reminder',
      desc: '',
      args: [],
    );
  }

  /// `تكرار`
  String get repeat {
    return Intl.message(
      'تكرار',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل`
  String get submit {
    return Intl.message(
      'تفعيل',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `ملي`
  String get ml {
    return Intl.message(
      'ملي',
      name: 'ml',
      desc: '',
      args: [],
    );
  }

  /// `التذكير التلقائي`
  String get auto_reminder {
    return Intl.message(
      'التذكير التلقائي',
      name: 'auto_reminder',
      desc: '',
      args: [],
    );
  }

  /// `حان وقت شرب الماء الخاص بك`
  String get time_to_drink {
    return Intl.message(
      'حان وقت شرب الماء الخاص بك',
      name: 'time_to_drink',
      desc: '',
      args: [],
    );
  }

  /// `تذكير لشرب الماء`
  String get reminder_to_drink {
    return Intl.message(
      'تذكير لشرب الماء',
      name: 'reminder_to_drink',
      desc: '',
      args: [],
    );
  }

  /// `ساعة`
  String get hour {
    return Intl.message(
      'ساعة',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `ساعات`
  String get hours {
    return Intl.message(
      'ساعات',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `دقيقة`
  String get minute {
    return Intl.message(
      'دقيقة',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `تم الحذف بنجاح`
  String get success_remove_reminder {
    return Intl.message(
      'تم الحذف بنجاح',
      name: 'success_remove_reminder',
      desc: '',
      args: [],
    );
  }

  /// `تم التعديل بنجاح`
  String get success_update_reminder {
    return Intl.message(
      'تم التعديل بنجاح',
      name: 'success_update_reminder',
      desc: '',
      args: [],
    );
  }

  /// `لابد أن يكون الوقت في المستقبل`
  String get time_is_after_error {
    return Intl.message(
      'لابد أن يكون الوقت في المستقبل',
      name: 'time_is_after_error',
      desc: '',
      args: [],
    );
  }

  /// `إضافة قسم جديد`
  String get add_new_section {
    return Intl.message(
      'إضافة قسم جديد',
      name: 'add_new_section',
      desc: '',
      args: [],
    );
  }

  /// `إضافة تمرين جديد`
  String get add_new_exercise {
    return Intl.message(
      'إضافة تمرين جديد',
      name: 'add_new_exercise',
      desc: '',
      args: [],
    );
  }

  /// `إضافة القسم`
  String get add_section {
    return Intl.message(
      'إضافة القسم',
      name: 'add_section',
      desc: '',
      args: [],
    );
  }

  /// `اسم القسم`
  String get section_name {
    return Intl.message(
      'اسم القسم',
      name: 'section_name',
      desc: '',
      args: [],
    );
  }

  /// `ترتيب القسم`
  String get section_order {
    return Intl.message(
      'ترتيب القسم',
      name: 'section_order',
      desc: '',
      args: [],
    );
  }

  /// `إضافة صور`
  String get add_images {
    return Intl.message(
      'إضافة صور',
      name: 'add_images',
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
