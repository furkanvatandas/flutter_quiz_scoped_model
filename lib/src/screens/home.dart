import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_quiz/src/scoped_models/question_scoped.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScopedModelDescendant<QuestionScoped>(
            builder: (BuildContext context, Widget widget, QuestionScoped model) {
          if (model.questionList.isEmpty) {
            return CircularProgressIndicator();
          }
          if (model.isCorrect) {
            return ListView(children: <Widget>[
              Column(children: <Widget>[
                Text(model.question.question),
                model.buttonID == 1 || model.question.answerCorrect == model.question.answerA
                    ? model.question.answerCorrect == model.question.answerA
                        ? trueButton(model.question.answerA)
                        : falseButton(model.question.answerA)
                    : neutralButton(model.question.answerA),
                model.buttonID == 2 || model.question.answerCorrect == model.question.answerB
                    ? model.question.answerCorrect == model.question.answerB
                        ? trueButton(model.question.answerB)
                        : falseButton(model.question.answerB)
                    : neutralButton(model.question.answerB),
                model.buttonID == 3 || model.question.answerCorrect == model.question.answerC
                    ? model.question.answerCorrect == model.question.answerC
                        ? trueButton(model.question.answerC)
                        : falseButton(model.question.answerC)
                    : neutralButton(model.question.answerC),
                model.buttonID == 4 || model.question.answerCorrect == model.question.answerD
                    ? model.question.answerCorrect == model.question.answerD
                        ? trueButton(model.question.answerD)
                        : falseButton(model.question.answerD)
                    : neutralButton(model.question.answerD),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    model.questionIndex == 0
                        ? RaisedButton(child: Text("<"), onPressed: null)
                        : RaisedButton(
                            child: Text("<"),
                            onPressed: () {
                              model.changeQuestion(-1);
                            },
                          ),
                    model.questionList.length - 1 == model.questionIndex
                        ? RaisedButton(child: Text(">"), onPressed: null)
                        : RaisedButton(
                            child: Text(">"),
                            onPressed: () => model.changeQuestion(1),
                          )
                  ],
                )
              ])
            ]);
          }
          return ListView(children: <Widget>[
            Column(children: <Widget>[
              Text(model.question.question),
              defaultButton(model.question.answerA, model, 1),
              defaultButton(model.question.answerB, model, 2),
              defaultButton(model.question.answerC, model, 3),
              defaultButton(model.question.answerD, model, 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  model.questionIndex == 0
                      ? RaisedButton(child: Text("<"), onPressed: null)
                      : RaisedButton(
                          child: Text("<"),
                          onPressed: () {
                            model.changeQuestion(-1);
                          },
                        ),
                  model.questionList.length - 1 == model.questionIndex
                      ? RaisedButton(child: Text(">"), onPressed: null)
                      : RaisedButton(
                          child: Text(">"),
                          onPressed: () => model.changeQuestion(1),
                        )
                ],
              )
            ])
          ]);
        }),
      ),
    );
  }

  Widget defaultButton(String answer, QuestionScoped model, int buttonID) {
    return RaisedButton(
      child: Text(answer),
      color: Colors.black54,
      textColor: Colors.white,
      onPressed: () {
        model.showAnswer();
        model.selectButtonID(buttonID);
      },
    );
  }

  Widget trueButton(String answer) {
    return RaisedButton(
      child: Text(answer),
      onPressed: null,
      disabledColor: Colors.green,
      disabledTextColor: Colors.white,
    );
  }

  Widget falseButton(String answer) {
    return RaisedButton(
      child: Text(answer),
      onPressed: null,
      disabledColor: Colors.red,
      disabledTextColor: Colors.white,
    );
  }

  Widget neutralButton(String answer) {
    return RaisedButton(
      child: Text(answer),
      onPressed: null,
      disabledColor: Colors.black54,
      disabledTextColor: Colors.white,
    );
  }
}
