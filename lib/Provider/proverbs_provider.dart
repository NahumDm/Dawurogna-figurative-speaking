import 'dart:convert';
import 'package:dawurogna_figurative_speaking/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProverbsProvider with ChangeNotifier {
  List<ProverbModel> _proverbs = [];
  bool _isLoading = false;

  //Public getter to access all proverbs to prev/next navigation
  List<ProverbModel> get allProverbs => _proverbs;

  //Public getter to check the loading state
  bool get isLoading => _isLoading;

  //Method to load proverbs from the JSON file
  Future<void> loadProverbs() async {
    if (_proverbs.isNotEmpty) return;

    _isLoading = true;
    notifyListeners(); //notify that loading has started.

    try {
      // Load JSON file from asset
      final String jsonString = await rootBundle.loadString(
        'assets/data/dawurogna_proverbs.json',
      );
      //Decode string into list of dynamic object
      final List<dynamic> jsonList = json.decode(jsonString);

      _proverbs = jsonList.map((json) => ProverbModel.fromJson(json)).toList();
    } catch (e) {
      //
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to get a filtered and sorted list of proverbs for a specific alphabet
  List<ProverbModel> getProverbsByAlphabet(String alphabet) {
    final cleanAlphabet = alphabet.trim(); //trim the input alphabet

    var filteredList =
        _proverbs
            .where(
              (proverb) =>
                  proverb.alphabet.trim().toUpperCase() ==
                  cleanAlphabet.toUpperCase(),
            )
            .toList();

    //Sort Filtered list by ID
    filteredList.sort((a, b) => a.id.compareTo(b.id));

    return filteredList;
  }

  //Method to Find Proverb by it's ID
  ProverbModel getProverbById(int id) {
    return _proverbs.firstWhere(
      (proverbs) => proverbs.id == id,
      orElse:
          () => ProverbModel(
            id: 0,
            alphabet: '',
            dawurogna: 'Not Found',
            amharicTranslation: '',
            dawurognaPhonetic: '',
          ),
    );
  }
}
