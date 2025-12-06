class SubjectsItem {
  late Airtime _airtime;
  late Collection _collection;
  late int _eps;
  late int _id;
  late List<Infobox> _infobox;
  late String _info;
  late List<String> _metaTags;
  late bool _locked;
  late String _name;
  late String _nameCN;
  late bool _nsfw;
  late Platform _platform;
  late Rating _rating;
  late int _redirect;
  late bool _series;
  late int _seriesEntry;
  late String _summary;
  late int _type;
  late int _volumes;
  late List<Tags> _tags;
  late Images _images;

  SubjectsItem({
    required Airtime airtime,
    required Collection collection,
    required int eps,
    required int id,
    required List<Infobox> infobox,
    required String info,
    required List<String> metaTags,
    required bool locked,
    required String name,
    required String nameCN,
    required bool nsfw,
    required Platform platform,
    required Rating rating,
    required int redirect,
    required bool series,
    required int seriesEntry,
    required String summary,
    required int type,
    required int volumes,
    required List<Tags> tags,
    required Images images,
  }) {
    _airtime = airtime;
    _collection = collection;
    _eps = eps;
    _id = id;
    _infobox = infobox;
    _info = info;
    _metaTags = metaTags;
    _locked = locked;
    _name = name;
    _nameCN = nameCN;
    _nsfw = nsfw;
    _platform = platform;
    _rating = rating;
    _redirect = redirect;
    _series = series;
    _seriesEntry = seriesEntry;
    _summary = summary;
    _type = type;
    _volumes = volumes;
    _tags = tags;
    _images = images;
  }

  SubjectsItem.fromJson(dynamic json) {
    _airtime = Airtime.fromJson(json['airtime']);
    _collection = Collection.fromJson(json['collection']);
    _eps = json['eps'];
    _id = json['id'];
    _infobox = [];
    if (json['infobox'] != null) {
      json['infobox'].forEach((v) {
        _infobox.add(Infobox.fromJson(v));
      });
    }
    _info = json['info'];
    _metaTags = List<String>.from(json['metaTags']);
    _locked = json['locked'];
    _name = json['name'];
    _nameCN = json['nameCN'];
    _nsfw = json['nsfw'];
    _platform = Platform.fromJson(json['platform']);
    _rating = Rating.fromJson(json['rating']);
    _redirect = json['redirect'];
    _series = json['series'];
    _seriesEntry = json['seriesEntry'];
    _summary = json['summary'];
    _type = json['type'];
    _volumes = json['volumes'];
    _tags = [];
    if (json['tags'] != null) {
      json['tags'].forEach((v) {
        _tags.add(Tags.fromJson(v));
      });
    }
    _images = Images.fromJson(json['images']);
  }

  Airtime get airtime => _airtime;
  Collection get collection => _collection;
  int get eps => _eps;
  int get id => _id;
  List<Infobox> get infobox => _infobox;
  String get info => _info;
  List<String> get metaTags => _metaTags;
  bool get locked => _locked;
  String get name => _name;
  String get nameCN => _nameCN;
  bool get nsfw => _nsfw;
  Platform get platform => _platform;
  Rating get rating => _rating;
  int get redirect => _redirect;
  bool get series => _series;
  int get seriesEntry => _seriesEntry;
  String get summary => _summary;
  int get type => _type;
  int get volumes => _volumes;
  List<Tags> get tags => _tags;
  Images get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['airtime'] = _airtime.toJson();
    map['collection'] = _collection.toJson();
    map['eps'] = _eps;
    map['id'] = _id;
    map['infobox'] = _infobox.map((v) => v.toJson()).toList();
    map['info'] = _info;
    map['metaTags'] = _metaTags;
    map['locked'] = _locked;
    map['name'] = _name;
    map['nameCN'] = _nameCN;
    map['nsfw'] = _nsfw;
    map['platform'] = _platform.toJson();
    map['rating'] = _rating.toJson();
    map['redirect'] = _redirect;
    map['series'] = _series;
    map['seriesEntry'] = _seriesEntry;
    map['summary'] = _summary;
    map['type'] = _type;
    map['volumes'] = _volumes;
    map['tags'] = _tags.map((v) => v.toJson()).toList();
    map['images'] = _images.toJson();
    return map;
  }
}

class Airtime {
  late String _date;
  late int _month;
  late int _weekday;
  late int _year;

  Airtime({
    required String date,
    required int month,
    required int weekday,
    required int year,
  }) {
    _date = date;
    _month = month;
    _weekday = weekday;
    _year = year;
  }

  Airtime.fromJson(dynamic json) {
    _date = json['date'];
    _month = json['month'];
    _weekday = json['weekday'];
    _year = json['year'];
  }

  String get date => _date;
  int get month => _month;
  int get weekday => _weekday;
  int get year => _year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['month'] = _month;
    map['weekday'] = _weekday;
    map['year'] = _year;
    return map;
  }
}

class Collection {
  late Map<String, int> _data;

  Collection({
    required Map<String, int> data,
  }) {
    _data = data;
  }

  Collection.fromJson(dynamic json) {
    _data = {};
    if (json is Map) {
      json.forEach((key, value) {
        if (key is String && value is int) {
          _data[key] = value;
        }
      });
    }
  }

  Map<String, int> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    _data.forEach((key, value) {
      map[key] = value;
    });
    return map;
  }
}

class Infobox {
  late String _key;
  late List<Values> _values;

  Infobox({
    required String key,
    required List<Values> values,
  }) {
    _key = key;
    _values = values;
  }

  Infobox.fromJson(dynamic json) {
    _key = json['key'];
    _values = [];
    if (json['values'] != null) {
      json['values'].forEach((v) {
        _values.add(Values.fromJson(v));
      });
    }
  }

  String get key => _key;
  List<Values> get values => _values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['values'] = _values.map((v) => v.toJson()).toList();
    return map;
  }
}

class Values {
  late String _v;

  Values({
    required String v,
  }) {
    _v = v;
  }

  Values.fromJson(dynamic json) {
    _v = json['v'];
  }

  String get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = _v;
    return map;
  }
}

class Platform {
  late int _id;
  late String _type;
  late String _typeCN;
  late String _alias;
  late int _order;
  late bool _enableHeader;
  late String _wikiTpl;

  Platform({
    required int id,
    required String type,
    required String typeCN,
    required String alias,
    required int order,
    required bool enableHeader,
    required String wikiTpl,
  }) {
    _id = id;
    _type = type;
    _typeCN = typeCN;
    _alias = alias;
    _order = order;
    _enableHeader = enableHeader;
    _wikiTpl = wikiTpl;
  }

  Platform.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeCN = json['typeCN'];
    _alias = json['alias'];
    _order = json['order'];
    _enableHeader = json['enableHeader'];
    _wikiTpl = json['wikiTpl'];
  }

  int get id => _id;
  String get type => _type;
  String get typeCN => _typeCN;
  String get alias => _alias;
  int get order => _order;
  bool get enableHeader => _enableHeader;
  String get wikiTpl => _wikiTpl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['typeCN'] = _typeCN;
    map['alias'] = _alias;
    map['order'] = _order;
    map['enableHeader'] = _enableHeader;
    map['wikiTpl'] = _wikiTpl;
    return map;
  }
}

class Rating {
  late int _rank;
  late List<int> _count;
  late double _score;
  late int _total;

  Rating({
    required int rank,
    required List<int> count,
    required double score,
    required int total,
  }) {
    _rank = rank;
    _count = count;
    _score = score;
    _total = total;
  }

  Rating.fromJson(dynamic json) {
    _rank = json['rank'];
    _count = List<int>.from(json['count']);
    _score = json['score'];
    _total = json['total'];
  }

  int get rank => _rank;
  List<int> get count => _count;
  double get score => _score;
  int get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = _rank;
    map['count'] = _count;
    map['score'] = _score;
    map['total'] = _total;
    return map;
  }
}

class Tags {
  late String _name;
  late int _count;

  Tags({
    required String name,
    required int count,
  }) {
    _name = name;
    _count = count;
  }

  Tags.fromJson(dynamic json) {
    _name = json['name'];
    _count = json['count'];
  }

  String get name => _name;
  int get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['count'] = _count;
    return map;
  }
}

class Images {
  late String _large;
  late String _common;
  late String _medium;
  late String _small;
  late String _grid;

  Images({
    required String large,
    required String common,
    required String medium,
    required String small,
    required String grid,
  }) {
    _large = large;
    _common = common;
    _medium = medium;
    _small = small;
    _grid = grid;
  }

  Images.fromJson(dynamic json) {
    _large = json['large'];
    _common = json['common'];
    _medium = json['medium'];
    _small = json['small'];
    _grid = json['grid'];
  }

  String get large => _large;
  String get common => _common;
  String get medium => _medium;
  String get small => _small;
  String get grid => _grid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['large'] = _large;
    map['common'] = _common;
    map['medium'] = _medium;
    map['small'] = _small;
    map['grid'] = _grid;
    return map;
  }
}
