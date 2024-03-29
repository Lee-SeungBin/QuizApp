import 'package:flutter/material.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/views/add_question.dart';
import 'package:quizapp2/views/add_question2.dart';
import 'package:quizapp2/widget/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {


  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizDesc;

  bool isLoading = false;
  bool oxquiz = false;
  String quizId;


  createQuiz(){

    quizId = randomAlphaNumeric(16);
    if(_formKey.currentState.validate()){

      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizTitle" : quizTitle,
        "quizDesc" : quizDesc,
        "quizid" : quizId,
      };

      databaseService.addQuizData(quizData, quizId).then((value){
        setState(() {
          isLoading = false;
        });
        if(oxquiz){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>  AddQuestion(quizId)
          ));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>  AddQuestion2(quizId)
          ));
        }

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
              decoration: InputDecoration(
                hintText: "Quiz Title"
              ),
              onChanged: (val){
                quizTitle = val;
              },
            ),
            SizedBox(height: 5,),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
              decoration: InputDecoration(
                  hintText: "Quiz Description"
              ),
              onChanged: (val){
               quizDesc = val;
              },
            ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  oxquiz = false;
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "4지 선다형",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  oxquiz = true;
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "OX퀴즈",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 90,
              ),
          ],)
          ,),
      ),
    );
  }
}
