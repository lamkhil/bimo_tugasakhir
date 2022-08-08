class User {
  String username;
  String password;
  String nama;

  User({required this.nama, required this.password, required this.username});

  factory User.fromMap(Map map) => User(
      nama: map['nama'], password: map['password'], username: map['username']);

  toMap() => {
        'username': username,
        'password': password,
        'nama': nama,
      };
}
