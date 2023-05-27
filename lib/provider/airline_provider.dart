import 'package:airline_app/database/request.dart';
import 'package:airline_app/models/airline.dart';
import 'package:airline_app/models/flight.dart';
import 'package:flutter/material.dart';

class AirlineProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Airline> airlines = [];
  List<Flight> flights = [];
  AirlineProvider() {
    getListAirline();
  }

  void getListAirline() async {
    airlines = await fetchData();
    print('aaa');
    notifyListeners();
  }

  void getListFlight(String sbdi, String sbden, String time) async {
    isLoading = true;
    notifyListeners();
    flights = await listFlight(sbdi, sbden, time);
    isLoading = false;
    notifyListeners();
  }
}
