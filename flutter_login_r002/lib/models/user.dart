class User {
  String username;
  String password;
  String email;

  User(String username, String password, String email) {
    this.username = username;
    this.password = password;
    this.email = email;
  }

  //konversi dari contact ke map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['username'] = this.username;
    map['password'] = this.password;
    map['email'] = this.email;
    return map;
  }
}
