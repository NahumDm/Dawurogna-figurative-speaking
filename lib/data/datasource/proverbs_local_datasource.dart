import 'dart:convert';

import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:flutter/services.dart';

/// Loads proverbs from bundled JSON. Replace or complement with a remote
/// datasource when sync is added.
class ProverbsLocalDataSource {
  Future<List<Proverb>> loadProverbs() async {
    final jsonString = await rootBundle.loadString(AppConstants.proverbsAssetPath);
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((item) => Proverb.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
