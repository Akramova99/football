import 'package:flutter/cupertino.dart';
import 'package:football/models/team_name_model.dart';

class TeamLogoWidget extends StatelessWidget {
  final TeamNamesModel team;

  const TeamLogoWidget({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Image(
        image: NetworkImage(team.logo!),
        width: 30,
        height: 30,
      ),
    );
  }
}
