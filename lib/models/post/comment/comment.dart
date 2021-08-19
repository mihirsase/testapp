class Comment {
  int? id;
  int? postId;
  String? name;
  String? email;
  String? body;

  Comment({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => new Comment(
    id: json["id"],
    postId: json["postId"],
    name: json["name"],
    email: json["email"],
    body: json["body"],
  );

  static List<Comment> listFromMap(final List<dynamic> jsons) {
    return jsons.map<Comment>((final dynamic json) {
      return Comment.fromMap(json);
    }).toList();
  }
}