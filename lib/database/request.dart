import 'dart:convert';

import 'package:airline_app/models/airline.dart';
import 'package:airline_app/models/flight.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

String api = "https://airline-gx52.onrender.com";

Future<List<Airline>> fetchData() async {
  List<Airline> airlines = [];
  // ignore: unused_local_variable
  var client = http.Client();
  try {
    var url = Uri.parse("$api/location/list");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          jsonDecode(utf8.decode(response.bodyBytes))['data'] as List;
      // ignore: avoid_function_literals_in_foreach_calls
      jsonResponse.forEach((element) {
        airlines.add(Airline.fromJson(element));
      });
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // ignore: avoid_print
    print('${e.toString()} loi o day');
  }

  return airlines;
}

Future<List<Flight>> listFlight(String sbdi, String sbden, String time) async {
  List<Flight> flights = [];
  try {
    Dio dio = Dio();
    Response response = await dio.post('$api/flight/search',
        data: {'sbdi': sbdi, 'sbden': sbden, 'time': time});
    if (response.statusCode == 200) {
      // Yêu cầu thành công
      var jsonResponse = response.data['data'] as List;
      for (var element in jsonResponse) {
        flights.add(Flight.fromJson(element));
      }
    } else {
      // Xử lý lỗi nếu cần thiết
      print('POST request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }

  return flights;
}

Future<String> codeGmail(String gmail, String name) async {
  try {
    Dio dio = Dio();
    Response response =
        await dio.post('$api/gmail/send', data: {'gmail': gmail, 'name': name});
    if (response.statusCode == 200) {
      // Yêu cầu thành công
      var jsonResponse = response.data['code'];
      return jsonResponse.toString();
    } else {
      // Xử lý lỗi nếu cần thiết
      print('POST request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return '';
}

Future<String> addAvaibleSeat(
    {required String cmnd, required String macb}) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post('$api/flight/add/available_seats',
        data: {'cmnd': cmnd, 'macb': macb});
    if (response.statusCode == 200) {
      // Yêu cầu thành công
      var jsonResponse = response.data['data'];
      print(jsonResponse);
      return jsonResponse.toString();
    } else {
      // Xử lý lỗi nếu cần thiết
      print('POST request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return '';
}

Future<String> addUser(
    {required String cmnd,
    required String tenkh,
    required DateTime ngaysinh,
    required String noicap}) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post('$api/users/add', data: {
      'cmnd': cmnd,
      'tenkh': tenkh,
      'ngaysinh': DateFormat('yyyy-MM-dd').format(ngaysinh),
      noicap: 'noicap'
    });
    if (response.statusCode == 200) {
      // Yêu cầu thành công
      var jsonResponse = response.data['data'];
      return jsonResponse.toString();
    } else {
      // Xử lý lỗi nếu cần thiết
      print('POST request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return '';
}

Future<void> buyTicket(
    String gmail,
    String sbdi,
    String masbdi,
    String sbden,
    String masbden,
    DateTime giodi,
    DateTime gioden,
    String giobay,
    String code) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post('$api/gmail/send/buyticket', data: {
      'gmail': gmail,
      'sbdi': sbdi,
      'masbdi': masbdi,
      'sbden': sbden,
      'masbden': masbden,
      'giodi': DateFormat('yyyy-MM-dd HH:mm:ss').format(giodi),
      'gioden': DateFormat('yyyy-MM-dd HH:mm:ss').format(gioden),
      'giobay': giobay,
      'code': code,
    });
    if (response.statusCode == 200) {
      // Yêu cầu thành công
      var jsonResponse = response.data['code'];
      print("ok $jsonResponse");
    } else {
      // Xử lý lỗi nếu cần thiết
      print('POST request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
