import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbClient.fromString('http://admin:password@127.0.0.1:5984');
  final da = Databases(c);
  final ddm = DesignDocuments(c);
  final dm = Documents(c);
  final sm = Server(c);

  final queries = <Map<String, Object>>[{'keys': <String>['_design/yyy', 'FishStew']}];

  try {
    final headers = <String, String>{'Accept': 'text/plain'};
    final o = await da.dbInfo('denta');
    print(o.dbName);
  } on CouchDbException catch (e) {
    print(e);
  }
}

