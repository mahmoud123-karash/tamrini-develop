class Rating {
  String userid;
  double rating;

  Rating({
    required this.userid,
    required this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userid: json['userid'] ?? '',
      rating: json['rating'].toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'rating': rating,
    };
  }
}
