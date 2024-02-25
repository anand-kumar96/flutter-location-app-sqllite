import 'package:location_app/controller/place_controller.dart';
import 'package:location_app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_app/screens/add_place.dart';
import 'package:location_app/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  List<PlaceModel> places = [];
  @override
  void initState() {
    super.initState();
    updateUserPlacesList();
  }

void updateUserPlacesList() async {
 await ref.read(userPlaceController.notifier).loadPlaces();
  setState(() {
  places = ref.watch(userPlaceController);
});
}
  @override
  Widget build(BuildContext context) {
    places = ref.watch(userPlaceController);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(places: places,)
      ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddPlaceScreen(updatePlaceList:updateUserPlacesList ),));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white,),
        ) ,
    );
  }
}
