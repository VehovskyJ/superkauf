import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_state.dart';
import 'package:superkauf/feature/post_detail/view/components/post_detail_description.dart';
import 'package:superkauf/feature/post_detail/view/components/post_detail_view_component.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_state.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';

class PostDetailScreen extends Screen {
  static const String name = ScreenPath.postDetailScreen;

  PostDetailScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _scrollController = ScrollController();
  var descriptionEdit = false;
  @override
  void initState() {
    _scrollController.addListener(_listener);
    super.initState();
  }

  void _listener() {
    scrollToRefreshListener(controller: _scrollController);
  }

  var postId = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.appTheme.colorScheme.background,
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<PostDetailBloc>().add(
                  ReloadPost(postId: postId.toString()),
                );
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                state.maybeMap(
                    success: (success) {
                      if (postId == -1) {
                        return;
                      }
                      BlocProvider.of<PostDetailBloc>(context).add(ReloadPost(
                        postId: postId.toString(),
                        wait: false,
                      ));
                    },
                    error: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.error),
                        ),
                      );
                    },
                    orElse: () {});
              },
              child: BlocBuilder<PostDetailBloc, PostDetailState>(
                builder: (context, state) {
                  return state.maybeMap(initial: (initial) {
                    return SizedBox(
                        width: constraints.maxWidth,
                        child: Column(
                          children: [
                            PostDetailViewComponent(
                              constraints: constraints,
                              post: initial.post,
                              user: initial.user,
                              onDescriptionEdit: () {},
                              canEdit: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const AppProgress(),
                          ],
                        ));
                  }, loaded: (loaded) {
                    postId = loaded.post.id;
                    return SizedBox(
                        width: constraints.maxWidth,
                        child: Column(
                          children: [
                            PostDetailViewComponent(
                              constraints: constraints,
                              post: loaded.post,
                              user: loaded.user,
                              onDescriptionEdit: () {
                                setState(() {
                                  descriptionEdit = true;
                                });
                              },
                              canEdit: loaded.canEdit,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            PostDetailDescription(
                              constraints: constraints,
                              post: loaded.post,
                              scrollController: _scrollController,
                              onDone: (newDescription) {
                                BlocProvider.of<PostBloc>(context).add(UpdatePost(
                                  postId: loaded.post.id,
                                  newDescription: newDescription,
                                ));
                                setState(() {
                                  descriptionEdit = false;
                                });
                              },
                              startEdit: descriptionEdit,
                            ),
                          ],
                        ));
                  }, error: (error) {
                    return Text(error.error);
                  }, orElse: () {
                    return const Center(child: AppProgress());
                  });
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }
}
