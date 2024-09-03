import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/Post.dart';
import '../../Provider/PostProvider.dart';
import '../Widget/TimerIcon.dart';
import 'PostDetail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder<void>(
        future: postProvider.loadPosts(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              final Post post = postProvider.posts[index];
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: TimerIcon(),
                  tileColor:
                      post.isRead == false ? Colors.yellow[200] : Colors.white,
                  // Ensure you have this widget implemented
                  onTap: () {
                    postProvider.markAsRead(post.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(postId: post.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
