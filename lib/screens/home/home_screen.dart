import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/background.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        if (_controller.value.isInitialized) {
          _controller.setLooping(true);
          _controller.play();
        }
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          if (_isVideoInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 50,
                    color: Colors.amber,
                  ),
                  const Text(
                    'London',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 47,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Turn on location services',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 230,
                    height: 185,
                    child: Stack(
                      children: [
                        Text(
                          13.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 167,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            '°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 47,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Cloudy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 47,
                        fontWeight: FontWeight.bold,
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(150, 50),
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.energy_savings_leaf,
                          color: Colors.white,
                        ),
                        const Text(
                          'AQI 14',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  dayWeather(
                      weather: 'sunny',
                      dayOfWeek: DateFormat('d MMM')
                          .format(DateTime.now().add(Duration(days: 1))),
                      maxTemp: 25,
                      minTemp: 19),
                  dayWeather(
                    weather: 'sunny',
                    dayOfWeek: DateFormat('d MMM')
                        .format(DateTime.now().add(Duration(days: 2))),
                    maxTemp: 25,
                    minTemp: 19,
                  ),
                  dayWeather(
                    weather: 'sunny',
                    dayOfWeek: DateFormat('d MMM')
                        .format(DateTime.now().add(Duration(days: 3))),
                    maxTemp: 25,
                    minTemp: 19,
                  ),
                  dayWeather(
                    weather: 'sunny',
                    dayOfWeek: DateFormat('d MMM')
                        .format(DateTime.now().add(Duration(days: 4))),
                    maxTemp: 25,
                    minTemp: 19,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dayWeather(
      {required String weather,
      required String dayOfWeek,
      required int maxTemp,
      required int minTemp}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        left: 16,
        right: 16,
        bottom: 6,
      ),
      child: Row(
        children: [
          Icon(Icons.cloud, color: Colors.white, size: 16.0),
          Text('$dayOfWeek • $weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
          Spacer(),
          Text('$minTemp° / $maxTemp°'),
        ],
      ),
    );
  }
}
