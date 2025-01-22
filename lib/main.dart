// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/features/pick_place/presentation/cubit/city_cubit.dart';
import 'package:flutter_weater_forecast/features/pick_place/presentation/pages/pick_place_page.dart';
import 'package:flutter_weater_forecast/injection.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Cara daftarkan CUBI
        BlocProvider(create: (context) => locator<CityCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.white,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => PickPlacePage(),
          AppRoute.pickPlace.name: (context) => Scaffold(),
          AppRoute.hourlyForecast.name: (context) => Scaffold(),
        },
      ),
    );
  }
}
