import 'package:isar/isar.dart';

part 'player_model.g.dart';

@collection
class PlayerModel {
  Id id = 0;
  String? name;
  String? email;
  int? score;
  int? totalQuizzes;

  PlayerModel({
    this.name,
    this.email,
    this.score,
    this.totalQuizzes,
  });
}