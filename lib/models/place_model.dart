import 'dart:io';
import 'package:location_app/models/location_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
class PlaceModel {
  PlaceModel({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final LocationModel location;

  // convert place Model to json
  Map<String,dynamic> toJson(){
    return {
    'id': id,
    'title':title,
    'image':image.path,
    'lat':location.latitude,
    'lng':location.longitude,
    'address':location.address,
    };
  }
  
 // convert jason to Map using named Constructor
 PlaceModel.fromMapObject(Map<String,dynamic> places) :
 id = places['id'] as String,
 title = places['title'] as String,
 image= File(places['image'] as String),
 location = LocationModel(
 address: places['address'] as String,
 latitude: places['lat'] as double,
 longitude: places['lng'] as double
 );
}
