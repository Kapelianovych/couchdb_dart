import 'package:couchdb/couchdb_server.dart';

Future<void> main() async {
  CouchDbServerClient c = CouchDbServerClient(username: 'admin', password: 'poiu7890_A');
  DatabaseModel dm = DatabaseModel(c);
  final o = await dm.dbInfo('denta');
  print(o);
}
