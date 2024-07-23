import 'package:firebase_database/firebase_database.dart';

abstract class RealtimeDatabaseDataSource {
  Future<String> getCountryCode();
  Future<String> getApiKey();
  Future<Map> getDetails();
  Future<void> setCountryCode(String countryCode);
}

class RealtimeDatabaseDataSourceImpl implements RealtimeDatabaseDataSource {
  final FirebaseDatabase database;

  RealtimeDatabaseDataSourceImpl({required this.database});

  @override
  Future<String> getCountryCode() async {
    DatabaseReference ref = database.ref().child('country_code');
    DataSnapshot snapshot = await ref.get();
    return snapshot.value as String;
  }

  @override
  Future<void> setCountryCode(String countryCode) async {
    DatabaseReference ref = database.ref().child('country_code');
    await ref.set(countryCode);
  }

  @override
  Future<String> getApiKey() async {
    DatabaseReference ref = database.ref().child('api_key');
    DataSnapshot snapshot = await ref.get();
    return snapshot.value as String;
  }

  @override
  Future<Map> getDetails() async {
    DatabaseReference ref = database.ref();
    DataSnapshot snapshot = await ref.get();
    return Map<String, dynamic>.from(snapshot.value as Map);
  }
}
