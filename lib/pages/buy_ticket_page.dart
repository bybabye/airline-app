import 'package:airline_app/database/request.dart';
import 'package:airline_app/models/flight.dart';
import 'package:airline_app/models/user.dart';
import 'package:airline_app/pages/auth_email_page.dart';
import 'package:airline_app/theme/app_color.dart';
import 'package:airline_app/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({super.key, required this.flight});
  final Flight flight;

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  late TextEditingController nameController; // nhậP dữ liệu tên
  late TextEditingController cmndController; // nhậP cmnd của khách hàng
  late TextEditingController gmailController; // nhậP gmail của khách hàng
  late TextEditingController
      issuedController; // nhập nơi cấp cmnd của khách hàng
  bool isLoading = false; // sự kiện xảy ra khi khách hàng bấm vào xác nhận

  late double height; // lấy chiều cao của màn hình
  late double width; // lấy chiều rộng của màn hình
  DateTime timer = DateTime.now(); // lấy ngày sinh ở hiệN tại
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    cmndController = TextEditingController();
    gmailController = TextEditingController();
    issuedController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    cmndController.dispose();
    gmailController.dispose();
    issuedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
          "Thông tin cá nhân",
          style: AppStyles.h4,
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textFieldCustom('Họ Tên : Bùi Lê Huy', nameController),
                _textFieldCustom('Số CMND : XXXXXXXXXXXXXXXXX', cmndController),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 10),
                        child: Text(
                          "Ngày Sinh",
                          style: AppStyles.h6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, right: 16, left: 16, top: 12),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TimePickerSpinnerPopUp(
                            mode: CupertinoDatePickerMode.date,
                            initTime: DateTime.now(),
                            minTime: DateTime.now()
                                .subtract(const Duration(days: 10)),
                            maxTime:
                                DateTime.now().add(const Duration(days: 10)),
                            barrierColor:
                                Colors.black12, //Barrier Color when pop up show
                            minuteInterval: 1,
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
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
                    ],
                  ),
                ),
                _textFieldCustom(
                    'gmail : builehuy1@gmail.com', gmailController),
                _textFieldCustom('nơi cấp : Quảng trị - gio linh - gio việt',
                    issuedController),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (gmailController.text.isEmpty ||
                            cmndController.text.isEmpty ||
                            nameController.text.isEmpty ||
                            issuedController.text.isEmpty) {
                          // thông báo nhậP đủ các trường
                        } else {
                          setState(() {
                            isLoading =
                                true; // update lại UI khi sự kiệN loading xảy ra
                          });
                          // xử lý logic code
                          String code = await codeGmail(
                              gmailController.text,
                              nameController
                                  .text); // gọi api gửi mail và trả code về để back sang màn hình B
                          User user = User(
                              cmnd: cmndController.text,
                              tenkh: nameController.text,
                              ngaysinh: timer,
                              noicap: issuedController.text,
                              gmail: gmailController.text);
                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AuthEmailPage(
                                  code: code,
                                  flight: widget.flight,
                                  user: user),
                            ),
                          );

                          setState(() {
                            isLoading =
                                false; // update lại UI khi sự kiệN loading kết thúc
                          });
                        }
                      },
                      child: Text("ĐẶT VÉ / BOOK TICKET",
                          style: AppStyles.h6.copyWith(color: Colors.blue)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Opacity(
              opacity: 0.1,
              child: Container(
                color: Colors.black, // Màu nền của lớp nền mờ
              ),
            ),
          if (isLoading)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _textFieldCustom(String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.only(right: 25, left: 20),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.h6
              .copyWith(color: Colors.grey, fontWeight: FontWeight.normal),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
