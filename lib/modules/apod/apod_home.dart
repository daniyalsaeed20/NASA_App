import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:picture_of_the_day/modules/apod/apod_details.dart';
import 'package:picture_of_the_day/modules/apod/today_picture_cubit/today_picture_cubit.dart';
import 'package:picture_of_the_day/repositories/local_storage_repository.dart';
import 'package:picture_of_the_day/repositories/nasa_repository.dart';
import 'package:picture_of_the_day/services/network_services.dart';
import 'package:picture_of_the_day/widgets/search_bar/search_cubit/search_cubit.dart';

import '../../utils/theme_data.dart';
import '../../widgets/apod_tile.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/search_bar/search_bar.dart';
import 'apod_bloc/apod_bloc.dart';

class ApodHome extends StatelessWidget {
  const ApodHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApodBloc(
            localStorageRepository:
                RepositoryProvider.of<LocalStorageRepository>(context),
            nasaRepository: RepositoryProvider.of<NasaRepository>(context),
            networkServices: NetworkServices(),
          )..add(const ApodFetchEvent(count: 10)),
        ),
        BlocProvider(
          create: (context) => TodayPictureCubit(
            localStorageRepository:
                RepositoryProvider.of<LocalStorageRepository>(context),
            nasaRepository: RepositoryProvider.of<NasaRepository>(context),
            networkServices: NetworkServices(),
          )..fetchTodayPicture(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: const Ui(),
    );
  }
}

TextEditingController _searchQueryController = TextEditingController();

class Ui extends StatefulWidget {
  const Ui({super.key});

  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<ApodBloc>(context, listen: false).add(
              ApodFetchPaginationEvent(
                  count: BlocProvider.of<ApodBloc>(context).state.count + 10));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApodBloc, ApodState>(
      builder: (context, apodState) {
        if (apodState is ApodLoadState) {
          return Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              margin: EdgeInsets.only(
                  left: horizontalMargin, right: horizontalMargin),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                ),
                color: foreGroundColor,
              ),
              child: const Center(child: CustomLoader()));
        } else if (apodState is ApodFailedState) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  apodState.msg,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: verticalPadding,
                ),
                CustomButton(
                  text: 'APOD API',
                  icon: Icons.rocket_launch_outlined,
                  onPressed: () async {
                    BlocProvider.of<ApodBloc>(context)
                        .add(ApodFetchEvent(count: 10));
                  },
                ),
              ],
            ),
          );
        } else {
          return BlocBuilder<SearchCubit, SearchState>(
            builder: (context, searchState) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    margin: EdgeInsets.only(
                        left: horizontalMargin, right: horizontalMargin),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                      color: foreGroundColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomSearchBar(
                          controller: _searchQueryController,
                          onChanged: (value) {
                            BlocProvider.of<SearchCubit>(context)
                                .readSearchQuery(searchString: value!);
                            return;
                          },
                        ),
                        BlocBuilder<TodayPictureCubit, TodayPictureState>(
                          builder: (context, tpState) {
                            return CustomButton(
                                onPressed: tpState is TodayPictureFailedState
                                    ? () {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Please fill in the required fields.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: accentColor,
                                          textColor: Colors.black,
                                          fontSize: 16.1.sp,
                                        );
                                      }
                                    : () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                ApodDetails(
                                              apodModel: tpState.todayPicture,
                                            ),
                                          ),
                                        );
                                      },
                                text: 'Click to view today`s picture');
                          },
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            backgroundColor: backGroundColor,
                            color: accentColor,
                            onRefresh: () async =>
                                BlocProvider.of<ApodBloc>(context)
                                    .add(const ApodFetchEvent(count: 10)),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: apodState.apodList.length,
                              itemBuilder: (context, index) {
                                if (apodState.apodList[index].date
                                        .toLowerCase()
                                        .contains(searchState.searchString
                                            .toLowerCase()) ||
                                    apodState.apodList[index].title
                                        .toLowerCase()
                                        .contains(searchState.searchString
                                            .toLowerCase())) {
                                  return ApodTile(
                                    apodModel: apodState.apodList[index],
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ApodDetails(
                                          apodModel: apodState.apodList[index],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (apodState is ApodLoadPaginationState)
                    Container(
                      color: backGroundColor.withOpacity(0.5),
                      child: const Center(child: CustomLoader()),
                    )
                ],
              );
            },
          );
        }
      },
    );
  }
}
