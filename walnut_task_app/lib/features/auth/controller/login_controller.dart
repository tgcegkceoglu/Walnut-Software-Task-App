import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/models/base_response_model.dart';
import 'package:walnut_task_app/core/services/token_service.dart';
import 'package:walnut_task_app/features/auth/model/login/login_request_model.dart';
import 'package:walnut_task_app/features/auth/model/auth_data_model.dart';
import 'package:walnut_task_app/features/auth/service/remote_auth_service.dart';

class LoginController {
  final RemoteAuthService _remoteAuthService = RemoteAuthService();

  // TextEditing controller
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  //

  LoginRequestModel loginRequestModel = LoginRequestModel(); // // The information we receive when the user logs in is model - login model
  BaseResponseModel<AuthDataModel> loginResponseModel =BaseResponseModel(); // The model that returns the response when the user logs in - the login response model

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();


  // User login func. - If the login is successful, we direct it to the home page from the service, true or false, view section. If it is incorrect, we display toast in the view.
  Future<ApiResponseStatus> loginUser() async {
    try {
      loginResponseModel = await _remoteAuthService.loginUser(
        loginRequestModel,
      );
      
      if (loginResponseModel.success != null && loginResponseModel.success!) {
        final String? jwtToken = loginResponseModel.data?.jwt;
      
        if (jwtToken != null) {
            await TokenService.instance.saveToken(jwtToken);
         
        }
        return ApiResponseStatus.success;
      }
    } catch (e) {
      return ApiResponseStatus.failure;
    }

    return ApiResponseStatus.failure;
  }

  void dispose() {
    emailController.clear();
    passwordController.clear();
    emailController.dispose();
    passwordController.dispose();
    loginRequestModel = LoginRequestModel();
    loginResponseModel = BaseResponseModel();
  }
}
