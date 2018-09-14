class Question {
  int id;
  String questionImage;
  String question;
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  String answerCorrect;

  Question.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        questionImage = parsedJson["questionImage"],
        question = parsedJson["question"],
        answerA = parsedJson["answerA"],
        answerB = parsedJson["answerB"],
        answerC = parsedJson["answerC"],
        answerD = parsedJson["answerD"],
        answerCorrect = parsedJson["answerCorrect"];
}
