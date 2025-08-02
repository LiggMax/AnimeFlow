import 'package:AnimeFlow/request/bangumi_tv.dart';
import 'package:flutter/material.dart';
import 'package:AnimeFlow/utils/fullscreen_utils.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  Map<String, dynamic>? _rankData;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadRankingData();

    // 添加滚动监听器实现上拉加载更多
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // 检查是否滚动到页面底部
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // 触发加载更多
      _loadMoreData();
    }
  }

  Future<void> _loadRankingData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final data = await BangumiTvService.getRank(1);

      if (mounted) {
        setState(() {
          _rankData = data;
          _isLoading = false;
          _currentPage = 1;
          _hasMore = true; // 重置更多数据状态
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMoreData() async {
    // 如果正在加载或没有更多数据，则不执行
    if (_isLoadingMore || !_hasMore || _isLoading) return;

    try {
      setState(() {
        _isLoadingMore = true;
      });

      final nextPage = _currentPage + 1;
      final data = await BangumiTvService.getRank(nextPage);

      if (mounted) {
        setState(() {
          _isLoadingMore = false;

          if (data == null ||
              (data['titles'] == null || (data['titles'] as List).isEmpty)) {
            _hasMore = false; // 没有更多数据
          } else {
            // 追加新数据
            final newTitles = List<String>.from(data['titles'] ?? []);
            final newCovers = List<String>.from(data['covers'] ?? []);
            final newLinks = List<String>.from(data['links'] ?? []);

            if (newTitles.isEmpty) {
              _hasMore = false;
            } else {
              // 合并数据
              final currentTitles = List<String>.from(_rankData!['titles'] ?? []);
              final currentCovers = List<String>.from(_rankData!['covers'] ?? []);
              final currentLinks = List<String>.from(_rankData!['links'] ?? []);

              currentTitles.addAll(newTitles);
              currentCovers.addAll(newCovers);
              currentLinks.addAll(newLinks);

              _rankData = {
                'titles': currentTitles,
                'covers': currentCovers,
                'links': currentLinks,
              };

              _currentPage = nextPage;
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在加载排行榜...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '加载失败: $_error',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadRankingData,
              child: const Text('重新加载'),
            ),
          ],
        ),
      );
    }

    if (_rankData == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.leaderboard,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '暂无排行榜数据',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    final titles = List<String>.from(_rankData!['titles'] ?? []);
    final covers = List<String>.from(_rankData!['covers'] ?? []);
    final links = List<String>.from(_rankData!['links'] ?? []);

    if (titles.isEmpty || covers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.leaderboard,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '暂无排行榜数据',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // 检查是否滚动到页面底部
        if (!_isLoadingMore &&
            _hasMore &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
          _loadMoreData();
          return true;
        }
        return false;
      },
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: FullscreenUtils.getCrossAxisCount(context),
          childAspectRatio: 0.7,
          crossAxisSpacing: 2,
        ),
        itemCount: titles.length + (_hasMore ? 1 : 0), // 添加加载更多指示器
        itemBuilder: (context, index) {
          // 如果是最后一个item且正在加载更多，显示加载指示器
          if (_hasMore && index == titles.length) {
            return _buildLoadingMoreIndicator();
          }

          return _buildRankItem(
            title: titles[index],
            coverUrl: index < covers.length ? covers[index] : '',
            link: index < links.length ? links[index] : '',
          );
        },
      ),
    );
  }

  // 加载更多指示器
  Widget _buildLoadingMoreIndicator() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildRankItem({
    required String title,
    required String coverUrl,
    required String link,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 封面图片
          _buildCoverImage(coverUrl),

          // 底部蒙版和标题
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.5),
                  ],
                  stops: const [0.0, 0.5, 0.8, 1.0],
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage(String coverUrl) {
    if (coverUrl.isEmpty) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(
          Icons.image,
          color: Colors.grey,
          size: 40,
        ),
      );
    }

    return Image.network(
      coverUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(
            Icons.broken_image,
            color: Colors.grey,
            size: 40,
          ),
        );
      },
    );
  }
}
