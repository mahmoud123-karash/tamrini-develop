import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

List<String> catgoryName = [
  "Iso",
  "Sports Vitamins",
  "Creatine",
  "Energy Drinks",
  "protein",
  "Mass Gainers",
];

List<int> qunatities = [
  50,
  100,
  150,
  200,
  250,
  300,
  350,
  400,
  450,
  500,
  550,
  600,
  650,
  700,
  750,
  800,
  850,
  900,
  950,
  1000,
];

List<String> times(context) => [
      '30 ${S.of(context).minute}',
      '1 ${S.of(context).hour}',
      '2 ${S.of(context).hours}',
      '3 ${S.of(context).hours}',
      '4 ${S.of(context).hours}',
      '5 ${S.of(context).hours}',
    ];

List<String> promotionList = [
  'trainer',
  'gym owner',
  'store owner',
  'writer',
];

List<IconData> icons = [
  Icons.person_outline_outlined,
  Icons.fitness_center_outlined,
  Icons.store_outlined,
  Icons.document_scanner_outlined
];
