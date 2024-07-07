part of 'apod_bloc.dart';

sealed class ApodState extends Equatable {
  const ApodState({required this.apodList, required this.count});
  final List<ApodModel> apodList;
  final int count;

  @override
  List<Object> get props => [apodList, count];
}

final class ApodInitial extends ApodState {
  const ApodInitial({required super.apodList, required super.count});
}

final class ApodLoadState extends ApodState {
  const ApodLoadState({required super.apodList, required super.count});
}

final class ApodLoadPaginationState extends ApodState {
  const ApodLoadPaginationState(
      {required super.apodList, required super.count});
}

final class ApodFailedState extends ApodState {
  const ApodFailedState(
      {required this.msg, required super.apodList, required super.count});
  final String msg;

  @override
  List<Object> get props => [msg];
}

final class ApodSuccessState extends ApodState {
  const ApodSuccessState({required super.apodList, required super.count});
}
