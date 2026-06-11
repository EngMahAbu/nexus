import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:nexus/models/cloud_message.dart';

class FirebaseCloudMessagingManager {
  static late String serviceAccountCredentialsFileUri;

  static void init({required String serviceAccountCredentials}) {
    serviceAccountCredentialsFileUri = serviceAccountCredentials;
  }

  static Future<String> getAccessToken() async {
    // Load service account key
    final String response = await rootBundle.loadString(
      serviceAccountCredentialsFileUri,
    );
    final Map<String, dynamic> accountCredentials = json.decode(response);

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    AutoRefreshingAuthClient client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(accountCredentials),
      scopes,
    );

    // Obtain the access token
    AccessCredentials credentials =
        await obtainAccessCredentialsViaServiceAccount(
          ServiceAccountCredentials.fromJson(accountCredentials),
          scopes,
          client,
        );

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  static Future<Response> sendNotification({
    // required String targetDeviceToken,
    required CloudMessage message,
  }) async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    final String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/social-nexus-flutter/messages:send';

    final Response response = await post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message.toMap()),
    );

    return response;
  }
}
