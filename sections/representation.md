# Representation {#representation}

{: #representation-description}
{{&protocol}} lets a user agent to ask and receive the current representation and subsequent event-notifications in a single request/response. When compared to using, say, Fetch {{FETCH}} and EventSource {{SSE}} in conjunction, {{&protocol}} not only saves on an extra round trip, but relieves a user agent from the burden of handling the possible race condition.

## Request {#representation-request}

{: #representation-request-procedure}
To request a representation of the resource in an {{&protocol}}, a client MUST express the interest in receiving the representation in a preferred form using a realization of the subscription data model ({{data-model}}) with the `QUERY` method ({{HTTP-QUERY, Section 3}}).

{: #representation-request-example-description}
The following example shows subscription request for representation along with notifications transmitted using the `application/http` media-type. The `state` property indicates the interest in receiving representation. The preferred form of representation is specified using the request headers in the `state` property.

~~~ http-message
{::include examples/stream/state-request.http}
~~~
{: sourcecode-name="representation-request-example.http" #representation-request-example title="Representation and Notifications Request"}

## Response {#representation-response}

{: #representation-not-available}
A server unable to provide a representation MUST NOT serve event-notifications. This does not apply in case of conditional request for representation that is not fulfilled.

{: #representation-response-body}
A server able to provide a stream with a representation and event-notifications transmits the representation immediately following the response header ({{stream-response-header}}). Otherwise, the response is the same as that described in {{stream-response}}.

{: #representation-response-encapsulation}
Again, we shall use the `application/http` media-type ({{-HTTP1, Section 10.2}}) for the purpose of illustration. Chunks have been omitted for clarity.

~~~ http-message
{::include examples/stream/response-headers.http}

{::include examples/stream/representation.http}
~~~
{: sourcecode-name="representation-response-example.http" #representation-response-example title="Representation Response"}

{: #representation-response-non-standard}
While this is default behaviour, there is no requirement that a representation is the first message or is sent only once. In such cases, the encapsulated message needs to indicate if it is a representation and not an event-notification. Such a mechanism is not defined in this specification.

{: #representation-response-notifications}
Notifications are transmitted just as described in {{stream-response}}. See {{example}} for a complete example of a response with representation and notifications.
