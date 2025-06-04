import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/extensions/context_extensions.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/core/helpers/toast_helper.dart';
import 'package:walnut_task_app/features/auth/controller/register_controller.dart';
import 'package:walnut_task_app/product/constants/image_constants.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';
import 'package:walnut_task_app/product/constants/routing_constants.dart';
import 'package:walnut_task_app/product/widgets/custom_button_widget.dart';
import 'package:walnut_task_app/product/widgets/custom_textfiled_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final RegisterController _registerController = RegisterController();
  
  // user registration and value assignment to model
  Future<void> signUpUser() async {
    _registerController.registerRequestModel.username = _registerController.nameController.text;
    _registerController.registerRequestModel.email = _registerController.emailController.text;
    _registerController.registerRequestModel.password = _registerController.passwordController.text;
    ApiResponseStatus status = await _registerController.registerUser();
    if(mounted){
      if(status == ApiResponseStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            loginView,
            (Route<dynamic> route) => false,
          );
      } else{
        ToastHelper.showToast(context, _registerController.registerResponseModel.error.toString(),type: ToastificationType.error);
      }
    }
   
  }

  @override
  void dispose() {
    _registerController.dispose();
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
            child: Text("Welcome!", style: context.titleLarge),
          ),

          // login info text
          Padding(
            padding: PaddingConstants.pageAllNormal,
            child: Text(
              "Sign up to easily view, create, and manage your appointments.",
              style: context.bodySmall,
            ),
          ),

          // UserName text ve textfield
          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: Text("Username", style: context.bodySmall),
          ),
          Padding(
            padding: PaddingConstants.topTRBLow,
            child: CustomTextFieldWidget(controller: _registerController.nameController),
          ),

          // Email text ve textfield
          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: Text("Email", style: context.bodySmall),
          ),
          Padding(
            padding: PaddingConstants.topTRBLow,
            child: CustomTextFieldWidget(controller: _registerController.emailController,inputType: TextInputType.emailAddress,),
          ),

          // Password text ve textfield
          Padding(
            padding: PaddingConstants.pageHorizontalNormal,
            child: Text("Password", style: context.bodySmall),
          ),
          Padding(
            padding: PaddingConstants.topTRBLow,
            child: CustomTextFieldWidget(controller: _registerController.passwordController,isPassword: true,),
          ),

            Padding(
            padding: PaddingConstants.pageVerticalLow,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  loginView,
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "Do you have an account? Log in",
                style: context.bodyMedium.copyWith(
                  color: context.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          CustomButtonWidget(
            text: "REGISTER",
            onPressed: signUpUser,
            width: context.width * .5,
          ),
        ],
      ),
    );
  }
}
