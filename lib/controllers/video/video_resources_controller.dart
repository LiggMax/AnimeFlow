import 'package:anime_flow/utils/getConfigFlie.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

class VideoResourcesController {
  static Logger logger = Logger();
  //解析html搜索页
  static void parseSearchHtml(String searchHtml) async {
    final config = await GetConfigFile.loadPluginConfig();
    final String searchList = config['searchList'];
    final String searchName = config['searchName'];
    final String searchLink = config['searchLink'];

    final parser = parse(searchHtml).documentElement!;

    final searchListElement = parser.queryXPath(searchList);
    final searchNameListElement = parser.queryXPath('$searchList$searchName');
    final searchLinkListElement = parser.queryXPath('$searchList$searchLink');

    for(var element in searchListElement.nodes) {
      logger.i("搜索结果列表: ${element.text}");
    }

    for(var element in searchNameListElement.nodes) {
      logger.i("搜索结果名称: ${element.text}");
    }

    for(var element in searchLinkListElement.nodes) {
      logger.i("搜索结果链接: ${element.attributes['href']}");
    }
  }
}