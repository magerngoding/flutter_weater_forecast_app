// ignore_for_file: prefer_const_constructors

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_bloc.dart';

class HourlyForecastPage extends StatefulWidget {
  const HourlyForecastPage({super.key});

  @override
  State<HourlyForecastPage> createState() => _HourlyForecastPageState();
}

class _HourlyForecastPageState extends State<HourlyForecastPage> {
  refresh() {
    context.read<HourlyForecastBloc>().add(OnGetHourlyForecast());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Positioned.fill(
            child: Material(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          foreground(),
        ],
      ),
    );
  }

  Widget background() {
    return DView.nothing();
  }

  Widget foreground() {
    return DView.nothing();
  }
}
