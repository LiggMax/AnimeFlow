class BgmApi {
  static const String nextBaseUrl = 'https://next.bgm.tv';
  //热门条目
  static const String hot = '$nextBaseUrl/p1/trending/subjects';

  //获取根据id获取条目
  static const String subjectById = '$nextBaseUrl/p1/subjects/{subjectId}';
}