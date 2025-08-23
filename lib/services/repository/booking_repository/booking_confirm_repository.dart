import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/services/api/api_services.dart';
import 'package:get/get.dart';
import '../../../models/booking_create_responce_model.dart';

class BookingConfirmRepository extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successfullyMessage;
  String? get successfullyMessage => _successfullyMessage;

  /// এখন এই মেথড Future<Map<String, dynamic>?> রিটার্ন করবে
  Future<BookingResponseModel?> bookingCreate(var bookingCreateModel) async {
    _inProgress = true;
    update();

    try {
      var response = await ApiService.postApi(
        ApiUrls.bookingCreateUrl,
        bookingCreateModel,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _successfullyMessage = response.message;
        _inProgress = false;
        update();

        // পুরো data কে model হিসেবে parse করি
        return BookingResponseModel.fromJson(response.body['data']);
      } else {
        _errorMessage = response.message;
        _successfullyMessage = null;
        _inProgress = false;
        update();
        return null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _successfullyMessage = null;
      _inProgress = false;
      update();
      return null;
    }
  }

}
