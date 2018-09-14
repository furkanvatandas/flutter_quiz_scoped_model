import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/question_model.dart';

class QuestionScoped extends Model {
  int questionIndex = 0;
  int buttonID = -1;
  bool isCorrect = false; // 0-Wrong, 1-Correct, 2-Default
  Question question;
  List<Question> questionList = [];
  Map<String, int> buttonIDs = Map<String, int>();

  Future fetchQuestions() async {
    if (questionList.isEmpty) {
      final jsonData = json.decode(await rootBundle.loadString('assets/questions.json'));
      jsonData.forEach((v) => questionList.add(Question.fromJson(v)));
      //Show first question
      showQuestion();
    }
  }

  showQuestion() {
    question = questionList[questionIndex];
    notifyListeners();
  }

  changeQuestion(int value) {
    this.questionIndex += value;
    if (buttonIDs.containsKey("$questionIndex")) {
      this.buttonID = buttonIDs["$questionIndex"];
      isCorrect = true;
    } else {
      print(questionIndex);
      print((buttonIDs.containsKey("$questionIndex")));
      isCorrect = false;
    }

    showQuestion();
  }

  showAnswer() {
    isCorrect = true;
    notifyListeners();
  }

  void selectButtonID(int id) {
    this.buttonID = id;
    buttonIDs["$questionIndex"] = id;
    print(buttonIDs.length);
    notifyListeners();
  }
}
