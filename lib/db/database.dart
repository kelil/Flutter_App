import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quraana_oromiffa/md/quraan_model.dart';
import 'package:quraana_oromiffa/md/sura_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static Database _db;
  static String path;
  static final _databaseName = "hiikaa_quraana.db";
  static final _databaseVersion = 1;

 DatabaseHelper.pConstructor();
  static final DatabaseHelper instance = DatabaseHelper.pConstructor();


  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  Future _onCreate(Database db, int version) async {}

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", _databaseName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future <List<SuraModel>> getSura() async{
    Database db = await instance.db;
    var res=await  db.rawQuery("select * from suralist");
     return res.toList().map((data) => SuraModel.fromMap(data)).toList();
 

  }
  Future <List<QuraanModel>> getQuraan(id) async{
    Database db = await instance.db;
    var res=await  db.rawQuery("select * from Hiikkaa_Quraana where sura="+id.toString());
     return res.toList().map((data) => QuraanModel.fromMap(data)).toList();
 

  }
}
