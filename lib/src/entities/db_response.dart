/// Object containing all results returned by database
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
      this.sourceLastSeq});

  /// Parses [json] response from database
  factory DbResponse.fromJson(Map<String, Object> json) => DbResponse(
      ok: json['ok'],
      error: "${json['error']}",
      reason: "${json['reason']}",
      id: "${json['id'] ?? json['_id']}",
      rev: "${json['rev'] ?? json['_rev']}",
      headers: json['headers'],
      offset: json['offset'],
      rows: json['rows'],
      totalRows: json['total_rows'],
      results: json['results'],
      docs: json['docs'],
      warning: '${json['warning']}',
      executionStats: json['execution_stats'],
      bookmark: '${json['bookmark']}',
      result: '${json['result']}',
      name: '${json['name']}',
      indexes: json['indexes'],
      dbName: '${json['dbname']}',
      fields: json['fields'],
      index: json['index'],
      limit: json['limit'],
      opts: json['opts'],
      range: json['range'],
      selector: json['selector'],
      skip: json['skip'],
      pending: json['pending'],
      lastSeq: '${json['last_seq']}',
      instanceStartTime: '${json['instance_start_time']}',
      admins: json['admins'],
      members: json['members'],
      purgeSeq: json['purge_seq'],
      purged: json['purged'],
      missedRevs: json['missed_revs'],
      deleted: json['_deleted'],
      attachments: json['_attachments'],
      conflicts: json['_conflicts'],
      deletedConflicts: json['_deleted_conflicts'],
      localSeq: '${json['_local_seq']}',
      revsInfo: json['_revs_info'],
      revisions: json['_revisions'],
      couchDb: '${json['couchdb']}',
      uuid: '${json['uuid']}',
      version: '${json['version']}',
      vendor: json['vendor'],
      state: '${json['state']}',
      allNodes: json['all_nodes'],
      clusterNodes: json['cluster_nodes'],
      history: json['history'],
      replicationIdVersion: json['replication_id_version'],
      sessionId: '${json['session_id']}',
      sourceLastSeq: '${json['source_last_seq']}',
      json: json);

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
  String couchDb;

  /// Universally unique identifier of CouchDB
  String uuid;

  /// Field that contain manufacturer of CouchDB
  Map<String, Object> vendor;

  /// Version of CouchDB
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

  @override
  String toString() => 'Instance of DbResponse';
}
