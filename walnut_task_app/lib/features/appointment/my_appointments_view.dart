import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/core/helpers/toast_helper.dart';
import 'package:walnut_task_app/features/appointment/controller/appointment_controller.dart';
import 'package:walnut_task_app/features/appointment/create_appointment/widget/appointment_calendar.dart';
import 'package:walnut_task_app/features/appointment/create_appointment/widget/appointment_card.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';
import 'package:walnut_task_app/product/constants/routing_constants.dart';

class MyAppointmentsView extends StatefulWidget {
  const MyAppointmentsView({super.key});

  @override
  State<MyAppointmentsView> createState() => _MyAppointmentsViewState();
}

class _MyAppointmentsViewState extends State<MyAppointmentsView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final AppointmentController _appointmentController = AppointmentController();

  // We get the appointment data from the database and put it into the appointment list.
  Future<void> getApppointments() async {
    ApiResponseStatus status = await _appointmentController.getApppointments();

    if (status == ApiResponseStatus.unauthorized && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        loginView,
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> getInitData() async {
    await getApppointments();
    setState(() {});
  }

  @override
  void initState() {
    getInitData();
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _appointmentController.dispose();
    super.dispose();
  }

    // Returns a list of appointments scheduled for the given day.
  // It filters the appointments by matching year, month, and day.
  List<AppointmentRequestModel> _getAppointmentsForDay(DateTime day) {
    final filtered = _appointmentController.appointments.where((appointment) {
      final date = appointment.appointmentDate;
      if (date == null) return false;
      return date.year == day.year &&
          date.month == day.month &&
          date.day == day.day;
    }).toList();
    return filtered;
  }

  // delete appointment 
  Future<void> deleteAppointment(AppointmentRequestModel appointment) async {
    if (appointment.documentId != null) {
      ApiResponseStatus status = await _appointmentController.deleteAppointment(
        appointment.documentId!,
      );
      if (status == ApiResponseStatus.success) {
        ToastHelper.showToast(context, "Appointment Deleted");
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.lightGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni randevu oluşturma sayfasına git
          Navigator.pushNamed(context, appointmentCreateView);
        },
        backgroundColor: context.primaryColor,
        child:  Icon(Icons.add,color: context.whiteColor,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PaddingConstants.pageDynamicTopNormalGap(context),
            child: Text(
              "My Appointments",
              style: context.bodyLarge.copyWith(color: context.secondaryColor),
            ),
          ),
          AppointmentCalendar(
            appointments: _appointmentController.appointments,
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            onDaySelected: (selectedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = selectedDay;
              });
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child:
                _selectedDay == null ||
                    _getAppointmentsForDay(_selectedDay!).isEmpty
                ? Center(
                    child: Text(
                      "There are no appointments for today.",
                      style: context.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _getAppointmentsForDay(_selectedDay!).length,
                    itemBuilder: (context, index) {
                      final AppointmentRequestModel appointment =
                          _getAppointmentsForDay(_selectedDay!)[index];
                      return AppointmentCard(
                        appointment: appointment,
                        deleteFunc: () => deleteAppointment(appointment),
                        editFunc: () => Navigator.pushNamed(context, appointmentCreateView, arguments: appointment),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
