class User {
  int? id;
  String username;
  String? name;
  String email;
  String password;
  String? profilePicture;

  User({
    this.id,
    required this.username,
    this.name,
    required this.email,
    required this.password,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      profilePicture: map['profilePicture'],
    );
  }
}
