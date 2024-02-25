import 'dart:io';
import 'package:location_app/models/location_model.dart';
import 'package:location_app/models/place_model.dart';
import 'package:location_app/repository/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PlaceNotifier extends StateNotifier<List<PlaceModel>>{
  DatabaseRepository databaseRepository = DatabaseRepository();
  PlaceNotifier():super([]);
  
   // get all places
   Future<void> loadPlaces () async{
   final places = await databaseRepository.getPlaceList();
   state = places;
   }

   // add places
   Future<void> addPlaces (String title, File image, LocationModel location) async{
    final appDir = await getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final newPlace = PlaceModel(title: title, image: copiedImage, location: location);
    await databaseRepository.insertPlaces(newPlace);
    state = [newPlace, ...state];
   }
}

final userPlaceController = StateNotifierProvider<PlaceNotifier,List<PlaceModel>>((ref) => PlaceNotifier());