import 'database_response.dart';
import 'design_document_response.dart';
import 'document_response.dart';
import 'error_response.dart';
import 'local_document_response.dart';
import 'server_response.dart';

/// Base class that unit all responses of CouchDB
class Response {
  /// Creates instance of [Response] with [raw] and [json]
  Response(this.json, {this.headers, this.raw});

  /// Field that contain raw body of response
  final String raw;

  /// Field that contain json itself in order to grab custom fields
  final Map<String, Object> json;

  /// Headers of response
  final Map<String, String> headers;

  /// Returns response with fields that may be returned by `Server`
  /// request methods
  ServerResponse serverResponse() => ServerResponse(
      // [Server.nodeStats] returns JSON with `couchdb` field
      // which type is Map
      couchDbMessage:
          json['couchdb'] is String ? json['couchdb'] as String : null,
      uuid: json['uuid'] as String,
      vendor: (json['vendor'] as Map<String, Object>)
          ?.map((k, e) => MapEntry<String, String>(k, e as String)),
      version: json['version'] as String,
      state: json['state'] as String,
      results: (json['results'] as List<Object>)
          ?.map((o) => (o as Map<String, Object>)
              ?.map((k, e) => MapEntry<String, String>(k, e as String)))
          ?.toList(),
      lastSeq: json['last_seq'] as String,
      allNodes: (json['all_nodes'] as List<Object>)
          ?.map((v) => v as String)
          ?.toList(),
      clusterNodes: (json['cluster_nodes'] as List<Object>)
          ?.map((v) => v as String)
          ?.toList(),
      history: (json['results'] as List<Object>)
          ?.map((o) => o as Map<String, Object>)
          ?.toList(),
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
      fabric: (json['fabric'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Map<String, Object>>>(
              k,
              (v as Map<String, Object>)?.map(
                  (k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)))),
      ddocCache: (json['ddoc_cache'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      couchDb: json['couchdb'] is Map ? (json['couchdb'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)) : null,
      pread: (json['pread'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      couchReplicator: (json['couch_replicator'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      mem3: (json['mem3'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Map<String, Object>>>(k, (v as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)))),
      couchLog: (json['couch_log'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Map<String, Object>>>(k, (v as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)))),
      rexi: (json['rexi'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      globalChanges: (json['global_changes'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
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
      list: json['list'] as List<Object>,
      name: json['name'] as String,
      roles: (json['roles'] as List<Object>)?.map((v) => v as String)?.toList(),
      userCtx: json['userCtx'] as Map<String, Object>);

  /// Returns response with fields that may be returned by `Database`
  /// request methods
  DatabaseResponse databaseResponse() => DatabaseResponse(
      cluster: (json['cluster'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, int>(k, v as int)),
      compactRunning: json['compact_running'] as bool,
      dbName: (json['db_name'] ?? json['dbname']) as String,
      diskFormatVersion: json['disk_format_version'] as int,
      docCount: json['doc_count'] as int,
      docDelCount: json['doc_del_count'] as int,
      purgeSeq: json['purge_seq'] as String,
      sizes: (json['sizes'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, int>(k, v as int)),
      updateSeq: json['update_seq'] as String,
      ok: json['ok'] as bool,
      id: json['id'] as String,
      rev: json['rev'] as String,
      offset: json['offset'] as int,
      rows: (json['rows'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      totalRows: json['total_rows'] as int,
      results: (json['results'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      docs: (json['docs'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      warning: json['warning'] as String,
      executionStats: (json['execution_stats'] as Map<String, Object>)
          ?.map((k, v) => MapEntry<String, num>(k, v as num)),
      bookmark: json['bookmark'] as String,
      result: json['result'] as String,
      name: json['name'] as String,
      indexes: (json['indexes'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      index: json['index'] as Map<String, Object>,
      selector: (json['selector'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      opts: json['opts'] as Map<String, Object>,
      limit: json['limit'] as int,
      skip: json['skip'] as int,
      fields: json['fields'] is String ? <String>[json['fields'] as String] : (json['fields'] as List<Object>)?.map((e) => e as String)?.toList(),
      range: json['range'] is Map<String, Object> ? (json['range'] as Map<String, Object>)?.map((k, v) => MapEntry(k, v as List<Object>)) : null,
      lastSeq: json['last_seq'] as String,
      pending: json['pending'] as int,
      admins: (json['admins'] as Map<String, Object>)?.map((k, v) => MapEntry<String, List<String>>(k, (v as List<Object>)?.map((e) => e as String)?.toList())),
      members: (json['members'] as Map<String, Object>)?.map((k, v) => MapEntry<String, List<String>>(k, (v as List<Object>)?.map((e) => e as String)?.toList())),
      purged: (json['purged'] as Map<String, Object>)?.map((k, v) => MapEntry<String, Map<String, List<String>>>(k, (v as Map<String, Object>)?.map((k, v) => MapEntry<String, List<String>>(k, (v as List<Object>)?.map((e) => e as String)?.toList())))),
      missedRevs: (json['missed_revs'] as Map<String, Object>)?.map((k, v) => MapEntry<String, List<String>>(k, (v as List<Object>)?.map((e) => e as String)?.toList())),
      revsDiff: json.keys.every(RegExp('[a-z0-9-]{32,36}').hasMatch) ? json?.map((k, v) => MapEntry<String, Map<String, List<String>>>(k, (v as Map<String, Object>)?.map((k, v) => MapEntry<String, List<String>>(k, (v as List<Object>)?.map((e) => e as String)?.toList())))) : null,
      list: (json['list'] as List<Object>)?.map((e) => e as Map<String, Object>)?.toList(),
      shards: (json['shards'] as Map<String, Object>)?.map((k, v) => MapEntry<String, List<String>>(k, (v as List<Object>)?.map((v) => v as String)?.toList())),
      shardRange: json['range'] is String ? json['range'] as String : null,
      nodes: (json['nodes'] as List<Object>)?.map((v) => v as String)?.toList());

  /// Returns response with fields that may be returned by `Document`
  /// request methods
  DocumentResponse documentResponse() => DocumentResponse(
      doc: json,
      ok: json['ok'] as bool,
      id: (json['_id'] ?? json['id']) as String,
      rev: (json['_rev'] ?? json['rev']) as String,
      attachment: json['_attachments'] ?? raw,
      conflicts: (json['_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      deleted: json['_deleted'] as bool,
      deletedConflicts: (json['_deleted_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      localSeq: json['_local_seq'] as String,
      revsInfo: (json['_revs_info'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      revisions: json['_revisions'] as Map<String, Object>);

  /// Returns response with fields that may be returned by
  /// `DesignDocument` request methods
  DesignDocumentResponse designDocumentResponse() => DesignDocumentResponse(
      ddoc: json,
      ok: json['ok'] as bool,
      id: (json['_id'] ?? json['id']) as String,
      rev: (json['_rev'] ?? json['rev']) as String,
      attachment: json['_attachments'] ?? raw,
      conflicts: (json['_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      deleted: json['_deleted'] as bool,
      deletedConflicts: (json['_deleted_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      localSeq: json['_local_seq'] as String,
      revsInfo: (json['_revs_info'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      revisions: json['_revisions'] as Map<String, Object>,
      name: json['name'] as String,
      viewIndex: json['view_index'] as Map<String, Object>,
      offset: json['offset'] as int,
      rows: (json['rows'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      totalRows: json['total_rows'] as int,
      updateSeq: json['update_seq'] as String,
      results: (json['results'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      status: json['status'] as String,
      raw: raw);

  /// Returns response with fields that may be returned by
  /// `LocalDocument` request methods
  LocalDocumentResponse localDocumentResponse() => LocalDocumentResponse(
      offset: json['offset'] as int,
      rows: (json['rows'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      totalRows: json['total_rows'] as int,
      updateSeq: json['update_seq'] as String,
      doc: json,
      ok: json['ok'] as bool,
      id: (json['_id'] ?? json['id']) as String,
      rev: (json['_rev'] ?? json['rev']) as String,
      attachment: json['_attachments'] ?? raw,
      conflicts: (json['_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      deleted: json['_deleted'] as bool,
      deletedConflicts: (json['_deleted_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      localSeq: json['_local_seq'] as String,
      revsInfo: (json['_revs_info'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      revisions: json['_revisions'] as Map<String, Object>);

  /// Returns error response if exists, otherwise return `null`
  ErrorResponse errorResponse() {
    ErrorResponse e;
    if (isError()) {
      e = ErrorResponse(json['error'] as String, json['reason'] as String);
    }
    return e;
  }

  /// Check if this response is error
  bool isError() => json['error'] != null;

  @override
  String toString() => '''
    json - $json
    raw - $raw
    ''';
}
