import 'dart:async';

import 'package:path/path.dart';
import 'package:picture_of_the_day/model/apod_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'apod.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE apods (
            date TEXT PRIMARY KEY,
            title TEXT,
            explanation TEXT,
            url TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertApod(ApodModel apod) async {
    final db = await database;
    await db.insert('apods', apod.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ApodModel>> fetchApods() async {
    final db = await database;
    final maps = await db.query('apods');

    return List.generate(maps.length, (i) {
      return ApodModel(
        date: maps[i]['date'].toString(),
        title: maps[i]['title'].toString(),
        explanation: maps[i]['explanation'].toString(),
        url: maps[i]['url'].toString(),
      );
    });
  }
}
