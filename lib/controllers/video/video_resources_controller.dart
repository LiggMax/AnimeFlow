import 'package:anime_flow/models/void/episode_resources_item.dart';
import 'package:anime_flow/models/void/search_resources_item.dart';
import 'package:anime_flow/utils/getConfigFlie.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

class VideoResourcesController extends GetxController {
  static Logger logger = Logger();

  ///解析html搜索页
  static Future<List<SearchResourcesItem>> parseSearchHtml(
      String searchHtml) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String searchList = config['searchList'];
    final String searchName = config['searchName'];
    final String searchLink = config['searchLink'];

    final parser = parse(searchHtml).documentElement!;

    final searchListElement = parser.queryXPath(searchList);
    final searchNameElement = parser.queryXPath('$searchList$searchName');
    final searchLinkElement = parser.queryXPath('$searchList$searchLink');

    final List<SearchResourcesItem> resourcesItems = List.generate(
      searchListElement.nodes.length,
      (i) => SearchResourcesItem(
        name: searchNameElement.nodes[i].text?.trim() ?? '',
        link: searchLinkElement.nodes[i].attributes['href'] ?? '',
      ),
    );

    logger.i("搜索结果:${resourcesItems.toString()}");
    return resourcesItems;
  }

  ///解析html资源页面
  static Future<List<EpisodeResourcesItem>> parseResourcesHtml(
      String resourcesHtml) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String lineNames = config['lineNames'];
    final String lineList = config['lineList'];
    final String episode = config['episode'];
    final String matchEpisodeSort = config['matchEpisodeSort'];

    final parser = parse(resourcesHtml).documentElement!;
    final lineNamesElement = parser.queryXPath(lineNames);
    final lineListElement = parser.queryXPath(lineList);

    List<EpisodeResourcesItem> episodeResourcesList = [];

    // 根据lineListElement长度循环（每个线路）
    for (int i = 0; i < lineListElement.nodes.length; i++) {
      // 获取线路名称
      String lineName = '';
      if (i < lineNamesElement.nodes.length) {
        lineName = lineNamesElement.nodes[i].text?.trim() ?? '';
      }

      // 将lineListElement转换为HTML元素，在该元素内查找剧集
      final currentLineElement = lineListElement.nodes[i];
      final currentEpisodesElement = currentLineElement.queryXPath(episode);

      // 提取当前线路的所有剧集
      List<Episode> episodes = [];
      for (var episodeNode in currentEpisodesElement.nodes) {
        String episodeName = episodeNode.text?.trim() ?? '';
        RegExp numberRegex = RegExp(r'\d+');
        RegExpMatch? match = numberRegex.firstMatch(episodeName);
        String? episodeNumberStr = match!.group(0);

        Episode episodeObj = Episode(
          episodeSort: episodeNumberStr!,
          like: episodeNode.attributes['href'] ?? '',
        );
        episodes.add(episodeObj);
      }

      // 创建EpisodeResources对象
      EpisodeResourcesItem episodeResource = EpisodeResourcesItem(
        lineNames: lineName,
        episodes: episodes,
      );

      episodeResourcesList.add(episodeResource);
    }

    logger.i("线路资源:${episodeResourcesList.toString()}");
    return episodeResourcesList;
  }

  ///解析html视频源
  static Future<String> parseVideoUrl(String playHtml) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String matchVideoUrl = config['matchVideoUrl'];

    final RegExp regex = RegExp(r'https://[^\s]+(\.mp4|\.mkv|\.m3u8)');

    final Match? match = regex.firstMatch(playHtml);
    logger.i(match);
    return "";
  }
}
