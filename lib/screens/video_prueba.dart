import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPruebaScreen extends StatefulWidget {
  const VideoPruebaScreen({Key? key}) : super(key: key);

  @override
  State<VideoPruebaScreen> createState() => _VideoPruebaScreenState();
}

class _VideoPruebaScreenState extends State<VideoPruebaScreen> {
  late YoutubePlayerController trailerController = YoutubePlayerController(
    initialVideoId: 'ts8i-6AtDfc',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    trailerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    trailerController.dispose();
    super.dispose();
  }

  //r2vFOkemOaY
//ts8i-6AtDfc

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hey')),
      body: ListView(
        children: [
          YoutubePlayer(
              controller: trailerController, showVideoProgressIndicator: true),
          YoutubePlayer(
              controller: trailerController, showVideoProgressIndicator: true),
          YoutubePlayer(
              controller: trailerController, showVideoProgressIndicator: true),
          buildYoutubeVideo('r2vFOkemOaY')
        ], //r2vFOkemOaY
      ),
    );
    //return YoutubePlayerBuilder();
  }

  Widget buildYoutubeVideo(String urlTrailer) {
    return YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: urlTrailer,
          flags: YoutubePlayerFlags(autoPlay: false, mute: true),
        ),
        showVideoProgressIndicator: true);
  }
}
