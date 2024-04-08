import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:my_app/masakan/present_masakan.dart'; // Ubah nama impor

class DbHelper {
  static late DbHelper _dbHelper;
  static late Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper = DbHelper._createObject(); // Inisialisasi _dbHelper di sini
    _dbHelper.initDb(); // Initialize the database before returning the instance
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'masakan.db'; // Ubah nama file database
    var masakanDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    _database = masakanDatabase; // Set the _database field
    return masakanDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE masakan (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama_masakan TEXT, -- Ubah nama kolom
      jenis_masakan TEXT, -- Ubah nama kolom
      tanggal_posting TEXT -- Ubah nama kolom
    )
  ''');
  }

  Future<Database> get database async {
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList =
        await db.query('masakan', orderBy: 'nama_masakan'); // Ubah nama tabel
    return mapList;
  }

  Future<int> insert(Resep object) async {
    Database db = await this.database;
    Map<String, dynamic> mapWithoutId = object.toMap();
    mapWithoutId.remove('id'); // Hapus kolom 'id' dari peta
    int count = await db.insert('masakan', mapWithoutId);
    return count;
  }

  Future<int> update(Resep object) async {
    Database db = await this.database;
    int count = await db.update('masakan', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db
        .delete('masakan', where: 'id=?', whereArgs: [id]); // Ubah nama tabel
    return count;
  }

  Future<List<Resep>> getResepList() async {
    var masakanMapList = await select();
    int count = masakanMapList.length;
    List<Resep> resepList = []; // Ubah tipe objek
    for (int i = 0; i < count; i++) {
      resepList.add(Resep.fromMap(masakanMapList[i])); // Ubah tipe objek
    }
    return resepList;
  }
}
