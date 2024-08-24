class LoginInfo {
  String username;
  String password;
  bool isSave;

  LoginInfo(
    this.username,
    this.password,
    this.isSave,
  ) {}

  LoginInfo.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        isSave = json['isSave'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'isSave': isSave,
      };
}
