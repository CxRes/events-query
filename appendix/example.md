# Examples {#examples}

Some examples used in this specification are consolidated below. Chunks have been omitted for clarity.

## Representation and Notifications {#example-representation}

{: #example-description}
The following example illustrates a complete request and response for representation and notifications transferred with the `application/http` media-type as described in {{representation}}: {{<<representation}}.

### Request {#example-representation-request-http}

~~~ http-message
{::include examples/stream/state-request.http}
~~~
{: sourcecode-name="representation-request-http-example.http" #representation-request-http-complete-example title="Request for Representation and Notifications"}

### Response {#example-http-representation-response}

~~~ http-message
{::include examples/stream/response-headers.http}
Content-Type: application/http

{::include examples/stream/representation.http.txt}

{::include examples/notifications/update.http.txt}

{::include examples/notifications/delete.http.txt}
~~~
{: sourcecode-name="representation-response-http-complete-example.http" #representation-response-http-complete-example title="Response with Representation and Notifications"}

## Notifications Stream {#example-stream}

This following example illustrates complete request and response for JSON formatted notifications transferred with the `application/json-seq` media-type as described in {{<<stream}}: {{<<stream}}.

### Request {#example-json-stream-request}

~~~ http-message
{::include examples/stream/json-events-request.http}
~~~
{: sourcecode-name="stream-request-example.http" #stream-request-json-complete-example title="Request for JSON Notifications"}

### Response {#example-json-stream-response}

~~~ http-message
{::include examples/stream/response-headers.http}
Content-Type: application/json-seq

{::include examples/notifications/update.json.txt}
{::include examples/notifications/delete.json.txt}
~~~
{: sourcecode-name="stream-response-json-complete-example.http" #stream-response-json-complete-example title="Response with JSON Notifications"}
