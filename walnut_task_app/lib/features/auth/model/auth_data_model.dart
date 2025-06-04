import 'user_model.dart';

class AuthDataModel {
  final String? jwt;
  final UserModel? user;

  AuthDataModel({
    this.jwt,
    this.user,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      jwt: json['jwt'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'user': user?.toJson(),
  };
}
