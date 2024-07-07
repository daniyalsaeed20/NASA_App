// ignore_for_file: avoid_print

import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picture_of_the_day/model/apod_model.dart';
import 'package:picture_of_the_day/modules/apod/bloc/apod_bloc.dart';
import 'package:picture_of_the_day/repositories/local_storage_repository.dart';
import 'package:picture_of_the_day/repositories/nasa_repository.dart';
import 'package:picture_of_the_day/services/network_services.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MockNasaRepository extends Mock implements NasaRepository {
  @override
  fetchApods({required int count}) async {
    return <ApodModel>[];
  }
}

class MockLocalStorageRepository extends Mock
    implements LocalStorageRepository {
  @override
  Future<Database> get database => throw UnimplementedError();

  @override
  Future<List<ApodModel>> fetchApods() async {
    return <ApodModel>[];
  }

  @override
  Future<Database> initDb() {
    throw UnimplementedError();
  }

  @override
  Future<void> insertApod(ApodModel apod) {
    throw UnimplementedError();
  }
}

class MockNetworkServices extends Mock implements NetworkServices {
  @override
  Future<bool> checkInternetConnection() async {
    return true;
  }
}

void main() {
  group(
    'ApodBloc',
    () {
      late ApodBloc apodBloc;
      late MockNasaRepository nasaRepository;
      late MockLocalStorageRepository localStorageRepository;
      late MockNetworkServices networkServices;

      setUp(() {
        print('Setup complete');
        nasaRepository = MockNasaRepository();
        localStorageRepository = MockLocalStorageRepository();
        networkServices = MockNetworkServices();

        apodBloc = ApodBloc(
          nasaRepository: nasaRepository,
          localStorageRepository: localStorageRepository,
          networkServices: networkServices,
        );
      });

      tearDown(() {
        print('Test complete');
        apodBloc.close();
      });

      blocTest<ApodBloc, ApodState>(
        'emits [ApodLoadState, ApodSuccessState] when ApodFetchEvent is added and internet is available',
        build: () {
          print(
              'emits [ApodLoadState, ApodSuccessState] when ApodFetchEvent is added and internet is available');
          when(networkServices.checkInternetConnection().then((_) => true));
          when(nasaRepository.fetchApods(
              count: 10 + Random().nextInt(50 - 10 + 1)));
          return apodBloc;
        },
        act: (bloc) => bloc.add(const ApodFetchEvent(count: 10)),
        expect: () => [
          const ApodLoadState(apodList: [], count: 10),
          const ApodSuccessState(apodList: [], count: 10),
        ],
      );

      blocTest<ApodBloc, ApodState>(
        'emits [ApodLoadState, ApodFailedState] when ApodFetchEvent is added and no internet is available',
        build: () {
          print(
              'emits [ApodLoadState, ApodFailedState] when ApodFetchEvent is added and no internet is available');
          when(networkServices.checkInternetConnection().then((_) => false));
          when(localStorageRepository.fetchApods());
          return apodBloc;
        },
        act: (bloc) => bloc.add(const ApodFetchEvent(count: 10)),
        expect: () => [
          const ApodLoadState(apodList: [], count: 10),
          const ApodSuccessState(apodList: [], count: 10),
        ],
      );

      blocTest<ApodBloc, ApodState>(
        'emits [ApodLoadPaginationState, ApodSuccessState] when ApodFetchPaginationEvent is added and internet is available',
        build: () {
          print(
              'emits [ApodLoadPaginationState, ApodSuccessState] when ApodFetchPaginationEvent is added and internet is available');
          when(networkServices.checkInternetConnection());
          when(nasaRepository.fetchApods(
              count: 10 + Random().nextInt(50 - 10 + 1)));
          return apodBloc;
        },
        act: (bloc) => bloc.add(const ApodFetchPaginationEvent(count: 10)),
        expect: () => [
          const ApodLoadPaginationState(apodList: [], count: 10),
          const ApodSuccessState(apodList: [], count: 10),
        ],
      );

      blocTest<ApodBloc, ApodState>(
        'emits [ApodLoadPaginationState, ApodFailedState] when ApodFetchPaginationEvent is added and no internet is available',
        build: () {
          print(
              'emits [ApodLoadPaginationState, ApodFailedState] when ApodFetchPaginationEvent is added and no internet is available');
          when(networkServices.checkInternetConnection());
          when(localStorageRepository.fetchApods());
          return apodBloc;
        },
        act: (bloc) => bloc.add(const ApodFetchPaginationEvent(count: 10)),
        expect: () => [
          const ApodLoadPaginationState(apodList: [], count: 10),
          const ApodSuccessState(apodList: [], count: 10),
        ],
      );
    },
  );
}
