class User {
  String username;
  String password;
  String nama;
  bool accept;
  List<dynamic> notif;

  User(
      {required this.nama,
      required this.password,
      required this.username,
      required this.notif,
      required this.accept});

  factory User.fromMap(Map map) => User(
      nama: map['nama'],
      accept: map['accept'],
      password: map['password'],
      username: map['username'],
      notif: ((map['notif'] ?? []) as List).reversed.toList());

  toMap() => {
        'username': username,
        'password': password,
        'nama': nama,
        'accept': accept,
      };
}
