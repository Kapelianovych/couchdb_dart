import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import 'base_model.dart';

abstract class ServerBaseModel extends BaseModel {

  ServerBaseModel(CouchDbBaseClient client): super(client);

  Future<String> serverInfo();
  Future<List<String>> activeTasks();
  Future<List<String>> allDbs();
  Future<List<String>> dbsInfo(List<String> keys);
  Future<List<String>> clusterSetup({
    List<String> ensureDbsExist = const <String>['_users','_replicator','_global_changes']
  });
  // Cluster setup API with POST will be soon
  Future<List<String>> dbUpdates({
    String feed = 'normal',
    int timeout = 60,
    int heartbeat = 60000,
    String since
  });
  Future<String> membership();
  Future<String> replicate({
    bool cancel,
    bool continuous,
    bool createTarget,
    List<String> docIds,
    String filterFunJS,
    String proxy,
    Object source,
    Object target
  });
  Future<String> schedulerJobs({ int limit, int skip });
  Future<String> schedulerDocs({ int limit, int skip });
  Future<String> schedulerDocsWithReplicatiorDbName({ @required String replicator, int limit, int skip });
  Future<String> schedulerDocsWithDocId(String replicator, String docId);
  Future<String> nodeStats({ String nodeName = '_local' });
  Future<String> systemStatsForNode({ String nodeName = '_local' });
  // _utils will be soon
  Future<String> up();
  Future<List<String>> uuids({ int count = 1 });
  // favicon ?
}