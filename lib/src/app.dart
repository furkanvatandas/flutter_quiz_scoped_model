import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_quiz/src/scoped_models/question_scoped.dart';
import 'package:scoped_quiz/src/screens/home.dart';

class RootOfApp extends StatelessWidget {
  final QuestionScoped questionScoped = QuestionScoped();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<QuestionScoped>(
      model: questionScoped,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) {
          questionScoped.fetchQuestions();
          return Home();
        });
        break;
    }
    return null;
  }
}
