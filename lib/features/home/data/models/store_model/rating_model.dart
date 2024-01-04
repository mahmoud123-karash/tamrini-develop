class Rating {
  String userid;
  double rating;
  String id;

  Rating({
    required this.userid,
    required this.rating,
    required this.id,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userid: json['userid'] ?? '',
      rating: json['rating'].toDouble() ?? 0.0,
      id: json['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'rating': rating,
    };
  }
}
