// import 'package:flutter/material.dart';
// import '/screens/player.dart';
// import '/utils/api_client.dart';
// import '../models/song.dart';
// import 'package:audioplayers/audioplayers.dart';

// class ListOfSongs extends StatefulWidget {
//   const ListOfSongs({Key? key}) : super(key: key);

//   @override
//   State<ListOfSongs> createState() => _ListOfSongsState();
// }

// class _ListOfSongsState extends State<ListOfSongs> {
//   AudioPlayer audioPlayer = AudioPlayer();
//   List<Song> songs = [];
//   int currentSongIndex = 0;
//   dynamic error;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     client.getSongs(getSongList, getSongError);
//     // Future.delayed(Duration(seconds: 10), () {
//     //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Player()));
//     // });
//   }

//   ApiClient client = ApiClient();

//   getSongList(List<Song> songs) {
//     this.songs = songs;

//     setState(() {});
//   }

//   getSongError(dynamic error) {
//     this.error = error;

//     setState(() {});
//   }

//   ListView _printSong() {
//     return ListView.builder(
//       itemBuilder: (BuildContext ctx, int index) {
//         return ListTile(
//           onTap: () {
//             Future.delayed(Duration(milliseconds: 10), () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (ctx) => Player(song)));
//             });
//           },
//           leading: Image.network(songs[index].image),
//           title: Text(songs[index].trackName),
//           subtitle: Text(songs[index].artistName),
//           trailing: IconButton(
//               onPressed: () async {
//                 // print("Song played ${audioPlayer.play(songs[index].audio}");
//                 print("Song Play ${songs[index].audio}");
//                 await audioPlayer.play(songs[index].audio);
//               },
//               icon: const Icon(
//                 Icons.play_arrow_rounded,
//                 size: 30,
//                 color: Colors.redAccent,
//               )),
//         );
//       },
//       itemCount: songs.length,
//     );
//   }

//   Center _showLoading() {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   TextEditingController searchCtrl = TextEditingController();

//   _searchSongs() {
//     String searchValueTxt = searchCtrl.text;
//     client.getSongs(getSongList, getSongError, songName: searchValueTxt);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: PreferredSize(
//       //   preferredSize: Size.fromHeight(100),
//       //   child: AppBar(
//       //     //toolbarHeight: 100,
//       //     title: Container(
//       //       margin: EdgeInsets.all(20),
//       //       decoration: BoxDecoration(
//       //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
//       //       //color: Colors.white,
//       //       child: TextField(
//       //         decoration: InputDecoration(
//       //             border: OutlineInputBorder(
//       //                 borderRadius: BorderRadius.circular(10)),
//       //             suffixIcon: Icon(
//       //               Icons.search,
//       //             ),
//       //             labelText: 'Search',
//       //             hintText: 'Type to Search'),
//       //       ),
//       //     ),
//       //     //title: Text('Songs'),
//       //   ),
//       // ),
//       appBar: AppBar(
//           // title: const Text('Songs'),
//           toolbarHeight: 80,
//           title: Container(
//             margin: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             child: TextField(
//               controller: searchCtrl,
//               decoration: InputDecoration(
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     print("You clicked on Search...");
//                     _searchSongs();
//                   },
//                 ),
//                 // labelText: "Search",
//                 hintText: "Type to Search",
//               ),
//             ),
//           )),
//       body: Container(child: (songs.isEmpty) ? _showLoading() : _printSong()),
//     );
//   }
// }

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/models/song.dart';
import '/screens/player.dart';
import '/utils/api_client.dart';
import 'package:shake/shake.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({Key? key}) : super(key: key);

  @override
  _ListOfSongsState createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  AudioPlayer audioPlayer = AudioPlayer();
  int currentSongIndex = 0;
  List<Song> songs = [];
  dynamic error;
  ApiClient client = ApiClient();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //detector.stopListening();
  }

  late ShakeDetector detector;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      // Do stuff on phone shake
      print("Shake Detect.....................");
    });

    client.getSongs(getSongList, getSongError);
    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Player()));
    // });
  }

  getSongList(List<Song> songs) {
    this.songs = songs;
    setState(() {});
  }

  getSongError(dynamic error) {
    this.error = error;
    setState(() {});
  }

  Center _showLoading() {
    return Center(child: CircularProgressIndicator());
  }

  _showPlayer(Song song) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => Player(song)));
  }

  ListView _printSong() {
    return ListView.builder(
      itemBuilder: (BuildContext ctx, int index) {
        return ListTile(
          onTap: () {
            _showPlayer(songs[index]);
          },
          leading: Image.network(songs[index].image),
          title: Text(songs[index].trackName),
          subtitle: Text(songs[index].artistName),
          trailing: IconButton(
              onPressed: () async {
                print("Song Play ${songs[index].audio}");
                currentSongIndex = index;
                print("Now the current song index $currentSongIndex");
                await audioPlayer.play(songs[index].audio);
              },
              icon: Icon(
                Icons.play_arrow_rounded,
                size: 30,
                color: Colors.redAccent,
              )),
        );
      },
      itemCount: songs.length,
    );
  }

  TextEditingController searchCtrl = TextEditingController();

  _searchSongs() {
    String searchValueTxt = searchCtrl.text;
    client.getSongs(getSongList, getSongError, searchValue: searchValueTxt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(100),
      //   child: AppBar(
      //     //toolbarHeight: 100,
      //     title: Container(
      //       margin: EdgeInsets.all(20),
      //       decoration: BoxDecoration(
      //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
      //       //color: Colors.white,
      //       child: TextField(
      //         decoration: InputDecoration(
      //             border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(10)),
      //             suffixIcon: Icon(
      //               Icons.search,
      //             ),
      //             labelText: 'Search',
      //             hintText: 'Type to Search'),
      //       ),
      //     ),
      //     //title: Text('Songs'),
      //   ),
      // ),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          //color: Colors.white,
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    //print("U Click on Search....");
                    _searchSongs();
                  },
                ),
                labelText: 'Search',
                hintText: 'Type to Search'),
          ),
        ),
        //title: Text('Songs'),
      ),
      body:
          Container(child: (songs.length == 0) ? _showLoading() : _printSong()),
    );
  }
}
