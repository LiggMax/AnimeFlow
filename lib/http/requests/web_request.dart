import 'dart:math';

import 'package:anime_flow/controllers/video/video_resources_controller.dart';
import 'package:anime_flow/http/api/common_api.dart';
import 'package:anime_flow/utils/getConfigFlie.dart';
import 'package:anime_flow/utils/http/dio_request.dart';
import 'package:dio/dio.dart';
import 'package:anime_flow/utils/constants.dart';
import 'package:logger/logger.dart';

class WebRequest {
  static Logger logger = Logger();

  ///获取搜索条目列表
  static Future<String> getSearchSubjectListService(String keyword) async {
    final config = await GetConfigFile.loadPluginConfig();

    final String searchURL = config['searchURL'];
    final userAgent = userAgentsList[Random().nextInt(userAgentsList.length)];

    final response =
        await dioRequest.get(searchURL.replaceFirst("{keyword}", keyword),
            options: Options(headers: {
              CommonApi.userAgent: userAgent,
            }));
    logger.i(response.data);
    VideoResourcesController.parseSearchHtml(response.data);
    return '';
  }
}
