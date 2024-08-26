import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:iasop/screens/patient_home_screen.dart';

void main() {
  runApp(MusicScreen());
}

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayerPage(),
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSong = '';

  final List<Map<String, String>> songs = [
    {
      'title': 'Infinite Horizon',
      'artist': 'Chris Charlie',
      'url': 'assets/music/infinite-stars-231067.mp3',
      'image': 'images/img_37.png',
    },
    {
      'title': 'Overthinking',
      'artist': 'Meadows',
      'url': 'https://www.sample-videos.com/audio/mp3/wave.mp3',
      'image': 'images/img_38.png',
    },
    {
      'title': 'Nightfall',
      'artist': 'Dreamer',
      'url': 'https://www.sample-videos.com/audio/mp3/crash.mp3',
      'image': 'images/img_39.png',
    },
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playMusic(String url) async {
    if (isPlaying && currentSong == url) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      if (url.startsWith('assets')) {
        await _audioPlayer.play(AssetSource(url)); // Corrected for local asset
      } else {
        await _audioPlayer.play(UrlSource(url)); // Corrected for network URL
      }

      setState(() {
        isPlaying = true;
        currentSong = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/img_36.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PatientHomeScreen()),
                          );
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        'CALM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Gentle way to help individuals manage anxiety, improve sleep, and support mental and physical health',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: Image.asset(
                    song['image']!,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(song['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(song['artist']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isPlaying && currentSong == song['url']
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          _playMusic(song['url']!);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.teal),
                        onPressed: () {
                          // Add to playlist functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.teal),
                        onPressed: () {
                          // More options functionality
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
