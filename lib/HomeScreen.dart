import 'package:expencetracker/MyHomePage.dart';
import 'package:expencetracker/Resourcess/Databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _amount = TextEditingController();

  var tracker="Expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: (){},
                          ),
                          SizedBox(width: 100.0),
                          Text("Home",style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                      SizedBox(height: 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            groupValue: tracker,
                            value: "Income",
                            onChanged:(val){
                              setState(() {
                                tracker=val!;
                              });
                            },
                          ),
                          Text("Income"),
                          SizedBox(width: 20.0),
                          Radio(
                            groupValue: tracker,
                            value: "Expense",
                            onChanged: (val){
                              setState(() {
                                tracker=val!;
                              });
                            },
                          ),
                          Text("Expense")
                        ],
                      ),      // Radio button
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Title :-",style: TextStyle(
                              fontSize: 30.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _title,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Remark :-",style: TextStyle(
                              fontSize: 20.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _remark,
                          minLines: 5,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft ,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Amount :-",style: TextStyle(
                            fontSize: 20.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _amount,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 10.0),

                      Container(
                        height: 50.0,
                        width: 150.0,
                        child: ElevatedButton(
                          onPressed: () async{

                            var title = _title.text.toString();
                            var remark = _remark.text.toString();
                            var amount = _amount.text.toString();

                            Databasehelper obj = new Databasehelper();
                            var id = await obj.insertTrakor(tracker,title,remark,amount);

                            var snackbar = SnackBar(
                              content: Text("Record Inserted at :" + id.toString()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);

                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text("Submit",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
