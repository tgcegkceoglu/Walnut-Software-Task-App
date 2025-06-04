import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/exception/unauthorized_exception.dart';
import 'package:walnut_task_app/core/models/base_response_model.dart';
import 'package:walnut_task_app/core/utils/date_time_utils.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/features/appointment/models/time_slot_model.dart';
import 'package:walnut_task_app/features/appointment/service/remote_appointment_service.dart';

class AppointmentController {
  final RemoteAppointmentService _remoteAppointmentService =
      RemoteAppointmentService();
  BaseResponseModel<List<TimeSlotModel>> _timeSlotModel =
      BaseResponseModel<List<TimeSlotModel>>();
  BaseResponseModel<List<AppointmentRequestModel>> _appointmentResponseModel =
      BaseResponseModel<List<AppointmentRequestModel>>();
  final AppointmentRequestModel _appointmentRequestModel =
      AppointmentRequestModel();
  BaseResponseModel<AppointmentRequestModel> appointmentResponseModel =
      BaseResponseModel<AppointmentRequestModel>();

  List<TimeSlotModel> timeSlots = [];
  List<AppointmentRequestModel> appointments = [];
  List<TimeSlotModel> selectedTimeSlots = [];
  DateTime selectedDate = DateTime.now();

  // text editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  ///

  // We take the inputs and time intervals for the user creation process and transfer them to the model
  void createAppointmentFromInput() {
    _appointmentRequestModel.userName = nameController.text;
    _appointmentRequestModel.age = int.tryParse(ageController.text);
    _appointmentRequestModel.title = titleController.text;
    _appointmentRequestModel.description = descriptionController.text;
    _appointmentRequestModel.timeSlots = selectedTimeSlots;
    _appointmentRequestModel.appointmentDate = selectedDate;
  }

  // For user update, we transfer the values ​​in the existing model to inputs and lists.
  void createSelectedAppointmentFromInput(
    AppointmentRequestModel appointment,
  ) async {
    try {
      nameController.text = appointment.userName ?? '';
      ageController.text = appointment.age.toString();
      titleController.text = appointment.title ?? '';
      descriptionController.text = appointment.description ?? '';

      selectedDate = DateTime.parse(appointment.appointmentDate.toString());
      dateController.text = formatDate(selectedDate);

      // Eğer time_slots verisi array olarak geldiyse (id, start, end varsa):
      if (appointment.timeSlots != null)
        selectedTimeSlots = appointment.timeSlots!.cast<TimeSlotModel>();
    } catch (e) {
      debugPrint('Fetch error: $e');
    }
  }

  // Creates a new appointment and returns the result
  Future<ApiResponseStatus> appointmentCreate() async {
    try {
      appointmentResponseModel = await _remoteAppointmentService
          .appointmentCreate(_appointmentRequestModel);

      if (appointmentResponseModel.success != null &&
          appointmentResponseModel.success!) {
        return ApiResponseStatus.success;
      }
    } catch (e) {
      return ApiResponseStatus.failure;
    }

    return ApiResponseStatus.failure;
  }

  // Updates a new appointment and returns the result

  Future<ApiResponseStatus> appointmentUpdate(String id) async {
    try {
      appointmentResponseModel = await _remoteAppointmentService
          .appointmentUpdate(_appointmentRequestModel, id);

      if (appointmentResponseModel.success != null &&
          appointmentResponseModel.success!) {
        return ApiResponseStatus.success;
      }
    } catch (e) {
      return ApiResponseStatus.failure;
    }

    return ApiResponseStatus.failure;
  }

  // English: Retrieves available time slots from the remote service
  Future<ApiResponseStatus> getTimeSlots() async {
    try {
      if (timeSlots.isEmpty) {
        _timeSlotModel = await _remoteAppointmentService.getTimeSlots();
        if (_timeSlotModel.success != null && _timeSlotModel.success!) {
          timeSlots = _timeSlotModel.data ?? [];
          return ApiResponseStatus.success;
        }
      }
    } on UnauthorizedException {
      return ApiResponseStatus.unauthorized;
    } catch (e) {
      return ApiResponseStatus.failure;
    }
    return ApiResponseStatus.failure;
  }

  //Retrieves the user's appointments from the remote service
  Future<ApiResponseStatus> getApppointments() async {
    _appointmentResponseModel = await _remoteAppointmentService
        .getApppointments();
    if (_appointmentResponseModel.success != null &&
        _appointmentResponseModel.success!) {
      appointments =
          _appointmentResponseModel.data ??
          []; // If the result is success, it adds the data to the appointments list.
      return ApiResponseStatus.success;
    }
    return ApiResponseStatus.failure;
  }

  // Send delete request to the remote service
  Future<ApiResponseStatus> deleteAppointment(String id) async {
    try {
      final response = await _remoteAppointmentService.deleteApppointment(id);
      // Refresh the appointment list after deletion
      await getApppointments();
      return response;
    } catch (e) {
      return ApiResponseStatus.failure;
    }
  }

  void dispose() {
    nameController.dispose();
    ageController.dispose();
    dateController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    timeSlots = [];
    selectedTimeSlots = [];
    appointments = [];
    selectedDate = DateTime.now();
    _timeSlotModel = BaseResponseModel<List<TimeSlotModel>>();
    _appointmentResponseModel =BaseResponseModel<List<AppointmentRequestModel>>();
    _appointmentRequestModel.userName = null;
    _appointmentRequestModel.age = null;
    _appointmentRequestModel.title = null;
    _appointmentRequestModel.description = null;
    _appointmentRequestModel.timeSlots = null;
    _appointmentRequestModel.appointmentDate = null;
    appointmentResponseModel = BaseResponseModel<AppointmentRequestModel>();
  }
}
