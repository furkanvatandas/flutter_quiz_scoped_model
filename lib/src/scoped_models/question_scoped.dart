import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/question_model.dart';

class QuestionScoped extends Model {
  int questionIndex = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  //buttonID: 1-A, 2-B, 3-C, 4-D
  String buttonID = "";
  //When click one of the buttons then triggers checkAnswer
  bool checkAnswer = false;

  Question question;
  List<Question> questionList = [];
  Map<String, String> buttonIDMap = Map<String, String>();

  Future fetchQuestions() async {
    if (questionList.isEmpty) {
      final jsonData = json.decode(await rootBundle.loadString('assets/questions.json'));
      jsonData.forEach((v) => questionList.add(Question.fromJson(v)));
      getQuestion();
    }
  }

  /*
  When click one of the change buttons in home.dart 
  then triggers changeQuestion()
  value is for change question index
  */
  changeQuestion(int value) {
    this.questionIndex += value;
    //if yes, show my answered questions
    if (buttonIDMap.containsKey("$questionIndex")) {
      this.buttonID = buttonIDMap["$questionIndex"];
      checkAnswer = true;
    }
    //if no, show my unanswered questions
    else {
      checkAnswer = false;
      buttonID = "";
    }
    getQuestion();
  }

  /*
  Turns List<Question> to Question model
  */
  getQuestion() {
    question = questionList[questionIndex];
    notifyListeners();
  }

  /*
  When click one of the answer buttons in home.dart then triggers showAnswer()
  then change widgets and show me which one is wrong or correct
  */
  showAnswer(String id) {
    checkAnswer = true;
    this.buttonID = id;
    buttonIDMap["$questionIndex"] = id;
    notifyListeners();
  }
}
