class Post {
  int? id;
  String? title;
  String? body;

  Post({
    this.id,
    this.title,
    this.body,
  });

  factory Post.fromMap(Map<String, dynamic> json) => new Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  static List<Post> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Post>((final dynamic json) {
      return Post.fromMap(json);
    }).toList();
  }
}
