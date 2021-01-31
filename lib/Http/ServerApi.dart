import 'package:flutter_app/Http/UrlApi.dart' as api;
import 'package:flutter_app/ObjectResp/SelfCarePromotion.dart';
import 'package:flutter_app/ObjectResp/SelfCareTwo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> selfCarePromotionApi() async {
  var url = api.selfCarePromotionApi;
  var client = http.Client();
  var response = await client.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> data = jsonResponse['deals'];
    if (data != null && data.isNotEmpty) {
      return data.map((json) => SelfCareTwo.fromJson(json)).toList();
    }
    return [];
  } else {
    return 500;
  }
}

Future<dynamic> dealerPromotionApi() async {
  var url = api.dealerPromotionApi;
  var response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> data = jsonResponse['promotions'];
    if (data != null && data.isNotEmpty) {
      return data.map((json) => SelfCarePromotion.fromJson(json)).toList();
    }
    return [];
  } else {
    return response.statusCode;
  }
}
