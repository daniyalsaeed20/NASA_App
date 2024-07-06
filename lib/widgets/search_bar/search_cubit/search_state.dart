part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState({required this.searchString});

  final String searchString;

  @override
  List<Object> get props => [searchString];
}

final class SearchInitial extends SearchState {
  const SearchInitial({required super.searchString});
}
