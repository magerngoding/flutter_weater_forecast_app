import 'package:flutter_weater_forecast/common/app_session.dart';
import 'package:flutter_weater_forecast/features/pick_place/presentation/cubit/city_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // regisDI cubit / bloc
  locator.registerFactory(() => CityCubit(locator()));

  // external dari package sharedP.
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => AppSession(pref));
}
