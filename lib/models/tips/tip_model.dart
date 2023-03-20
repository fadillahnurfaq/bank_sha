class TipModel {
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnail;

  TipModel({
    this.id,
    this.title,
    this.url,
    this.thumbnail,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) => TipModel(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnail: json['thumbnail'],
      );

  @override
  String toString() {
    return 'TipModel(id: $id, title: $title, url: $url, thumbnail: $thumbnail)';
  }
}
