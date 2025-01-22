// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weater_forecast/common/app_session.dart';

class CityCubit extends Cubit<String> {
  final AppSession appSession;
  CityCubit(
    this.appSession,
  ) : super('');

  String init() {
    String? city = appSession.cityName;
    if (city != null) emit(city);

    return state;
  }

  listenChange(String n) {
    emit(n);
  }

  saveCity() {
    appSession.saveCityName(state);
    // bool success = await appSession.saveCityName(state);
    // DMethod.printTitle('saveCity', success.toString());
  }
}
