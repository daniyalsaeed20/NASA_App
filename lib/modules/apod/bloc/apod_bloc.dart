import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picture_of_the_day/model/apod_model.dart';
import 'package:picture_of_the_day/repositories/nasa_repository.dart';
import 'package:picture_of_the_day/services/network_services.dart';

import '../../../repositories/local_storage_repository.dart';

part 'apod_event.dart';
part 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  ApodBloc(
      {required NasaRepository nasaRepository,
      required LocalStorageRepository localStorageRepository,
      required NetworkServices networkServices})
      : _nasaRepository = nasaRepository,
        _localStorageRepository = localStorageRepository,
        _networkServices = networkServices,
        super(const ApodInitial(apodList: [], count: 10)) {
    on<ApodFetchEvent>(_mapApodFetchEventToState);
    on<ApodFetchPaginationEvent>(_mapApodFetchPaginationEventToState);
  }
  final NasaRepository _nasaRepository;
  final LocalStorageRepository _localStorageRepository;
  final NetworkServices _networkServices;

  _mapApodFetchEventToState(
      ApodFetchEvent event, Emitter<ApodState> emit) async {
    try {
      emit(ApodLoadState(apodList: state.apodList, count: event._count));
      dynamic response;
      response = await _networkServices.checkInternetConnection(); // returns a future bool
      if (response) {
        response = await _nasaRepository.fetchApods(count: event._count);
      } else {
        response = await _localStorageRepository.fetchApods();
        print(response);
      }
      if (response.runtimeType == List<ApodModel>) {
        for (ApodModel apod in response) {
          _localStorageRepository.insertApod(apod);
        }
        return emit(ApodSuccessState(apodList: response, count: event._count));
      } else if (response.runtimeType == String) {
        return emit(ApodFailedState(
            msg: response, count: event._count, apodList: state.apodList));
      } else {
        return emit(ApodFailedState(
            msg: 'Failed to load APODs',
            count: event._count,
            apodList: state.apodList));
      }
    } catch (e) {
      return emit(ApodFailedState(
          msg: 'Failed to load APODs',
          count: event._count,
          apodList: state.apodList));
    }
  }

  _mapApodFetchPaginationEventToState(
      ApodFetchPaginationEvent event, Emitter<ApodState> emit) async {
    try {
      emit(ApodLoadPaginationState(
          count: event._count, apodList: state.apodList));
      dynamic response;
      response = await _networkServices.checkInternetConnection(); // returns a future bool
      if (response) {
        response = await _nasaRepository.fetchApods(count: event._count);
      } else {
        response = await _localStorageRepository.fetchApods();
        print(response);
      }
      if (response.runtimeType == List<ApodModel>) {
        for (ApodModel apod in response) {
          _localStorageRepository.insertApod(apod);
        }
        return emit(ApodSuccessState(
            apodList: state.apodList + response, count: event._count));
      } else if (response.runtimeType == String) {
        return emit(ApodFailedState(
            msg: response, count: event._count, apodList: state.apodList));
      } else {
        return emit(ApodFailedState(
            msg: 'Failed to load APODs',
            count: event._count,
            apodList: state.apodList));
      }
    } catch (e) {
      return emit(ApodFailedState(
          msg: 'Failed to load APODs',
          count: event._count,
          apodList: state.apodList));
    }
  }
}
