import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thrivve_assignment/core/themes/colors.dart';
import 'package:thrivve_assignment/core/themes/images.dart';

class WithdrawPage extends StatefulWidget {
  static const routeName = '/WithdrawPage';

  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _controller = TextEditingController();
  double availableBalance = 400.00;

  // Preset amounts
  final List<double> amounts = [50, 100, 200, 400];

  void setAmount(double amount) {
    setState(() {
      _controller.text = amount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: _appBar(),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: ThemeColors.white,
      leadingWidth: 60.sp,
      leading: Row(
        children: [
          SizedBox(width: 16.w),
          CircleAvatar(
            backgroundColor: ThemeColors.colorC8C9CC,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: ThemeColors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          _titleHeader(),
          SizedBox(height: 20),

          // Amount input
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                // SAR icon placeholder
                Images.saudiIcon,
                width: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0.00",
                    hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Text(
            "Your available balance is SAR ${availableBalance.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.grey),
          ),

          SizedBox(height: 20),

          // Preset amount buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: amounts.map((amount) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 8.sp, vertical: 8.sp),
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => setAmount(amount),
                child: Text(
                  "$amount SAR",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 30),

          // Payment Method
          Text(
            "Payment method",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.account_balance, color: Colors.blue),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Al Rajhi Bank",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "SA720011100000000085954356",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Spacer(),

          // Disclaimer
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Bank withdrawals may take 12-24 hours to complete.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _controller.text.isEmpty
                  ? null
                  : () {
                      // Handle withdrawal
                    },
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleHeader() {
    return Text(
      "Enter the amount you want to withdraw",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
