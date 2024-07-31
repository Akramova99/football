import '../models/player_selection_model.dart';
import '../models/team_model.dart';

PlayerSelectionModel convertToPlayerSelectionModel(Player player) {
  return PlayerSelectionModel(
    id: player.id,
    name: player.name,
    position: player.position,
    playerNumber: player.playerNumber,
    clubName: player.clubName,
    price: player.price,
    currentScore: player.currentScore,
    score: player.score,
    jersey: player.jersey,
  );
}

List<PlayerSelectionModel> convertPlayerListToPlayerSelectionModelList(
    List<Player> players) {
  return players
      .map((player) => convertToPlayerSelectionModel(player))
      .toList();
}
