import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserWallet {
  static final UserWallet _instance = UserWallet._internal();

  factory UserWallet() => _instance;

  UserWallet._internal();

  final ValueNotifier<int> balance = ValueNotifier(0);

  bool _isLoaded = false;

  static const String _key = 'user_points';

  Future<void> loadBalance() async {
    if (_isLoaded) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      balance.value = prefs.getInt(_key) ?? 0;
      _isLoaded = true;

      if (kDebugMode) {
        print('💰 UserWallet: loaded balance = ${balance.value}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ UserWallet: error loading balance: $e');
      }
      balance.value = 0;
      _isLoaded = true;
    }
  }

  Future<void> addPoints(int points) async {
    if (points <= 0) return;

    try {
      final oldBalance = balance.value;
      balance.value += points;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, balance.value);

      if (kDebugMode) {
        print('💰 UserWallet: added $points points ($oldBalance → ${balance.value})');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ UserWallet: error saving balance: $e');
      }
      balance.value -= points;
    }
  }

  Future<void> setBalance(int value) async {
    try {
      balance.value = value;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, value);

      if (kDebugMode) {
        print('💰 UserWallet: set balance = $value');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ UserWallet: error setting balance: $e');
      }
    }
  }

  Future<void> reset() async {
    try {
      balance.value = 0;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      _isLoaded = false;

      if (kDebugMode) {
        print('💰 UserWallet: reset');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ UserWallet: error resetting: $e');
      }
    }
  }

  int get currentBalance => balance.value;
}
