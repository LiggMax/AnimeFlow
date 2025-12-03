import 'dart:async';
import 'dart:io';
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
import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart'
    if (dart.library.io) 'package:webview_windows/webview_windows.dart';

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

  /// 获取视频源（使用 WebView 方案）
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
    if (Platform.isWindows) {
      return _getVideoSourceWithWebViewWindows(url, videoRegex);
    } else {
      // 对于其他平台，使用传统的 HTTP 请求方式
      return _getVideoSourceWithHttp(url, videoRegex);
    }
  }

  /// Windows 平台：使用 webview_windows 获取视频源
  static Future<String> _getVideoSourceWithWebViewWindows(
      String url, RegExp videoRegex) async {
    final Completer<String> completer = Completer<String>();
    final webviewController = WebviewController();

    try {
      // 初始化 WebView
      await webviewController.initialize();

      // 设置为不可见（尺寸设为 1x1）
      await webviewController.setBackgroundColor(Colors.transparent);
      await webviewController
          .setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);

      String? foundVideoUrl;

      // 监听页面导航完成
      webviewController.loadingState.listen((state) async {
        if (state == LoadingState.navigationCompleted) {
          try {
            // 等待页面 JavaScript 执行完成
            await Future.delayed(const Duration(seconds: 3));

            // 执行 JavaScript 获取页面完整 HTML
            final html = await webviewController
                .executeScript('document.documentElement.outerHTML');

            if (html != null && html.toString().isNotEmpty) {
              // 清理返回的 HTML 字符串
              final cleanHtml = html
                  .toString()
                  .replaceAll(r'\n', '\n')
                  .replaceAll(r'\"', '"')
                  .replaceAll(r"\'", "'");

              //在 HTML 中查找视频链接
              final directMatches = videoRegex.allMatches(cleanHtml);
              if (directMatches.isNotEmpty) {
                foundVideoUrl = directMatches.first.group(0);
                logger.i('✅ 找到视频源 (直接匹配): $foundVideoUrl');
              }
            } else {
              if (!completer.isCompleted) {
                completer.completeError('无法获取页面内容');
              }
            }
          } catch (e) {
            logger.e('提取视频源时出错: $e');
            if (!completer.isCompleted) {
              completer.completeError('提取视频源失败: $e');
            }
          }
        }
      });

      // 加载页面
      await webviewController.loadUrl(url);

      // 等待结果，超时时间 30 秒
      final result = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('获取视频源超时');
        },
      );

      return foundVideoUrl ?? '';
    } catch (e) {
      logger.e('WebView 获取视频源失败: $e');
      rethrow;
    } finally {
      // 清理资源
      try {
        await webviewController.dispose();
      } catch (e) {
        logger.w('WebView 清理失败: $e');
      }
    }
  }

  /// 其他平台：使用 HTTP 请求 + HTML 解析
  static Future<String> _getVideoSourceWithHttp(
      String url, RegExp videoRegex) async {
    try {
      logger.i('使用 HTTP 方式获取视频源: $url');

      final userAgent = userAgentsList[Random().nextInt(userAgentsList.length)];

      final response = await dioRequest.get(
        url,
        options: Options(
          headers: {
            CommonApi.userAgent: userAgent,
            'Accept':
                'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
            'Accept-Encoding': 'gzip, deflate',
            'Connection': 'keep-alive',
          },
          followRedirects: true,
        ),
      );

      final htmlContent = response.data.toString();

      // 直接匹配视频链接
      final matches = videoRegex.allMatches(htmlContent);
      if (matches.isNotEmpty) {
        final videoUrl = matches.first.group(0)!;
        logger.i('✅ 找到视频源: $videoUrl');
        return videoUrl;
      }

      // 从 script 标签提取
      final scriptRegex = RegExp(
        r'<script[^>]*>([\s\S]*?)</script>',
        caseSensitive: false,
      );

      final scriptMatches = scriptRegex.allMatches(htmlContent);
      for (final match in scriptMatches) {
        final scriptContent = match.group(1) ?? '';
        final videoMatch = videoRegex.firstMatch(scriptContent);
        if (videoMatch != null) {
          final videoUrl = videoMatch.group(0)!;
          logger.i('✅ 找到视频源 (script): $videoUrl');
          return videoUrl;
        }
      }

      throw Exception('未找到视频源');
    } catch (e) {
      logger.e('HTTP 获取视频源失败: $e');
      rethrow;
    }
  }
}
