import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

/// Server interface provides the basic interface to a CouchDB server
/// for obtaining CouchDB information and getting and setting configuration information
abstract class ServerBaseModel extends BaseModel {
  /// Create ServerModel by accepting web-based or server-based client
  ServerBaseModel(CouchDbBaseClient client) : super(client);

  /// Accessing the root of a CouchDB instance returns meta information about the instance
  Future<DbResponse> couchDbInfo({Map<String, String> headers});

  /// List of running tasks, including the task type, name, status and process ID
  ///
  /// Result of this method is available in [DbResponse.results] field
  Future<DbResponse> activeTasks({Map<String, String> headers});

  /// Returns a list of all the databases in the CouchDB instance
  ///
  /// Result of this method is available in [DbResponse.results] field
  Future<DbResponse> allDbs({Map<String, String> headers});

  /// Returns information of a list of the specified databases in the CouchDB instance
  ///
  /// Result of this method is available in [DbResponse.results] field
  Future<DbResponse> dbsInfo(List<String> keys);

  /// Returns the status of the node or cluster, per the cluster setup wizard
  ///
  /// If [ensureDbsExist] isn't specified, it is defaults to `["_users","_replicator","_global_changes"]`
  Future<DbResponse> getClusterSetup(
      {List<String> ensureDbsExist, Map<String, String> headers});

  /// Configure a node as a single (standalone) node, as part of a cluster, or finalise a cluster
  ///
  /// Correspond to `POST /_cluster_setup` method.
  /// If [ensureDbsExist] isn't specified, it is defaults to `["_users","_replicator","_global_changes"]`.
  /// [bindAdress] should be provided not [host], if CouchDB is configuring as `single_node`.
  Future<DbResponse> configureCouchDb(
      {@required String action,
      @required String bindAdress,
      @required String username,
      @required String password,
      @required int port,
      int nodeCount,
      String remoteNode,
      String remoteCurrentUser,
      String remoteCurrentPassword,
      String host,
      List<String> ensureDbsExist,
      Map<String, String> headers});

  /// Returns a list of all database events in the CouchDB instance
  Future<DbResponse> dbUpdates(
      {String feed = 'normal',
      int timeout = 60,
      int heartbeat = 60000,
      String since,
      Map<String, String> headers});

  /// Displays the nodes that are part of the cluster as `cluster_nodes`
  Future<DbResponse> membership({Map<String, String> headers});

  /// Request, configure, or stop, a replication operation
  Future<DbResponse> replicate(
      {bool cancel,
      bool continuous,
      bool createTarget,
      List<String> docIds,
      String filterFunJS,
      String proxy,
      Object source,
      Object target,
      Map<String, String> headers});

  Future<String> schedulerJobs({int limit, int skip});
  Future<String> schedulerDocs({int limit, int skip});
  Future<String> schedulerDocsWithReplicatiorDbName(
      {@required String replicator, int limit, int skip});
  Future<String> schedulerDocsWithDocId(String replicator, String docId);
  Future<String> nodeStats({String nodeName = '_local'});
  Future<String> systemStatsForNode({String nodeName = '_local'});
  // _utils will be soon
  Future<String> up();
  Future<List<String>> uuids({int count = 1});
  // favicon ?
}
