import 'package:flutter/material.dart';

class HelperFunctions {
  static Widget wrapWithAnimatedBuilder({
    required Animation<Offset> animation,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => FractionalTranslation(
        translation: animation.value,
        child: child,
      ),
    );
  }

  static bool matchesSearch(List<String> searchWords, String phrase) {
    // List<String> words = phrase.toLowerCase().split(' ');
    // return searchWords.any((searchTerm) =>
    //     words.any((word) => word.contains(searchTerm.toLowerCase())));

    List<String> words = phrase.split(" ");
    return searchWords.every((searchWord) => words.contains(searchWord));
  }
}
