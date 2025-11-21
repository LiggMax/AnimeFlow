/// data : [{"subject":{"id":526448,"name":"グノーシア","nameCN":"古诺希亚","type":2,"info":"21话 / 2025年10月11日 / 市川量也 / プチデポット / 松浦有紗","rating":{"rank":1229,"count":[8,5,2,10,36,74,411,484,56,26],"score":7.38,"total":1112},"locked":false,"nsfw":false,"images":{"large":"https://lain.bgm.tv/pic/cover/l/17/82/526448_ssr71.jpg","common":"https://lain.bgm.tv/pic/cover/c/17/82/526448_ssr71.jpg","medium":"https://lain.bgm.tv/pic/cover/m/17/82/526448_ssr71.jpg","small":"https://lain.bgm.tv/pic/cover/s/17/82/526448_ssr71.jpg","grid":"https://lain.bgm.tv/pic/cover/g/17/82/526448_ssr71.jpg"}},"count":1900},{"subject":{"id":582501,"name":"藤本タツキ17-26","nameCN":"藤本树17-26","type":2,"info":"8话 / 2025年11月8日 / 長屋誠志郎、木村延景、武内宣之、安藤尚也、渡邉徹明、寺澤和晃、本間修 / 藤本タツキ「藤本タツキ短編集17-21」「藤本タツキ短編集22-26」 (集英社ジャンプコミック刊) / Moaang、小園菜穂、もりともこ、MYOUN、島崎望、徳岡紘平、東島久志、佐川遥","rating":{"rank":1066,"count":[0,1,1,9,24,109,496,581,59,24],"score":7.44,"total":1304},"locked":false,"nsfw":false,"images":{"large":"https://lain.bgm.tv/pic/cover/l/fb/2b/582501_A5ytA.jpg","common":"https://lain.bgm.tv/pic/cover/c/fb/2b/582501_A5ytA.jpg","medium":"https://lain.bgm.tv/pic/cover/m/fb/2b/582501_A5ytA.jpg","small":"https://lain.bgm.tv/pic/cover/s/fb/2b/582501_A5ytA.jpg","grid":"https://lain.bgm.tv/pic/cover/g/fb/2b/582501_A5ytA.jpg"}},"count":1870},{"subject":{"id":498378,"name":"SPY×FAMILY Season 3","nameCN":"间谍过家家 第三季","type":2,"info":"13话 / 2025年10月4日 / 今井友紀子 / 遠藤達哉（集英社「少年ジャンプ＋」連載） / 嶋田和晃","rating":{"rank":1200,"count":[2,1,1,4,24,108,567,402,46,50],"score":7.38,"total":1205},"locked":false,"nsfw":false,"images":{"large":"https://lain.bgm.tv/pic/cover/l/3d/79/498378_3ycrL.jpg","common":"https://lain.bgm.tv/pic/cover/c/3d/79/498378_3ycrL.jpg","medium":"https://lain.bgm.tv/pic/cover/m/3d/79/498378_3ycrL.jpg","small":"https://lain.bgm.tv/pic/cover/s/3d/79/498378_3ycrL.jpg","grid":"https://lain.bgm.tv/pic/cover/g/3d/79/498378_3ycrL.jpg"}},"count":1695},{"subject":{"id":542203,"name":"東島丹三郎は仮面ライダーになりたい","nameCN":"东岛丹三郎想成为假面骑士","type":2,"info":"2025年10月4日 / 池添隆博 / 柴田ヨクサル（ヒーローズコミックス刊） / Cindy H. Yamauchi（山内英子）","rating":{"rank":1468,"count":[4,0,3,12,25,122,457,413,46,22],"score":7.3,"total":1104},"locked":false,"nsfw":false,"images":{"large":"https://lain.bgm.tv/pic/cover/l/58/51/542203_YYfsF.jpg","common":"https://lain.bgm.tv/pic/cover/c/58/51/542203_YYfsF.jpg","medium":"https://lain.bgm.tv/pic/cover/m/58/51/542203_YYfsF.jpg","small":"https://lain.bgm.tv/pic/cover/s/58/51/542203_YYfsF.jpg","grid":"https://lain.bgm.tv/pic/cover/g/58/51/542203_YYfsF.jpg"}},"count":1335},{"subject":{"id":285757,"name":"ワンパンマン 第3期","nameCN":"一拳超人 第三季","type":2,"info":"2025年10月12日 / 永居慎平 / ONE・村田雄介（集英社「となりのヤングジャンプ」連載） / 久保田誓、黒田新次郎、白川亮介","rating":{"rank":9217,"count":[42,29,69,150,181,202,112,43,5,12],"score":5.11,"total":845},"locked":false,"nsfw":false,"images":{"large":"https://lain.bgm.tv/pic/cover/l/5a/63/285757_VvaRn.jpg","common":"https://lain.bgm.tv/pic/cover/c/5a/63/285757_VvaRn.jpg","medium":"https://lain.bgm.tv/pic/cover/m/5a/63/285757_VvaRn.jpg","small":"https://lain.bgm.tv/pic/cover/s/5a/63/285757_VvaRn.jpg","grid":"https://lain.bgm.tv/pic/cover/g/5a/63/285757_VvaRn.jpg"}},"count":1039}]
/// total : 1000

class HotItem {
  HotItem({
    List<Data>? data,
    num? total,}){
    _data = data;
    _total = total;
  }

  HotItem.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _total = json['total'];
  }
  List<Data>? _data;
  num? _total;
  HotItem copyWith({  List<Data>? data,
    num? total,
  }) => HotItem(  data: data ?? _data,
    total: total ?? _total,
  );
  List<Data>? get data => _data;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    return map;
  }

}

/// subject : {"id":526448,"name":"グノーシア","nameCN":"古诺希亚","type":2,"info":"21话 / 2025年10月11日 / 市川量也 / プチデポット / 松浦有紗","rating":{"rank":1229,"count":[8,5,2,10,36,74,411,484,56,26],"score":7.38,"total":1112},"locked":false,"nsfw":false,"images":{"large":"https://lain.bgm.tv/pic/cover/l/17/82/526448_ssr71.jpg","common":"https://lain.bgm.tv/pic/cover/c/17/82/526448_ssr71.jpg","medium":"https://lain.bgm.tv/pic/cover/m/17/82/526448_ssr71.jpg","small":"https://lain.bgm.tv/pic/cover/s/17/82/526448_ssr71.jpg","grid":"https://lain.bgm.tv/pic/cover/g/17/82/526448_ssr71.jpg"}}
/// count : 1900

class Data {
  Data({
    Subject? subject,
    num? count,}){
    _subject = subject;
    _count = count;
  }

  Data.fromJson(dynamic json) {
    _subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    _count = json['count'];
  }
  Subject? _subject;
  num? _count;
  Data copyWith({  Subject? subject,
    num? count,
  }) => Data(  subject: subject ?? _subject,
    count: count ?? _count,
  );
  Subject? get subject => _subject;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_subject != null) {
      map['subject'] = _subject?.toJson();
    }
    map['count'] = _count;
    return map;
  }

}

/// id : 526448
/// name : "グノーシア"
/// nameCN : "古诺希亚"
/// type : 2
/// info : "21话 / 2025年10月11日 / 市川量也 / プチデポット / 松浦有紗"
/// rating : {"rank":1229,"count":[8,5,2,10,36,74,411,484,56,26],"score":7.38,"total":1112}
/// locked : false
/// nsfw : false
/// images : {"large":"https://lain.bgm.tv/pic/cover/l/17/82/526448_ssr71.jpg","common":"https://lain.bgm.tv/pic/cover/c/17/82/526448_ssr71.jpg","medium":"https://lain.bgm.tv/pic/cover/m/17/82/526448_ssr71.jpg","small":"https://lain.bgm.tv/pic/cover/s/17/82/526448_ssr71.jpg","grid":"https://lain.bgm.tv/pic/cover/g/17/82/526448_ssr71.jpg"}

class Subject {
  Subject({
    num? id,
    String? name,
    String? nameCN,
    num? type,
    String? info,
    Rating? rating,
    bool? locked,
    bool? nsfw,
    Images? images,}){
    _id = id;
    _name = name;
    _nameCN = nameCN;
    _type = type;
    _info = info;
    _rating = rating;
    _locked = locked;
    _nsfw = nsfw;
    _images = images;
  }

  Subject.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameCN = json['nameCN'];
    _type = json['type'];
    _info = json['info'];
    _rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    _locked = json['locked'];
    _nsfw = json['nsfw'];
    _images = json['images'] != null ? Images.fromJson(json['images']) : null;
  }
  num? _id;
  String? _name;
  String? _nameCN;
  num? _type;
  String? _info;
  Rating? _rating;
  bool? _locked;
  bool? _nsfw;
  Images? _images;
  Subject copyWith({  num? id,
    String? name,
    String? nameCN,
    num? type,
    String? info,
    Rating? rating,
    bool? locked,
    bool? nsfw,
    Images? images,
  }) => Subject(  id: id ?? _id,
    name: name ?? _name,
    nameCN: nameCN ?? _nameCN,
    type: type ?? _type,
    info: info ?? _info,
    rating: rating ?? _rating,
    locked: locked ?? _locked,
    nsfw: nsfw ?? _nsfw,
    images: images ?? _images,
  );
  num? get id => _id;
  String? get name => _name;
  String? get nameCN => _nameCN;
  num? get type => _type;
  String? get info => _info;
  Rating? get rating => _rating;
  bool? get locked => _locked;
  bool? get nsfw => _nsfw;
  Images? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['nameCN'] = _nameCN;
    map['type'] = _type;
    map['info'] = _info;
    if (_rating != null) {
      map['rating'] = _rating?.toJson();
    }
    map['locked'] = _locked;
    map['nsfw'] = _nsfw;
    if (_images != null) {
      map['images'] = _images?.toJson();
    }
    return map;
  }

}

/// large : "https://lain.bgm.tv/pic/cover/l/17/82/526448_ssr71.jpg"
/// common : "https://lain.bgm.tv/pic/cover/c/17/82/526448_ssr71.jpg"
/// medium : "https://lain.bgm.tv/pic/cover/m/17/82/526448_ssr71.jpg"
/// small : "https://lain.bgm.tv/pic/cover/s/17/82/526448_ssr71.jpg"
/// grid : "https://lain.bgm.tv/pic/cover/g/17/82/526448_ssr71.jpg"

class Images {
  Images({
    String? large,
    String? common,
    String? medium,
    String? small,
    String? grid,}){
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
  String? _large;
  String? _common;
  String? _medium;
  String? _small;
  String? _grid;
  Images copyWith({  String? large,
    String? common,
    String? medium,
    String? small,
    String? grid,
  }) => Images(  large: large ?? _large,
    common: common ?? _common,
    medium: medium ?? _medium,
    small: small ?? _small,
    grid: grid ?? _grid,
  );
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

/// rank : 1229
/// count : [8,5,2,10,36,74,411,484,56,26]
/// score : 7.38
/// total : 1112

class Rating {
  Rating({
    num? rank,
    List<num>? count,
    num? score,
    num? total,}){
    _rank = rank;
    _count = count;
    _score = score;
    _total = total;
  }

  Rating.fromJson(dynamic json) {
    _rank = json['rank'];
    _count = json['count'] != null ? json['count'].cast<num>() : [];
    _score = json['score'];
    _total = json['total'];
  }
  num? _rank;
  List<num>? _count;
  num? _score;
  num? _total;
  Rating copyWith({  num? rank,
    List<num>? count,
    num? score,
    num? total,
  }) => Rating(  rank: rank ?? _rank,
    count: count ?? _count,
    score: score ?? _score,
    total: total ?? _total,
  );
  num? get rank => _rank;
  List<num>? get count => _count;
  num? get score => _score;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = _rank;
    map['count'] = _count;
    map['score'] = _score;
    map['total'] = _total;
    return map;
  }

}