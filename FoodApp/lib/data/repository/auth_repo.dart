import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn() {
    print("token: "+sharedPreferences.getString(AppConstants.TOKEN).toString());
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }
  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"phone":phone, "password":password});
  }


  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
      try{
        await sharedPreferences.setString(AppConstants.PHONE, number);
        await sharedPreferences.setString(AppConstants.PASSWORD, password);
      }catch(e){
        throw e;
      }
  }

  bool clearShareData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }

  /*Future<Response> updateToken() async{
    String? _deviceToken;
    if(GetPlatform.isIOS && !GetPlatform.isWeb){
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized){
        _deviceToken = await _saveDeviceToken();
        print("My token is "+_deviceToken!);
      }
    }else{
      _deviceToken = await _saveDeviceToken();
      print("My token is "+_deviceToken!);
    }
    if(!GetPlatform.isWeb){
      //FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    }
    return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "cm_firebase_token": _deviceToken});
  }

  Future<String?> _saveDeviceToken() async{
    String? _deviceToken = '@';
    if(!GetPlatform.isWeb){
      try{
        FirebaseMessaging.instance.requestPermission();
        _deviceToken = await FirebaseMessaging.instance.getToken();
      }catch(e){
        print("could not get the token");
        print(e.toString());
      }
    }
    if(_deviceToken != null){
      print('--------Device Token--------'+_deviceToken);
    }
    return _deviceToken;
  }*/
}
