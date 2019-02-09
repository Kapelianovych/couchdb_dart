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

  /// Holds how many results were skipped in [ServerModel.schedulerJobs]
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
  final Object info;

  /// Holds consecutive errors count
  final int errorCount;

  /// Holds cluster-related operations
  final Map<String, Map<String, Map<String, Object>>> fabric;

  /// Cache info about design document?
  final Map<String, Map<String, Object>> ddocCache;

  /// Primary CouchDB database operations info
  ///
  /// Produced by [ServerModel.nodeStats]
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
  /// Returned by [ServerModel.uuids]
  final List<String> uuids;

  /// List of some objects (if JSON itself is list)
  ///
  /// Returned by [ServerModel.activeTasks], [ServerModel.allDbs], [ServerModel.dbsInfo]
  final List<Object> list;
}
