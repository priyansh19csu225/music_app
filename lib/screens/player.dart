import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/models/song.dart';

class Player extends StatefulWidget {
  Song song;
  Player(this.song);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  AudioPlayer player = AudioPlayer();
  Duration? _duration;
  Duration? _position;
  bool isPlay = false;
  _play() {
    if (isPlay) {
      player.pause();
    } else {
      player.play(widget.song.audio);
    }
    isPlay = !isPlay;
  }

  @override
  void initState() {
    super.initState();
    _initPlayerThings();
  }

  _initPlayerThings() {
    player.onDurationChanged.listen((duration) {
      this._duration = duration;
      setState(() {});
    });
    player.onAudioPositionChanged.listen((pos) {
      _position = pos;
      setState(() {});
    });
    player.onPlayerCompletion.listen((duration) {});
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.song.image),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Colors.yellow,
                  Colors.orangeAccent,
                  Colors.deepOrangeAccent
                ])),
            height: deviceSize.height / 2,
            width: deviceSize.width,
          ),
          Text(widget.song.artistName),
          Text(widget.song.trackName),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, size: 50),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  _play();
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, size: 50),
                onPressed: () {},
              )
            ],
          ),
          Text("Current is ${_position?.inSeconds}"),
          Text('Duration is ${_duration == null ? 0.0 : _duration?.inSeconds}')
        ],
      ),
    );
  }
}
