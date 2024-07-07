part of 'today_picture_cubit.dart';

sealed class TodayPictureState extends Equatable {
  const TodayPictureState({required this.todayPicture});
  final ApodModel todayPicture;

  @override
  List<Object> get props => [todayPicture];
}

final class TodayPictureInitial extends TodayPictureState {
  const TodayPictureInitial({required super.todayPicture});
}
final class TodayPictureLoadState extends TodayPictureState {
  const TodayPictureLoadState({required super.todayPicture});
}
final class TodayPictureFailedState extends TodayPictureState {
  const TodayPictureFailedState({required super.todayPicture,required this.msg});
  final String msg;
    @override
  List<Object> get props => [msg];
}
