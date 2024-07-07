import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:picture_of_the_day/repositories/nasa_repository.dart';
import 'package:picture_of_the_day/services/nasa_services.dart';

import 'home_screen.dart';
import 'repositories/local_storage_repository.dart';
import 'utils/theme_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NasaRepository(nasaServices: NasaServices()),
        ),
        RepositoryProvider(
          create: (context) => LocalStorageRepository(),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: designViewport,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp(
            
            theme: themeData,
            title: 'Picture of the day',
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
