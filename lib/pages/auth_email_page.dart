import 'package:airline_app/database/request.dart';
import 'package:airline_app/models/flight.dart';
import 'package:airline_app/models/user.dart';
import 'package:airline_app/theme/app_color.dart';
import 'package:airline_app/theme/app_styles.dart';
import 'package:flutter/material.dart';

class AuthEmailPage extends StatefulWidget {
  const AuthEmailPage(
      {super.key,
      required this.code,
      required this.flight,
      required this.user});
  final String code;
  final Flight flight;
  final User user;

  @override
  State<AuthEmailPage> createState() => _AuthEmailPageState();
}

class _AuthEmailPageState extends State<AuthEmailPage> {
  late TextEditingController codeController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColor.kBGAppbar,
        title: const Text(
          "Xác nhận email",
          style: AppStyles.h4,
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.only(right: 25, left: 20),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: "########",
                hintStyle: AppStyles.h6.copyWith(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.code == codeController.text) {
                    await addUser(
                        cmnd: widget.user.cmnd,
                        tenkh: widget.user.tenkh,
                        ngaysinh: widget.user.ngaysinh,
                        noicap: widget.user.noicap);
                    String code = await addAvaibleSeat(
                        cmnd: widget.user.cmnd, macb: widget.flight.id);
                    await buyTicket(
                        widget.user.gmail,
                        widget.flight.departureAirport,
                        widget.flight.departureAirportId,
                        widget.flight.arrivalAirport,
                        widget.flight.arrivalAirportId,
                        widget.flight.departureTime,
                        widget.flight.arrivalTime,
                        '01:50',
                        code);
                    print('success');
                  } else {
                    print('no success');
                  }
                },
                child: Text("ĐẶT VÉ / BOOK TICKET",
                    style: AppStyles.h6.copyWith(color: Colors.blue)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
