import 'package:flutter/material.dart'; ///////////////////razan
import 'package:url_launcher/url_launcher.dart';

class LiveVideo extends StatefulWidget {
  const LiveVideo({Key? key}) : super(key: key);

  @override
  State<LiveVideo> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: _launchURL,
          child: new Text('Show Flutter homepage'),
        ),
      ),
    );
  }
}

_launchURL() async {
  final Uri url = Uri.parse('https://flutter.dev');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch _url');
  }
}