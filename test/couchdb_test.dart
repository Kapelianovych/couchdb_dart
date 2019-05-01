import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbClient.fromString('http://localhost:5984');
  final da = DatabaseModel(c);
  final ddm = DesignDocumentModel(c);
  final dm = DocumentModel(c);
  final sm = ServerModel(c);

  final queries = <Map<String, Object>>[{'keys': <String>['_design/yyy', 'FishStew']}];

  try {
    final headers = <String, String>{'Accept': 'text/plain'};

    //final r = await c.authenticate();

    final o = await da.shards('denta');
    print(o.databaseModelResponse().shards);
  } on CouchDbException catch (e) {
    print(e);
  }
}

