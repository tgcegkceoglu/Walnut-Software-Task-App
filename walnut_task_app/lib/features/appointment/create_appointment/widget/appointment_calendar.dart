import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/product/widgets/custom_marker_widget.dart';

class AppointmentCalendar extends StatefulWidget {
  final List<AppointmentRequestModel> appointments;
  final Function(DateTime selectedDay) onDaySelected;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  const AppointmentCalendar({
    super.key,
    required this.appointments,
    required this.onDaySelected,
    required this.focusedDay,
    required this.selectedDay,
  });

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  // Returns a list of appointments scheduled for the given day.
  // It filters the appointments by matching year, month, and day.
  List<AppointmentRequestModel> _getAppointmentsForDay(DateTime day) {
    return widget.appointments.where((appointment) {
      final date = appointment.appointmentDate;
      return date != null &&
          date.year == day.year &&
          date.month == day.month &&
          date.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final firstDay = DateTime(today.year, today.month, today.day);
    final lastDay = DateTime(today.year + 10, today.month, today.day);

    return TableCalendar(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: widget.focusedDay,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay);
      },
      eventLoader: _getAppointmentsForDay,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: context.secondaryColor,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: context.primaryColor,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(bottom: -3, child: CustomMarkerWidget());
          }
          return null;
        },
      ),
    );
  }
}
