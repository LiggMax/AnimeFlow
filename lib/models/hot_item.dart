class HotItem {
  final Subject subject;
  final int count;

  HotItem({
    required this.subject,
    required this.count,
  });

  factory HotItem.fromJson(Map<String, dynamic> json) {
    return HotItem(
      subject: Subject.fromJson(json['subject']),
      count: json['count'],
    );
  }
}

class Subject {
  final int id;
  final String name;
  final String nameCN;
  final int type;
  final String info;
  final Rating rating;
  final bool locked;
  final bool nsfw;
  final Images images;

  Subject({
    required this.id,
    required this.name,
    required this.nameCN,
    required this.type,
    required this.info,
    required this.rating,
    required this.locked,
    required this.nsfw,
    required this.images,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      nameCN: json['nameCN'],
      type: json['type'],
      info: json['info'],
      rating: Rating.fromJson(json['rating']),
      locked: json['locked'],
      nsfw: json['nsfw'],
      images: Images.fromJson(json['images']),
    );
  }
}

class Rating {
  final int rank;
  final List<int> count;
  final double score;
  final int total;

  Rating({
    required this.rank,
    required this.count,
    required this.score,
    required this.total,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rank: json['rank'],
      count: List<int>.from(json['count']),
      score: json['score'].toDouble(),
      total: json['total'],
    );
  }
}

class Images {
  final String large;
  final String common;
  final String medium;
  final String small;
  final String grid;

  Images({
    required this.large,
    required this.common,
    required this.medium,
    required this.small,
    required this.grid,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      large: json['large'],
      common: json['common'],
      medium: json['medium'],
      small: json['small'],
      grid: json['grid'],
    );
  }
}
