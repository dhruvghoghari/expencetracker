import 'package:expencetracker/EditHomeScreen.dart';
import 'package:expencetracker/HomeScreen.dart';
import 'package:expencetracker/MyBalance.dart';
import 'package:expencetracker/Resourcess/Databasehelper.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  Future<List>? getalldata;

  Future<List> viewdata() async
  {
    Databasehelper obj = Databasehelper();
    var data =  obj.getalldata();
    return data;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getalldata = viewdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: () {

                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => MyBalance(),
                  ),
                );
              }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getalldata,
            builder: (context,snapshots)
            {
              if(snapshots.hasData)
              {
                if(snapshots.data!.length<=0)
                {
                  return Center(
                    child: Text("NO data"),
                  );
                }
                else
                {
                  return ListView.builder(
                      itemCount: snapshots.data!.length,
                      itemBuilder: (context,index)
                      {
                        return ListTile(
                          title: Text(
                            snapshots.data![index]["title"].toString(),
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          subtitle: Text(snapshots.data![index]["type"].toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Rs. " + snapshots.data![index]["amount"].toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(
                                onPressed: () {

                                  var id = snapshots.data![index]["Tid"].toString();

                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EditHomeScreen(
                                    updateid: id,
                                  ))
                                  );

                                },
                                icon: Icon(Icons.edit,color: Colors.green,),
                                tooltip: "Edit",
                              ),
                              SizedBox(height: 30.0),
                              IconButton(
                                onPressed: () async{

                                  var id = snapshots.data![index]["Tid"].toString();

                                  Databasehelper obj = new Databasehelper();
                                  var status = await obj.deletetrackor(id);
                                  if(status==1)
                                    {
                                      setState(() {
                                        getalldata = viewdata();
                                      });
                                    }
                                  else
                                    {
                                      var snackbar = SnackBar(
                                        content: Text("Data Not Delete"),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);

                                    }

                                },
                                icon: Icon(Icons.delete,color: Colors.red,),
                                tooltip: "delete",
                              ),
                            ],
                          ),
                        );
                      }
                  );
                }
              }
              else
              {
                return Center(
                  child: Text("Loading."),
                );
              }
            }
        ),
      ),
    );
  }
}
