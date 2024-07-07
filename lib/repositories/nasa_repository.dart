import 'dart:convert';

import 'package:picture_of_the_day/services/nasa_services.dart';

import '../model/apod_model.dart';
import 'response_handler.dart';

class NasaRepository {
  NasaRepository({required NasaServices nasaServices})
      : _nasaServices = nasaServices;
  final NasaServices _nasaServices;

  fetchApods({required int count}) async {
    try {
      final response = await _nasaServices.fetchApods(count: count);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ApodModel> apodModelList =
            data.map((json) => ApodModel.fromJson(json)).toList();
        return apodModelList;
      } else {
        return ResponseHandler.handleResponse(statusCode: response.statusCode);
      }
    } catch (e) {
      return 'Failed to load APODs';
    }
  }

  fetchPod() async {
    try {
      final response = await _nasaServices.fetchPod();
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        ApodModel apodModel = ApodModel.fromJson(data);
        return apodModel;
      } else {
        return ResponseHandler.handleResponse(statusCode: response.statusCode);
      }
    } catch (e) {
      return 'Failed to load APOD';
    }
  }
}
