import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Driver 
{
  final String id;
  String? imageUrl;
  String? apiId;
  String? teamRace;
  String? completeName;

  int rating = 5;

  Driver(this.id);

  Future getImageUrl() async 
  {
    if (imageUrl != null) 
    {
      return;
    }

    HttpClient http = HttpClient();
    try 
    {
      apiId = id;

      var uri = Uri.https('65562b7f84b36e3a431f444d.mockapi.io', '/pilots/$apiId');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> data = json.decode(responseBody);
        imageUrl = data["image"];
        teamRace = data["team"];
        completeName = data["name"];
    } 
    catch (exception) 
    {
      //print(exception);
    }
  }
}
