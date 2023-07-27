import 'package:expencetracker/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _date = TextEditingController();



  var tracker="";

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
                            value: "I",
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
                            value: "E",
                            onChanged: (val){
                              setState(() {
                                tracker=val!;
                              });
                            },
                          ),
                          Text("Expense")
                        ],
                      ),
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
                          child: Text("Date :-",style: TextStyle(
                            fontSize: 20.0,
                          ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.date_range_sharp),
                              onPressed: (){

                              },
                            ),
                              border: OutlineInputBorder(
                              )
                          ),
                          controller: _date,
                          keyboardType: TextInputType.text,
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
