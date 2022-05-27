class Song {
  late String artistName;
  late String trackName;
  late String image; //image url
  late String audio; //audio url

  Song(this.artistName, this.trackName, this.image, this.audio);

  Song.fromJson(Map<String, dynamic> map) {
    artistName = map['artistName'];
    trackName = map['trackName'];
    image = map['artworkUrl100'];
    audio = map['previewUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      "artisName": artistName,
      "trackName": artistName,
      "artworkUrl100": artistName,
      "previewUrl": artistName
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "artistName $artistName TrackName $trackName image $image audio $audio";
  }
}
