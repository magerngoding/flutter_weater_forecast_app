// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/api/urls.dart';
import 'package:flutter_weater_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import '../../../../common/app_constant.dart';

class HourlyForecastPage extends StatefulWidget {
  const HourlyForecastPage({super.key});

  @override
  State<HourlyForecastPage> createState() => _HourlyoOrecastPageState();
}

class _HourlyoOrecastPageState extends State<HourlyForecastPage> {
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
        // antara salah disini atau di remote datasource
        // jika masih error tambakan stackFit.expand

        children: [
          Positioned.fill(child: background()),
          Positioned.fill(
            child: Material(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          foreground(),
        ],
      ),
    );
  }

  Widget background() {
    return Image.asset(
      weatherBG['shower rain']!,
      fit: BoxFit.cover,
    );
  }

  Widget foreground() {
    return Column(
      children: [
        AppBar(
          title: Text('Hourly Forecast'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          // warna backArrow & title
          foregroundColor: Colors.white,
          forceMaterialTransparency: true,
        ),
        Expanded(
          child: BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
            builder: (context, state) {
              if (state is HourlyForecastLoading) return DView.loadingCircle();
              if (state is HourlyForecastFailure) {
                return Column(
                  key: Key('part_error'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        refresh();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              }
              if (state is HourlyForecastSuccess) {
                final list = state.data;
                return GroupedListView<WeatherEntity, String>(
                  padding: EdgeInsets.all(0),
                  physics: BouncingScrollPhysics(),
                  elements: list,
                  groupHeaderBuilder: (element) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          DateFormat('EEEE d MMM yyyy')
                              .format(element.dateTime),
                        ),
                      ),
                    );
                  },
                  groupBy: (element) =>
                      DateFormat('yyyy-MM-dd').format(element.dateTime),
                  itemBuilder: (context, weather) {
                    return Padding(
                      padding: EdgeInsets.only(left: 12, right: 16),
                      child: Row(
                        children: [
                          ExtendedImage.network(
                            URLs.weatherIcon(weather.icon),
                            height: 80,
                            width: 80,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('HH:mm').format(weather.dateTime),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weather.description,
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${(weather.temperature - 273.15).round()}\u2103',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
