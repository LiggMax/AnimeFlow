import 'package:my_anime/api/bgm_api.dart';

import '../models/hot_item.dart';
import '../utils/dio_request.dart';

Future<HotItem> getHotApi(int limit, int offset) async {
  final response = await dioRequest.get(BgmApi.hot, queryParameters: {
    "type": 2,
    "limit": limit,
    "offset": offset
  });
  return HotItem.fromJson(response.data);
}