import '../../couchdb_client.dart';

abstract class BaseModel {
  CouchDbClient _client;
  
  BaseModel(this._client);
}