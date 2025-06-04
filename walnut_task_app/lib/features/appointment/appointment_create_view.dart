import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/core/helpers/toast_helper.dart';
import 'package:walnut_task_app/features/appointment/controller/appointment_controller.dart';
import 'package:walnut_task_app/features/appointment/create_appointment/steps/appointment_first_step_view.dart';
import 'package:walnut_task_app/features/appointment/create_appointment/steps/appointment_secondary_step_view.dart';
import 'package:walnut_task_app/features/appointment/create_appointment/widget/appointment_create_bottom_navbar.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/product/constants/routing_constants.dart';

class AppointmentCreateView extends StatefulWidget {
  final AppointmentRequestModel? appointment;
  const AppointmentCreateView({super.key, this.appointment});

  @override
  State<AppointmentCreateView> createState() => _AppointmentCreateViewState();
}

class _AppointmentCreateViewState extends State<AppointmentCreateView> {
  final PageController _pageController = PageController();
  final AppointmentController _appointmentController = AppointmentController();

  int _currentPage = 0;

  // Go to the next page if the current page index is less than 1
  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Go to the previous page if the current page index is greater than 0
  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Handles confirmation logic for creating or updating an appointment
  Future<void> onConfirm() async {
    _appointmentController.createAppointmentFromInput();
    ApiResponseStatus status;
    String statusText;
    if (widget.appointment != null) {
      // to show toast text and response status
      status = await _appointmentController.appointmentUpdate(widget.appointment!.documentId!,
      ); // appointment update
      statusText = "Appointment Updated";
    } else {
      status = await _appointmentController.appointmentCreate(); // appointment create
      statusText = "Appointment Created";
    }

    if (status == ApiResponseStatus.failure) {
      if (mounted) {
        ToastHelper.showToast(
          context,
          _appointmentController.appointmentResponseModel.message.toString(),
          type: ToastificationType.error,
        );
      }
    } else if (status == ApiResponseStatus.success) {
      if (mounted) {
        ToastHelper.showToast(context, statusText);
        Navigator.pushNamedAndRemoveUntil(
          context,
          myAppointmentsView,
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    // If there is an appointment, we assign textfield files and time slots.
    if (widget.appointment != null) {
      _appointmentController.createSelectedAppointmentFromInput(
        widget.appointment!,
      );
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    _appointmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.lightGrey,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          AppointmentFirstStepView(
            header: widget.appointment != null
                ? "Update Appointment"
                : "Create an Appointment",
            appointmentController: _appointmentController,
          ),
          AppointmentSecondaryStepView(
            appointmentController: _appointmentController,
          ),
        ],
      ),
      bottomNavigationBar: AppointmentCreateBottomNavBar(
        currentPage: _currentPage,
        onNext: _nextPage,
        onBack: _prevPage,
        onConfirm: onConfirm,
      ),
    );
  }
}
