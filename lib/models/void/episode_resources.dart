class EpisodeResources {
  final String lineNames;
  final List<String> episodeNames;

  EpisodeResources({required this.lineNames, required this.episodeNames});

  factory EpisodeResources.fromJson(Map<String, dynamic> json) {
    return EpisodeResources(
      lineNames: json['lineNames'],
      episodeNames: json['episodeNames'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lineNames': lineNames,
      'episodeNames': episodeNames,
    };
  }

  @override
  String toString() {
    return 'EpisodeResources{lineNames: $lineNames, episodeNames: $episodeNames}';
  }
}
