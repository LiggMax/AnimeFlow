import 'package:AnimeFlow/modules/bangumi/character_data.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import '../modules/bangumi/search_data.dart';
import 'request.dart';
import 'api/bangumi/v0_api.dart';
import '../modules/bangumi/comments.dart';
import '../modules/bangumi/Related.dart';
import 'api/common_api.dart';
import 'api/bangumi/p1_api.dart';

class BangumiService {
  static final Logger _log = Logger('BangumiService');

  ///获取每日放送
  static Future<Map<String, dynamic>?> getCalendar() async {
    try {
      final response = await httpRequest.get(BangumiP1Api.bangumiCalendar);
      return response.data;
    } catch (e) {
      _log.severe('获取每日放送失败: $e');
      return null;
    }
  }

  /// 获取条目详情
  static Future<Map<String, dynamic>?> getInfoByID(int id) async {
    try {
      final response = await httpRequest.get(
        '${BangumiV0Api.bangumiInfoByID}/$id',
      );
      return response.data;
    } catch (e) {
      _log.severe('获取条目详情失败: $e');
      return null;
    }
  }

  ///获取剧集详情
  static Future<Map<String, dynamic>?> getEpisodesByID(int id) async {
    try {
      final response = await httpRequest.get(
        BangumiV0Api.bangumiEpisodeByID,
        queryParameters: {'subject_id': id, 'limit': 100, 'offset': 0},
      );
      return response.data;
    } catch (e) {
      _log.severe('获取剧集详情失败: $e');
      return null;
    }
  }

  ///条目搜索
  static Future<SearchData?> search(String keyword) async {
    try {
      final response = await httpRequest.post(
        BangumiV0Api.bangumiRankSearch
            .replaceAll('{0}', '20')
            .replaceAll('{1}', '0'),
        data: {
          'keyword': keyword,
          'sort': 'rank',
          'filter': {
            "type": [2],
          },
        },
      );
      return SearchDataParser.parseSearchResponse(response.data);
    } catch (e) {
      _log.severe('条目搜索失败: $e');
      return null;
    }
  }

  ///条目评论
  static Future<CommentsData?> getComments(
    int subjectId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await httpRequest.get(
        BangumiP1Api.bangumiComment.replaceAll(
          '{subject_id}',
          subjectId.toString(),
        ),
        options: Options(headers: {'User-Agent': CommonApi.bangumiUserAgent}),
        queryParameters: {'limit': limit, 'offset': offset},
      );

      // 解析评论数据
      return CommentsData.fromJson(response.data);
    } catch (e) {
      _log.severe('获取评论失败: $e');
      return null;
    }
  }

  ///相关条目
  static Future<RelatedData?> getRelated(int subjectId) async {
    try {
      final response = await httpRequest.get(
        BangumiV0Api.bangumiRelated.replaceAll(
          '{subject_id}',
          subjectId.toString(),
        ),
        options: Options(headers: {'User-Agent': CommonApi.bangumiUserAgent}),
      );

      return RelatedData.fromJson(response.data);
    } catch (e) {
      _log.severe('获取相关条目失败: $e');
      return null;
    }
  }

  ///条目角色
  static Future<CharacterData?> getCharacters(int subjectId) async {
    try {
      final response = await httpRequest.get(
        BangumiP1Api.bangumiCharacter.replaceAll(
          '{subject_id}',
          subjectId.toString(),
        ),
        options: Options(headers: {'User-Agent': CommonApi.bangumiUserAgent}),
      );
      return CharacterData.fromJson(response.data);
    } catch (e) {
      _log.severe('获取角色失败: $e');
      return null;
    }
  }
}
