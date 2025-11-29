import 'package:dio/dio.dart';
import 'package:anime_flow/api/bgm_api.dart';

import '../models/hot_item.dart';
import '../utils/dio_request.dart';
import 'common_api.dart';

Future<HotItem> getHotApi(int limit, int offset) async {
  final response = await dioRequest.get(BgmApi.hot, queryParameters: {
    "type": 2,
    "limit": limit,
    "offset": offset
  }, options: Options(headers: {CommonApi.userAgent: CommonApi.bangumiUserAgent}));
  return HotItem.fromJson(response.data);
}