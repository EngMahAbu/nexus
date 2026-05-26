import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

const String storageBucketId = 'nexus-main-bucket';
const String usersAvatarsDirectory = 'avatars';
const String usersCoversDirectory = 'covers';

class SupabaseManager {
  static String getPublicUrl(File file, String path) {
    return Supabase.instance.client.storage
        .from(storageBucketId)
        .getPublicUrl('$path/${file.uri.pathSegments.last}');
  }

  static Future<String> uploadFile(File file, String path) {
    return Supabase.instance.client.storage
        .from(storageBucketId)
        .upload('$path/${file.uri.pathSegments.last}', file);
  }
}
