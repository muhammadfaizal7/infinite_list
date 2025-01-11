import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list/model/post.dart';

class PostEvent {}

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostUninitialized extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded({required this.posts, required this.hasReachedMax});

  PostLoaded copyWith({List<Post>? posts, bool? hasReachedMax}) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];
}

class PostError extends PostState {
  final String message;

  PostError({required this.message});

  @override
  List<Object> get props => [message];
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostUninitialized()) {
    // Event handler for PostEvent
    on<PostEvent>((event, emit) async {
      try {
        if (state is PostUninitialized) {
          // Fetch initial posts
          final posts = await Post.connectToAPI(0, 10);
          emit(PostLoaded(posts: posts, hasReachedMax: false));
        } else if (state is PostLoaded) {
          // Fetch additional posts
          final currentState = state as PostLoaded;
          final posts = await Post.connectToAPI(currentState.posts.length, 10);
          emit(posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts, hasReachedMax: false));
        }
      } catch (error) {
        emit(PostError(message: error.toString()));
      }
    });
  }
}
