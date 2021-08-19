class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
  );

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email : $email}';
  }
}

List<User> dummyUsers = [
  User(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz"),
  User(id: 2, name: "Ervin Howell", username: "Antonette", email: "Shanna@melissa.tv"),
  User(id: 3, name: "Clementine Bauch", username: "Samantha", email: "Nathan@yesenia.net"),
  User(id: 4, name: "Patricia Lebsack", username: "Karianne", email: "Julianne.OConner@kory.org"),
  User(id: 5, name: "Chelsey Dietrich", username: "Kamren", email: "Lucio_Hettinger@annie.ca"),
  User(id: 6, name: "Mrs. Dennis Schulist", username: "Leopoldo_Corkery", email: "Karley_Dach@jasper.info"),
  User(id: 7, name: "Kurtis Weissnat", username: "Elwyn.Skiles", email: "Telly.Hoeger@billy.biz"),
  User(id: 8, name: "Nicholas Runolfsdottir V", username: "Maxime_Nienow", email: "Sherwood@rosamond.me"),
  User(id: 9, name: "Glenna Reichert", username: "Delphine", email: "Chaim_McDermott@dana.io"),
  User(id: 10, name: "Clementina DuBuque", username: "Moriah.Stanton", email: "Rey.Padberg@karina.biz"),
  User(id: 11, name: "Mihir Sase", username: "mihirsase", email: "mihir@rirev.com"),
];
