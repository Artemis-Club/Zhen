
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'dart:io';

class DBService {
  final SupabaseClient_client;

  DBService(this.SupabaseClient_client);

  Future<void> addUser() async {
    final response = await SupabaseClient_client
        .from('users')
        .insert({'username': 'johndoe', 'status': 'ONLINE'})
        .execute();

    if (response.error != null) {
      // Handle the error
    }
  }
  Future<void> getUsers() async {
    final response = await SupabaseClient_client
        .from('users')
        .select()
        .execute();


    if (response.error != null) {
      // Handle the error
    } else {
      final List<dynamic> data = response.data;
      // Work with the data
    }
  }
  Future<void> updateUser(String userId) async {
    final response = await SupabaseClient_client
        .from('users')
        .update({'status': 'OFFLINE'})
        .match({'id': userId})
        .execute();

    if (response.error != null) {
      // Handle the error
    }
  }
  Future<void> deleteUser(String userId) async {
    final response = await SupabaseClient_client
        .from('users')
        .delete()
        .match({'id': userId})
        .execute();

    if (response.error != null) {
      // Handle the error
    }
  }
  void realtimeSubscription() {
    SupabaseClient_client
        .from('users')
        .on(SupabaseEventTypes.insert, (payload) {
      // Handle real-time insert event
    })
        .subscribe();
  }
  Future<void> uploadFile(String filePath, String fileName) async {
    final file = File(filePath);
    final response = await SupabaseClient_client.storage
        .from('avatars')
        .upload(fileName, file);

    if (response.error != null) {
      // Handle error
    }
  }
  Future<String?> downloadFile(String fileName) async {
    final response = await SupabaseClient_client.storage
        .from('avatars')
        .download(fileName);

    if (response.error != null) {
        print('Error downloading file: ${response.error!.message}');
        return null;
    } else {
      final String url = response.data;
      // Use the file URL
      return url;
    }
  }
}
