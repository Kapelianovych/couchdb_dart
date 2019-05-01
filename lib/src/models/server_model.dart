import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../entities/db_response.dart';
import '../entities/server_model_response.dart';
import '../exceptions/couchdb_exception.dart';
// import '../utils/browser_runner.dart';
import '../utils/includer_path.dart';
import 'base/server_base_model.dart';

/// Server interface provides the basic interface to a CouchDB server
/// for obtaining CouchDB information and getting and setting configuration information
class ServerModel extends ServerBaseModel {
  /// Create ServerModel by accepting web-based or server-based client
  ServerModel(CouchDbClient client) : super(client);

  @override
  Future<ServerModelResponse> couchDbInfo({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> activeTasks({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_active_tasks', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> allDbs({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_all_dbs', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> dbsInfo(List<String> keys) async {
    DbResponse result;

    final body = <String, List<String>>{'keys': keys};

    try {
      result = await client.post('_dbs_info', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> clusterSetupStatus(
      {List<String> ensureDbsExist, Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get(
          '_cluster_setup?${includeNonNullParam('ensure_dbs_exist', ensureDbsExist)}',
          reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> configureCouchDb(
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
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> dbUpdates(
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
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> membership({Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_membership', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> replicate(
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
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> schedulerJobs({int limit, int skip}) async {
    DbResponse result;

    try {
      result = await client.get(
          '_scheduler/jobs?${includeNonNullParam('limit', limit)}&${includeNonNullParam('skip', skip)}');
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> schedulerDocs({int limit, int skip}) async {
    DbResponse result;

    try {
      result = await client.get(
          '_scheduler/docs?${includeNonNullParam('limit', limit)}&${includeNonNullParam('skip', skip)}');
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> schedulerDocsWithReplicatorDbName(
      {String replicator = '_replicator', int limit, int skip}) async {
    DbResponse result;

    try {
      result = await client.get(
          '_scheduler/docs/$replicator?${includeNonNullParam('limit', limit)}&${includeNonNullParam('skip', skip)}');
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> schedulerDocsWithDocId(String docId,
      {String replicator = '_replicator'}) async {
    DbResponse result;

    try {
      result = await client.get('_scheduler/docs/$replicator/$docId');
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> nodeStats(
      {String nodeName = '_local',
      String statisticSection,
      String statisticId,
      Map<String, String> headers}) async {
    DbResponse result;

    final path = statisticSection != null && statisticId != null
        ? '_node/$nodeName/_stats/$statisticSection/$statisticId'
        : '_node/$nodeName/_stats';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> systemStatsForNode(
      {String nodeName = '_local', Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_node/$nodeName/_system', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  // @override
  // Future<void> utils() async {
  //   await BrowserRunner('${client.connectUri}/_utils/').run();
  // }

  @override
  Future<ServerModelResponse> up() async {
    DbResponse result;

    try {
      result = await client.get('_up');
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  @override
  Future<ServerModelResponse> uuids(
      {int count = 1, Map<String, String> headers}) async {
    DbResponse result;

    try {
      result = await client.get('_uuids?count=$count', reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.serverModelResponse();
  }

  // @override
  // Future<DbResponse> favicon() async {
  //   DbResponse result;

  //   try {
  //     result = await client.get('favicon.ico');
  //   } on CouchDbException {
  //     rethrow;
  //   }
  //   return result;
  // }
}
