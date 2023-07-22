import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/models/github_repositories_model.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/repositories/github_repositories.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
part 'github_repos_state.dart';

class GithubReposCubit extends Cubit<GithubReposState> {
  GithubReposCubit({required this.repository}) : super(GithubReposInitial());

  final GithubRepository repository;

  void calGithubRepos({required int pageNumber}) async {
    emit(LoadingReposState());
    final failureOrRepos = await repository.getGithubRepos(pageNumber: pageNumber);
    emit(_mapFailureOrPostsToState(failureOrRepos));
  }

  GithubReposState _mapFailureOrPostsToState(Either<Failure, List<GithubRepositoriesModel>> either) {
    return either.fold(
            (failure) {
              // print(failure.toString());
              return ErrorReposState(message: _mapFailureToMessage(failure));
            },
            (repos) {
          // print(repos.toString());
          return LoadedReposState(
            reposList: repos,
          );
        }
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
