import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/core/utils/date_time_utils.dart';
import 'package:walnut_task_app/features/appointment/controller/appointment_controller.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';
import 'package:walnut_task_app/product/widgets/custom_textfiled_widget.dart';

class AppointmentFirstStepView extends StatefulWidget {
  final AppointmentController appointmentController;
  final String header;

  const AppointmentFirstStepView({
    super.key,
    required this.header,
    required this.appointmentController,
  });

  @override
  State<AppointmentFirstStepView> createState() =>
      _AppointmentFirstStepViewState();
}

class _AppointmentFirstStepViewState extends State<AppointmentFirstStepView> {
  // Opens a date picker dialog for the user to select a date.
  // When a date is picked, updates the controller's selectedDate,
  // formats the date, sets it in the dateController text field,
  // and refreshes the UI.
  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      widget.appointmentController.selectedDate = picked;
      final formatted = formatDate(picked);
      widget.appointmentController.dateController.text = formatted;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.lightGrey,
      appBar: AppBar(
        backgroundColor: context.lightGrey,
        title: Text(
        widget.header,
          style: context.bodyLarge.copyWith(color: context.secondaryColor),
        ),
      ),
      body: ListView(
        padding: PaddingConstants.pageDynamicTopNormalGap(context),
        children: [
          //  info text
          Text(
            "Choose a date and time slot that works for you. You can view available slots and create a new appointment quickly.",
            style: context.bodySmall.copyWith(color: context.blackColor),
          ),
          SizedBox(height: 16),

          // create age text and textfield
          Text(
            "Date",
            style: context.bodySmall.copyWith(color: context.primaryColor),
          ),
          SizedBox(height: 8),
          CustomTextFieldWidget(
            controller: widget.appointmentController.dateController,
            readOnly: true,
            onIconTap: _selectDate,
            icon: Icons.date_range_outlined,
          ),
          SizedBox(height: 16),

          // create username text and textfield
          Text(
            "Username",
            style: context.bodySmall.copyWith(color: context.primaryColor),
          ),
          SizedBox(height: 8),

          CustomTextFieldWidget(
            controller: widget.appointmentController.nameController,
            inputType: TextInputType.text,
          ),
          SizedBox(height: 16),

          // create age text and textfield
          Text(
            "Age",
            style: context.bodySmall.copyWith(color: context.primaryColor),
          ),
          SizedBox(height: 8),

          CustomTextFieldWidget(
            controller: widget.appointmentController.ageController,
            inputType: TextInputType.number,
          ),
          SizedBox(height: 16),

          // create note text and textfield
          Text(
            "Title",
            style: context.bodySmall.copyWith(color: context.primaryColor),
          ),
          SizedBox(height: 8),

          CustomTextFieldWidget(
            controller: widget.appointmentController.titleController,
            maxLines: 5,
            inputType: TextInputType.text,
          ),

          SizedBox(height: 16),

          // create note text and textfield
          Text(
            "Description",
            style: context.bodySmall.copyWith(color: context.primaryColor),
          ),
          SizedBox(height: 8),

          CustomTextFieldWidget(
            controller: widget.appointmentController.descriptionController,
            maxLines: 5,
            inputType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
