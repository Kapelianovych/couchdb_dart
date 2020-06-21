import 'package:couchdb/couchdb.dart';

import '../server.dart';

/// Class that contains responses from `Server` class
class ServerResponse {
  /// Creates instance of [ServerResponse]
  ServerResponse({this.couchDbMessage,
    this.uuid,
    this.vendor,
    this.version,
    this.state,
    this.results,
    this.lastSeq,
    this.allNodes,
    this.clusterNodes,
    this.history,
    this.ok,
    this.replicationIdVersion,
    this.sessionId,
    this.sourceLastSeq,
    this.offset,
    this.totalRows,
    this.id,
    this.database,
    this.docId,
    this.pid,
    this.node,
    this.source,
    this.target,
    this.startTime,
    this.lastUpdate,
    this.info,
    this.errorCount,
    this.fabric,
    this.ddocCache,
    this.couchDb,
    this.pread,
    this.couchReplicator,
    this.mem3,
    this.couchLog,
    this.rexi,
    this.globalChanges,
    this.uptime,
    this.memory,
    this.runQueue,
    this.etsTableCount,
    this.contextSwitches,
    this.reductions,
    this.garbageCollectionCount,
    this.wordsReclaimed,
    this.ioInput,
    this.ioOutput,
    this.osProcCount,
    this.staleProcCount,
    this.processCount,
    this.processLimit,
    this.messageQueues,
    this.internalReplicationJobs,
    this.distribution,
    this.status,
    this.uuids,
    this.list,
    this.name,
    this.roles,
    this.userCtx});

  ServerResponse.from(ApiResponse response) : this(
    // [Server.nodeStats] returns JSON with `couchdb` field
    // which type is Map
      couchDbMessage:
      response.json['couchdb'] is String
          ? response.json['couchdb'] as String
          : null,
      uuid: response.json['uuid'] as String,
      vendor: (response.json['vendor'] as Map<String, Object>)
          ?.map((k, e) => MapEntry<String, String>(k, e as String)),
      version: response.json['version'] as String,
      state: response.json['state'] as String,
      results: (response.json['results'] as List<Object>)
          ?.map((o) =>
          (o as Map<String, Object>)
              ?.map((k, e) => MapEntry<String, String>(k, e as String)))
          ?.toList(),
      lastSeq: response.json['last_seq'] as String,
      allNodes: (response.json['all_nodes'] as List<Object>)
          ?.map((v) => v as String)
          ?.toList(),
      clusterNodes: (response.json['cluster_nodes'] as List<Object>)
          ?.map((v) => v as String)
          ?.toList(),
      history: (response.json['results'] as List<Object>)
          ?.map((o) => o as Map<String, Object>)
          ?.toList(),
      ok: response.json['ok'] as bool,
      replicationIdVersion: response.json['replication_id_version'] as int,
      sessionId: response.json['session_id'] as String,
      sourceLastSeq: response.json['source_last_seq'] as int,
      offset: response.json['offset'] as int,
      totalRows: response.json['total_rows'] as int,
      id: response.json['id'] as String,
      database: response.json['database'] as String,
      docId: response.json['doc_id'] as String,
      pid: response.json['pid'] as String,
      node: response.json['node'] as String,
      source: response.json['source'] as String,
      target: response.json['target'] as String,
      startTime: response.json['start_time'] as String,
      lastUpdate: response.json['last_update'] as String,
      info: response.json['info'],
      errorCount: response.json['error_count'] as int,
      fabric: (response.json['fabric'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Map<String, Object>>>(
              k,
              (v as Map<String, Object>)?.map(
                      (k, v) => MapEntry<String, Map<String, Object>>(
                      k, v as Map<String, Object>)))),
      ddocCache: (response.json['ddoc_cache'] as Map<String, Object>)?.map((k,
          v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      couchDb: response.json['couchdb'] is Map
          ? (response.json['couchdb'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>))
          : null,
      pread: (response.json['pread'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      couchReplicator: (response.json['couch_replicator'] as Map<String,
          Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      mem3: (response.json['mem3'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Map<String, Object>>>(k,
              (v as Map<String, Object>)?.map((k, v) =>
                  MapEntry<String, Map<String, Object>>(
                      k, v as Map<String, Object>)))),
      couchLog: (response.json['couch_log'] as Map<String, Object>)?.map((k,
          v) => MapEntry<String, Map<String, Map<String, Object>>>(k,
          (v as Map<String, Object>)?.map((k, v) =>
              MapEntry<String, Map<String, Object>>(
                  k, v as Map<String, Object>)))),
      rexi: (response.json['rexi'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      globalChanges: (response.json['global_changes'] as Map<String, Object>)
          ?.map((k, v) =>
          MapEntry<String, Map<String, Object>>(k, v as Map<String, Object>)),
      uptime: response.json['uptime'] as int,
      memory: (response.json['memory'] as Map<String, Object>)?.map((k, v) =>
          MapEntry<String, int>(k, v as int)),
      runQueue: response.json['run_queue'] as int,
      etsTableCount: response.json['ets_table_count'] as int,
      contextSwitches: response.json['context_switches'] as int,
      reductions: response.json['reductions'] as int,
      garbageCollectionCount: response.json['garbage_collection_count'] as int,
      wordsReclaimed: response.json['words_reclaimed'] as int,
      ioInput: response.json['io_input'] as int,
      ioOutput: response.json['io_output'] as int,
      osProcCount: response.json['os_proc_count'] as int,
      staleProcCount: response.json['stale_proc_count'] as int,
      processCount: response.json['process_count'] as int,
      processLimit: response.json['process_limit'] as int,
      messageQueues: response.json['message_queues'] as Map<String, Object>,
      internalReplicationJobs: response
          .json['internal_replication_jobs'] as int,
      distribution: response.json['distribution'] as Map<String, Object>,
      status: response.json['status'] as String,
      uuids: (response.json['uuids'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      list: response.json['list'] as List<Object>,
      name: response.json['name'] as String,
      roles: (response.json['roles'] as List<Object>)
          ?.map((v) => v as String)
          ?.toList(),
      userCtx: response.json['userCtx'] as Map<String, Object>);

  /// Welcome message from CouchDB
  ///
  /// Provided by [Server.couchDbInfo]
  final String couchDbMessage;

  /// UUID of database
  final String uuid;

  /// Field that contain manufacturer of CouchDB
  final Map<String, String> vendor;

  /// Version of CouchDB
  final String version;

  /// Current state of the node and/or cluster
  final String state;

  /// Holds database updates
  final List<Map<String, String>> results;

  /// Last sequense of the event
  final String lastSeq;

  /// Holds all nodes of database instance
  final List<String> allNodes;

  /// Holds all nodes of database instance
  final List<String> clusterNodes;

  /// Holds replication history
  final List<Map<String, Object>> history;

  /// Holds replication status
  final bool ok;

  /// Holds replication protocol version
  final int replicationIdVersion;

  /// Holds unique session ID
  final String sessionId;

  /// Holds last sequence number read from source database
  final int sourceLastSeq;

  /// Holds how many results were skipped in [Server.schedulerJobs]
  final int offset;

  /// Holds total number of replication jobs
  final int totalRows;

  /// Holds replication ID
  final String id;

  /// Holds replication document database
  final String database;

  /// Holds replication document ID
  final String docId;

  /// Holds replication process ID
  final String pid;

  /// Holds cluster node where the job is running
  final String node;

  /// Holds replication source
  final String source;

  /// Holds replication target
  final String target;

  /// Timestamp of when the replication was started
  final String startTime;

  /// Holds timestamp of last state update
  final String lastUpdate;

  /// May contain additional information about the state.
  ///
  /// For error states, this will be a string. For success states this will contain a JSON object.
  /// Also may contain server authentication configuration as `Map<String, Object>` type.
  final Object info;

  /// Holds consecutive errors count
  final int errorCount;

  /// Holds cluster-related operations
  final Map<String, Map<String, Map<String, Object>>> fabric;

  /// Cache info about design document?
  final Map<String, Map<String, Object>> ddocCache;

  /// Primary CouchDB database operations info
  ///
  /// Produced by [Server.nodeStats]
  final Map<String, Map<String, Object>> couchDb;

  /// CouchDB file-related exceptions info
  final Map<String, Map<String, Object>> pread;

  /// Replication scheduler and subsystem info
  final Map<String, Map<String, Object>> couchReplicator;

  /// Node membership-related statistics
  final Map<String, Map<String, Map<String, Object>>> mem3;

  /// Logging subsystem info
  final Map<String, Map<String, Map<String, Object>>> couchLog;

  /// Cluster internal RPC-related statistics
  final Map<String, Map<String, Object>> rexi;

  /// Global changes feed info
  final Map<String, Map<String, Object>> globalChanges;

  /// These statistic are generally intended for CouchDB developers only.
  final int uptime;

  /// These statistic are generally intended for CouchDB developers only.
  final Map<String, int> memory;

  /// These statistic are generally intended for CouchDB developers only.
  final int runQueue;

  /// These statistic are generally intended for CouchDB developers only.
  final int etsTableCount;

  /// These statistic are generally intended for CouchDB developers only.
  final int contextSwitches;

  /// These statistic are generally intended for CouchDB developers only.
  final int reductions;

  /// These statistic are generally intended for CouchDB developers only.
  final int garbageCollectionCount;

  /// These statistic are generally intended for CouchDB developers only.
  final int wordsReclaimed;

  /// These statistic are generally intended for CouchDB developers only.
  final int ioInput;

  /// These statistic are generally intended for CouchDB developers only.
  final int ioOutput;

  /// These statistic are generally intended for CouchDB developers only.
  final int osProcCount;

  /// These statistic are generally intended for CouchDB developers only.
  final int staleProcCount;

  /// These statistic are generally intended for CouchDB developers only.
  final int processCount;

  /// These statistic are generally intended for CouchDB developers only.
  final int processLimit;

  /// These statistic are generally intended for CouchDB developers only.
  final Map<String, Object> messageQueues;

  /// These statistic are generally intended for CouchDB developers only.
  final int internalReplicationJobs;

  /// These statistic are generally intended for CouchDB developers only.
  final Map<String, Object> distribution;

  /// Status of current running node
  final String status;

  /// List of uuids returned by CouchDB
  ///
  /// Returned by [Server.uuids]
  final List<String> uuids;

  /// List of some objects (if JSON itself is list)
  ///
  /// Returned by [Server.activeTasks], [Server.allDbs], [Server.dbsInfo]
  final List<Object> list;

  /// Holds username
  final String name;

  /// Holds roles of user in database
  final List<String> roles;

  /// Holds user context for the current user
  final Map<String, Object> userCtx;
}
