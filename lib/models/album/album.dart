class Album {
  int? id;
  String? title;
  int? userId;

  Album({
    this.id,
    this.title,
    this.userId,
  });

  factory Album.fromMap(Map<String, dynamic> json) => new Album(
    id: json["id"],
    title: json["title"],
    userId: json["userId"],
  );

  static List<Album> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Album>((final dynamic json) {
      return Album.fromMap(json);
    }).toList();
  }
}
