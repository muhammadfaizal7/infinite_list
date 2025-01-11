import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  String id, title, body;

  Post({required this.id, required this.title, required this.body});

  factory Post.createPost(Map<String, dynamic> object) {
    return Post(
      id: object["id"].toString(),
      title: object["title"],
      body: object["body"],
    );
  }

  static Future<List<Post>> connectToAPI(int start, int limit) async {
    try {
      String apiURL =
          "https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit";
      var apiResult = await http.get(Uri.parse(apiURL));

      if (apiResult.statusCode == 200) {
        var jsonObject = json.decode(apiResult.body) as List;
        return jsonObject
            .map<Post>((item) => Post(
                  id: item["id"].toString(),
                  title: item["title"],
                  body: item["body"],
                ))
            .toList();
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception("Error connecting to API: $e");
    }
  }
}
