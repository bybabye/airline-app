import 'package:airline_app/models/flight.dart';
import 'package:airline_app/theme/app_color.dart';
import 'package:airline_app/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Ticket extends StatelessWidget {
  const Ticket(
      {super.key,
      required this.height,
      required this.width,
      required this.flight});

  final double height;
  final double width;
  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      width: width,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "Airplane Company",
                style: AppStyles.h5,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 1,
            color: AppColor.kBGAppbar,
          ),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "IATA Code :", style: AppStyles.h7),
                          TextSpan(
                              text: flight.departureAirportId,
                              style: AppStyles.h5)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: "From :", style: AppStyles.h7),
                          TextSpan(
                              text: flight.departureProvince,
                              style: AppStyles.h5)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "Departure Time :", style: AppStyles.h7),
                          TextSpan(
                              text: DateFormat('HH:mm')
                                  .format(flight.departureTime),
                              style: AppStyles.h5)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_sharp),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "IATA Code :", style: AppStyles.h7),
                          TextSpan(
                              text: flight.arrivalAirportId,
                              style: AppStyles.h5)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: "To :", style: AppStyles.h7),
                          TextSpan(
                              text: flight.arrivalProvince, style: AppStyles.h5)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "Arrival Time :", style: AppStyles.h7),
                          TextSpan(
                              text: DateFormat('HH:mm')
                                  .format(flight.arrivalTime),
                              style: AppStyles.h5)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 1,
            color: AppColor.kBGAppbar,
          ),
          const Spacer(),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: "Flight Status     ", style: AppStyles.h7),
                TextSpan(text: "Active / Boarding", style: AppStyles.h5)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
