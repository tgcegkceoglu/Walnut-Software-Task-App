import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/features/appointment/controller/appointment_controller.dart';
import 'package:walnut_task_app/features/appointment/models/time_slot_model.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';
import 'package:walnut_task_app/product/constants/routing_constants.dart';

class AppointmentSecondaryStepView extends StatefulWidget {
  final AppointmentController appointmentController;
  const AppointmentSecondaryStepView({
    super.key,
    required this.appointmentController,
  });

  @override
  State<AppointmentSecondaryStepView> createState() =>
      _AppointmentSecondaryStepViewState();
}

class _AppointmentSecondaryStepViewState
    extends State<AppointmentSecondaryStepView> {
  // if time slot list is empty, it will fetch the available time slots simultaneously.
  // If the user is not authorized, it will go to the login screen and clear the navigation stack.
  Future<void> getSlots() async {
    ApiResponseStatus status = await widget.appointmentController
        .getTimeSlots();

    // If the login is present but there is no token or if it is unauthorized, we redirect to login.
    if (status == ApiResponseStatus.unauthorized && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        loginView,
        (Route<dynamic> route) => false,
      );
    }
  }

  // Toggles the selection state of a given time slot.
  // If the slot is already selected, it removes it from the selected list.
  // Otherwise, it adds the slot to the selected list.
  // Calls setState to update the UI accordingly.
  void toggleSlot(TimeSlotModel slotLabel) {
    setState(() {
      if (widget.appointmentController.selectedTimeSlots.contains(slotLabel)) {
        widget.appointmentController.selectedTimeSlots.remove(slotLabel);
      } else {
        widget.appointmentController.selectedTimeSlots.add(slotLabel);
      }
    });
  }

  @override
  void initState() {
    Future.wait([getInitData()]);
    super.initState();
  }

  // Loads initial data for the widget, including time slots if not already loaded,
  // then triggers a UI update.
  Future<void> getInitData() async {
    if (widget.appointmentController.timeSlots.isEmpty) await getSlots();
    setState(() {});
  }
 
 // Editing button style based on selected
  ButtonStyle getButtonStyle(bool isSelected, BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? context.green : context.primaryColor,
      padding: PaddingConstants.itemNormal,
      elevation: isSelected ? 6 : 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.lightGrey,
      appBar: AppBar(
        backgroundColor: context.lightGrey,
        title: Text(
          "Select Appointment Times",
          style: context.bodyLarge.copyWith(color: context.secondaryColor),
        ),
      ),
      body: ListView(
        padding: PaddingConstants.pageDynamicTopNormalGap(context),
        children: [
          // Servisten gelen zamanların listelenmesi
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.appointmentController.timeSlots.map((slot) {
              final label ="${slot.formattedStartTime} - ${slot.formattedEndTime}";
              final isSelected = widget.appointmentController.selectedTimeSlots.contains(slot);

              return ElevatedButton(
                onPressed: () => toggleSlot(slot),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? context.green
                      : context.primaryColor,
                  padding: PaddingConstants.itemNormal,
                ),
                child: Text(
                  label,
                  style: context.bodySmall.copyWith(color: context.whiteColor),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
