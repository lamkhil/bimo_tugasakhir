class User {
  String username;
  String password;
  String nama;
  List<dynamic> notif;

  User(
      {required this.nama,
      required this.password,
      required this.username,
      required this.notif});

  factory User.fromMap(Map map) => User(
      nama: map['nama'],
      password: map['password'],
      username: map['username'],
      notif: map['notif'] ?? []);

  toMap() => {'username': username, 'password': password, 'nama': nama};
}
