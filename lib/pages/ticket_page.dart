import 'package:airline_app/models/flight.dart';
import 'package:airline_app/pages/buy_ticket_page.dart';
import 'package:airline_app/theme/app_color.dart';
import 'package:airline_app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TicketPage extends StatefulWidget {
  const TicketPage({super.key, required this.flight});
  final Flight flight;

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    String formattedDate = DateFormat('EEEE, dd MMMM, yyyy', 'vi_VN')
        .format(widget.flight.departureTime);
    final NumberFormat numberFormat = NumberFormat('#,##0');

    return Scaffold(
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
            "Thông tin chuyến bay",
            style: AppStyles.h4,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CHUYẾN BAY / FLIGHT",
                      style: AppStyles.h5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "NGÀY / DATE :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      formattedDate,
                      style: AppStyles.h6.copyWith(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "NƠI ĐI / FROM :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      '${widget.flight.departureProvince} (${widget.flight.departureAirportId})',
                      style: AppStyles.h6.copyWith(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "NƠI ĐẾN / TO :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      '${widget.flight.arrivalProvince} (${widget.flight.arrivalAirportId})',
                      style: AppStyles.h6.copyWith(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "KHỞI HÀNH / DEPARTING AT :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      '${DateFormat('HH:mm').format(widget.flight.departureTime)} ',
                      style: AppStyles.h6.copyWith(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "GIỜ ĐẾN / ARRIVING AT :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      '${DateFormat('HH:mm').format(widget.flight.arrivalTime)} ',
                      style: AppStyles.h6.copyWith(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "SỐ GHẾ TRỐNG/ AVAILABLE SEATS :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      '${widget.flight.availableSeats} ',
                      style: AppStyles.h6.copyWith(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "GIÁ VÉ/ PRICE  :",
                      style: AppStyles.h5,
                    ),
                    Text(
                      '${numberFormat.format(int.parse(widget.flight.price))} VND ',
                      style: AppStyles.h6.copyWith(color: Colors.blue),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BuyTicketPage(flight: widget.flight),
                        ),
                      );
                    },
                    child: Text("ĐẶT VÉ / BOOK TICKET",
                        style: AppStyles.h6.copyWith(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
