class AccessToken {
  String accessToken;
  String refreshToken;
  int expiresIn;
  late int expiresTimestamp;

  AccessToken(
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  ) {

    // expiresIn ~/ 2 : chia 2 lấy phần nguyên
    // expiresIn = 43200
    expiresTimestamp = DateTime.now()
        // .add(const Duration(seconds: 30))
        // .add(Duration(seconds: expiresIn ~/ 2))
        .add(Duration(seconds: expiresIn))
        .millisecondsSinceEpoch;
    // expiresTimestamp =
    //     DateTime.now().add(Duration(seconds: 30)).millisecondsSinceEpoch;
  }

  bool isExpired() {
    return expiresTimestamp < DateTime.now().millisecondsSinceEpoch;
  }

  bool isOverExpired() {
    return expiresTimestamp + expiresIn * 0.25 <
        DateTime.now().millisecondsSinceEpoch;
  }

  AccessToken.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        expiresIn = json['expiresIn'],
        expiresTimestamp = json['expiresTimestamp'];

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiresIn': expiresIn,
        'expiresTimestamp': expiresTimestamp,
      };
}
