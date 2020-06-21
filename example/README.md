# Server

```dart
import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final client = CouchDbClient(username: 'name', password: 'password');
  final db = Databases(client);
  final doc = Documents(client)

  try {
    final DatabasesResponse response1 = await db.allDocs('some_db');

    for (var i in response1.rows) {
      // Some code here
    }

    final DocumentsResponse response2 = await doc.doc('another_db', 'some_id');

    var thing = response2.doc['some_attribute'];

  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
```

## Browser

```dart
import 'dart:html';

import 'package:couchdb/couchdb.dart';

Future<void> main(List<String> args) async {
  final ButtonElement btn = querySelector('#data');
  final DivElement output = querySelector('#output');

  final c = CouchDbClient(username: 'name', password: 'pass', cors: true);
  final dm = Documents(c);

  btn.onClick.listen((event) async {
  try {
    final DocumentsResponse response1 = await dm.doc('some_db', 'some_doc_id');

    final Map<String, Object> doc = response1.doc;

    // Some code here

    // There properties are extracted from [doc] in order to gets direct access
    final String id = response1.id;
    final String rev = response1.rev;
    final Object attachment = response1.attachment;

    // Another code here

  } on CouchDbException catch (e) {
      window.console.log('${e.code} - error');
    }
  });
}
```
