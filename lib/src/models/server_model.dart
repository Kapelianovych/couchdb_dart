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

    final body = <String, List<String>>{'keys': keys};

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

  @override
  Future<DbResponse> configureCouchDb(
      {@required String action,
      String bindAdress,
      String username,
      String password,
      int port,
      int nodeCount,
      String remoteNode,
      String remoteCurrentUser,
      String remoteCurrentPassword,
      String host,
      List<String> ensureDbsExist,
      Map<String, String> headers}) async {
    DbResponse result;

    final body = <String, Object>{'action': action};

    switch (action) {
      case 'enable_single_node':
        body['bind_address'] = bindAdress;
        body['username'] = username;
        body['password'] = password;
        body['port'] = port;
        break;
      case 'enable_cluster':
        body['bind_address'] = bindAdress;
        body['username'] = username;
        body['password'] = password;
        body['port'] = port;
        body['node_count'] = nodeCount;
        body['remote_node'] = remoteNode;
        body['remote_current_user'] = remoteCurrentUser;
        body['remote_current_password'] = remoteCurrentPassword;
        break;
      case 'add_node':
        body['username'] = username;
        body['password'] = password;
        body['port'] = port;
        body['host'] = host;
        break;
      default:
    }

    if (ensureDbsExist != null) {
      body['ensure_dbs_exist'] = ensureDbsExist;
    }

    try {
      result =
          await client.post('_cluster_setup', reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> dbUpdates(
      {String feed = 'normal',
      int timeout = 60,
      int heartbeat = 60000,
      String since,
      Map<String, String> headers}) async {
    DbResponse result;

    String path;

    feed == 'longpoll' || feed == 'continuous' || feed == 'eventsource'
        ? path =
            '_db_updates?feed=$feed&timeout=$timeout&heartbeat=$heartbeat&${includeNonNullParam('since', since)}'
        : path =
            '_db_updates?feed=$feed&timeout=$timeout&${includeNonNullParam('since', since)}';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> membership({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_membership', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> replicate(
      {bool cancel,
      bool continuous,
      bool createTarget,
      List<String> docIds,
      String filterFunJS,
      String proxy,
      Object source,
      Object target,
      Map<String, String> headers}) async {
    DbResponse result;
    final body = <String, Object>{};

    if (cancel != null) {
      body['cancel'] = cancel;
    }
    if (continuous != null) {
      body['continuous'] = continuous;
    }
    if (createTarget != null) {
      body['create_target'] = createTarget;
    }
    if (docIds != null) {
      body['doc_ids'] = docIds;
    }
    if (filterFunJS != null) {
      body['filter'] = filterFunJS;
    }
    if (proxy != null) {
      body['proxy'] = proxy;
    }
    if (source != null) {
      body['source'] = source;
    }
    if (target != null) {
      body['target'] = target;
    }

    try {
      result = await client.post('_replicate', reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  Future<String> schedulerJobs({int limit, int skip}) async {}

  Future<String> schedulerDocs({int limit, int skip}) async {}

  Future<String> schedulerDocsWithReplicatiorDbName(
      {@required String replicator, int limit, int skip}) async {}

  Future<String> schedulerDocsWithDocId(
      String replicator, String docId) async {}

  Future<String> nodeStats({String nodeName = '_local'}) async {}

  Future<String> systemStatsForNode({String nodeName = '_local'}) async {}
  // _utils will be soon
  Future<String> up() async {}

  Future<List<String>> uuids({int count = 1}) async {}
  // favicon ?
}
