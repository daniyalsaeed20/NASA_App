import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial(searchString: ''));

  readSearchQuery({required String searchString}) {
    return emit(SearchInitial(searchString: searchString));
  }
}
