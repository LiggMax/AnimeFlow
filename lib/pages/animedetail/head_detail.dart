import 'package:flutter/material.dart';
import 'package:anime_flow/models/hot_item.dart';

class HeadDetailView extends StatelessWidget {
  final Subject data;

  const HeadDetailView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 基础文本样式

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧海报
          Hero(
            tag: data.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                data.images.large,
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // 右侧信息区
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题
              Text(
                data.nameCN ?? data.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black54,
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // 年份/连载信息框
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  data.info.split(' / ').first, // 尝试提取第一段信息作为日期
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ),
              const SizedBox(height: 10),

              // 评分栏
              Row(
                children: [
                  Text(
                    "${data.rating.score}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          // 简单的星级计算
                          var score = data.rating.score / 2;
                          IconData icon = Icons.star_border;
                          if (index < score.floor()) {
                            icon = Icons.star;
                          } else if (index < score && score - index >= 0.5) {
                            icon = Icons.star_half;
                          }
                          return Icon(icon, color: Colors.white, size: 12);
                        }),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${data.rating.total} 人评 | #${data.rating.rank}",
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),
              // 收藏状态 (因接口缺少此数据，暂时使用Total模拟展示格式)
              Text(
                "${data.rating.total * 3} 收藏 / ${data.rating.total * 2} 在看 / ${data.rating.total ~/ 10} 抛弃",
                style: const TextStyle(color: Colors.white, fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // 按钮组
              Row(
                children: [
                  // 已在看
                  SizedBox(
                    height: 32,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.check_circle_outline, size: 16),
                      label: const Text("播放", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // 网格图标
                  // Container(
                  //   width: 32,
                  //   height: 32,
                  //   decoration: BoxDecoration(
                  //      border: Border.all(color: Colors.white38),
                  //      borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: const Icon(Icons.grid_view, color: Colors.white, size: 16),
                  // ),
                  // const SizedBox(width: 8),

                  // 继续观看
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.zero,
                        elevation: 0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "继续观看 01",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
