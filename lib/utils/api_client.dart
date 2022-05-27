import 'package:http/http.dart' as http;
import 'package:musicapp/config/api_path.dart';
import 'dart:convert' as jsonconvert;
import '../models/song.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/models/song.dart';

class ApiClient {
  void getSongs(Function successCallBack, Function failCallBack,
      {String searchValue = 'sonu+nigam'}) async {
    //
    //
    //
    //
    // final URL = "https://itunes.apple.com/search?term=$songName&limit=25";
    final URL = "${ApisPath.BASE_URL}?term=$searchValue&limit=25";
    Future<http.Response> future = http.get(Uri.parse(URL)); //or post url
    future.then((response) {
      String json = response.body;

      // Doing JSON Conversion and store in song model
      Map<String, dynamic> map = jsonconvert.jsonDecode(json);
      //convert json to map
      //key is string, rest becomes an object

      List<dynamic> list = map['results'];
      //get the list from the map
      //var list = map['results'];

      List<Song> songs = list.map((songMap) => Song.fromJson(songMap)).toList();
      print("Songs are $songs");
      //songMap represents the element of the list
      //neeche wala same kaam short me and standard way

      /*List<Song> song = list
          .map((element) => Song(element['artistName'], element['trackName'],
              element['artworkUrl100'], element['previewUrl']))
          .toList(); */
      //traverse the list and map of each track and convert map into song object and song object store in store list

      successCallBack(songs);

      // print("Map is $map and Map type ${map.runtimeType}");
      // print("JSON $json"); //JSON format
      // print(json.runtimeType);
    }).catchError((err) => failCallBack(err));
  }
}
