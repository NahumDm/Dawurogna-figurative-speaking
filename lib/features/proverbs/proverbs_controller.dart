import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/data/repositories/proverbs_repository.dart';
import 'package:flutter/foundation.dart';

class ProverbsController extends ChangeNotifier {
  ProverbsController(this._repository);

  final ProverbsRepository _repository;

  List<Proverb> get allProverbs => _repository.allProverbs;

  bool get isLoading => _repository.isLoading;

  String? get errorMessage => _repository.errorMessage;

  Future<void> loadProverbs() async {
    await _repository.loadProverbs();
    notifyListeners();
  }

  List<Proverb> getProverbsByLetter(String letter) =>
      _repository.getProverbsByLetter(letter);

  Proverb? getProverbById(String id) => _repository.getProverbById(id);
}
