import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/extensions/context_extensions.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/core/helpers/toast_helper.dart';
import 'package:walnut_task_app/features/auth/controller/login_controller.dart';
import 'package:walnut_task_app/product/constants/image_constants.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';
import 'package:walnut_task_app/product/constants/routing_constants.dart';
import 'package:walnut_task_app/product/widgets/custom_button_widget.dart';
import 'package:walnut_task_app/product/widgets/custom_textfiled_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _loginController = LoginController();

  // user input and value assignment to the model
  Future<void> signInUser() async {
    _loginController.loginRequestModel.identifier =
        _loginController.emailController.text;
    _loginController.loginRequestModel.password =
        _loginController.passwordController.text;

    ApiResponseStatus status = await _loginController.loginUser();
    if (mounted) {
      if (status == ApiResponseStatus.success) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          myAppointmentsView,
          (Route<dynamic> route) => false,
        );
      } else {
        ToastHelper.showToast(
          context,
          _loginController.loginResponseModel.error.toString(),
          type: ToastificationType.error,
        );
      }
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.lightGrey,
      body: ListView(
        children: [
          // logo field
          ImageConstants.logo.toImagePng,

          // welcome text
          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: Text("Welcome Back!", style: context.titleLarge),
          ),

          // login info text
          Padding(
            padding: PaddingConstants.pageAllNormal,
            child: Text(
              "Log in with your account to easily view, create and manage your appointments.",
              style: context.bodySmall,
            ),
          ),

          // Email text ve textfield
          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: Text("Email or Username", style: context.bodySmall),
          ),
          Padding(
            padding: PaddingConstants.topTRBLow,
            child: CustomTextFieldWidget(
              controller: _loginController.emailController,
            ),
          ),

          // Password text ve textfield
          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: Text("Password", style: context.bodySmall),
          ),
          SizedBox(height: 8),

          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: CustomTextFieldWidget(
              controller: _loginController.passwordController,
              isPassword: true,
            ),
          ),

          Padding(
            padding: PaddingConstants.pageVerticalLow,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  registerView,
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "Create Account",
                style: context.bodyMedium.copyWith(
                  color: context.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          CustomButtonWidget(
            text: "LOGIN",
            onPressed: signInUser,
            width: context.width * .5,
          ),
        ],
      ),
    );
  }
}
