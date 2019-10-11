import '../responses/api_response.dart';
import '../responses/server_response.dart';

/// Only provided for backward compatibility
@Deprecated('Use ServerResponse instead')
class ServerModelResponse extends ServerResponse {
  ServerModelResponse.from(ApiResponse response) : super.from(response);

  ServerModelResponse(
      {String couchDbMessage,
      String uuid,
      Map<String, String> vendor,
      String version,
      String state,
      List<Map<String, String>> results,
      String lastSeq,
      List<String> allNodes,
      List<String> clusterNodes,
      List<Map<String, Object>> history,
      bool ok,
      int replicationIdVersion,
      String sessionId,
      int sourceLastSeq,
      int offset,
      int totalRows,
      String id,
      String database,
      String docId,
      String pid,
      String node,
      String source,
      String target,
      String startTime,
      String lastUpdate,
      Object info,
      int errorCount,
      Map<String, Map<String, Map<String, Object>>> fabric,
      Map<String, Map<String, Object>> ddocCache,
      Map<String, Map<String, Object>> couchDb,
      Map<String, Map<String, Object>> pread,
      Map<String, Map<String, Object>> couchReplicator,
      Map<String, Map<String, Map<String, Object>>> mem3,
      Map<String, Map<String, Map<String, Object>>> couchLog,
      Map<String, Map<String, Object>> rexi,
      Map<String, Map<String, Object>> globalChanges,
      int uptime,
      Map<String, int> memory,
      int runQueue,
      int etsTableCount,
      int contextSwitches,
      int reductions,
      int garbageCollectionCount,
      int wordsReclaimed,
      int ioInput,
      int ioOutput,
      int osProcCount,
      int staleProcCount,
      int processCount,
      int processLimit,
      Map<String, Object> messageQueues,
      int internalReplicationJobs,
      Map<String, Object> distribution,
      String status,
      List<String> uuids,
      List<Object> list,
      String name,
      List<String> roles,
      Map<String, Object> userCtx})
      : super(
            couchDbMessage: couchDbMessage,
            uuid: uuid,
            vendor: vendor,
            version: version,
            state: state,
            results: results,
            lastSeq: lastSeq,
            allNodes: allNodes,
            clusterNodes: clusterNodes,
            history: history,
            ok: ok,
            replicationIdVersion: replicationIdVersion,
            sessionId: sessionId,
            sourceLastSeq: sourceLastSeq,
            offset: offset,
            totalRows: totalRows,
            id: id,
            database: database,
            docId: docId,
            pid: pid,
            node: node,
            source: source,
            target: target,
            startTime: startTime,
            lastUpdate: lastUpdate,
            info: info,
            errorCount: errorCount,
            fabric: fabric,
            ddocCache: ddocCache,
            couchDb: couchDb,
            pread: pread,
            couchReplicator: couchReplicator,
            mem3: mem3,
            couchLog: couchLog,
            rexi: rexi,
            globalChanges: globalChanges,
            uptime: uptime,
            memory: memory,
            runQueue: runQueue,
            etsTableCount: etsTableCount,
            contextSwitches: contextSwitches,
            reductions: reductions,
            garbageCollectionCount: garbageCollectionCount,
            wordsReclaimed: wordsReclaimed,
            ioInput: ioInput,
            ioOutput: ioOutput,
            osProcCount: osProcCount,
            staleProcCount: staleProcCount,
            processCount: processCount,
            processLimit: processLimit,
            messageQueues: messageQueues,
            internalReplicationJobs: internalReplicationJobs,
            distribution: distribution,
            status: status,
            uuids: uuids,
            list: list,
            name: name,
            roles: roles,
            userCtx: userCtx);
}
