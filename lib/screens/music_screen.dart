import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      'title': 'Perfect Beauty',
      'artist': 'Unknown Artist',
      'url': '', // Leave this empty for Firebase download
      'image': 'images/img_37.png',
      'firebasePath': 'music/perfect-beauty-191271.mp3', // Firebase file path
    },
    {
      'title': 'Overthinking',
      'artist': 'Meadows',
      'url': 'https://www.sample-videos.com/audio/mp3/wave.mp3',
      'image': 'images/img_38.png',
      'firebasePath': 'music/overthinking.mp3',
    },
    {
      'title': 'Nightfall',
      'artist': 'Dreamer',
      'url': 'https://www.sample-videos.com/audio/mp3/crash.mp3',
      'image': 'images/img_39.png',
      'firebasePath': 'music/nightfall.mp3',
    },
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Function to play music
  void _playMusic(String url) async {
    if (isPlaying && currentSong == url) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      if (url.startsWith('assets')) {
        await _audioPlayer.play(AssetSource(url));
      } else {
        await _audioPlayer.play(UrlSource(url));
      }

      setState(() {
        isPlaying = true;
        currentSong = url;
      });
    }
  }

  // Function to download the file from Firebase Storage
  Future<void> _downloadMusic(String firebasePath, String songTitle, int index) async {
    try {
      // Request storage permission
      if (await Permission.storage.request().isGranted) {
        // Get directory to save the music file
        final dir = await getExternalStorageDirectory();
        final filePath = '${dir?.path}/$songTitle.mp3';

        // Reference the file from Firebase Storage
        final ref = FirebaseStorage.instance.ref().child(firebasePath);
        final downloadUrl = await ref.getDownloadURL();

        // Create a file to save the downloaded data
        final file = File(filePath);

        // Download the file using HttpClient
        final response = await HttpClient().getUrl(Uri.parse(downloadUrl));
        final responseData = await response.close();
        final bytes = await consolidateHttpClientResponseBytes(responseData);

        // Write the bytes to the file
        await file.writeAsBytes(bytes);

        // Update the local path for the song in the list after download
        setState(() {
          songs[index]['url'] = file.path;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloaded $songTitle')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Permission denied')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error downloading: $e')));
    }
  }

  // Helper function to convert the response to bytes
  Future<List<int>> consolidateHttpClientResponseBytes(HttpClientResponse response) async {
    final bytes = <int>[];
    await for (var chunk in response) {
      bytes.addAll(chunk);
    }
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                      // Download button
                      IconButton(
                        icon: Icon(Icons.download, color: Colors.teal),
                        onPressed: () {
                          _downloadMusic(song['firebasePath']!, song['title']!, index);
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