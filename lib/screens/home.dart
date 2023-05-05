import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;
  static const String _title = "Home";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulHomeWidget(errMsg: errMsg),
    );
  }
}

class StatefulHomeWidget extends StatefulWidget {
  const StatefulHomeWidget({Key? key, required this.errMsg}) : super(key: key);
  final String errMsg;

  @override
  State<StatefulHomeWidget> createState() =>
      _StatefulHomeWidget(errMsg: errMsg);
}

class _StatefulHomeWidget extends State<StatefulHomeWidget> {
  _StatefulHomeWidget({required this.errMsg});

  final String errMsg;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    if (errMsg.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errMsg),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
