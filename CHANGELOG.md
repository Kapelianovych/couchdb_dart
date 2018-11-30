# 0.1.0

- Introducing beta-version of library.
- Implement all methods of `ServerModel` class.
- Implement all methods of `DesignDocumentModel` class.
- Add library description to `CouchDb(Server/Web)Client` classes.
- Add `raw` field to `DbResponse` class (prior `rawBody`).
- Change `body` parameter of `post()` method in `CouchDb(Server/Web)Client` to `Object` type.

## 0.0.8

- Implements `schedulerJobs()`, `schedulerDocs()`, `schedulerDocsWithReplicatorDbName()`, `schedulerDocsWithDocId()`,
`nodeStats()`, `systemStatsForNode()`, `up()` and `uuids()` methods of `ServerModel` class.
- Add some fields to `DbResponse` class.

## 0.0.7

- Change `toString()` method of `CouchDbException` class - it shows error code, name error and reason.
- Add `allNodes`, `clusterNodes`, `history`, `replicationIdVersion`, `sessionId` and `sourceLastSeq` fields to `DbResponse` class.
- Implements `configureCouchDb()`, `dbUpdates()`, `membership()` and `replicate()` methods of `ServerModel` class.

## 0.0.6

- Moving `CouchDbWebClient` and `CouchDbServerClient` to the separate export.
- Delete `rawBody` field from `DbResponse` class.
- Add `state` field to `DbResponse` class.
- Implements `couchDbInfo()`, `activeTasks()`, `allDbs()`, `dbsInfo()` and `getClusterSetup()` methods of `ServerModel` class.
- Small changes in `CouchDb(Server/Web)Client` classes.

## 0.0.5

- Implement `CouchDbWebClient` class for interacting with CouchDB.
- Moving all examples to `example/README.md`.

## 0.0.4

- Implements `attachmentInfo()`, `getAttachment()`, `insertAttachment()` and `deleteAttachment()` methods of `DocumentModel` class.
- Implement `setRevsLimit()` method of `DatabaseModel` class.
- Method `put()` now accept any body type.
- Non-json response body now available in `rawBody` field of `DbRespone` class.

## 0.0.3

- Implements `insertDoc()`, `deleteDoc()` and `copyDoc()` methods of `DocumentModel` class.
- All methods of `CouchDb(Server/Web)Client` can set custom headers.

## 0.0.2

- Implementats `docInfo()` and `getDoc()` methods of `DocumentModel` class.
- Add documentation to `DatabaseModel` methods.
- Add opportunity to add headers to `head()` method of `CouchDb(Server/Web)Client` classes.

## 0.0.1

- Initial version.
- Implement `CouchDbServerClient` for interacting with CouchDB.
- Implements `DatabaseBaseModel` methods.