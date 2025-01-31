// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/features/pick_place/presentation/cubit/city_cubit.dart';

class PickPlacePage extends StatefulWidget {
  const PickPlacePage({super.key});

  @override
  State<PickPlacePage> createState() => _PickPlacePageState();
}

class _PickPlacePageState extends State<PickPlacePage> {
  final edtCity = TextEditingController();

  @override
  void initState() {
    edtCity.text = context.read<CityCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/pick_place.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Up\nyour location',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                DView.height(24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 30),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: edtCity,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                            hintText: 'Type city name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onChanged: (value) {
                            context.read<CityCubit>().listenChange(value);
                          },
                        ),
                      ),
                      DView.width(30),
                      BlocBuilder<CityCubit, String>(
                        builder: (context, state) {
                          if (state == '') return DView.nothing();
                          return IconButton.filledTonal(
                            onPressed: () {
                              context.read<CityCubit>().saveCity();
                              // setelah ketik selesai keyboard di close
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pop(context, 'refresh');
                            },
                            icon: Icon(Icons.check),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // extended agar posisi di pojok kanan bawah
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: Text('Back'),
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
