import 'package:walnut_task_app/core/constants/base_url.dart';
import 'package:walnut_task_app/core/models/base_response_model.dart';
import 'package:walnut_task_app/core/network_manager/network_manager.dart';
import 'package:walnut_task_app/features/auth/model/auth_data_model.dart';
import 'package:walnut_task_app/features/auth/model/login/login_request_model.dart';
import 'package:walnut_task_app/features/auth/model/register/register_request_model.dart';
import 'package:walnut_task_app/features/auth/model/user_model.dart';

class RemoteAuthService {
  final _networkManager = NetworkManager.instance;

  // We send a Laravel login post request for user register.
  Future<BaseResponseModel<UserModel>> registerUser(
    RegisterRequestModel registerRequestModel,
  ) async {
    BaseResponseModel<UserModel> response = await _networkManager
        .postRequest<BaseResponseModel<UserModel>>(
          baseUrl: registerUrl,
          input: registerRequestModel.toJson(),
          fromJson: (json) => BaseResponseModel<UserModel>.fromJson(
            json,
            (dataJson) => UserModel.fromJson(dataJson),
          ),
        );
    return response;
  }

  // We send a Laravel login post request for user login.
  Future<BaseResponseModel<AuthDataModel>> loginUser(
    LoginRequestModel loginRequestModel,
  ) async {
    BaseResponseModel<AuthDataModel> response = await _networkManager
        .postRequest<BaseResponseModel<AuthDataModel>>(
          baseUrl: loginUrl,
          input: loginRequestModel.toJson(),
          fromJson: (json) => BaseResponseModel<AuthDataModel>.fromJson(
            json,
            (dataJson) => AuthDataModel.fromJson(dataJson),
          ),
        );
    return response;
  }
}
