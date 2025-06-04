import 'package:walnut_task_app/core/utils/date_time_utils.dart';

class TimeSlotModel {
  final int id;
  final String? startDate;
  final String? endDate;

  TimeSlotModel({required this.id, this.startDate, this.endDate});

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      startDate: json['startDate'],
      endDate: json['endDate'],
      id: json['id'],
    );
  }

  String get formattedStartTime => formatHourMinute(startDate ?? "");
  String get formattedEndTime => formatHourMinute(endDate ?? "");
  
  Map<String, dynamic> toJson() {
    return {'startDate': startDate, 'endDate': endDate,'id':id};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TimeSlotModel &&
        other.id == id &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode => id.hashCode ^ startDate.hashCode ^ endDate.hashCode;
}
