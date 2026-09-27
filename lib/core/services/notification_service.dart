import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final SupabaseClient _supabase =
      Supabase.instance.client;

  static Future<void> sendNotification({
    required String title,
    required String body,
    String? fcmToken,
    String? topic,
    Map<String, String>? data,
  }) async {
    final Map<String, dynamic> bodyData = {
      'title': title,
      'body': body,
    };

    if (fcmToken != null && fcmToken.isNotEmpty) {
      bodyData['fcmToken'] = fcmToken;
    } else if (topic != null && topic.isNotEmpty) {
      bodyData['topic'] = topic;
    } else {
      throw Exception(
        'fcmToken or topic is required',
      );
    }

    if (data != null && data.isNotEmpty) {
      bodyData['data'] = data;
    }

    print('📤 Sending notification...');
    print('Data: $bodyData');

    final response = await _supabase.functions.invoke(
      'send-notification',
      body: bodyData,
    );

    print('📥 Status: ${response.status}');
    print('📥 Response: ${response.data}');

    if (response.status != 200) {
      throw Exception(
        response.data?['error'] ??
            response.data?['message'] ??
            'Failed to send notification',
      );
    }

    print('✅ Notification sent successfully');
  }
}