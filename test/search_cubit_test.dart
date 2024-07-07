import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picture_of_the_day/widgets/search_bar/search_cubit/search_cubit.dart';
void main() {
  group('SearchCubit', () {
    late SearchCubit searchCubit;

    setUp(() {
      searchCubit = SearchCubit();
      print('Setup complete');
    });

    tearDown(() {
      searchCubit.close();
      print('Test complete');
    });

    test('initial state is SearchInitial with empty searchString', () {
      expect(searchCubit.state, const SearchInitial(searchString: ''));
    });

    blocTest<SearchCubit, SearchState>(
      'emits [SearchInitial] with updated searchString when readSearchQuery is called',
      build: () => searchCubit,
      act: (cubit) => cubit.readSearchQuery(searchString: 'test search'),
      expect: () => [
        const SearchInitial(searchString: 'test search'),
      ],
      verify: (cubit) {
        print('SearchCubit state: ${cubit.state}');
      },
    );

    test('readSearchQuery updates the state with the provided searchString', () {
      const testString = 'new search';
      searchCubit.readSearchQuery(searchString: testString);
      expect(searchCubit.state, const SearchInitial(searchString: testString));
    
    });
  });
}
