part of 'github_repos_cubit.dart';


abstract class GithubReposState {}

class GithubReposInitial extends GithubReposState {}


class LoadingReposState extends GithubReposInitial {
}

class LoadedReposState extends GithubReposInitial {
  final List<GithubRepositoriesModel> reposList;

  LoadedReposState({required this.reposList});

}

class ErrorReposState extends GithubReposInitial {
  final String message;


  ErrorReposState({required this.message});

}