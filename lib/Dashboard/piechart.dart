import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:budget_app/Database/Database.dart';

import '../colours.dart';
import '../drawer.dart';

class PieChartScreen extends StatefulWidget {
  UserData userData;
  List<UserTransactionData> allTransaction;
  bool showAppBar;
  PieChartScreen({ Key? key, required this.userData, required this.allTransaction, required this.showAppBar}) : super(key: key);

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {

  Map<String, double> dataMap = {
    "Groceries": 0, "Transportation": 0, "Restaurants/Ordering": 0, "Shopping": 0, "Rent": 0,
    "Salary": 0, "Personal Spending": 0, "Medical": 0,
    "Bills": 0, "Vacation": 0, "Saving": 0,
    "Investments": 0, "Gifts": 0, "Others": 0, "Unassigned": 0
  };

  Map<String, double> percentList = {
    "Groceries": 0, "Transportation": 0, "Restaurants/Ordering": 0, "Shopping": 0, "Rent": 0,
    "Salary": 0, "Personal Spending": 0, "Medical": 0,
    "Bills": 0, "Vacation": 0, "Saving": 0,
    "Investments": 0, "Gifts": 0, "Others": 0, "Unassigned": 0
  };

  void setDataMap(){

    double totalAmount = 0;

    // Regular expression, to extract only 5000.00 from +PKR 5000.00 or +KWD 5000.00
    var regEXP = RegExp('(0.((0[1-9]{1})|([1-9]{1}([0-9]{1})?)))|(([1-9]+[0-9]*)(.([0-9]{1,2}))?)');

    //Start of loop to find the amount of the categories
    for(int i = 0; i < widget.allTransaction.length; i++){

      double amount = 0;
      double credit = 0;
      double debited = 0;

      for(int j = 0; j < widget.allTransaction[i].debited.length; j++){
        Iterable<Match> matches = regEXP.allMatches(widget.allTransaction[i].debited, j);
        for (final Match m in matches) {
          debited = double.parse(m[0]!);
        }
        break;
      }

      for(int k = 0; k < widget.allTransaction[i].credited.length; k++){
        Iterable<Match> matches = regEXP.allMatches(widget.allTransaction[i].credited, k);
        for (final Match m in matches) {
          credit = double.parse(m[0]!);
        }
        break;
      }

      amount = credit + debited;



      if(widget.allTransaction[i].category == "Groceries") {
        dataMap.update("Groceries", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Transportation") {
        dataMap.update("Transportation", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Restaurants/Ordering") {
        dataMap.update("Restaurants/Ordering", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Shopping") {
        dataMap.update("Shopping", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Rent") {
        dataMap.update("Rent", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Salary") {
        dataMap.update("Salary", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Personal Spending") {
        dataMap.update("Personal Spending", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Medical") {
        dataMap.update("Medical", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Bills") {
        dataMap.update("Bills", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Vacation") {
        dataMap.update("Vacation", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Saving") {
        dataMap.update("Saving", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Investments") {
        dataMap.update("Investments", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "Gifts") {
        dataMap.update("Gifts", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else if(widget.allTransaction[i].category == "") {
        dataMap.update("Unassigned", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }else{
        dataMap.update("Others", (value) => value + amount);
        totalAmount = totalAmount + amount;
      }

    }
    // end of loop

    for (int a = 0; a < 10; a++){
      if(dataMap[catList[a]] != 0){
        percentList[catList[a]] = double.parse(((dataMap[catList[a]]! / totalAmount) * 100).toStringAsFixed(2));
        // print("%: ${percentList[catList[a]]}");
      }
    }
  }

  List catList = [
    "Groceries", "Transportation", "Restaurants/Ordering", "Shopping", "Rent",
    "Salary", "Personal Spending", "Medical",
    "Bills", "Vacation", "Saving",
    "Investments", "Gifts", "Others", "Unassigned"
  ];

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff77ff5d),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xff91ff7d),
    const Color(0xff3A7F50),
    const Color(0xff6EE094),
    const Color(0xffd99a7d),
    const Color(0xff548f2c),
    const Color(0xff3181f2),
    const Color(0xff3713aa),
    const Color(0xffff341a),
    const Color(0xff34f13b),
    const Color(0xff347f9a),
    const Color(0xffFE9539),
  ];

  @override
  initState(){
    super.initState();
    setDataMap();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.showAppBar
        ? AppBar(
          elevation: 0,
          title: Text("Expenditure ${DateTime.now().year}", style: TextStyle(color: Colors.white),),
          backgroundColor: primarycolor,
        )
        : null,
        drawer: widget.showAppBar ? Drawerr(allTransaction: widget.allTransaction, userData: widget.userData,) : null,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
            child: Column(
              children: [
                Center(
                  child: PieChart(
                    dataMap: dataMap,
                    colorList: colorList,
                    chartType: ChartType.ring,
                    chartRadius: MediaQuery.of(context).size.width / 1.9,
                    centerText: "KWD 127.352 \nTotal Expenses 2022",
                    ringStrokeWidth: MediaQuery.of(context).size.width * 0.09,
                    animationDuration: const Duration(seconds: 1),
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValues: true,
                        showChartValuesOutside: true,
                        showChartValuesInPercentage: true,
                        showChartValueBackground: false
                    ),
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 15,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return singleCategory(index);
                      }
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget singleCategory(int i) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          color: colorList[i],
          height: 40,
          width: 40,
          child: Center(
              child: Text(
                "${percentList[catList[i]]}%",
                style: TextStyle(color: Colors.black, fontSize: 11),
              )
          ),
        ),
        SizedBox(width: 20,),
        Text(catList[i]),
        Spacer(),
        Text("${dataMap[catList[i]]}")
      ],
    ),
  );

}