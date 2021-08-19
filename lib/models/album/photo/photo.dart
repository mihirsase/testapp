class Photo {
  int? id;
  String? title;
  int? albumId;
  String? url;

  Photo({
    this.id,
    this.title,
    this.albumId,
    this.url,
  });

  factory Photo.fromMap(Map<String, dynamic> json) => new Photo(
    id: json["id"],
    title: json["title"],
    albumId: json["albumId"],
    url: json["url"],
  );

  static List<Photo> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Photo>((final dynamic json) {
      return Photo.fromMap(json);
    }).toList();
  }
}
