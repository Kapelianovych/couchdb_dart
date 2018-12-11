# A library for Dart developers for work with CouchDB

**Introducing first beta of library! 🎊 🎉**

Created under a MIT-style
[license](https://github.com/YevhenKap/couchdb_dart/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'name', password: 'password');
  final dm = DatabaseModel(c);

  try {
    final DbResponse o = await dm.getAllDocs('denta');

    // Some code here

  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
```

## Overview

> CouchDB is a database that completely embraces the web. Store your data with JSON documents. Access your documents with your web browser, via HTTP.

Every supported method: `HEAD`, `GET`, `POST`, `PUT` and `COPY` - have `Accept` header with default value as `application/json` and `POST` and `PUT` - `Content-Type` header with default value as `application/json`.
You might override it if you need it.

### Authorization

At the current time only **Basic** authorization is implemented.

### Areas of API

> Requests to the API are categorised by the different areas of the CouchDB system that you are accessing.

Exist 5 areas of API:

    1. Server
    2. Database
    3. Documents
    4. Design documents
    5. Local documents

Every area (layer) contain its own method for interacting with CouchDB.
Detailed information you can find in [official documentation site](http://docs.couchdb.org/en/stable/api/basics.html).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/YevhenKap/couchdb_dart/issues

**With ❤️ to CouchDB**