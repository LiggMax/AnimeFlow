import 'dart:async';
import 'dart:math';
import 'package:anime_flow/controllers/video/video_resources_controller.dart';
import 'package:anime_flow/http/api/common_api.dart';
import 'package:anime_flow/models/void/episode_resources_item.dart';
import 'package:anime_flow/models/void/search_resources_item.dart';
import 'package:anime_flow/utils/getConfigFlie.dart';
import 'package:anime_flow/utils/http/dio_request.dart';
import 'package:dio/dio.dart';
import 'package:anime_flow/constants/constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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

  /// 获取视频源
  static Future<String> getVideoSourceService(String episode) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String baseURL = config['baseURL'];
    final url = baseURL + episode;

    // 正则表达式：匹配 https:// 开头，以 .mp4、.mkv 或 .m3u8 结尾的链接
    final RegExp videoRegex = RegExp(
      r'https://[^\s"<>\\]+\.(mp4|mkv|m3u8)',
      caseSensitive: false,
    );

    // 根据平台选择不同的实现方式
    return _getVideoSourceWithInAppWebView(url, videoRegex);
  }

  //无头webview
  static Future<String> _getVideoSourceWithInAppWebView(
      String url, RegExp videoRegex) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String baseURL = config['baseURL'];
    final bool enableNestedUrl = config['matchVideo']['enableNestedUrl'];
    final String matchNestedUrl = config['matchVideo']['matchNestedUrl'];

    final Completer<String> completer = Completer<String>();
    late InAppWebViewController webViewController;

    final headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      onLoadStop: (controller, uri) async {
        try {
          // 等待页面 JavaScript 执行完成
          await Future.delayed(const Duration(seconds: 3));

          // 获取页面 HTML 内容
          final html = await controller.evaluateJavascript(
              source: "document.documentElement.outerHTML"
          );

          if (html != null) {
            // 清理返回的 HTML 字符串
            final cleanHtml = html
                .toString()
                .replaceAll(r'\n', '\n')
                .replaceAll(r'\"', '"')
                .replaceAll(r"\'", "'");

            // 查找视频链接
            final directMatches = videoRegex.allMatches(cleanHtml);
            if (directMatches.isNotEmpty) {
              final foundVideoUrl = directMatches.first.group(0);
              if (enableNestedUrl) {
                final nestedUrlRegex = RegExp(matchNestedUrl);
                final nestedUrlMatches = nestedUrlRegex.allMatches(foundVideoUrl!);
                final realVideoUrl = nestedUrlMatches.first.group(0);
                logger.i('✅ 找到视频源 (嵌套匹配): $realVideoUrl');
              }
              logger.i('✅ 找到视频源 (直接匹配): $foundVideoUrl');
              if (!completer.isCompleted) {
                completer.complete(foundVideoUrl);
              }
            }
          }
        } catch (e) {
          logger.e('提取视频源时出错: $e');
          if (!completer.isCompleted) {
            completer.completeError('提取视频源失败: $e');
          }
        }
      },
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
    );

    try {
      // 启动无头 WebView
      await headlessWebView.run();

      // 等待结果，超时时间 30 秒
      final result = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('获取视频源超时');
        },
      );
      logger.i('✅ 找到视频源 (无头 WebView): $result');
      return result;
    } finally {
      // 清理资源
      await headlessWebView.dispose();
    }
  }
}
