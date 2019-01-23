import '../models/server_model.dart';

/// Class that contains responses from `ServerModel` class
class ServerModelResponse {
  /// Creates instance of [ServerModelResponse]
  ServerModelResponse(
      {this.couchDbMessage,
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
      this.list});

  /// Welcome message from CouchDB
  ///
  /// Provided by [ServerModel.couchDbInfo]
  String couchDbMessage;

  /// UUID of database
  String uuid;

  /// Field that contain manufacturer of CouchDB
  Map<String, String> vendor;

  /// Version of CouchDB
  String version;

  /// Current state of the node and/or cluster
  String state;

  /// Holds database updates
  List<Map<String, String>> results;

  /// Last sequense of the event
  String lastSeq;

  /// Holds all nodes of database instance
  List<String> allNodes;

  /// Holds all nodes of database instance
  List<String> clusterNodes;

  /// Holds replication history
  List<Map<String, Object>> history;

  /// Holds replication status
  bool ok;

  /// Holds replication protocol version
  int replicationIdVersion;

  /// Holds unique session ID
  String sessionId;

  /// Holds last sequence number read from source database
  int sourceLastSeq;

  /// Holds how many results were skipped in [ServerModel.schedulerJobs]
  int offset;

  /// Holds total number of replication jobs
  int totalRows;

  /// Holds replication ID
  String id;

  /// Holds replication document database
  String database;

  /// Holds replication document ID
  String docId;

  /// Holds replication process ID
  String pid;

  /// Holds cluster node where the job is running
  String node;

  /// Holds replication source
  String source;

  /// Holds replication target
  String target;

  /// Timestamp of when the replication was started
  String startTime;

  /// Holds timestamp of last state update
  String lastUpdate;

  /// May contain additional information about the state.
  ///
  /// For error states, this will be a string. For success states this will contain a JSON object.
  Object info;

  /// Holds consecutive errors count
  int errorCount;

  /// Holds cluster-related operations
  Map<String, Map<String, Map<String, Object>>> fabric;

  /// Cache info about design document?
  Map<String, Map<String, Object>> ddocCache;

  /// Primary CouchDB database operations info
  ///
  /// Produced by [ServerModel.nodeStats]
  Map<String, Map<String, Object>> couchDb;

  /// CouchDB file-related exceptions info
  Map<String, Map<String, Object>> pread;

  /// Replication scheduler and subsystem info
  Map<String, Map<String, Object>> couchReplicator;

  /// Node membership-related statistics
  Map<String, Map<String, Map<String, Object>>> mem3;

  /// Logging subsystem info
  Map<String, Map<String, Map<String, Object>>> couchLog;

  /// Cluster internal RPC-related statistics
  Map<String, Map<String, Object>> rexi;

  /// Global changes feed info
  Map<String, Map<String, Object>> globalChanges;

  /// These statistic are generally intended for CouchDB developers only.
  int uptime;

  /// These statistic are generally intended for CouchDB developers only.
  Map<String, int> memory;

  /// These statistic are generally intended for CouchDB developers only.
  int runQueue;

  /// These statistic are generally intended for CouchDB developers only.
  int etsTableCount;

  /// These statistic are generally intended for CouchDB developers only.
  int contextSwitches;

  /// These statistic are generally intended for CouchDB developers only.
  int reductions;

  /// These statistic are generally intended for CouchDB developers only.
  int garbageCollectionCount;

  /// These statistic are generally intended for CouchDB developers only.
  int wordsReclaimed;

  /// These statistic are generally intended for CouchDB developers only.
  int ioInput;

  /// These statistic are generally intended for CouchDB developers only.
  int ioOutput;

  /// These statistic are generally intended for CouchDB developers only.
  int osProcCount;

  /// These statistic are generally intended for CouchDB developers only.
  int staleProcCount;

  /// These statistic are generally intended for CouchDB developers only.
  int processCount;

  /// These statistic are generally intended for CouchDB developers only.
  int processLimit;

  /// These statistic are generally intended for CouchDB developers only.
  Map<String, Object> messageQueues;

  /// These statistic are generally intended for CouchDB developers only.
  int internalReplicationJobs;

  /// These statistic are generally intended for CouchDB developers only.
  Map<String, Object> distribution;

  /// Status of current running node
  String status;

  /// List of uuids returned by CouchDB
  ///
  /// Returned by [ServerModel.uuids]
  List<String> uuids;

  /// List of some objects (if JSON itself is list)
  ///
  /// Returned by [ServerModel.activeTasks], [ServerModel.allDbs], [ServerModel.dbsInfo]
  List<Object> list;
}
