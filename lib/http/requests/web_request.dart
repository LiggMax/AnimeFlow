import 'dart:math';

import 'package:anime_flow/controllers/video/video_resources_controller.dart';
import 'package:anime_flow/http/api/common_api.dart';
import 'package:anime_flow/models/void/episode_resources_item.dart';
import 'package:anime_flow/models/void/search_resources_item.dart';
import 'package:anime_flow/utils/getConfigFlie.dart';
import 'package:anime_flow/utils/http/dio_request.dart';
import 'package:dio/dio.dart';
import 'package:anime_flow/constants/constants.dart';
import 'package:logger/logger.dart';

class WebRequest {
  static Logger logger = Logger();

  ///获取搜索条目列表
  static Future<List<SearchResourcesItem>> getSearchSubjectListService(
      String keyword) async {
    final config = await GetConfigFile.loadPluginConfig();

    final String searchURL = config['searchURL'];
    final userAgent = userAgentsList[Random().nextInt(userAgentsList.length)];

    final response =
        await dioRequest.get(searchURL.replaceFirst("{keyword}", "咒术回战"),
            options: Options(headers: {
              CommonApi.userAgent: userAgent,
            }));
    getResourcesListService("/GV13093/");
    return VideoResourcesController.parseSearchHtml(response.data);
  }

  ///获取资源列表
  static Future<List<EpisodeResourcesItem>> getResourcesListService(
      String link) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String baseURL = config['baseURL'];

    final userAgent = userAgentsList[Random().nextInt(userAgentsList.length)];

    final response = await dioRequest.get(baseURL + link,
        options: Options(headers: {
          CommonApi.userAgent: userAgent,
        }));
    getVideoSourceService("/playGV26765-1-1/");
    return VideoResourcesController.parseResourcesHtml(response.data);
  }

  ///获取视频源
  static Future<String> getVideoSourceService(String episode) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String baseURL = config['baseURL'];

    final userAgent = userAgentsList[Random().nextInt(userAgentsList.length)];

    final response = await dioRequest.get(baseURL + episode,
        options: Options(headers: {
          CommonApi.userAgent: userAgent,
        }));
    await Future.delayed(Duration(seconds: 5));
    return VideoResourcesController.parseVideoUrl(response.data);
  }
}
