import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_task/features%20/github_repositories/presentation/screens/widgets/message_display_widget.dart';
import 'package:flutter_dev_task/features%20/github_repositories/presentation/screens/widgets/repos_list_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../di.dart' as di;
import '../cubit/github_repos_cubit.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<GithubReposCubit>()..calGithubRepos(pageNumber: 1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Github Repositories'),
          centerTitle: true,
        ),
        body: _buildBody()
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<GithubReposCubit, GithubReposState>(
        builder: (context, state) {
          if (state is LoadingReposState) {
            return const LoadingWidget();
          } else if (state is LoadedReposState) {
            return ReposListWidget(repos: state.reposList);
          } else if (state is ErrorReposState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
