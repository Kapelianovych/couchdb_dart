import 'package:meta/meta.dart';

import 'interfaces/client_interface.dart';
import 'interfaces/server_interface.dart';
import 'responses/api_response.dart';
import 'responses/server_response.dart';
import 'utils/includer_path.dart';

/// Server interface provides the basic interface to a CouchDB server
/// for obtaining CouchDB information and getting and setting configuration information
class Server implements ServerInterface {
  /// Instance of connected client
  final ClientInterface _client;

  /// Create Server by accepting web-based or server-based client
  Server(this._client);

  @override
  Future<ServerResponse> activeTasks({Map<String, String> headers}) async {
    ApiResponse result =
        await _client.get('_active_tasks', reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> allDbs({Map<String, String> headers}) async {
    ApiResponse result = await _client.get('_all_dbs', reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> dbsInfo(List<String> keys) async {
    final body = <String, List<String>>{'keys': keys};

    ApiResponse result = await _client.post('_dbs_info', body: body);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> clusterSetupStatus(
      {List<String> ensureDbsExist, Map<String, String> headers}) async {
    ApiResponse result = await _client.get(
        '_cluster_setup?${includeNonNullParam('ensure_dbs_exist', ensureDbsExist)}',
        reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> configureCouchDb(
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
    }

    if (ensureDbsExist != null) {
      body['ensure_dbs_exist'] = ensureDbsExist;
    }

    ApiResponse result =
        await _client.post('_cluster_setup', reqHeaders: headers, body: body);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> couchDbInfo({Map<String, String> headers}) async {
    ApiResponse result = await _client.get('', reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> dbUpdates(
      {String feed = 'normal',
      int timeout = 60,
      int heartbeat = 60000,
      String since,
      Map<String, String> headers}) async {
    String path;

    feed == 'longpoll' || feed == 'continuous' || feed == 'eventsource'
        ? path =
            '_db_updates?feed=$feed&timeout=$timeout&heartbeat=$heartbeat&${includeNonNullParam('since', since)}'
        : path =
            '_db_updates?feed=$feed&timeout=$timeout&${includeNonNullParam('since', since)}';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> membership({Map<String, String> headers}) async {
    ApiResponse result = await _client.get('_membership', reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> nodeStats(
      {String nodeName = '_local',
        String statisticSection,
        String statisticId,
        Map<String, String> headers}) async {
    final path = statisticSection != null && statisticId != null
        ? '_node/$nodeName/_stats/$statisticSection/$statisticId'
        : '_node/$nodeName/_stats';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> replicate(
      {bool cancel,
      bool continuous,
      bool createTarget,
      List<String> docIds,
      String filterFunJS,
      String proxy,
      Object source,
      Object target,
      Map<String, String> headers}) async {
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

    ApiResponse result =
        await _client.post('_replicate', reqHeaders: headers, body: body);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> schedulerJobs({int limit, int skip}) async {
    ApiResponse result = await _client.get(
        '_scheduler/jobs?${includeNonNullParam('limit', limit)}&${includeNonNullParam('skip', skip)}');
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> schedulerDocs({int limit, int skip}) async {
    ApiResponse result = await _client.get(
        '_scheduler/docs?${includeNonNullParam('limit', limit)}&${includeNonNullParam('skip', skip)}');
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> schedulerDocsWithReplicatorDbName(
      {String replicator = '_replicator', int limit, int skip}) async {
    ApiResponse result = await _client.get(
        '_scheduler/docs/$replicator?${includeNonNullParam('limit', limit)}&${includeNonNullParam('skip', skip)}');
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> schedulerDocsWithDocId(String docId,
      {String replicator = '_replicator'}) async {
    ApiResponse result =
        await _client.get('_scheduler/docs/$replicator/$docId');
    return ServerResponse.from(result);
  }


  @override
  Future<ServerResponse> systemStatsForNode(
      {String nodeName = '_local', Map<String, String> headers}) async {
    ApiResponse result =
        await _client.get('_node/$nodeName/_system', reqHeaders: headers);
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> up() async {
    ApiResponse result = await _client.get('_up');
    return ServerResponse.from(result);
  }

  @override
  Future<ServerResponse> uuids(
      {int count = 1, Map<String, String> headers}) async {
    ApiResponse result =
        await _client.get('_uuids?count=$count', reqHeaders: headers);
    return ServerResponse.from(result);
  }
}
