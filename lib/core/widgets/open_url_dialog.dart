import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_task/core/utils/ext.dart';
import 'package:flutter_dev_task/core/widgets/bouncing_widgets.dart';

import '../../di.dart';
import '../../features /github_repositories/data/models/github_repositories_model.dart';
import '../../features /github_repositories/presentation/cubit/github_repos_cubit.dart';

class OpenUrlDialog extends StatelessWidget {
  OpenUrlDialog({super.key, required this.githubRepositoriesModel});

  final cubit = getIt<GithubReposCubit>();
  final GithubRepositoriesModel githubRepositoriesModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  children: [
                    const Text(
                      'For more details go to repository page or owner page!',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        BounceIt(
                          child: OutlinedButton(
                            onPressed: () {
                              cubit.launchUrlInBrowser(
                                  url:
                                      Uri.parse(githubRepositoriesModel.htmlUrl));
                            },
                            child: const Text('repository'),
                          ),
                        ).expanded,
                        const SizedBox(
                          width: 15,
                        ),
                        BounceIt(
                          child: OutlinedButton(
                              onPressed: () async {
                                print(githubRepositoriesModel
                                    .owner?.htmlUrl);
                                cubit.launchUrlInBrowser(
                                    url: Uri.parse(githubRepositoriesModel
                                        .owner?.htmlUrl));
                              },
                              child: const Text('owner')),
                        ).expanded,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
