import 'package:majduradda/models/Majdurs/majdurdetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MajdurService
{
  var baseUri ='https://majdurbackend.onrender.com';
  Future<List<MajdurDetails>> getMajdurdata() async{
    var client = http.Client();
    try {
    var uri = Uri.parse('$baseUri/getallmajdur');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = jsonDecode(response.body) as List;
      return json.map((e) => MajdurDetails.fromJson(e)).toList();
    }
    else
    {
      return List.empty();
    }    
  } 
  catch (e) {
    
    return List.empty();
  } 
  finally {
    client.close();
  }
  }
}