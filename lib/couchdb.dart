/// A library for interacting with CouchDB via server
/// applications or browser-based clients
///
/// It is making according to the CouchDB API.
/// > Requests are made using HTTP and requests are used
/// to request information from the database,
/// > store new data, and perform views and formatting of
/// the information stored within the documents.
///
/// More detailed information about API is [here](http://docs.couchdb.org/en/stable/index.html).
library couchdb;

export 'src/clients/couchdb_client.dart';

export 'src/responses/database_response.dart';
export 'src/responses/response.dart';
export 'src/responses/design_document_response.dart';
export 'src/responses/document_response.dart';
export 'src/responses/local_document_response.dart';
export 'src/responses/server_response.dart';

export 'src/exceptions/couchdb_exception.dart';

export 'src/components/component.dart';
export 'src/components/database.dart';
export 'src/components/design_document.dart';
export 'src/components/document.dart';
export 'src/components/local_document.dart';
export 'src/components/server.dart';
