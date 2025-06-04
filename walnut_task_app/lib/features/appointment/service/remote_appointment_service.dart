import 'package:walnut_task_app/core/constants/base_url.dart';
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/models/base_response_model.dart';
import 'package:walnut_task_app/core/network_manager/network_manager.dart';
import 'package:walnut_task_app/features/appointment/models/appointment_request_model.dart';
import 'package:walnut_task_app/features/appointment/models/time_slot_model.dart';

class RemoteAppointmentService {
  final _networkManager = NetworkManager.instance;

  // Fetch list of time slots from the backend
  Future<BaseResponseModel<List<TimeSlotModel>>> getTimeSlots() async {
    BaseResponseModel<List<TimeSlotModel>> response = await _networkManager
        .getRequest<BaseResponseModel<List<TimeSlotModel>>>(
          baseUrl: getSlotUrl,
          fromJson: (json) => BaseResponseModel<List<TimeSlotModel>>.fromJson(
            json,
            (dataJson) => (dataJson as List)
                .map((e) => TimeSlotModel.fromJson(e))
                .toList(),
          ),
        );

    return response;
  }

  // Fetch all appointments for the users
  Future<BaseResponseModel<List<AppointmentRequestModel>>>
  getApppointments() async {
    BaseResponseModel<List<AppointmentRequestModel>> response =
        await _networkManager
            .getRequest<BaseResponseModel<List<AppointmentRequestModel>>>(
              baseUrl: getApppointment,
              fromJson: (json) =>
                  BaseResponseModel<List<AppointmentRequestModel>>.fromJson(
                    json,
                    (dataJson) => (dataJson as List)
                        .map((e) => AppointmentRequestModel.fromJson(e))
                        .toList(),
                  ),
            );

    return response;
  }

  // Create a new appointment
  Future<BaseResponseModel<AppointmentRequestModel>> appointmentCreate(
    AppointmentRequestModel appointmentRequestModel,
  ) async {
    try {
      final response = await _networkManager
          .postRequestwithJwtToken<BaseResponseModel<AppointmentRequestModel>>(
            baseUrl: createApppointment,
            input: appointmentRequestModel.toJson(),
            fromJson: (json) =>
                BaseResponseModel<AppointmentRequestModel>.fromJson(
                  json,
                  (dataJson) => AppointmentRequestModel.fromJson(dataJson),
                ),
          );

      return response;
    } catch (e) {
      // Hata durumunda boş response dön, ya da özel bir error modelin varsa onu kullan
      return BaseResponseModel<AppointmentRequestModel>(
        success: false,
        message: "Bir hata oluştu.",
        data: null,
      );
    }
  }

  // Update an existing appointment by ID
  Future<BaseResponseModel<AppointmentRequestModel>> appointmentUpdate(
    AppointmentRequestModel appointmentRequestModel,
    String id,
  ) async {
    try {
      final response = await _networkManager
          .putRequestwithJwtToken<BaseResponseModel<AppointmentRequestModel>>(
            baseUrl: '$updateAppointment/$id',
            input: appointmentRequestModel.toJson(),
            fromJson: (json) =>
                BaseResponseModel<AppointmentRequestModel>.fromJson(
                  json,
                  (dataJson) => AppointmentRequestModel.fromJson(dataJson),
                ),
          );

      return response;
    } catch (e) {
      return BaseResponseModel<AppointmentRequestModel>(
        success: false,
        message: "Bir hata oluştu.",
        data: null,
      );
    }
  }

  // Delete appointment by ID
  Future<ApiResponseStatus> deleteApppointment(String id) async {
    ApiResponseStatus status = await _networkManager.deleteRequest(
      baseUrl: "$deleteAppointment/$id",
    );

    return status;
  }
}
