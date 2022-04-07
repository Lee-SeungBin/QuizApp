import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  Future<void> addData(userData) async {
    Firestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection("QuizBank")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addQuestionData(quizData, String quizId) async {
    await Firestore.instance
        .collection("QuizBank")
        .document(quizId)
        .collection("Quiz")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addAnswerData(quizData) async {
    await Firestore.instance
        .collection("Answer")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await Firestore.instance.collection("QuizBank").snapshots();
  }

  getQuizTitle(String quizId) async {
    return await Firestore.instance
        .collection("QuizBank")
        .document(quizId)
        .snapshots();
  }

  getQuestionData(String quizId) async{
    return await Firestore.instance
        .collection("QuizBank")
        .document(quizId)
        .collection("Quiz")
        .snapshots();
  }
}
