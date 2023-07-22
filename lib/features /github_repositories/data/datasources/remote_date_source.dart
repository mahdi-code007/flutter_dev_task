import 'dart:convert';

import 'package:flutter_dev_task/core/strings/const.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/models/github_repositories_model.dart';
import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';

abstract class RemoteDataSource {
  Future<List<GithubRepositoriesModel>> getGitHubRepos({required int pageNumber});
}

class RemoteDataSourceImpl implements RemoteDataSource {

  final Client client;
  RemoteDataSourceImpl({required this.client});
  @override
  Future<List<GithubRepositoriesModel>> getGitHubRepos({required int pageNumber}) async {

    final response = await client.get(
      Uri.parse("${BASE_URL}users/square/repos?page=$pageNumber&per_page=150"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<GithubRepositoriesModel> reposModels = decodedJson
          .map<GithubRepositoriesModel>((jsonReposModel) => GithubRepositoriesModel.fromJson(jsonReposModel))
          .toList();
      return reposModels;
    } else {
      throw ServerException();
    }
  }
}