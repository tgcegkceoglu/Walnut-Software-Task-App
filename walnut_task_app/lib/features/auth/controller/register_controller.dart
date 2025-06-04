import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/models/base_response_model.dart';
import 'package:walnut_task_app/features/auth/model/register/register_request_model.dart';
import 'package:walnut_task_app/features/auth/model/user_model.dart';
import 'package:walnut_task_app/features/auth/service/remote_auth_service.dart';

class RegisterController {
  final RemoteAuthService _remoteAuthService = RemoteAuthService();

  // TextEditing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  //

  RegisterRequestModel registerRequestModel = RegisterRequestModel(); //The information we receive when registering as a user is a model - register model
  BaseResponseModel<UserModel> registerResponseModel = BaseResponseModel(); // The model returned from the response when the user registers - register response model

  // User registration function - If the registration is successful, we direct you to the login page from the service, if it is true or false, from the view section. If it is false, we also make a toast.
  Future<ApiResponseStatus> registerUser() async {
    try {
      final response = await _remoteAuthService.registerUser(
        registerRequestModel,
      );

      registerResponseModel = response;

      if (registerResponseModel.success == true &&
          registerResponseModel.data != null) {
        
        return ApiResponseStatus.success;
      }
    } catch (e) {
      debugPrint('Register Error: $e');
    }

    return ApiResponseStatus.failure;
  }

  void dispose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    registerRequestModel = RegisterRequestModel();
    registerResponseModel = BaseResponseModel();
  }
}
