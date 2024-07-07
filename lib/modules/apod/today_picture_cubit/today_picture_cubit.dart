import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:picture_of_the_day/model/apod_model.dart';
import 'package:picture_of_the_day/repositories/nasa_repository.dart';

import '../../../repositories/local_storage_repository.dart';
import '../../../services/network_services.dart';

part 'today_picture_state.dart';

class TodayPictureCubit extends Cubit<TodayPictureState> {
  TodayPictureCubit(
      {required NasaRepository nasaRepository,
      required LocalStorageRepository localStorageRepository,
      required NetworkServices networkServices})
      : _nasaRepository = nasaRepository,
        _localStorageRepository = localStorageRepository,
        _networkServices = networkServices,
        super(TodayPictureInitial(todayPicture: ApodModel.empty()));
  final NasaRepository _nasaRepository;
  final LocalStorageRepository _localStorageRepository;
  final NetworkServices _networkServices;
  fetchTodayPicture() async {
    try {
      emit(TodayPictureLoadState(todayPicture: state.todayPicture));
      dynamic response;
      if (await _networkServices.checkInternetConnection()) {
        response = await _nasaRepository.fetchPod();
        if (response.runtimeType == ApodModel) {
           _localStorageRepository.insertApod(response);
          return {emit(TodayPictureInitial(todayPicture: response))};
        } else if (response.runtimeType == String) {
          return emit(TodayPictureFailedState(
              msg: response, todayPicture: state.todayPicture));
        }
      } else {
        response = await _localStorageRepository.fetchApods();
        for (ApodModel apod in response) {
          if (apod.date == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
            return {emit(TodayPictureInitial(todayPicture: apod))};
          }
          continue;
        }
        return emit(TodayPictureFailedState(
            msg: 'Failed to fetch Picture of the day.',
            todayPicture: state.todayPicture));
      }
    } catch (e) {
      return emit(TodayPictureFailedState(
          msg: 'Failed to fetch Picture of the day.',
          todayPicture: state.todayPicture));
    }
  }
}
