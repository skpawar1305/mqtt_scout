import '../models/broker_profile.dart';

abstract class BrokerRepository {
  Future<List<BrokerProfile>> getAllProfiles();
  Future<BrokerProfile?> getProfileById(String id);
  Future<void> saveProfile(BrokerProfile profile);
  Future<void> deleteProfile(String id);
  Future<BrokerProfile?> getLastConnectedProfile();
  Future<void> setLastConnectedProfile(String id);
}