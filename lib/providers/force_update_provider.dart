import 'package:hooks_riverpod/hooks_riverpod.dart'
    show StateNotifier, StateNotifierProvider;

class UpdateCheckerNotifier extends StateNotifier<bool> {
  UpdateCheckerNotifier() : super(false) {
    checkForUpdate();
  }

  // check for current update & force for update
  Future<void> checkForUpdate() async {
    await Future.delayed(Duration(seconds: 5));
    state = false;
  }

  void hide() => state = false;
}

final updateCheckerProvider =
    StateNotifierProvider<UpdateCheckerNotifier, bool>(
  (_) => UpdateCheckerNotifier(),
);
