import 'package:flutter/material.dart';
import 'package:walnut_task_app/features/appointment/appointment_create_view.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/features/appointment/my_appointments_view.dart';
import 'package:walnut_task_app/features/auth/login_view.dart';
import 'package:walnut_task_app/features/auth/register_view.dart';

class RoutingConstants {
  static Route<dynamic> createRoute(
    RouteSettings routingSettings,
  ) {
    switch (routingSettings.name) {
      case loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case registerView:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case appointmentCreateView:
         final AppointmentRequestModel? args =routingSettings.arguments as AppointmentRequestModel?;
        return MaterialPageRoute(builder: (_) => AppointmentCreateView(appointment: args,));
      case myAppointmentsView:
        return MaterialPageRoute(builder: (_) => const MyAppointmentsView());

      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
  }
}

const String loginView = '/loginView';
const String registerView = '/registerView';
const String appointmentCreateView = '/appointmentCreateView';
const String myAppointmentsView = '/myAppointmentsView';
