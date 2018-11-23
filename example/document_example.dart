import 'package:couchdb/couchdb.dart';

Future<void> main(List<String> args) async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final dm = DocumentModel(c);

  try {
    DbResponse r = await dm.deleteAttachment('das', 'FishStew', 'attname', rev: '2-40ecf2d4109130f4c9d9a2de3efb3c1e');
    print('${r.ok} - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
