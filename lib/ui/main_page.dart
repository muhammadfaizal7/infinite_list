import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/bloc/post_bloc.dart';
import 'package:infinite_list/ui/post_item.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !(context.read<PostBloc>().state as PostLoaded).hasReachedMax) {
      context.read<PostBloc>().add(PostEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Infinite List with BloC",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostUninitialized) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            } else if (state is PostLoaded) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: (state.hasReachedMax)
                      ? state.posts.length
                      : state.posts.length + 1,
                  itemBuilder: (context, index) => (index < state.posts.length)
                      ? PostItem(state.posts[index])
                      : Container(
                          child: Center(
                              child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ))));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
