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

Player convertToPlayer(PlayerSelectionModel player) {
  return Player(
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

List<Player> convertPlayerSelectionModelListToPlayerList(List<PlayerSelectionModel> players) {
  return players.map((player) => convertToPlayer(player)).toList();
}

List<Player> combinePlayers(
    List<Player> playerList, List<PlayerSelectionModel> selectionList) {
  // Create a set to track the IDs and names of players already in the combined list
  Set<int?> playerIds = playerList.map((player) => player.id).toSet();
  Set<String?> playerNames = playerList.map((player) => player.name).toSet();

  // Create a combined list and add all players from the original list
  List<Player> combinedList = [];

  // Add players from the selection list if they don't already exist in the combined list
  for (var selection in selectionList) {
    if (!playerIds.contains(selection.id) &&
        !playerNames.contains(selection.name)) {
      combinedList.add(Player(
        id: selection.id,
        name: selection.name,
        position: selection.position,
        playerNumber: selection.playerNumber,
        clubName: selection.clubName,
        price: selection.price,
        currentScore: selection.currentScore,
        score: selection.score,
        jersey: selection.jersey,
      ));
      playerIds.add(selection.id);
      playerNames.add(selection.name);
    }
  }

  return combinedList;
}
