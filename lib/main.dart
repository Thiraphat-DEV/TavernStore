import 'package:flutter/material.dart';
import 'package:untitled/screen/formscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/screen/show_whisky.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Thiraphat Increasement and decrement '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(body: TabBarView(
        children: [
         Screen() ,Show_Whisky()
          ],
          ),
          backgroundColor: Colors.cyan.shade500,
          bottomNavigationBar: TabBar(tabs: [
            Tab(text: "remember whisky",),
            Tab(text: "Whisky all Product",),
          ]),
          ),
    );
  }
}
