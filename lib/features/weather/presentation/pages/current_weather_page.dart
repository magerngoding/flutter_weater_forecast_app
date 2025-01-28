// ignore_for_file: prefer_const_constructors

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
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
              child: basicShadow(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
            width: double.infinity,
            child: basicShadow(),
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
    return DView.nothing();
  }

  Widget headerAction() {
    return DView.nothing();
  }

  Widget basicShadow() => DView.nothing();

  Widget background() {
    return DView.nothing();
  }
}
