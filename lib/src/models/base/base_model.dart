import '../../clients/base/couchdb_base_client.dart';

abstract class BaseModel {
  CouchDbBaseClient client;
  
  BaseModel(this.client);
}