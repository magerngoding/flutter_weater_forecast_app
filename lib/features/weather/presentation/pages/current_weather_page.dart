// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weater_forecast/common/app_constant.dart';
import 'package:flutter_weater_forecast/common/enum.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/widgets/basic_shadow.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  refresh() {
    context.read<CurrentWeatherBloc>().add(OnGetCurrentWeather());
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
          Positioned.fill(
            child: background(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: BasicShadow(
                topDown: false,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
            width: double.infinity,
            child: BasicShadow(
              topDown: true,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                child: headerAction(),
              ),
              // expanded mengisi ruang tersisa
              Expanded(
                child: foreground(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget foreground() {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        if (state is CurrentWeatherLoading) return DView.loadingCircle();
        if (state is CurrentWeatherFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DView.error(data: state.message),
              IconButton(
                onPressed: () {
                  refresh();
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  Widget headerAction() {
    return Row(
      children: [
        buttonAction(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoute.pickPlace.name,
            ).then((backResponse) {
              if (backResponse == null) return;
              if (backResponse == 'refresh') refresh();
            });
          },
          title: 'City',
          icon: Icons.edit,
        ),
        DView.width(8),
        buttonAction(
          onTap: () {
            refresh();
          },
          title: 'Refresh',
          icon: Icons.refresh,
        ),
        DView.width(8),
        buttonAction(
          onTap: () {
            Navigator.pushNamed(context, AppRoute.hourlyForecast.name);
          },
          title: 'Hourly',
          icon: Icons.access_time_rounded,
        ),
      ],
    );
  }

  Widget buttonAction({
    required VoidCallback onTap,
    required String title,
    required IconData icon,
  }) {
    return Expanded(
      child: Material(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        // pakai inkwell karna di GesD tidak ada border radius
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Icon(icon),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget background() {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
      builder: (context, state) {
        String assetPath = weatherBG.entries.first.value;
        if (state is CurrentWeatherSuccess) {
          assetPath = weatherBG[state.data.description] ?? assetPath;
        }

        return Image.asset(
          assetPath,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
