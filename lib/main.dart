import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/screens/list_of_songs.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Music App 2022',
    home: ListOfSongs(),
  ));
}
