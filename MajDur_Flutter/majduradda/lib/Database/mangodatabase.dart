import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static Db? _db;
  static const String DB_NAME = 'MajdurDB';
  static const String MONGO_CONN_URL = 'mongodb+srv://lamjingbasadokpam196:xDydrvMAoe7x5NW4@cluster7525.cyy5v.mongodb.net/MajdurDB?retryWrites=true&w=majority&appName=Cluster7525';
  

  static Future<void> connect() async {
    try {
      _db = await Db.create(MONGO_CONN_URL);
      await _db?.open();
      print('Connected to MongoDB successfully!');
    } catch (e) {
      print('Error connecting to MongoDB: $e');
    }
  }

  static Future<void> insert(String collection, Map<String, dynamic> data) async {
    if (_db != null) {
      var coll = _db?.collection(collection);
      await coll?.insertOne(data);
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String collection) async {
    if (_db != null) {
      var coll = _db?.collection(collection);
      return await coll?.find().toList() ?? [];
    }
    return [];
  }

  static Future<void> close() async {
    await _db?.close();
  }
}