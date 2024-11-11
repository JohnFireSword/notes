class AuthData {
  const AuthData({
    required this.userID,
    required this.token,
    required this.isValid,
  });

  final int userID;
  final String token;
  final bool isValid;

  AuthData.empty()
      : userID = -1,
        token = '',
        isValid = false;

  AuthData.networkError()
      : userID = -2,
        token = '',
        isValid = false;

  AuthData.fromJson(Map<String, dynamic> json)
      : userID = json['user_id'],
        token = json['token'],
        isValid = json['result'] == 'success';

  Map<String, dynamic> toJson() => {
        'user_id': userID,
        'token': token,
        'is_valid': isValid,
      };
}
