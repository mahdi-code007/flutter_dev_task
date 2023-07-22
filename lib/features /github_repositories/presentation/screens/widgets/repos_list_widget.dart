import 'package:flutter/material.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/models/github_repositories_model.dart';


class ReposListWidget extends StatelessWidget {
  final List<GithubRepositoriesModel> repos;
  const ReposListWidget({
    Key? key,
    required this.repos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: repos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(repos[index].owner?.login ,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          title: Text(
            repos[index].name!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            repos[index].description ?? 'No Description',
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          tileColor: repos[index].fork == false ? Colors.lightGreen : Colors.white,
          onTap: () {

          },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}