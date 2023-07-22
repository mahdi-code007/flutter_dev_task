import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_task/features%20/github_repositories/data/models/github_repositories_model.dart';
import 'package:flutter_dev_task/features%20/github_repositories/presentation/cubit/github_repos_cubit.dart';

import '../../../../../core/widgets/open_url_dialog.dart';
import '../../../../../di.dart';

class ReposListWidget extends StatelessWidget {
  final List<GithubRepositoriesModel> repos;

  const ReposListWidget({Key? key, required this.repos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: getIt<GithubReposCubit>(),
      builder: (context, state) {
        return ListView.separated(
          itemCount: repos.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(repos[index].owner?.login,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              title: Text(
                repos[index].name!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                repos[index].description ?? 'No Description',
                style: const TextStyle(fontSize: 16),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              tileColor:
                  repos[index].fork == false ? Colors.lightGreen : Colors.white,
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => OpenUrlDialog(
                    githubRepositoriesModel: repos[index],
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(thickness: 1),
        );
      },
    );
  }
}
