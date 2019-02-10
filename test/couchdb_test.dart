import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbClient(username: 'admin', password: 'pass', auth: 'cookie');
  final da = DatabaseModel(c);
  final ddm = DesignDocumentModel(c);
  final dm = DocumentModel(c);
  final sm = ServerModel(c);

  final queries = <Map<String, Object>>[{'keys': <String>['_design/yyy', 'FishStew']}];

  try {
    final headers = <String, String>{'Accept': 'text/plain'};
    
    final r = await c.authenticate();
    
    final o = await da.changesIn('denta');
    await o.forEach(print);
    print(await c.userInfo());
  } on CouchDbException catch (e) {
    print(e);
  }
}

