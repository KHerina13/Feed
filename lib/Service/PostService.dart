import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/Post.dart';

class PostService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse("$baseUrl/posts"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to Load Posts");
    }
  }

  Future<void> savePostsLocal(List<Post> posts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> postStrings = posts.map((post) => json.encode(post.toJson())).toList();
    await prefs.setStringList('posts', postStrings);
  }

  Future<List<Post>> getPostsFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? postStrings = prefs.getStringList('posts');
    if (postStrings != null) {
      return postStrings
          .map((postString) => Post.fromJson(json.decode(postString)))
          .toList();
    }
    return [];
  }

  Future<Post> fetchPostDetail(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post detail');
    }
  }
}
