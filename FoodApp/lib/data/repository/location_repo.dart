import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latlng) async {

    String apiUri = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latlng.latitude},${latlng.longitude}&key=AIzaSyDem6tbEobOfBYhLkN3r6bb_gpMJQ-XAVQ';
    // return await apiClient.getData('${AppConstants.GEOCODE_URI}'
    // '?lat=${latlng.latitude}&lng=${latlng.longitude}');
    Response response = await apiClient.getData(apiUri);
    return response;
  }

  Future<String> getCourse(LatLng latlng) async {
    String apiUri = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latlng.latitude},${latlng.longitude}&key=AIzaSyDem6tbEobOfBYhLkN3r6bb_gpMJQ-XAVQ';
    var url = Uri.parse(apiUri);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return data['results'][0]['formatted_address'];
    } else {
      throw Exception('Failed to load!');
    }
  }

  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }

  Future<Response> addAddress(AddressModel addressModel) async{
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeID) async {
    return await apiClient.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID');
  }
}


