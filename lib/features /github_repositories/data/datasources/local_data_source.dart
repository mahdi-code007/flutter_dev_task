import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dev_task/core/strings/const.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/models/github_repositories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';


abstract class LocalDataSource {
  Future<List<GithubRepositoriesModel>> getCachedRepos();
  Future<Unit> cacheRepos(List<GithubRepositoriesModel> reposModels);
}

class LocalDataSourceImpl implements LocalDataSource {

  final SharedPreferences sharedPreferences;


  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheRepos(List<GithubRepositoriesModel> reposModels) {
    List reposModelToJson = reposModels
        .map<Map<String, dynamic>>((reposModel) => reposModel.toJson()).toList();

    sharedPreferences.setString(CACHED_REPOS, json.encode(reposModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<GithubRepositoriesModel>> getCachedRepos() {
    final jsonString = sharedPreferences.getString(CACHED_REPOS);
    if(jsonString != null){
      List decodedJsonData = json.decode(jsonString);

      List<GithubRepositoriesModel> jsonToReposModels = decodedJsonData
          .map<GithubRepositoriesModel>((jsonReposModel)
      => GithubRepositoriesModel.fromJson(jsonReposModel)).toList();

      return Future.value(jsonToReposModels);
    }else{
      throw EmptyCacheException();
    }
  }
}