import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_quiz/src/scoped_models/question_scoped.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Center(
        child: ScopedModelDescendant<QuestionScoped>(
            builder: (BuildContext context, Widget widget, QuestionScoped model) {
          if (model.questionList.isEmpty) {
            return CircularProgressIndicator();
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: ListView(children: <Widget>[
                    //Question Image
                    model.question.questionImage != null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Image.memory(
                              base64.decode(model.question.questionImage),
                              height: 100.0,
                              gaplessPlayback: true,
                            ),
                          )
                        : Container(),
                    //Question
                    Text(
                      "${model.questionIndex + 1} - ${model.question.question}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          height: 1.3),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    _buildShowButton(model.question.answerA, model, "A"),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildShowButton(model.question.answerB, model, "B"),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildShowButton(model.question.answerC, model, "C"),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildShowButton(model.question.answerD, model, "D"),
                  ]),
                ),
              ),
              _buildChangeQuestion(model, context),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildChangeQuestion(QuestionScoped model, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        model.questionIndex == 0
            ? RaisedButton(child: Text("<"), onPressed: null)
            : RaisedButton(child: Text("<"), onPressed: () => model.changeQuestion(-1)),
        model.questionList.length - 1 == model.questionIndex
            ? RaisedButton(
                child: Text("Finish"),
                onPressed: () {
                  _askedToLead(context, model);
                })
            : RaisedButton(child: Text(">"), onPressed: () => model.changeQuestion(1))
      ],
    );
  }

  Future<Null> _askedToLead(BuildContext context, QuestionScoped model) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    "Correct Number: ${model.correctAnswers}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "Wrong Number: ${model.wrongAnswers}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildShowButton(String answer, QuestionScoped model, String buttonNameID) {
    return InkWell(
      onTap: model.checkAnswer
          ? null
          : () {
              if (model.question.answerCorrect == buttonNameID) {
                model.correctAnswers++;
              } else {
                model.wrongAnswers++;
              }
              model.showAnswer(buttonNameID);
            },
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black54),
              borderRadius: BorderRadius.circular(10.0),
              color: buttonBackground(model, buttonNameID)),
          child: answer.length < 100
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    answer,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.memory(
                  base64.decode(answer),
                  gaplessPlayback: true,
                  height: 100.0,
                )),
    );
  }

  Color buttonBackground(QuestionScoped model, String buttonNameID) {
    if (model.checkAnswer &&
        (model.buttonID == buttonNameID || buttonNameID == model.question.answerCorrect)) {
      if (model.question.answerCorrect == buttonNameID) {
        return Colors.green[800];
      } else {
        return Colors.red[800];
      }
    } else {
      return Color(0xDD607d8b);
    }
  }
}
