// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/api/urls.dart';

import 'package:flutter_weater_forecast/common/app_constant.dart';
import 'package:flutter_weater_forecast/common/enum.dart';
import 'package:flutter_weater_forecast/common/extension.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/widgets/basic_shadow.dart';
import 'package:intl/intl.dart';

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
            key: Key('part_error'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DView.error(data: state.message),
              IconButton.filledTonal(
                onPressed: () {
                  refresh();
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          );
        }
        if (state is CurrentWeatherSuccess) {
          final weather = state.data;
          return Padding(
            key: Key('weather_success'),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.cityName!,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                Text(
                  '- ${weather.main} -',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.7),
                    shadows: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                // Kalau gambarnya bukan dari local pakai EXTENDED image network
                ExtendedImage.network(
                  URLs.weatherIcon(weather.icon),
                ),
                // Image.network(
                //   weather.icon,
                // ),
                Text(
                  weather.description.capitalize,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                // date time how to write code
                Text(
                  DateFormat('EEEE, d MMM yyyy').format(
                    DateTime.now(),
                  ),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    shadows: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                DView.height(20),
                Text(
                  // Ceil() = membulatkan keatas, Round() = membulatkan kebawah
                  '${(weather.temperature - 273.15).round()}\u2103',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                DView.height(50),
                GridView(
                  padding: const EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 60,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  children: [
                    itemStat(
                      icon: Icons.thermostat,
                      title: 'Temprature',
                      data: '${weather.temperature}°K',
                    ),
                    itemStat(
                      icon: Icons.air,
                      title: 'Wind',
                      data: '${weather.wind}m/s',
                    ),
                    itemStat(
                      icon: Icons.compare_arrows,
                      title: 'Pressure',
                      data: '${NumberFormat.currency(
                        decimalDigits: 0,
                        symbol: '',
                      ).format(weather.pressure)}hPa',
                    ),
                    itemStat(
                      icon: Icons.water_drop_outlined,
                      title: 'Humidity',
                      data: '${weather.humidity}%',
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget itemStat({
    required IconData icon,
    required String title,
    required String data,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).colorScheme.primary,
            radius: 18,
            child: Icon(icon),
          ),
          DView.width(6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Text(
                data,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
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
