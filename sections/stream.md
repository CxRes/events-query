# Notifications Stream {#stream}

{: #stream-description}
{{&protocol}} can also be used to request a stream of multiple event-notifications ({{RFC6202, Section 3}}).

## Request {#stream-request}

{: #stream-request-procedure}
To receive multiple notifications, a client MUST:

+ {: #stream-request-procedure--data-model}
send a realization of the subscription data model that includes an interest in receiving a stream of event-notifications in a preferred form,

+ {: #stream-request-procedure--method}
using the QUERY method ({{HTTP-QUERY, Section 2}}). 

{: #stream-request-conneg}
Since the response transmits event-notifications within an encapsulating representation ({{stream-response}}), it follows that header fields cannot be used to negotiate the form of event-notifications as in the case of [Single Notification Request](#single-notification-request){:noabbrev}. Instead, header fields are useful for negotiating the representation that encapsulates event-notifications. The following examples illustrate subscription requests that negotiate a stream of event-notifications to be transferred respectively using a composite media type (`multipart/mixed`) and a discrete media type (`application/json-seq`):

{: #stream-request-multipart}
The first example shows a subscription request for effectively a stream of discrete [Single Notifications](#single-notification){:noabbrev} to be transferred using `multipart/mixed` ({{RFC2046, Section 5.1.3}}) as the encapsulating media type. The `events` property in this example indicates an interest in receiving event-notifications and its sub-properties describe the preferred form of notifications. Since the notifications are transferred as a pipeline of HTTP messages, these sub-properties are identical to [header fields](#single-notification-request-conneg){:noabbrev} used for specifying preconditions and content negotiation in a [Single Notification Request](#single-notification-request){:noabbrev}.

~~~ http-message
{::include examples/stream/events-request.http}
~~~
{: sourcecode-name="stream-request-multipart-example.http" #stream-request-multipart-example title="Request for Multipart Notifications Stream"}

{: #stream-request-json}
The second example shows a subscription request for a stream of JSON notifications to be transferred using `application/json-seq` ({{RFC7464}}) as the encapsulating media type. The `events` property in this example is being used to communicate the preferred schema for the requested event-notifications.

~~~ http-message
{::include examples/stream/json-events-request.http}
~~~
{: sourcecode-name="stream-request-json-example.http" #stream-request-json-example title="Request for JSON Notifications Stream"}

## Response {#stream-response}

{: #stream-response-encapsulation}
The response stream transmits multiple event-notifications in an encapsulating media type. The following illustrates event-notifications streamed in both a composite media type (`multipart/mixed`) and a discrete media type (`application/json-seq`) in response to the example [requests](#stream-request) in {{stream-request}}.

### Headers {#stream-response-headers}

{: #stream-response-headers-list}
A server able to provide a stream of event-notifications MUST immediately send headers, which include:

+ {: #stream-response-events-field}
The =Events= header field, to communicate the properties of the notifications stream.

    + {: #stream-response-duration-property}
    The =duration= property, set to the maximum duration for which the server intends to serve event-notifications.

+ {: #stream-response-incremental-field}
The `Incremental` header field ({{INCREMENTAL-HTTP-MESSAGES, Section 3}}) set to `?1` to indicate that the response is to be immediately forwarded by intermediaries and not buffered.

~~~ http-message
{::include examples/stream/response-headers.http}
~~~
{: sourcecode-name="stream-response-headers-example.http" #stream-response-headers-example title="Notifications Stream Response Headers"}

{: #stream-response-multipart-content-type-field}
The `Content-Type` header field in response to the request in the first example is:

~~~ http-message
Content-Type: multipart/mixed; boundary="THIS_STRING_SEPARATES"

~~~
{: sourcecode-name="stream-response-multipart-content-header-example.http" #stream-response-multipart-content-header-example title="Notifications Stream Multipart Content Response Header"}

{: #stream-response-json-content-type-field}
whereas in response to the request in the second example is:

~~~ http-message
Content-Type: application/json-seq

~~~
{: sourcecode-name="stream-response-json-content-header-example.http" #stream-response-json-content-header-example title="Notifications Stream JSON Content Response Headers"}

### Notifications {#stream-response-body}

{: #stream-response-event}
Subsequently, when event(s) occur, the server transmits a notification.

{: #stream-update-event-multipart}
An event-notification transferred in a `multipart/mixed` response stream is identical to the [Single Notification Response](#single-notification-response){:noabbrev}, except that non "Content-*" fields are excluded as required by {{RFC2046, Section 5.1}}: 

~~~ http-message
{::include examples/notifications/update.multipart.txt}
~~~
{: sourcecode-name="stream-update-notification-multipart-example.http" #stream-update-notification-multipart-example title="Multipart Update Notification"}

{: #stream-update-event-json}
The same event-notification when transferred in an `application/json-seq` response stream is as follows:

~~~
{::include examples/notifications/update.json.txt}
~~~
{: sourcecode-name="stream-update-notification-json-example.http" #stream-update-notification-json-example title="JSON Update Notification"}

{: #stream-response-terminal-event}
A server MUST end the response immediately after transmitting the event-notification that signals the deletion of a resource.

{: #stream-delete-event-multipart}
The notification for a delete event expressed inside a multipart message might be as follows:

~~~ http-message
{::include examples/notifications/delete.multipart.txt}
~~~
{: sourcecode-name="stream-delete-notification-multipart-example.http" #stream-delete-event-multipart-example title="Multipart Delete Notification"}

{: #stream-delete-event-json}
The same notification for a delete event as JSON would be as follows:

~~~
{::include examples/notifications/delete.json.txt}
~~~
{: sourcecode-name="stream-delete-notification-json-example.http" #stream-delete-event-json-example title="JSON Delete Notification"}

{: #stream-response-timeout}
Otherwise, a server MUST end the response when the connection duration exceeds the period set in the =duration= property of the =Events= header field.
