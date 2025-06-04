import 'package:walnut_task_app/features/appointment/models/time_slot_model.dart';

class AppointmentRequestModel {
  DateTime? appointmentDate;
  String? description;
  List<TimeSlotModel>? timeSlots; // sadece id'ler burada
  String? title;
  String? userName;
  int? age;
  String? documentId;
  int? userId;

  AppointmentRequestModel({
    this.appointmentDate,
    this.description,
    this.timeSlots,
    this.title,
    this.userName,
    this.age,
    this.documentId,
    this.userId,
  });

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    return AppointmentRequestModel(
      appointmentDate: json['appointmentDate'] != null
          ? DateTime.parse(json['appointmentDate'])
          : null,
      description: json['description'],
      timeSlots: json['timeSlots'] != null
          ? (json['timeSlots'] as List)
                .map(
                  (e) =>
                      TimeSlotModel.fromJson(e['id'] as Map<String, dynamic>),
                )
                .toList()
          : null,
      title: json['title'],
      userName: json['userName'],
      age: json['age'],
      userId: json['userId'],
      documentId: json['documentId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'appointmentDate': appointmentDate?.toIso8601String(),
    'description': description,
    'timeSlots': timeSlots?.map((id) => {'id': id}).toList(),
    'title': title,
    'userName': userName,
    'userId': userId,
    'age': age,
    'documentId': documentId,
  };
}
