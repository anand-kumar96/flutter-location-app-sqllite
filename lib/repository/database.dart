import 'dart:io';
import 'package:location_app/models/place_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Singleton class
class DatabaseRepository{
static const _databaseName = 'places.db';
static const _databaseVersion = 1;

static const placeTable = 'user_place';
static const columnId = 'id';
static const columnTitle = 'title';
static const columnImage = 'image';
static const columnLat = 'lat';
static const columnLang = 'lng';
static const columnAddress = 'address';

static DatabaseRepository ? _databaseRepository;
// a private named to prevent the class from being instantiated outside the class.
DatabaseRepository._createInstance();

// to create only one instance
factory DatabaseRepository (){
  _databaseRepository ??= DatabaseRepository._createInstance();
  return _databaseRepository!;
}

 // only have a single app-wide reference to the database
  static Database  ? _database;
  Future<Database> get database async {
  _database ??= await initializeDatabase();
  return _database!;
	}
  
  Future<Database> initializeDatabase() async {
		Directory directory = await getApplicationDocumentsDirectory(); 
		String path = '${directory.path}$_databaseName';
		var placesDatabase = await openDatabase(path, version: _databaseVersion, onCreate: _createDb);
		return placesDatabase;
  }

  // Create Database
  void _createDb(Database db, int newVersion) async {
  await db.execute(
      '''
       CREATE TABLE $placeTable(
       $columnId TEXT PRIMARY KEY, 
       $columnTitle TEXT,
		   $columnImage TEXT, 
       $columnLat   REAL, 
       $columnLang REAL,
       $columnAddress TEXT
       )
       ''');
  }

  // Insert Places
  Future<void> insertPlaces (PlaceModel places) async {
    Database db = await database;
    await db.insert(placeTable, places.toJson());
  }

  // getPlaces
  Future<List<PlaceModel>> getPlaceList() async{
  Database db = await database;
  var result = await db.query(placeTable);
  List<PlaceModel> places = [];
  for(int i=0;i<result.length;i++) {
    places.add(PlaceModel.fromMapObject(result[i]));
  }
  return places;
  }
}