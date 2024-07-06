part of 'apod_bloc.dart';

sealed class ApodEvent extends Equatable {
  const ApodEvent();

  @override
  List<Object> get props => [];
}

 class ApodFetchEvent extends ApodEvent {
  const ApodFetchEvent({required int count}) : _count = count;
  final int _count;

  @override
  List<Object> get props => [_count];
}
 class ApodFetchPaginationEvent extends ApodEvent {
  const ApodFetchPaginationEvent({required int count}) : _count = count;
  final int _count;

  @override
  List<Object> get props => [_count];
}
