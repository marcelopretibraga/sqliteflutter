import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = "PessoasDB.db";
  static final _dbVersion = 1;

  //Transforma a classe em Singleton para Gerenciar
  //as conexões do Banco
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory dbDiretory = await getApplicationDocumentsDirectory();
    String path = join(dbDiretory.path, _dbName); //Monta o caminho da database
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE PESSOA 
                        (ID INTEGER PRIMARY KEY, 
                         NOME TEXT, 
                         IDADE INTEGER)''');
  }

  //Metodo de Insert
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("PESSOA", row);
  } 


}
