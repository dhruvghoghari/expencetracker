import 'package:expencetracker/ExploreScreen.dart';
import 'package:expencetracker/Resourcess/Databasehelper.dart';
import 'package:flutter/material.dart';

class EditHomeScreen extends StatefulWidget {

  var updateid="";
  EditHomeScreen({required this.updateid});

  @override
  State<EditHomeScreen> createState() => _EditHomeScreenState();
}

class _EditHomeScreenState extends State<EditHomeScreen> {

  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _amount = TextEditingController();

  var tracker="Expense";
  viewdata() async
  {
    Databasehelper obj = new Databasehelper();
    var data = await obj.getsingledata(widget.updateid);
    setState(() {
      tracker = data[0]["type"].toString();
      _title.text = data[0]["title"].toString();
      _amount.text = data[0]["amount"].toString();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdata();
  }

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
                            onPressed: (){
                              Navigator.pop(context);
                            },
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
                            var amount = _amount.text.toString();

                            Databasehelper obj = await Databasehelper();
                            var status = await obj.updateexptrackor(title,tracker,amount,widget.updateid);
                            if(status==1)
                              {
                                Navigator.of(context).pop(); // update
                                Navigator.of(context).pop(); // view
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => ExploreScreen())
                                );
                              }
                            else
                              {
                                print("Not Updated");
                              }


                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text("Update",style: TextStyle(
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
