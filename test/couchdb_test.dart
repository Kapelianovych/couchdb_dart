import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbClient.fromString('http://name:password@localhost:5984');
  final da = Database(c);
  final ddm = DesignDocument(c);
  final dm = Document(c);
  final sm = Server(c);

  final queries = <Map<String, Object>>[{'keys': <String>['_design/yyy', 'FishStew']}];

  try {
    final headers = <String, String>{'Accept': 'text/plain'};

    //final r = await c.authenticate();

    final o = await da.shards('denta');
    print(o.shards);
  } on CouchDbException catch (e) {
    print(e);
  }
}

