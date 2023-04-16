import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/models/cost_model.dart';
import 'package:expense_tracker/pages/detail_screen.dart';
import 'package:expense_tracker/widgets/custom_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import '../data/data.dart';
import '../models/type_model.dart';
import '../widgets/icon_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 10.h,
            leading:
                CustomBtn(onPress: () {}, iconData: Icons.settings_outlined),
            flexibleSpace: FlexibleSpaceBar(
              title: Text("     My Budget",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 12.sp,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                  )),
            ),
            actions: [
              CustomBtn(
                onPress: () {},
                iconData: Icons.add_outlined,
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(

                  (context, int index) {
                  if(index == 0){
                    return Container(
                      margin:EdgeInsets.only(
                          top: 2.h,
                          left: 2.w,
                          right: 2.w,
                          bottom: 2.h
                      ) ,

                      decoration:  BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(3.h),
                      ),

                      child: CustomChart(expenses: weeklySpending),
                    );
                  }
                  else{
                    final TypeModel typeModel = typeNames[index-1];
                    double tAmountSpent =0;
                    typeModel.expenses!.forEach((CostModel expense) {
                      tAmountSpent +=expense.cost!;
                    });
                    return _buildCategories(typeModel , tAmountSpent);
                  }
                  },
                childCount: 1 + typeNames.length
              ),
          ),
        ],
      ),
    );
  }
  _buildCategories(TypeModel category, double tAmountSpent){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
          typeModel: category,
        )));
      },
      child: Container(
        width: 120.w,
        height: 13.h,
        margin: kMargin,
        padding: kPadding,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: kRadius,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.name!,
                style: GoogleFonts.abel(
                fontSize: 14.sp,
                  color: kTextColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),),
                Text('\Rs${(category.maxAmount! - tAmountSpent).toStringAsFixed(2)} / \Rs${category.maxAmount!.toStringAsFixed(2)}',
                  style: GoogleFonts.atma(
                    fontSize: 14.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),),
              ],
            ),
            SizedBox(height: 2.h),
            LayoutBuilder(builder: (context, constraints) {
              final double maxBarWidth = constraints.maxWidth;
              final double percentage = (category.maxAmount! -tAmountSpent) / category.maxAmount!;
              double width = percentage * maxBarWidth;
              if(width<0){
                width= 0;
              }
              return Stack(
                children: [
                  Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.h),
                        bottomRight: Radius.circular(2.h),
                      )
                    ),
                  ),
                  Container(
                    height: 3.h,
                    width:width,
                    decoration: BoxDecoration(
                        color: setupColor(percentage),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.h),
                          bottomRight: Radius.circular(2.h),
                        )
                    ),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
