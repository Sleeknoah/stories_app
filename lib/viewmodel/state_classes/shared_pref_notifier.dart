import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefNotifier extends StateNotifier<bool> {
  SharedPrefNotifier({
    this.preferences,
  }) : super(preferences?.getBool('isDark') ?? false);
  final SharedPreferences? preferences;
  Future<void> changeDarkTheme(bool isDark) async {
    state = isDark;
    await preferences?.setBool('isDark', state);
  }
}
