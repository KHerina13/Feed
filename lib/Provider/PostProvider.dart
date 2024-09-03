import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Service/PostService.dart';
import '../Model/Post.dart';

class PostProvider with ChangeNotifier {
  List<Post> posts = [];
  final PostService postService = PostService();

  Future<void> loadPosts() async {
    List<Post> localPosts = await postService.getPostsFromLocal();
    if (localPosts.isNotEmpty) {
      posts = localPosts;
    } else {
      posts = await postService.fetchPosts();
      await postService.savePostsLocal(posts);
    }
    notifyListeners();
  }

  void markAsRead(int postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      posts[index] = Post(
        userId: posts[index].userId,
        id: posts[index].id,
        title: posts[index].title,
        body: posts[index].body,
        isRead: true, // Update isRead
      );
      notifyListeners();
    }
  }
}
