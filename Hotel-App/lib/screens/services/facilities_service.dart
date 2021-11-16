import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/feedback_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacilityService with ChangeNotifier {
  FirebaseFirestore? _instance;
  final List<FacilityModel> _facilities = [];

  List<FacilityModel> getFacilities() {
    return _facilities;
  }

  FacilityService() {
    getFacilitiesCollectionFromFirebase();
  }
  Future<void> getFacilitiesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('extra-facilities').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var facilitiesData = data['extra'] as List<dynamic>;
      for (var facilityData in facilitiesData) {
        FacilityModel f = FacilityModel.fromJson(facilityData);
        _facilities.add(f);
      }
    }
  }

  Future<void> addFacilityInFirebase(FacilityModel f) async {
    DocumentReference<Map<String, dynamic>> facilities =
        FirebaseFirestore.instance.collection('users').doc('extra-facilities');
    _facilities.add(f);
    final facilitiesMap = <Map<String, dynamic>>[];
    for (var f in _facilities) {
      facilitiesMap.add(f.toJson());
    }
    facilities.set({
      'extra': facilitiesMap,
    });
  }
}
