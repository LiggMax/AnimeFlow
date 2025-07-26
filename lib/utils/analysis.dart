/*
  @Author Ligg
  @Time 2025/7/26
 */

/// 视频源解析
library;

import 'package:html/parser.dart' as parser;
import 'package:logging/logging.dart';

class VideoAnalysis {
  static final Logger _log = Logger('analysisService');

  static const String selectNames =
      'body > .box-width .search-box .thumb-content > .thumb-txt';
  static const String selectLinks =
      'body > .box-width .search-box .thumb-menu > a';
  static const String selectChannelNames =
      '.anthology-tab > .swiper-wrapper a'; //线路名称
  static const String matchChannelName = r'^()?(?<ch>.+?)(\d+)?$'; //线路名称正则
  static const String selectEpisodeLists = '.anthology-list-box'; //剧集列表
  static const String matchEpisodeSortFromName =
      r'第\s*(?<ep>.+)\s*[话集]'; //剧集序号正则
  static const String selectEpisodesFromList = 'a';

  /// 解析解析条目
  static Map<String, List<String>> parseSearchResults(String htmlData) {
    try {
      // 解析HTML文档
      final document = parser.parse(htmlData);

      // 解析条目名称列表
      final titleElements = document.querySelectorAll(selectNames);
      final titles = titleElements
          .map((element) => element.text.trim())
          .toList();

      // 解析条目链接列表
      final linkElements = document.querySelectorAll(selectLinks);
      final links = linkElements
          .map((element) {
            final href = element.attributes['href'];
            return href != null ? href.trim() : '';
          })
          .where((link) => link.isNotEmpty)
          .toList();

      _log.info('解析到 ${titles.length} 个标题');
      _log.info('解析到 ${links.length} 个链接');

      return {'titles': titles, 'links': links};
    } catch (e) {
      _log.severe('HTML解析错误: $e');
      return {'titles': <String>[], 'links': <String>[]};
    }
  }

  /// 解析剧集数据
  static Map<String, dynamic> parseEpisodeData(String htmlData) {
    try {
      final document = parser.parse(htmlData);

      // 提取线路名称列表
      final routeElements = document.querySelectorAll(selectChannelNames);
      final routes = <Map<String, String>>[];

      // 正则表达式匹配线路名称
      final routeRegex = RegExp(matchChannelName);

      for (final element in routeElements) {
        final routeText = element.text.trim();
        final match = routeRegex.firstMatch(routeText);
        if (match != null) {
          final routeName = match.namedGroup('ch') ?? routeText;
          routes.add({'name': routeName, 'original': routeText});
        }
      }

      // 从页面中提取剧集面板列表
      final panelElements = document.querySelectorAll(selectEpisodeLists);
      final episodes = <List<Map<String, String>>>[];

      // 正则表达式匹配剧集序号
      final episodeRegex = RegExp(matchEpisodeSortFromName);

      for (final panel in panelElements) {
        // 从每个剧集面板中提取标签作为剧集列表
        final episodeLinks = panel.querySelectorAll(selectEpisodesFromList);
        final panelEpisodes = <Map<String, String>>[];

        for (final link in episodeLinks) {
          final episodeTitle = link.text.trim();
          final episodeUrl = link.attributes['href'] ?? '';

          // 匹配剧集序号
          final match = episodeRegex.firstMatch(episodeTitle);
          final episodeNumber = match?.namedGroup('ep') ?? '';

          panelEpisodes.add({
            'title': episodeTitle,
            'url': episodeUrl,
            'episode': episodeNumber,
          });
        }

        episodes.add(panelEpisodes);
      }

      _log.info('解析到 ${routes.length} 个线路');
      _log.info('解析到 ${episodes.length} 个剧集面板');

      return {'routes': routes, 'episodes': episodes};
    } catch (e) {
      _log.severe('剧集解析错误: $e');
      return {
        'routes': <Map<String, String>>[],
        'episodes': <List<Map<String, String>>>[],
      };
    }
  }

  ///解析视频链接
  static String? parsePlayUrl(String htmlData) {
    try {
      // 视频链接匹配正则表达式
      final videoUrlRegex = RegExp(
        r'(^http(s)?:\/\/(?!.*http(s)?:\/\/).+((\.mp4)|(\.mkv)|(m3u8)).*(\?.+)?)|(akamaized)|(bilivideo.com)',
        caseSensitive: false,
      );

      // 在HTML数据中查找匹配的视频链接
      final matches = videoUrlRegex.allMatches(htmlData);
      
      if (matches.isNotEmpty) {
        final match = matches.first;
        final videoUrl = match.group(0);
        
        if (videoUrl != null && videoUrl.isNotEmpty) {
          _log.info('解析到视频链接: $videoUrl');
          return videoUrl;
        }
      }

      _log.warning('未找到匹配的视频链接');
      return null;
    } catch (e) {
      _log.severe('视频链接解析错误: $e');
      return null;
    }
  }

}
