import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Model/Post.dart';
import '../../Service/PostService.dart';


class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
      ),
      body: FutureBuilder(
        future: PostService().fetchPostDetail(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error To fetch Post Detail"),
            );
          } else {
            Post post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(post.body.toString()),
            );
          }
        },
      ),
    );
  }
}
