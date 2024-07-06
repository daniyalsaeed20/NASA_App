import 'package:http/http.dart' as http;

class NasaServices{
  final String _apiKey = 'iLLZXzsurYA8ixWzAZ3mFzkUx75h6hy0Ya3dHKIl';

  // Future<List>
   fetchApods({int count = 10}) async {
    final response = await http.get(Uri.parse('https://api.nasa.gov/planetary/apod?api_key=$_apiKey&count=$count'));
    return response;
  }
}