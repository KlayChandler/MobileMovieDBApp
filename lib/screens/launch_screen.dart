import 'package:flutter/material.dart';
import 'movie_list.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  void enterPage() {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => const MovieList());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 1000,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('MovieApp.png'),
          ),
        ),
      ),
      //This part seems extreme, and I deep dove into styline and learn alot from it about style.
      Align(
          alignment: Alignment.center,
          child: SizedBox.expand(
              child: OutlinedButton(
            onPressed: () => enterPage(),
            child: Stack(children: <Widget>[
              Text('MOVIO',
                  textScaleFactor: 4.0,
                  style: TextStyle(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.black)),
              const Text('MOVIO',
                  textScaleFactor: 4.0, style: TextStyle(color: Colors.white)),
            ]),
          )))
    ]);
  }
}
