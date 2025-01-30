// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  elements: list,
                  groupHeaderBuilder: (element) {
                    return Align(
                      // default nya sudah ditengah
                      child: Container(
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
                  // itemComparator: (item1, item2) =>
                  //     item1['name'].compareTo(item2['name']), // optional
                  // useStickyGroupSeparators: true, // optional
                  // floatingHeader: true, // optional
                  itemBuilder: (context, weather) => ListTile(
                    title: Text(
                      DateFormat('HH:mm').format(weather.dateTime),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: Text(
                      '${(weather.temperature - 273.15).round()}\u2103',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
    //   return DView.nothing();
  }
}
