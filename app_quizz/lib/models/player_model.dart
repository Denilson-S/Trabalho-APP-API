class PlayerModel {
  String? name;
  String? email;
  int? score;
  int level = 0;
  int? totalQuizzes;
  int? totalQuizzesAproved;

  PlayerModel({
    this.name,
    this.email,
    this.score,
    this.totalQuizzes,
    this.totalQuizzesAproved,
  });
}