import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import 'icon_btn.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({super.key, required this.expenses});
  final List<double> expenses;
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Padding(
      padding: EdgeInsets.all(1.w),
      child: Column(
        children: [
          Text(
            "Weekly Spending",
            style: GoogleFonts.abel(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: kTextColor,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBtn(onPress: () {}, iconData: Icons.arrow_back_outlined),
              Text(
                "Nov 10,2020 - Nov 18,2021",
                style: GoogleFonts.atma(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
              CustomBtn(onPress: () {}, iconData: Icons.arrow_forward_outlined)
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomBar(
                    day: "sun",
                    amountSpent: expenses[0],
                    expensive: mostExpensive),
                CustomBar(
                    day: "Mon",
                    amountSpent: expenses[1],
                    expensive: mostExpensive),
                CustomBar(
                    day: "Tue",
                    amountSpent: expenses[2],
                    expensive: mostExpensive),
                CustomBar(
                    day: "Wed",
                    amountSpent: expenses[3],
                    expensive: mostExpensive),
                CustomBar(
                    day: "Thu",
                    amountSpent: expenses[4],
                    expensive: mostExpensive),
                CustomBar(
                    day: "Fri",
                    amountSpent: expenses[5],
                    expensive: mostExpensive),
                CustomBar(
                    day: "Sat",
                    amountSpent: expenses[6],
                    expensive: mostExpensive),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBar extends StatelessWidget {
  CustomBar(
      {super.key,
      required this.day,
      required this.amountSpent,
      required this.expensive});
  final String day;
  final double amountSpent;
  final double expensive;
  final double _maxBarHeight = 20.h;
  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / expensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\Rs${amountSpent.toStringAsFixed(2)}',
          style: GoogleFonts.aubrey(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: kTextColor,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: barHeight,
          width: 3.w,
          decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(
                (1.h),
              )),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          day,
          style: GoogleFonts.abel(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: kTextColor,
          ),
        )
      ],
    );
  }
}
