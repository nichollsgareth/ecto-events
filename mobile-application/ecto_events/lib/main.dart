import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ecto_events/widgets/event_search.dart';
import 'package:ecto_events/widgets/image_capture.dart';
import 'package:ecto_events/widgets/camera_capture.dart';
import 'package:ecto_events/widgets/event_manager.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  cameras = await availableCameras();
  runApp(App());
}

//void main() => runApp(App());

/// Returns the color scheme used by ecto
MaterialColor ectoColor() {
  return new MaterialColor(0xFF0498C1, {
    50: new Color(0xFFE1F3F8),
    100: new Color(0xFFB4E0EC),
    200: new Color(0xFF82CCE0),
    300: new Color(0xFF4FB7D4),
    400: new Color(0xFF2AA7CA),
    500: new Color(0xFF0498C1),
    600: new Color(0xFF0390BB),
    700: new Color(0xFF0385B3),
    800: new Color(0xFF027BAB),
    900: new Color(0xFF016A9E)
  });
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecto Events',
      theme: ThemeData(
        primarySwatch: ectoColor(),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: ectoColor(), backgroundColor: Colors.white
      ),
      home: HomePage(title: 'Ecto Events'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int page = 1;

  final CameraExampleHome _ImageCapturePage = new CameraExampleHome(cameras);
  final EventSearch _EventSearchPage = new EventSearch();
  final EventManager _EventManagerPage = new EventManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: new PageView(
            children: [
              _ImageCapturePage,
              _EventSearchPage,
              _EventManagerPage
            ],
            controller: pageController,
            onPageChanged: onPageChanged
        ),
      bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              //onPressed: _incrementCounter,
                icon: new Icon(Icons.camera),
                title: new Text("capture")),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.location_searching),
              title: new Text("search"),
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.add), title: new Text("new"))
          ],
          onTap: onTap,
          currentIndex: page
      )
    );
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }

  void onTap(int index) {
    pageController.animateToPage(
        index, duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
