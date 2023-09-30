import 'package:expencetracker/Resourcess/Databasehelper.dart';
import 'package:flutter/material.dart';

class MyBalance extends StatefulWidget {
  @override
  State<MyBalance> createState() => _MyBalanceState();
}

class _MyBalanceState extends State<MyBalance> {


  var income=0;
  var expense=0;

  getincome() async
  {
    Databasehelper obj =new Databasehelper();
    List data = await obj.allincome();
    data.forEach((row) {
      setState(() {
        income = income + int.parse(row["amount"]);
      });
    });
    List dataex = await obj.allexp();
    dataex.forEach((row) {
      setState(() {
        expense = expense + int.parse(row["amount"]);
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getincome();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("My Balance")),),
      body: SafeArea(
        child: Column(
          children: [
            Text("Total Income : " + income.toString()),
            Text("Total Expences : " + expense.toString()),
            Text("Balance : "+(income-expense).toString()),
          ],
        ),
      ),
    );
  }
}
