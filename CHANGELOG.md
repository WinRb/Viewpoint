# Changelog

## [Unreleased]

* Replace the `logging` gem with stdlib `logger`
* `EWSClient.new` and `Viewpoint::EWS::Connection.new` now take an `auth` hash (`endpoint:`, `type:`, `user:`, `password:`, `token:`) instead of positional `endpoint, username, password` arguments; OAuth bearer-token authentication is supported via `type: 'oauth'` with a `token:`, which is sent as an `Authorization: Bearer` header

## 1.2.0 (2025-10-28)

* Add method to delete calendar items with meeting cancellation
* Add method to find items using a calendar view
* Create events with categories
* Support setting default headers on HTTP options
* Fix `get_item` for occurrence item ids; fix dummy draft ordering when submitting file attachments
* Correct error-raising logic; avoid broken versions of Nokogiri

## 1.1.0 (2016-12-09)

* Override HTTPClient receive/connect timeouts; set a custom user agent; choose the SSL version
* Recurring event support when creating events; expose `Task` status/percent complete, `CalendarItem#legacy_free_busy_status`, and `Item#last_modified_time`
* Add PostItem type; `#mark_unread` alongside `#mark_read`
* Meeting time zone support in the builder; meeting action accessors; `IsResponseRequested` parameter
* Tolerant parsing: strip known bad character sequences before parsing
* Reorder elements to meet the XSD sequence; optional message body with explicit type

## 1.0.0 (2014-06-19)

* Ground-up Exchange Web Services (EWS) rewrite with a new SAX parsing back-end
* Folder operations (find/create/move/copy/empty) and item models for messages, calendar items, tasks, and contacts
* Attachment support; out-of-office settings; user availability
* All exceptions now stem from `EwsError`; pass custom CA cert paths/files and HTTP options to the connection
* Exchange 2013 SP1 version constant; sensible collection defaults (`[]` instead of `nil`)
