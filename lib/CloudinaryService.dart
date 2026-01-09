import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = "dmutuxahc";
  final String apiKey = "657992736165113";
  final String apiSecret = "lO_P04mZpuBdw_tNdoHz_O5YO08";

  Future<String?> uploadImage(File imageFile) async {
    try {
      final String uploadUrl = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['upload_preset'] = 'unsigned_preset'
        ..fields['api_key'] = apiKey
        ..fields['folder'] = 'Users'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['secure_url'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
