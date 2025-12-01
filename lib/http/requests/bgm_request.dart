import 'package:anime_flow/http/api/bgm_api.dart';
import 'package:anime_flow/http/api/common_api.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:anime_flow/models/subjects_item.dart';
import 'package:anime_flow/utils/http/dio_request.dart';
import 'package:dio/dio.dart';

class BgmRequest {
  /// 获取热门
  static Future<HotItem> getHotApi(int limit, int offset) async {
    final response = await dioRequest.get(BgmApi.hot,
        queryParameters: {"type": 2, "limit": limit, "offset": offset},
        options: Options(
            headers: {CommonApi.userAgent: CommonApi.bangumiUserAgent}));
    return HotItem.fromJson(response.data);
  }

  ///根据id获取条目
  static Future<SubjectsItem> getSubjectById(int id) async {
    final response = await dioRequest.get(
        BgmApi.subjectById.replaceFirst('{subjectId}', id.toString()),
        options: Options(
            headers: {CommonApi.userAgent: CommonApi.bangumiUserAgent}));
    return SubjectsItem.fromJson(response.data);
  }
}
