class Question {
  int id;
  String questionImage;
  String question;
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  String answerAImage;
  String answerBImage;
  String answerCImage;
  String answerDImage;
  String answerCorrect;

  Question.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        questionImage = parsedJson["questionImage"],
        question = parsedJson["question"],
        answerA = parsedJson["answerA"],
        answerB = parsedJson["answerB"],
        answerC = parsedJson["answerC"],
        answerD = parsedJson["answerD"],
        answerAImage = parsedJson["answerAImage"],
        answerBImage = parsedJson["answerBImage"],
        answerCImage = parsedJson["answerCImage"],
        answerDImage = parsedJson["answerDImage"],
        answerCorrect = parsedJson["answerCorrect"];
}
