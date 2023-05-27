import 'package:airline_app/components/ticket.dart';
import 'package:airline_app/pages/ticket_page.dart';

import 'package:airline_app/provider/airline_provider.dart';
import 'package:airline_app/theme/app_assets.dart';
import 'package:airline_app/theme/app_color.dart';
import 'package:airline_app/theme/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height;
  late double width;
  String? selectedFrom;
  String? selectedTo;
  DateTime timer = DateTime.now();
  late AirlineProvider airlineProvider;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    airlineProvider = Provider.of<AirlineProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Image.asset(AppAssets.background, fit: BoxFit.fitWidth),
        ),
        airlineProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    backgroundColor: AppColor.kBGAppbar,
                    title: Text(
                      "Ticket Booking",
                      style: AppStyles.h4,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          buttonStyleData: ButtonStyleData(
                                            height: 40,
                                            width: 140,
                                            padding:
                                                const EdgeInsets.only(left: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Colors.black26,
                                              ),
                                              color: Colors.white70,
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                          ),
                                          hint: const Text("From"),
                                          value: selectedFrom,
                                          onChanged: (value) => {
                                            setState(() {
                                              selectedFrom = value as String;
                                            })
                                          },
                                          items: airlineProvider.airlines
                                              .map(
                                                (airline) => DropdownMenuItem(
                                                  value: airline.masanbay,
                                                  child: Text(airline.tinh),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          buttonStyleData: ButtonStyleData(
                                            height: 40,
                                            width: 140,
                                            padding:
                                                const EdgeInsets.only(left: 14),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Colors.black26,
                                              ),
                                              color: Colors.white70,
                                            ),
                                          ),
                                          menuItemStyleData:
                                              const MenuItemStyleData(
                                            height: 40,
                                          ),
                                          hint: const Text("To"),
                                          value: selectedTo,
                                          onChanged: (value) => {
                                            setState(() {
                                              selectedTo = value as String;
                                            })
                                          },
                                          items: airlineProvider.airlines
                                              .map(
                                                (airline) => DropdownMenuItem(
                                                  value: airline.masanbay,
                                                  child: Text(airline.tinh),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TimePickerSpinnerPopUp(
                                    mode: CupertinoDatePickerMode.date,
                                    initTime: DateTime.now(),
                                    minTime: DateTime.now()
                                        .subtract(const Duration(days: 10)),
                                    maxTime: DateTime.now()
                                        .add(const Duration(days: 10)),
                                    barrierColor: Colors
                                        .black12, //Barrier Color when pop up show
                                    minuteInterval: 1,
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 10, 12, 10),
                                    cancelText: 'Cancel',
                                    confirmText: 'OK',
                                    pressType: PressType.singlePress,
                                    timeFormat: 'dd/MM/yyyy',
                                    // Customize your time widget
                                    // timeWidgetBuilder: (dateTime) {},
                                    onChange: (dateTime) {
                                      // Implement your logic with select dateTime
                                      timer = dateTime;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(8),
                                height: height * 0.048,
                                width: width,
                                decoration: BoxDecoration(
                                    color: AppColor.kBGAppbar,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        String time =
                                            "${timer.year}/${timer.month}/${timer.day}";

                                        airlineProvider.getListFlight(
                                            selectedFrom!, selectedTo!, time);
                                      },
                                      child: Text(
                                        "Search",
                                        style:
                                            AppStyles.h4.copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (airlineProvider.flights.isNotEmpty)
                          for (var i = 0;
                              i < airlineProvider.flights.length;
                              i++)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TicketPage(
                                      flight: airlineProvider.flights[i],
                                    ),
                                  ),
                                );
                              },
                              child: Ticket(
                                  height: height,
                                  width: width,
                                  flight: airlineProvider.flights[i]),
                            )
                      ],
                    ),
                  )
                ],
              ),
      ],
    ));
  }
}
