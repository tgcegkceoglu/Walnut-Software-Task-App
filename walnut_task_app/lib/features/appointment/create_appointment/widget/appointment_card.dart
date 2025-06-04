import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/core/utils/date_time_utils.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentRequestModel appointment;
  final VoidCallback deleteFunc;
  final Future<Object?> Function() editFunc;
  const AppointmentCard({super.key,required this.appointment, required this.deleteFunc, required this.editFunc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: context.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${appointment.userName}",
                    style: context.bodyLarge.copyWith(color: context.whiteColor),
                  ),
                ),
                Text(
                  "📅 ${formatDate(appointment.appointmentDate!)}",
                  style: context.bodySmall,
                ),
              ],
            ),
            
             Visibility(
              visible: appointment.description != null,
               child: Padding(
                 padding:PaddingConstants.pageVerticalLow,
                 child: Text(
                      " ${appointment.description?? ''}",
                      style: context.bodySmall,
                    ),
               ),
             ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${appointment.title}"),
                      SizedBox(height: 8),
                      Text("⏰ Seçilen Saatler:", style: context.bodySmall),

                      SizedBox(height: 8),
                      if (appointment.timeSlots != null)
                        ...appointment.timeSlots!.map<Widget>((slot) {
                          return Text(
                            "• ${formatHourMinute(slot.startDate ?? "")} - ${formatHourMinute(slot.endDate ?? '')}",
                            style: context.bodySmall,
                          );
                        }),
                    ],
                  ),
                ),
                IconButton(
                  onPressed:deleteFunc,
                  icon: Icon(Icons.delete, color: context.lightGrey),
                ),
                IconButton(
                  onPressed:editFunc,
                  icon: Icon(Icons.edit, color: context.lightGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
