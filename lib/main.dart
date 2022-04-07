import 'package:flutter/material.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/helper/authenticate.dart';
import 'package:quizapp2/helper/constants.dart';
import 'package:quizapp2/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await Constants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Quizanswer>(create: (_) => Quizanswer()),
      ],
    child: MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isUserLoggedIn ? Home() : Authenticate(),
    ),
    );
  }
}

class Quizanswer with ChangeNotifier {
  DatabaseService databaseService = new DatabaseService();
  int _count = 1;
  List<int> questionnumber = [];
  List<String> answeroption = [];
  uploadAnswerData(){
    Map<String, Object> answerMap = {
      "questionnumber": questionnumber,
      "answeroption": answeroption,
    };
    databaseService.addAnswerData(answerMap).then((value) {
      questionnumber = [];
      answeroption = [];
    }).catchError((e){
      print(e);
      });
  }
  int getCount() => _count;

  void increment(int value) {
    _count += value;
    notifyListeners(); //must be inserted
  }

  void decrement(int value) {
    _count -= value;
    notifyListeners(); //must be inserted
  }
}