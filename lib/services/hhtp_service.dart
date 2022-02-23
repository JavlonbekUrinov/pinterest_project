// import 'dart:convert';
//
// import 'package:http/http.dart';
// import 'package:logger/logger.dart';
// import 'package:pinterest_project/services/utils_service.dart';
//
// class Pinterest {
//   static bool isTester = true;
//
//   static String SERVER_DEVELOPMENT = "api.unsplash.com";
//   static String SERVER_PRODUCTION = "api.unsplash.com";
//
//   static Map<String, String> getHeaders() {
//     Map<String,String> headers = {'Accept-Version':'v1','Authorization':'Client-ID 2xWOWLnAE4CTbXe8h518hAFabo5vrOG2lG2IvBY9YWo'};
//     return headers;
//   }

import 'dart:convert';

import 'package:http/http.dart';
import 'package:pinterest_project/models/printerest_model.dart';

class ServerPinterest {
  ///API domain + header
  static String DOMAIN = "api.unsplash.com";
  // static  Map<String,String> header = {
  //   "Accept-Version":"v1",
  //   "Authorization":"Client-ID IuR29HU8Dj0Fpyz-i6kJA-wR6p0NArKTlR8qF-cdjho"
  // };
  static Map<String, String> header = {
    'Accept-Version':'v1',
    'Authorization':'Client-ID 2xWOWLnAE4CTbXe8h518hAFabo5vrOG2lG2IvBY9YWo',
  };

  ///API posts
  static String API_LIST = "/photos";
  static String API_ONE = "/photos";
  static String API_SEARCH = "/search/photos";

  ///API methods
  static Future<String?> GET(String api, Map<String, String> param) async {
    var url = Uri.https(DOMAIN, api, param);
    Response response = await get(url,headers: header);
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    }
    return null;
  }

  static List<Welcome> getParseList(String response) {
    List<Welcome> list = welcomeFromJson(response);
    return list;
  }

  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }

  static Map<String, String> paramGET(String id) {
    Map<String, String> map = {};
    map.addAll({
      "id":id
    });
    return map;
  }

  static Map<String, String> paramsSearch(String search, int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "query":search,
      "page":pageNumber.toString()
    });
    return params;
  }
  static List<Welcome> parseSearchParse(String response) {
    Map json = jsonDecode(response);
    List<Welcome> photos = List<Welcome>.from(json["results"].map((x) => Welcome.fromJson(x)));
    return photos;
  }
  static List<Welcome> parseUnsplashList(String response){
    var data = welcomeFromJson(response);
    return data;
  }

}