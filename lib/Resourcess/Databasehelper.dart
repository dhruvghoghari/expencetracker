 import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelper
 {

  Database? db;

  Future<Database> create_db() async
   {
   if(db!=null)
    {
     return db!;
    }
   else
    {
     var dir = await getApplicationDocumentsDirectory();
     var path = join(dir.path,"exptracker_db");
     var db = await openDatabase(path,version: 1,onCreate: create_table);
     return db;

    }

  }
  create_table(Database db, int version) async
  {
   db.execute("create table exptrakor (Tid integer primary key autoincrement,type text,title text,remark text,amount text)");

  }

  Future<int> insertTrakor(tracker, title, remark, amount) async
  {
   var db = await create_db();
   var id = await db.rawInsert("insert into exptrakor (type, title, remark, amount) values (?, ?, ?, ?)", [tracker, title, remark, amount]);
   return id;
  }


  Future<List> getalldata() async
  {
   var db = await create_db();
   var data = await db.rawQuery("select * from exptrakor");
   return data.toList();

  }

  allincome() async
  {
   var db = await create_db();
   var data = await db.rawQuery("select * from exptrakor where type=?",["Income"]);
   return data.toList();
  }


  allexp() async
  {
   var db = await create_db();
   var data = await db.rawQuery("select * from exptrakor where type=?",["Expense"]);
   return data.toList();
  }

  Future<int> deletetrackor(id) async
  {
   var db = await create_db();
   var status = await db.rawDelete("delete from exptrakor where Tid=?",[id]);
   return status;
   
  }

  Future<List> getsingledata(id) async
  {
   var db = await create_db();
   var data = await db.rawQuery("select * from exptrakor where Tid=?",[id]);
   return data.toList();
  }

  Future<int> updateexptrackor(title,tracker,amount,id) async
  {
   var db = await create_db();
   var status = await db.rawUpdate("update exptrakor set type=?,title=?,amount=? where Tid=?",[tracker,title,amount,id]);
   return status;

  }



 }