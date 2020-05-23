import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';

/// Init search of repos
class SearchRepos extends Change<List<Repo>> {
  final String text;

  SearchRepos(this.text);
}

class ToggleFavorite extends Change<Repo> {
  final Repo repo;
  final isFavorite;

  ToggleFavorite(this.repo, this.isFavorite);
}

class GetFavorites extends Change<List<Repo>> {}

class FavoriteCountChanges extends Change<int>{}