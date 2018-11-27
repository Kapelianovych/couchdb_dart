import 'package:meta/meta.dart';

import '../clients/base/couchdb_base_client.dart';
import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'base/server_base_model.dart';

/// Server interface provides the basic interface to a CouchDB server
/// for obtaining CouchDB information and getting and setting configuration information
class ServerModel extends ServerBaseModel {
  /// Create ServerModel by accepting web-based or server-based client
  ServerModel(CouchDbBaseClient client) : super(client);

  @override
  Future<DbResponse> couchDbInfo({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> activeTasks({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_active_tasks', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> allDbs({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_all_dbs', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> dbsInfo(List<String> keys) async {
    DbResponse result;

    final body = <String, List<String>>{
      'keys': keys
    };

    try {
      result = await client.post('_dbs_info', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> getClusterSetup(
      {List<String> ensureDbsExist, Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get(
        '_cluster_setup?${includeNonNullParam('ensure_dbs_exist', ensureDbsExist)}',
        reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  // Cluster setup API with POST will be soon
  Future<List<String>> dbUpdates(
      {String feed = 'normal',
      int timeout = 60,
      int heartbeat = 60000,
      String since}) async {

      }

  Future<String> membership() async {

  }

  Future<String> replicate(
      {bool cancel,
      bool continuous,
      bool createTarget,
      List<String> docIds,
      String filterFunJS,
      String proxy,
      Object source,
      Object target}) async {

      }

  Future<String> schedulerJobs({int limit, int skip}) async {

  }

  Future<String> schedulerDocs({int limit, int skip}) async {

  }

  Future<String> schedulerDocsWithReplicatiorDbName(
      {@required String replicator, int limit, int skip}) async {

      }

  Future<String> schedulerDocsWithDocId(String replicator, String docId) async {

  }

  Future<String> nodeStats({String nodeName = '_local'}) async {

  }

  Future<String> systemStatsForNode({String nodeName = '_local'}) async {

  }
  // _utils will be soon
  Future<String> up() async {

  }

  Future<List<String>> uuids({int count = 1}) async {

  }
  // favicon ?
}