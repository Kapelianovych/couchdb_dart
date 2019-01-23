import 'dart:io';

import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'admin', password: 'pass');
  final da = DatabaseModel(c);
  final ddm = DesignDocumentModel(c);
  final dm = DocumentModel(c);
  final sm = ServerModel(c);

  final queries = <Map<String, Object>>[{'keys': <String>['_design/yyy', 'FishStew']}];

  try {
    final headers = <String, String>{'Accept': 'text/plain'};
    final o = await da.revsDiff('denta', {"190f721ca3411be7aa9477db5f948bbb": [
        "3-bb72a7682290f94a985f7afac8b27137",
        "4-10265e5a26d807a3cfa459cf1a82ef2e",
        "5-067a00dff5e02add41819138abb3284d"
    ]}); // find('medical_bot', <String, Object>{'name': 'caries'});
    print(o.databaseModelResponse().revsDiff);
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}

