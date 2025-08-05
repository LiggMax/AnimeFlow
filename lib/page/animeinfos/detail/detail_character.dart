/*
  @Author Ligg
  @Time 2025/8/5
 */
import 'package:AnimeFlow/request/bangumi.dart';
import 'package:AnimeFlow/modules/bangumi/character_data.dart';
import 'package:flutter/material.dart';
import 'detail_info.dart';

class AnimeCharacter extends StatefulWidget {
  final int animeId;

  const AnimeCharacter({super.key, required this.animeId});

  @override
  State<AnimeCharacter> createState() => _AnimeCharacterState();
}

class _AnimeCharacterState extends State<AnimeCharacter> {
  CharacterData? _characterData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacterData();
  }

  Future<void> _loadCharacterData() async {
    try {
      final data = await BangumiService.getCharacters(widget.animeId);
      if (mounted) {
        setState(() {
          _characterData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 获取主角列表
  List<CharacterItem> get _mainCharacters {
    if (_characterData == null) return [];
    return _characterData!.data
        .where((item) => item.character.role == 1) // 主角
        .toList();
  }

  // 获取所有角色列表
  List<CharacterItem> get _allCharacters {
    if (_characterData == null) return [];
    return _characterData!.data;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_characterData == null || _characterData!.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimeInfoSection(
      title: '角色信息',
      children: [
        // 主角网格展示
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _mainCharacters.length > 4 ? 4 : _mainCharacters.length,
          itemBuilder: (context, index) {
            final character = _mainCharacters[index];
            return _buildCharacterCard(character);
          },
        ),
        // 查看全部按钮
        if (_allCharacters.length > 4)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _showAllCharacters(context),
                child: const Text('查看全部'),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCharacterCard(CharacterItem characterItem) {
    return Row(
      children: [
        // 角色头像
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(characterItem.character.images.medium),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 角色信息
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                characterItem.character.characterDisplayName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${characterItem.character.roleName}·${characterItem.actors.isNotEmpty ? characterItem.actors.first.actorDisplayName : ''}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAllCharacters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAllCharactersSheet(),
    );
  }

  Widget _buildAllCharactersSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // 拖拽指示器
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 标题
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      '角色',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_allCharacters.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // 角色列表
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _allCharacters.length,
                  itemBuilder: (context, index) {
                    final character = _allCharacters[index];
                    return _buildCharacterListItem(character);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCharacterListItem(CharacterItem characterItem) {
    return Row(
      children: [
        // 角色头像
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(characterItem.character.images.medium),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 角色信息
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                characterItem.character.characterDisplayName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${characterItem.character.roleName}·${characterItem.actors.isNotEmpty ? characterItem.actors.first.actorDisplayName : ''}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
