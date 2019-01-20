import 'database_model_response.dart';
import 'error_response.dart';
import 'server_model_response.dart';

/// Base class that unit all responses of CouchDB
class DbResponse {
  /// Creates instance of [DbResponse] with [raw] and [json]
  DbResponse(this.json, {this.raw});

  /// Field that contain raw body of response
  String raw;
  /// Field that contain json itself in order to grab custom fields
  Map<String, Object> json;
  /// Returns headers object
  Map<String, List<String>> get headers => (json['headers'] as Map<String, Object>)
      .map((k, e) => MapEntry<String, List<String>>(k, (e as List<Object>).map((v) => v as String).toList()));

  /// Returns response with fields that may be returned by `ServerModel` request methods
  ServerModelResponse serverModelResponse() => ServerModelResponse(
      // [ServerModel.nodeStats] returns JSON with `couchdb` field which type is Map
      couchDbMessage: json['couchdb'] is String ? json['couchdb'] as String : null,
      uuid: json['uuid'] as String,
      vendor: (json['vendor'] as Map<String, Object>)
          ?.map((k, e) => MapEntry<String, String>(k, e as String)),
      version: json['version'] as String,
      state: json['state'] as String,
      results: (json['results'] as List<Object>)
          ?.map((o) => (o as Map<String, Object>)?.map((k, e) => MapEntry<String, String>(k, e as String))
          )?.toList(),
      lastSeq: json['last_seq'] as String,
      allNodes: (json['all_nodes'] as List<Object>)?.map((v) => v as String)?.toList(),
      clusterNodes: (json['cluster_nodes'] as List<Object>)?.map((v) => v as String)?.toList(),
      history: (json['results'] as List<Object>)
          ?.map((o) => o as Map<String, Object>)?.toList(),
      ok: json['ok'] as bool,
      replicationIdVersion: json['replication_id_version'] as int,
      sessionId: json['session_id'] as String,
      sourceLastSeq: json['source_last_seq'] as int,
      offset: json['offset'] as int,
      totalRows: json['total_rows'] as int,
      id: json['id'] as String,
      database: json['database'] as String,
      docId: json['doc_id'] as String,
      pid: json['pid'] as String,
      node: json['node'] as String,
      source: json['source'] as String,
      target: json['target'] as String,
      startTime: json['start_time'] as String,
      lastUpdate: json['last_update'] as String,
      info: json['info'],
      errorCount: json['error_count'] as int,
      fabric: (json['fabric'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Map<String, Object>>>(k, (v as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)))),
      ddocCache: (json['ddoc_cache'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      couchDb: json['couchdb'] is Map ? (json['couchdb'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)) : null,
      pread: (json['pread'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      couchReplicator: (json['couch_replicator'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      mem3: (json['mem3'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Map<String, Object>>>(k, (v as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)))),
      couchLog: (json['couch_log'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Map<String, Object>>>(k, (v as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)))),
      rexi: (json['rexi'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      globalChanges: (json['global_changes'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      uptime: json['uptime'] as int,
      memory: (json['memory'] as Map<String, Object>)?.map((k, v) => MapEntry<String, int>(k, v as int)),
      runQueue: json['run_queue'] as int,
      etsTableCount: json['ets_table_count'] as int,
      contextSwitches: json['context_switches'] as int,
      reductions: json['reductions'] as int,
      garbageCollectionCount: json['garbage_collection_count'] as int,
      wordsReclaimed: json['words_reclaimed'] as int,
      ioInput: json['io_input'] as int,
      ioOutput: json['io_output'] as int,
      osProcCount: json['os_proc_count'] as int,
      staleProcCount: json['stale_proc_count'] as int,
      processCount: json['process_count'] as int,
      processLimit: json['process_limit'] as int,
      messageQueues: json['message_queues'] as Map<String, Object>,
      internalReplicationJobs: json['internal_replication_jobs'] as int,
      distribution: json['distribution'] as Map<String, Object>,
      status: json['status'] as String,
      uuids: (json['uuids'] as List<Object>)?.map((e) => e as String)?.toList(),
      list: json['list'] as List<Object>
  );

  /// Returns response with fields that may be returned by `DatabaseModel` request methods
  DatabaseModelResponse databaseModelResponse() => DatabaseModelResponse(
    cluster: (json['cluster'] as Map<String, Object>)?.map((k, v) => MapEntry<String, int>(k, v as int)),
    compactRunning: json['compact_running'] as bool,
    dbName: json['db_name'] as String,
    diskFormatVersion: json['disk_format_version'] as  int,
    docCount: json['doc_count'] as int,
    docDelCount: json['doc_del_count'] as int,
    purgeSeq: json['purge_seq'] as String,
    sizes: (json['sizes'] as Map<String, Object>)?.map((k, v) => MapEntry<String, int>(k, v as int)),
    updateSeq: json['update_seq'] as String,
    ok: json['ok'] as bool,
    id: json['id'] as String,
    rev: json['rev'] as String,
    offset: json['offset'] as int,
    rows: (json['rows'] as List<Object>)?.map((e) => e as Map<String, Object>)?.toList(),
    totalRows: json['total_rows'] as int,
    results: (json['results'] as List<Object>)
        ?.map((e) => e as Map<String, Object>)?.toList(),
    docs: (json['docs'] as List<Object>)
        ?.map((e) => e as Map<String, Object>)?.toList(),
    warning: json['warning'] as String,
    executionStats: (json['execution_stats'] as Map<String, Object>)
        ?.map((k, v) => MapEntry<String, num>(k, v as num)),
    bookmark: json['bookmark'] as String,

    list: (json['list'] as List<Object>)
        ?.map((e) => e as Map<String, Object>)?.toList(),
  );

  /// Returns error response if exists
  ErrorResponse errorResponse() => ErrorResponse(
    json['error'] as String,
    json['reason'] as String
  );

  @override
  String toString() => 
    '''
    $json
    $raw
    ''';
}