import 'package:json_annotation/json_annotation.dart';

import '../../models/server_model.dart';

part 'db_response.g.dart';

/// Object containing all results returned by database
@JsonSerializable(nullable: true)
class DbResponse {
  /// Constructor for creating response. Prefer using factory constructor [DbResponse.fromJson(json)]
  DbResponse(
      {this.ok,
      this.error,
      this.reason,
      this.id,
      this.rev,
      this.headers,
      this.offset,
      this.rows,
      this.totalRows,
      this.results,
      this.docs,
      this.bookmark,
      this.executionStats,
      this.warning,
      this.result,
      this.name,
      this.indexes,
      this.dbName,
      this.fields,
      this.index,
      this.limit,
      this.opts,
      this.range,
      this.selector,
      this.skip,
      this.lastSeq,
      this.pending,
      this.instanceStartTime,
      this.admins,
      this.members,
      this.purgeSeq,
      this.purged,
      this.missedRevs,
      this.deleted,
      this.attachments,
      this.conflicts,
      this.deletedConflicts,
      this.localSeq,
      this.revsInfo,
      this.revisions,
      this.json,
      this.couchDbWelcome,
      this.couchDb,
      this.uuid,
      this.vendor,
      this.state,
      this.version,
      this.allNodes,
      this.clusterNodes,
      this.history,
      this.replicationIdVersion,
      this.sessionId,
      this.sourceLastSeq,
      this.database,
      this.docId,
      this.node,
      this.pid,
      this.source,
      this.target,
      this.startTime,
      this.jobs,
      this.errorCount,
      this.info,
      this.lastUpdate,
      this.couchLog,
      this.couchReplicator,
      this.ddocCache,
      this.fabric,
      this.globalChanges,
      this.mem3,
      this.pread,
      this.rexi,
      this.value,
      this.type,
      this.desc,
      this.contextSwitches,
      this.distribution,
      this.etsTableCount,
      this.garbageCollectionCount,
      this.internalReplicationJobs,
      this.ioInput,
      this.ioOutput,
      this.memory,
      this.messageQueues,
      this.osProcCount,
      this.processCount,
      this.processLimit,
      this.reductions,
      this.runQueue,
      this.staleProcCount,
      this.uptime,
      this.wordsReclaimed,
      this.status,
      this.uuids,
      this.updateSeq,
      this.raw,
      this.viewIndex});

  /// Parses [json] response from database
  factory DbResponse.fromJson(Map<String, dynamic> json) => _$DbResponseFromJson(json);

  /// Replication document id
  String docId;

  /// Document id
  String id;

  /// Document revision
  String rev;

  /// Success of operation
  bool ok;

  /// Short description of error
  String error;

  /// Reason of error
  String reason;

  /// Headers of response
  Map<String, List<String>> headers;

  /// Offset where the design document list started
  int offset;

  ///  Array of view row objects
  List<Object> rows;

  /// Number of documents or indexes of database
  int totalRows;

  /// An array of result objects
  /// 
  /// Produce [ServerModel.activeTasks], [ServerModel.allDbs]
  List<Object> results;

  /// Array of documents matching the search of [find()] method
  List<Object> docs;

  /// Warning that appear during execution process
  String warning;

  /// Object that show execution statistics
  Map<String, Object> executionStats;

  /// An opaque string used for paging
  String bookmark;

  ///  Flag to show whether the index was created or one already exists. Can be **created** or **exists**
  String result;

  /// Name of the created index
  String name;

  /// Array of index definitions
  List<Object> indexes;

  /// Name of database
  String dbName;

  /// Index used to fulfill the query
  Map<String, Object> index;

  /// Query selector used
  Map<String, Object> selector;

  /// Query options used
  Map<String, Object> opts;

  /// Count limit of returned parameters
  int limit;

  /// Count of skipped parameters
  int skip;

  /// Fields to be returned by the query of [explain()] method
  ///
  /// May be an array of fields or sring value: 'all_fields'
  Object fields;

  /// Range parameters passed to the underlying view of [explain()] method
  Map<String, Object> range;

  /// Last change update sequence
  String lastSeq;

  /// Count of remaining items in the feed of [changesIn()] and [postChangesIn()] methods
  int pending;

  /// Exist for legacy reasons. Always have value "0"
  String instanceStartTime;

  /// Users that have admin privileges
  Map<String, Object> admins;

  /// Users that have member privileges
  Map<String, Object> members;

  /// Purge sequence number
  int purgeSeq;

  /// List of the document IDs and revisions successfully purged
  Map<String, Object> purged;

  /// Document revisions that do not exist in the database
  Map<String, Object> missedRevs;

  /// Deletion flag. Available if document was removed
  bool deleted;

  /// Attachment’s stubs. Available if document has any attachments
  Object attachments;

  /// List of conflicted revisions
  List<Object> conflicts;

  ///  List of deleted conflicted revisions
  List<Object> deletedConflicts;

  /// Document’s update sequence in database
  String localSeq;

  /// List of objects with information about local revisions and their status
  List<Object> revsInfo;

  /// List of local revision tokens without
  List<Object> revisions;

  /// Field that contain json itself in order to grab custom fields
  Map<String, Object> json;

  /// Field that contain `Welcome` message from CouchDB
  /// 
  /// Produce [ServerModel.couchDbInfo]
  String couchDbWelcome;

  /// Field that contain primary CouchDB database operations
  Object couchDb;

  /// Universally unique identifier of CouchDB
  /// 
  /// Produce [ServerModel.couchDbInfo]
  String uuid;

  /// Field that contain manufacturer of CouchDB
  /// 
  /// Produce [ServerModel.couchDbInfo]
  Map<String, String> vendor;

  /// Version of CouchDB
  /// 
  /// Produce [ServerModel.couchDbInfo]
  String version;

  /// Field that indicates the current node or cluster state
  String state;

  /// Field that contain all nodes this node knows about
  List<Object> allNodes;

  /// Field that contain all nodes this node knows about the ones that are part of the cluster
  List<Object> clusterNodes;

  /// Replication history
  List<Object> history;

  /// Replication protocol version
  int replicationIdVersion;

  /// Unique session ID
  String sessionId;

  /// Last sequence number read from source database
  String sourceLastSeq;

  /// Replication document database
  String database;

  /// Replication process ID
  String pid;

  /// Cluster node where the job is running
  String node;

  /// Replication source
  String source;

  /// Replication target
  String target;

  /// Timestamp of when the replication was started
  String startTime;

  /// List of replication jobs
  List<Object> jobs;

  /// Timestamp of last state update
  String lastUpdate;

  /// May contain additional information about the state. For error states, this will be a string.
  /// For success states this will contain a JSON object
  Object info;

  /// Consecutive errors count
  int errorCount;

  /// Field that contain cluster-related operations
  Map<String, Object> fabric;

  /// Design-document cache
  Map<String, Object> ddocCache;

  /// CouchDB file-related exceptions
  Map<String, Object> pread;

  /// Replication scheduler and subsystem
  Map<String, Object> couchReplicator;

  /// Node membership-related statistics
  Map<String, Object> mem3;

  ///  Logging subsystem
  Map<String, Object> couchLog;

  /// Cluster internal RPC-related statistics
  Map<String, Object> rexi;

  /// Global changes feed
  Map<String, Object> globalChanges;

  /// Statistic of some section of CouchDB
  Map<String, Object> value;

  /// The type of the statistic
  ///
  /// [type] value may have one of the following values:
  ///
  ///     1. counter: Monotonically increasing counter, resets on restart
  ///     2. histogram: Binned set of values with meaningful subdivisions
  ///     3. gauge: Single numerical value that can go up and down
  String type;

  /// Description of concrete statistic section
  String desc;

  /// These statistic are generally intended for CouchDB developers only.
  int uptime;

  /// These statistic are generally intended for CouchDB developers only.
  Map<String, Object> memory;

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

  /// Fild that contain `ok` value when CouchDB is up, running, and ready to respond to requests
  String status;

  /// Contain a list of UUIDs
  List<Object> uuids;

  /// Current update sequence for the database
  int updateSeq;

  /// Field that contain raw body of response
  String raw;

  /// View index information (http://docs.couchdb.org/en/stable/api/ddoc/common.html#api-ddoc-view-index-info)
  Map<String, Object> viewIndex;

  /// Convert this instance to JSON
  Map<String, dynamic> toJson() => _$DbResponseToJson(this);

  @override
  String toString() => 'Instance of DbResponse';
}
