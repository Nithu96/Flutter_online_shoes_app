import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestService{
  static Future<dynamic> getRequest(String url) async {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    try{
      if(response.statusCode == 200){
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      }else{
        return {"success": false};
      }
    }catch(exp){
      return {"success": false};
    }
  }
}