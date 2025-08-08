/*
  @Author Ligg
  @Time 2025/8/7
 */
import 'package:AnimeFlow/modules/bangumi/user_info.dart';
import 'package:AnimeFlow/request/request.dart';
import 'package:AnimeFlow/request/api/bangumi/p1_api.dart';
import 'package:dio/dio.dart';
import 'package:AnimeFlow/modules/bangumi/token.dart';
import 'package:AnimeFlow/modules/bangumi/user_collection.dart';
import '../api/common_api.dart';

class BangumiUser {
  ///获取用户信息
  static Future<UserInfo?> getUserinfo(String username, {token}) async {
    final response = await httpRequest.get(
      BangumiP1Api.bangumiUserInfo.replaceAll('{username}', username),
      options: Options(headers: {'User-Agent': CommonApi.bangumiUserAgent}),
    );
    return UserInfo.fromJson(response.data);
  }

  ///获取用户收藏
  static Future<UserCollection?> getUserCollection(
    BangumiToken token,
    int type, {
    int subjectType = 2,
    int limit = 10,
    int offset = 0,
  }) async {
    final response = await httpRequest.get(
      BangumiP1Api.bangumiUserCollection.replaceAll(
        '{username}',
        token.userId.toString(),
      ),
      options: Options(
        headers: {
          'User-Agent': CommonApi.bangumiUserAgent,
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
      queryParameters: {
        'subjectType': 2,
        'type': type,
        'limit': limit,
        'offset': offset,
      },
    );
    return UserCollection.fromJson(response.data);
  }
}
