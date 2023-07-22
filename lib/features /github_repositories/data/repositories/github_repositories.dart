import 'package:dartz/dartz.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/models/github_repositories_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_date_source.dart';

abstract class GithubRepository {
  Future<Either<Failure, List<GithubRepositoriesModel>>> getGithubRepos({required int pageNumber});
}

class GithubRepositoryImpl extends GithubRepository{
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GithubRepositoryImpl(
      {required this.remoteDataSource,required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<GithubRepositoriesModel>>> getGithubRepos({required int pageNumber}) async {
    if(await networkInfo.isConnected){
      try{
        final remoteRepos = await remoteDataSource.getGitHubRepos(pageNumber: pageNumber);
        localDataSource.cacheRepos(remoteRepos);
        print('remote Repos length = ${remoteRepos.length}');
        print(remoteRepos.first.name);
        // print(remoteRepos.toString());
        return Right(remoteRepos);
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final localRepos = await localDataSource.getCachedRepos();
        print('local Repos length  = ${localRepos.length}');
        return Right(localRepos);
      } on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }

    }
  }


}