# Representation {#representation}

{: #representation-description}
{{&protocol}} enables a user agent to ask and receive the current representation and subsequent event-notifications in a single request/response. When compared to using, say, Fetch {{FETCH}} and EventSource {{SSE}} in conjunction, {{&protocol}} not only saves on an extra round trip, but relieves a user agent from the burden of synchronizing the representation with event-notifications.

## Request {#representation-request}

{: #representation-request-procedure}
To request a representation of the resource in an {{&protocol}}, a client MUST express interest in receiving the representation in a preferred form using a realization of the subscription data model ({{data-model}}) with the `QUERY` method ({{HTTP-QUERY, Section 3}}).

{: #representation-request-example-description}
The following example shows a subscription request for the current representation along with the subsequent event-notifications transmitted using the `application/http` media type. The `state` property indicates interest in receiving representation. The preferred form of representation is specified using sub-properties identical to request headers in the `state` property.

~~~ http-message
{::include examples/stream/state-request.http}
~~~
{: sourcecode-name="representation-request-example.http" #representation-request-example title="Representation and Notifications Request"}

## Response {#representation-response}

{: #representation-not-available}
A server unable to provide a representation MUST NOT serve event-notifications. This does not apply to a conditional request for representation that is not fulfilled.

{: #representation-response-body}
A server able to provide a stream with a representation and event-notifications transmits the representation immediately following the response headers ({{stream-response-headers}}). Otherwise, the response is the same as that described in {{stream-response}}.

{: #representation-response-encapsulation}
Again, the `application/http` media type ({{-HTTP1, Section 10.2}}) is used for the purpose of illustration. Chunks have been omitted for clarity.

~~~ http-message
{::include examples/stream/response-headers.http}

{::include examples/stream/representation.http.txt}
~~~
{: sourcecode-name="representation-response-example.http" #representation-response-example title="Representation Response"}

{: #representation-response-non-standard}
While this is default behaviour, there is no requirement that a representation is the first message or that representations are sent only once. In such cases, the encapsulated message needs to indicate if it is a representation and not an event-notification. Such a mechanism is not defined in this specification.

{: #representation-response-notifications}
Notifications are transmitted just as in the case of [regular streaming](#stream-response). See {{example}} for a complete example of a response with representation and notifications.
