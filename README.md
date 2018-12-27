# A library for Dart developers for work with CouchDB

**Introducing first beta of library! 🎊 🎉**

Created under a MIT-style
[license](https://github.com/YevhenKap/couchdb_dart/blob/master/LICENSE).



## Overview

> CouchDB is a database that completely embraces the web. Store your data with JSON documents. Access your documents with your web browser, via HTTP.

A basic understanding of CouchDB is required to use this library. Detailed information can be found at the [official documentation site](http://docs.couchdb.org/en/stable/api/basics.html).



### API

The connection to the database, along with authentication, is hadled via one of the Client classes: either `CouchDbServerClient` or `CouchDbWebClient`. You will use the web client if your application is running in the browser, and the server client otherwise. __At the current time only *Basic* authorization is implemented.__

You can communicate with the server directly if you wish via the http client methods such as `get()` and `post()`, however, other classes provide functions which can abstract away the particulars of HTTP, therefore using these client methods directly is not the way you will typically use this library.

Every supported method: `HEAD`, `GET`, `POST`, `PUT` and `COPY` - has an `Accept` header with default value as `application/json`, and `POST` and `PUT` both have a `Content-Type` header with default value as `application/json`.
You can override this if you need.

All requests, both those by the basic http methods, as well as those by the other classes we will go over in a moment, return a `DbResponse` Object. This is simple an object representation of the JSON data that was sent by CouchDB, thus you should refer to the CouchDB documention to see exactly which values are returned by your specific request. You can also access the raw response as a `Map` via the `DbRepsonse.json` property.

The remainder of the API is divided into five areas or categories, each representing a different aspect of the database overall. These five categories are:

    1. Server
    2. Database
    3. Documents
    4. Design documents
    5. Local documents

#### 1: Server

Represented by the `ServerModel` class. This class provides server-level interaction with CouchDB, such as managing replication or obtaining basic information about the server.

#### 2: Database

A Database in CouchDB is a single document store located on the given database server. This part of the API is represented by the `DatabaseModel` class. You will use this class for interacting with your data on a database level; for example creating a new database or preforming a query to search for certain documents.

#### 3: Documents

You will use the `DocumentModel` class to interact with the data on a document level. This would include functions such as fetching a specific document, adding a new document, or attaching a file to a document. Note that this class does not model the documents themselves, but rather your interactions with them. The documents themselves are represented as `Map`s.

#### 4: Design Documents

Represented by the `DesignDocumentModel`, design documents provide views of data in the database.

#### 5: Local Documents

Local documents are no different than normal documents, with the exception that they are not copied to other instances of CouchDB during replication. You will interact with them via the `LocalDocumentModel` class.




## Usage

A simple usage example:

```dart
import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final client = CouchDbServerClient(username: 'name', password: 'password');
  final dbModel = DatabaseModel(client);
  final docModel = DocumentModel(client)

  try {
    final DbResponse response1 = await dbModel.getAllDocs('some_db');

    for (var i in response1.rows){
      // Some code here
    }
    
    final DbResponse response2 = await docModel.getDoc('another_db', 'some_id');
    
    var thing = response2.json['some_attribute'];

  } 
  catch (CouchDbException e) {
    print('$e - error');
  }
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/YevhenKap/couchdb_dart/issues

**With ❤️ to CouchDB**
