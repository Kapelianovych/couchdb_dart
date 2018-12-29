# Server

```dart
import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final client = CouchDbServerClient(username: 'name', password: 'password');
  final dbModel = DatabaseModel(client);
  final docModel = DocumentModel(client)

  try {
    final DbResponse response1 = await dbModel.allDocs('some_db');

    for (var i in response1.rows) {
      // Some code here
    }

    final DbResponse response2 = await docModel.doc('another_db', 'some_id');

    var thing = response2.json['some_attribute'];

  } catch (CouchDbException e) {
    print('$e - error');
  }
}
```

## Browser

```dart
import 'dart:html';

import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_web_client.dart';

Future<void> main(List<String> args) async {
  final ButtonElement btn = querySelector('#data');
  final DivElement output = querySelector('#output');

  final c = CouchDbWebClient(username: 'name', password: 'pass');
  final dm = DocumentModel(c);

  btn.onClick.listen((event) async {
    try {
      DbResponse r = await dm.doc('db', 'docId');
      output.text = '${r.id}';
    } on CouchDbException catch (e) {
      window.console.log('${e.code} - error');
    }
  });
}
```