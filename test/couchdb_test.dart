import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbClient(username: 'admin', password: 'pass');
  final da = DatabaseModel(c);
  final ddm = DesignDocumentModel(c);
  final dm = DocumentModel(c);
  final sm = ServerModel(c);

  final queries = <Map<String, Object>>[{'keys': <String>['_design/yyy', 'FishStew']}];

  try {
    final headers = <String, String>{'Accept': 'text/plain'};
    final o = await da.changesIn('denta', feed: 'eventsource');
    
    await o.forEach(print);
  } on CouchDbException catch (e) {
    print(e);
  }
}

