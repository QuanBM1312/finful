import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../core.dart';
import '../entity/entity.dart';

abstract class BaseLocal<T extends BaseEntity> {
  final Mapper<T>? _mapper;
  final SharedPreferences prefs;
  int lastUpdatedTime = 0;
  int? expiredTimeInMinute;

  BaseLocal({
    required Mapper<T>? mapper,
    required this.prefs,
    this.expiredTimeInMinute = 5,
  }) : _mapper = mapper;

  bool get _isExpired {
    if (expiredTimeInMinute == null) {
      return true;
    }

    final lastUpdatedTimeStamp = lastUpdated();
    final passedTime = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastUpdatedTimeStamp))
        .inMinutes;

    return passedTime > expiredTimeInMinute!;
  }

  Future<void> saveList(List<T> list, String key) async {
    try {
      await prefs.setString(
          key, json.encode(list.map((i) => i.toJson()).toList()));

      lastUpdatedTime = DateTime.now().millisecondsSinceEpoch;
      await prefs.setInt(_lastUpdatedKey, lastUpdatedTime);
    } catch (e) {
      logger().error('***saveList---${T.toString()} error: $e');
    }
  }

  List<T>? getList(String key) {
    if (_mapper == null || (_mapper.parse == null) ||
        _isExpired) {
      return null;
    }

    try {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final dic = List<Map<String, dynamic>>.from(json.decode(jsonString));
        if (dic.isEmpty) {
          return <T>[];
        }

        final items = dic.map(_mapper.parse!).toList();
        return items;
      }

      return null;
    } catch (e) {
      logger().error('***getList---Parse json ${T.toString()} error: $e');
      return null;
    }
  }

  Future<void> saveItem(T item, String key) async {
    try {
      await prefs.setString(key, json.encode(item.toJson()));
    } catch (e) {
      logger().error('***saveItem---${T.toString()} error: $e');
    }
  }

  T? getItem(String key) {
    if (_mapper == null || (_mapper.parse == null)) {
      return null;
    }

    try {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final dic = Map<String, dynamic>.from(json.decode(jsonString));
        if (dic.isEmpty) {
          return null;
        }

        if (_mapper.parse != null) {
          return _mapper.parse!(dic);
        }

        return null;
      }

      return null;
    } catch (e) {
      logger().error('***getItem---Parse json ${T.toString()} error: $e');
      return null;
    }
  }

  Future<void> clearObjectOrEntity(String key) async {
    try {
      await prefs.remove(key);
    } catch (e) {
      logger().error('***clearObjectOrEntity---$key error: $e');
    }
  }

  Future<void> saveEntity<S extends BaseEntity>(
      S entity,
      String key,
      ) async {
    try {
      await prefs.setString(key, json.encode(entity.toJson()));
    } catch (e) {
      logger().error('***saveEntity---${T.toString()} error: $e');
    }
  }

  S? getEntity<S extends BaseEntity>(
      String key, {
        required Mapper<S>? mapper,
      }) {
    if (mapper == null) {
      return null;
    }

    try {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final dic = Map<String, dynamic>.from(json.decode(jsonString));
        if (dic.isEmpty) {
          return null;
        }

        if (mapper.parse != null) {
          return mapper.parse!(dic);
        }

        return null;
      }

      return null;
    } catch (e) {
      logger().error('***getEntity---Parse json ${T.toString()} error: $e');
      return null;
    }
  }

  Future<void> saveString(String value, String key) async {
    try {
      await prefs.setString(key, value);
    } catch (e) {
      logger().error('***saveString---$key error: $e');
    }
  }

  String? getString(String key) {
    try {
      return prefs.getString(key);
    } catch (e) {
      logger().error('***getString---$key error: $e');
      return null;
    }
  }

  Future<void> saveInteger(int value, String key) async {
    try {
      await prefs.setInt(key, value);
    } catch (e) {
      logger().error('***saveInteger---$key error: $e');
    }
  }

  int? getInteger(String key) {
    try {
      return prefs.getInt(key);
    } catch (e) {
      logger().error('***getInteger---$key error: $e');
      return null;
    }
  }

  Future<void> saveBoolean(bool value, String key) async {
    try {
      await prefs.setBool(key, value);
    } catch (e) {
      logger().error('***saveBoolean---$key error: $e');
    }
  }

  bool? getBoolean(String key) {
    try {
      return prefs.getBool(key);
    } catch (e) {
      logger().error('***getBoolean---$key error: $e');
      return null;
    }
  }

  @override
  String toString() => 'BaseLocalDataSource';

  String get _lastUpdatedKey => 'key_${toString()}_last_update';

  int lastUpdated() {
    if (lastUpdatedTime > 0) {
      return lastUpdatedTime;
    }

    final updatedTime = prefs.getInt(_lastUpdatedKey);
    if (updatedTime != null) {
      lastUpdatedTime = updatedTime;
    }

    return lastUpdatedTime;
  }
}
