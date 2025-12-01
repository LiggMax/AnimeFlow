class SubjectsItem {
  Airtime? _airtime;
  Collection? _collection;
  int? _eps;
  int? _id;
  List<Infobox>? _infobox;
  String? _info;
  List<String>? _metaTags;
  bool? _locked;
  String? _name;
  String? _nameCN;
  bool? _nsfw;
  Platform? _platform;
  Rating? _rating;
  int? _redirect;
  bool? _series;
  int? _seriesEntry;
  String? _summary;
  int? _type;
  int? _volumes;
  List<Tags>? _tags;
  Images? _images;

  SubjectsItem({
    Airtime? airtime,
    Collection? collection,
    int? eps,
    int? id,
    List<Infobox>? infobox,
    String? info,
    List<String>? metaTags,
    bool? locked,
    String? name,
    String? nameCN,
    bool? nsfw,
    Platform? platform,
    Rating? rating,
    int? redirect,
    bool? series,
    int? seriesEntry,
    String? summary,
    int? type,
    int? volumes,
    List<Tags>? tags,
    Images? images,
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
    _airtime = json['airtime'] != null ? Airtime.fromJson(json['airtime']) : null;
    _collection = json['collection'] != null ? Collection.fromJson(json['collection']) : null;
    _eps = json['eps'];
    _id = json['id'];
    if (json['infobox'] != null) {
      _infobox = [];
      json['infobox'].forEach((v) {
        _infobox?.add(Infobox.fromJson(v));
      });
    }
    _info = json['info'];
    _metaTags = json['metaTags'] != null ? List<String>.from(json['metaTags']) : [];
    _locked = json['locked'];
    _name = json['name'];
    _nameCN = json['nameCN'];
    _nsfw = json['nsfw'];
    _platform = json['platform'] != null ? Platform.fromJson(json['platform']) : null;
    _rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    _redirect = json['redirect'];
    _series = json['series'];
    _seriesEntry = json['seriesEntry'];
    _summary = json['summary'];
    _type = json['type'];
    _volumes = json['volumes'];
    if (json['tags'] != null) {
      _tags = [];
      json['tags'].forEach((v) {
        _tags?.add(Tags.fromJson(v));
      });
    }
    _images = json['images'] != null ? Images.fromJson(json['images']) : null;
  }

  Airtime? get airtime => _airtime;
  Collection? get collection => _collection;
  int? get eps => _eps;
  int? get id => _id;
  List<Infobox>? get infobox => _infobox;
  String? get info => _info;
  List<String>? get metaTags => _metaTags;
  bool? get locked => _locked;
  String? get name => _name;
  String? get nameCN => _nameCN;
  bool? get nsfw => _nsfw;
  Platform? get platform => _platform;
  Rating? get rating => _rating;
  int? get redirect => _redirect;
  bool? get series => _series;
  int? get seriesEntry => _seriesEntry;
  String? get summary => _summary;
  int? get type => _type;
  int? get volumes => _volumes;
  List<Tags>? get tags => _tags;
  Images? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_airtime != null) {
      map['airtime'] = _airtime?.toJson();
    }
    if (_collection != null) {
      map['collection'] = _collection?.toJson();
    }
    map['eps'] = _eps;
    map['id'] = _id;
    if (_infobox != null) {
      map['infobox'] = _infobox?.map((v) => v.toJson()).toList();
    }
    map['info'] = _info;
    map['metaTags'] = _metaTags;
    map['locked'] = _locked;
    map['name'] = _name;
    map['nameCN'] = _nameCN;
    map['nsfw'] = _nsfw;
    if (_platform != null) {
      map['platform'] = _platform?.toJson();
    }
    if (_rating != null) {
      map['rating'] = _rating?.toJson();
    }
    map['redirect'] = _redirect;
    map['series'] = _series;
    map['seriesEntry'] = _seriesEntry;
    map['summary'] = _summary;
    map['type'] = _type;
    map['volumes'] = _volumes;
    if (_tags != null) {
      map['tags'] = _tags?.map((v) => v.toJson()).toList();
    }
    if (_images != null) {
      map['images'] = _images?.toJson();
    }
    return map;
  }
}

class Airtime {
  String? _date;
  int? _month;
  int? _weekday;
  int? _year;

  Airtime({
    String? date,
    int? month,
    int? weekday,
    int? year,
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

  String? get date => _date;
  int? get month => _month;
  int? get weekday => _weekday;
  int? get year => _year;

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
  Map<String, int> _data = {};

  Collection({
    Map<String, int>? data,
  }) {
    _data = data ?? {};
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
  String? _key;
  List<Values>? _values;

  Infobox({
    String? key,
    List<Values>? values,
  }) {
    _key = key;
    _values = values;
  }

  Infobox.fromJson(dynamic json) {
    _key = json['key'];
    if (json['values'] != null) {
      _values = [];
      json['values'].forEach((v) {
        _values?.add(Values.fromJson(v));
      });
    }
  }

  String? get key => _key;
  List<Values>? get values => _values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    if (_values != null) {
      map['values'] = _values?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Values {
  String? _v;

  Values({
    String? v,
  }) {
    _v = v;
  }

  Values.fromJson(dynamic json) {
    _v = json['v'];
  }

  String? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = _v;
    return map;
  }
}

class Platform {
  int? _id;
  String? _type;
  String? _typeCN;
  String? _alias;
  int? _order;
  bool? _enableHeader;
  String? _wikiTpl;

  Platform({
    int? id,
    String? type,
    String? typeCN,
    String? alias,
    int? order,
    bool? enableHeader,
    String? wikiTpl,
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

  int? get id => _id;
  String? get type => _type;
  String? get typeCN => _typeCN;
  String? get alias => _alias;
  int? get order => _order;
  bool? get enableHeader => _enableHeader;
  String? get wikiTpl => _wikiTpl;

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
  int? _rank;
  List<int>? _count;
  double? _score;
  int? _total;

  Rating({
    int? rank,
    List<int>? count,
    double? score,
    int? total,
  }) {
    _rank = rank;
    _count = count;
    _score = score;
    _total = total;
  }

  Rating.fromJson(dynamic json) {
    _rank = json['rank'];
    _count = json['count'] != null ? List<int>.from(json['count']) : [];
    _score = json['score'];
    _total = json['total'];
  }

  int? get rank => _rank;
  List<int>? get count => _count;
  double? get score => _score;
  int? get total => _total;

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
  String? _name;
  int? _count;

  Tags({
    String? name,
    int? count,
  }) {
    _name = name;
    _count = count;
  }

  Tags.fromJson(dynamic json) {
    _name = json['name'];
    _count = json['count'];
  }

  String? get name => _name;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['count'] = _count;
    return map;
  }
}

class Images {
  String? _large;
  String? _common;
  String? _medium;
  String? _small;
  String? _grid;

  Images({
    String? large,
    String? common,
    String? medium,
    String? small,
    String? grid,
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

  String? get large => _large;
  String? get common => _common;
  String? get medium => _medium;
  String? get small => _small;
  String? get grid => _grid;

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
