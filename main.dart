import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';

final assestsaudioplayer = AssetsAudioPlayer();
var song_index = 0;
var index_ = 0;

bool song_started = true;

bool is_playing = false;
main() {
  runApp(musicapp());
}

class musicapp extends StatefulWidget {
  @override
  _musicappState createState() => _musicappState();
}

class _musicappState extends State<musicapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home_pg(),
    );
  }
}

class home_pg extends StatefulWidget {
  @override
  _home_pgState createState() => _home_pgState();
}

class _home_pgState extends State<home_pg> {
  final music_title = ['Iron_man-theme song', 'The Lion king-theme song'];

  final icon_ = [Icons.play_circle_filled, Icons.pause_circle_filled];

  play_pause() {
    if (is_playing) {
      assestsaudioplayer.pause();
      is_playing = false;
      //index_ = 0;
      setState(() {
        index_ = 0;
      });
    } else {
      assestsaudioplayer.play();
      is_playing = true;
      //index_ = 1;
      setState(() {
        index_ = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2,
        title: Center(child: Text('Audio Player')),
        backgroundColor: Colors.cyan[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(8),
              //forsspace
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.cyan[700],
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 60,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'Open Playlist',
                      style: TextStyle(fontSize: 30, color: Colors.cyan[700]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130, bottom: 20),
                    child: IconButton(
                        icon: Icon(
                          Icons.playlist_play,
                          color: Colors.cyan[700],
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      playlist_page()));
                        }),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan[50],
              border: Border.all(
                color: Colors.cyan[700],
                width: 4,
              ),
              borderRadius: BorderRadius.circular(900),
            ),
            height: 350,
            //color: Colors.greenAccent,
            child: Center(
              child: Icon(
                Icons.music_note,
                color: Colors.cyan[700],
                size: 200,
              ),
            ),
          ),

          Container(
            height: 30,
            child: Text(music_title[song_index]),
          ),

          // Music tab code here
          BottomAppBar(
            color: Colors.cyan[50],
            child: Container(
              // margin: EdgeInsets.only(bottom: 10),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.cyan[700],
                  width: 3,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.fast_rewind,
                            color: Colors.cyan[700],
                            size: 30,
                          ),
                          onPressed: () {
                            assestsaudioplayer.previous();
                          }),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      print(song_started);
                      if (song_started) {
                        //assestsaudioplayer
                        //  .open(Audio('assets/audios/Lion_king.mp3'));
                        assestsaudioplayer.open(
                            Playlist(audios: [
                              Audio("assets/audios/mark1.mp3"),
                              Audio("assets/audios/Lion_king.mp3")
                            ]),
                            loopMode: LoopMode.playlist);

                        setState(() {
                          song_started = false;
                          print(assestsaudioplayer.current);
                        });
                      }
                      play_pause();
                    },
                    child: Expanded(
                      child: Container(
                        child: IconButton(
                            disabledColor: Colors.cyan[700],
                            iconSize: 70,
                            icon: Icon(icon_[index_]),
                            onPressed: null),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.fast_forward,
                            color: Colors.cyan[700],
                            size: 35,
                          ),
                          onPressed: () => assestsaudioplayer.next()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.cyan[700]),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/logo.png'),
                ),
                accountName: Text('DEMO AUDIO PLAYER'),
                accountEmail: Text('Designed in flutter')),
            ListTile(
              title: Text('Audio-Player'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => home_pg()));
              },
            ),
            ListTile(
              title: Text("About"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => about_page()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class playlist_page extends StatefulWidget {
  @override
  _playlist_pageState createState() => _playlist_pageState();
}

class _playlist_pageState extends State<playlist_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
        backgroundColor: Colors.cyan[700],
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              assestsaudioplayer.open(
                  Playlist(audios: [
                    Audio("assets/audios/mark1.mp3"),
                    Audio("assets/audios/Lion_king.mp3")
                  ]),
                  loopMode: LoopMode.playlist);
              setState(() {
                song_index = 0;
                index_ = 1;
                song_started = false;
                is_playing = true;
              });
            },
            child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: Text('Iron man theme song')),
          ),
          GestureDetector(
            onTap: () {
              assestsaudioplayer.open(
                  Playlist(audios: [
                    Audio("assets/audios/Lion_king.mp3"),
                    Audio("assets/audios/mark1.mp3"),
                  ]),
                  loopMode: LoopMode.playlist);
              setState(() {
                song_index = 1;
                song_started = false;
                is_playing = true;
                index_ = 1;
              });
              print(song_started);
            },
            child: Container(
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Text('Lion king theme song')),
          ),
        ],
      ),
    );
  }
}

class about_page extends StatefulWidget {
  @override
  _about_pageState createState() => _about_pageState();
}

class _about_pageState extends State<about_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.cyan[700],
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/logo.png'))),
          )),
          Container(
            child: Text(
              'Just Music app Developed in flutter :)',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
