import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final SupabaseClient _supabase =
      Supabase.instance.client;

  static Future<void> sendNotification({
    required String title,
    required String body,
    String? fcmToken,
    String? topic,
  }) async {
    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
    };

    if (fcmToken != null && fcmToken.isNotEmpty) {
      data['fcmToken'] = fcmToken;
    } else if (topic != null && topic.isNotEmpty) {
      data['topic'] = topic;
    } else {
      throw Exception(
        'fcmToken or topic is required',
      );
    }

    print('📤 Sending notification...');
    print('Data: $data');

    final response = await _supabase.functions.invoke(
      'send-notification',
      body: data,
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