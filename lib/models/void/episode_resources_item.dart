class EpisodeResourcesItem {
  final String lineNames;
  final List<Episode> episodes;

  EpisodeResourcesItem({required this.lineNames, required this.episodes});

  factory EpisodeResourcesItem.fromJson(Map<String, dynamic> json) {
    return EpisodeResourcesItem(
      lineNames: json['lineNames'],
      episodes: json['episodes'],
    );
  }

  @override
  String toString() {
    return 'EpisodeResourcesItem{lineNames: $lineNames, episodes: $episodes}';
  }
}

class Episode {
  final String episodeSort;
  final String like;

  Episode({required this.episodeSort, required this.like});

  @override
  String toString() {
    return 'Episode{episodeSort: $episodeSort, like: $like}';
  }
}
