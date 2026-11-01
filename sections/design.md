# Design {#design}

{: #resource-as-source-of-truth}
{{&protocol}} is predicated on a resource itself being the most intuitive source for events on it. {{&protocol}} treats notifications as a response to a query for an event occurring on the resource. With HTTP allowing representations to provide a potentially unbounded stream of data, the {{&protocol}} Protocol is also able to communicate multiple events on the resource as a stream of notifications.

## Goals {#goals}

{: #goals-list}
To aid the development of real-time applications, it is imperative that the {{&protocol}} Protocol reduces the complexity of both servers and clients implementing event-notifications. With this in mind, the goals of the {{&protocol}} Protocol are:

1. {: #goal--http-only}
to serve event-notifications using the Hypertext Transfer Protocol {{HTTP}}. Clients already fetching resources over HTTP need not switch to another protocol for receiving event-notifications.

1. {: #goal--unified-source-of-truth}
to send updates directly from a resource of interest, obviating the need for additional resources to be specifically dedicated as notification endpoints. In contrast to existing approaches, this frees up the client from the burden of coordinating the response from the resource of interest with notifications from an endpoint.

1. {: #goal--reliable-and-order}
to provide reliable and in-order transfer of event-notifications. The transfer of notifications directly from a resource ensures this for the duration of the response stream. Recovery across errors and loss of connection can be layered (see {{out-of-scope--temporal-coordination}}).

1. {: #goal--unified-request}
to deliver the representation and notifications in response to a single request, minimizing round trips between clients and servers. It also eliminates the need to synchronize the delivery of the representation and notifications.

1. {: #goal--content-negotiation}
to enable the transfer of event-notifications using arbitrary formats that might be content-negotiated. This allows implementers to serve notifications that are more expressive, say, in comparison to existing HTTP-based messaging protocols such as Server-Sent Events ({{HTML}}, <xref target="HTML" section="Section 9.2" relative="#server-sent-events" sectionFormat="bare"/>).

1. {: #goal--intermediation}
to specify transparent notification semantics that empower intermediaries to scale event-notifications, improve reliability and reduce latency. Intermediaries shall also be able to proactively update caches in real-time.

## Constraints {#constraints}

{: #constraints-list}
To the extent feasible, the {{&protocol}}:

1. {: #constraint--reuse}
adheres to established practices and conventions. In particular, every attempt has been made to reuse existing protocols and specifications. Implementers shall be able to repurpose existing tools and libraries for implementing this specification.

1. {: #constraint--rest}
conforms to the Representational State Transfer (REST) architectural style ({{REST}}, <xref target="REST" section="Chapter 5" relative="rest_arch_style.htm" sectionFormat="bare"/>), best practices for {{<<RFC9205}} {{RFC9205}}, and {{<<RFC6202}} {{RFC6202}}. This specification can thus be used to extend the capabilities of any existing or future resource to additionally serve event-notifications over HTTP. This is to afford implementers the opportunity to scale notifications with their data and application.
<!--
  See my original comment on the solid/specification Gitter channel on 24 April 2020
  https://matrix.to/#/!PlIOdBsCTDRSCxsTGA:gitter.im/$VgCcuq2HbpLKJvxIw4witAUOsqcdhC98glgzqVI1WOY
-->

## Scope {#scope}

{: #in-scope}
{{&protocol}} specifies a minimal protocol surface for transferring notifications over HTTP that includes:

1. {: #scope--discovery}
A mechanism to discover support for {{&protocol}} on a resource ({{discovery}}).

1. {: #scope--request}
A mechanism to request event-notifications from a resource (Sections {{<single-notification-request}} and {{<stream-request}}) along with the representation ({{representation-request}}).

1. {: #scope--query-data-model}
An abstract data model for requesting event-notifications ({{data-model}}).

1. {: #scope--single-response-semantics}
Response semantics for a [single notification](#single-notification-response){:noabbrev}.

1. {: #scope--streaming-response-semantics}
Response semantics for a stream carrying the [representation](#representation-response) (if requested) and [multiple event notifications](#stream-response){:noabbrev}.

## Out of Scope {#out-of-scope}

### Event Semantics {#out-of-scope--event-semantics}

{: #no-event-semantics}
Implementations require flexibility to generate event-notifications for the applications they wish to support on any given resource. It follows that the {{&protocol}} Protocol does not specify event semantics, including:

1. {: #no-event-semantics--specific-events}
The events for which a notification might be generated.

1. {: #no-event-semantics--notification-content}
The content of an event-notification.

Implementations can further provide mechanisms to filter the events generating notifications or to select the content of notifications. Affordances for such mechanisms can be exposed to clients by extending the abstract {{<<data-model}} with additional specifications.

### Realizations and Formats {#out-of-scope--realizations}

{: #no-format}
Since transferred data is subject to content negotiation between clients and server, the {{&protocol}} Protocol does not commit to a specific:

1. {: #no-format--request-data-model}
Realization of the abstract data model ({{data-model}}) used for requesting event-notifications.

1. {: #no-format--stream-representation}
Representation for the response stream encapsulating [multiple event notifications](#stream-response){:noabbrev}.

1. {: #no-format--event-notification}
Form of event-notifications within the response stream.

### Temporal Coordination {#out-of-scope--temporal-coordination}

{: #no-sync}
Event-notifications are typically implemented along with temporal coordination mechanisms, ranging in complexity from resumability on reconnection to real-time state synchronization. Implementations adopt these mechanisms based on application requirements. For this reason, the {{&protocol}} Protocol itself does not specify temporal coordination across responses. Instead, implementations shall be able to extend the {{<<data-model}} with additional specifications that provide:

1. {: #no-sync--versioning}
A scheme for labeling events on a resource or versioning its states.

1. {: #no-sync--replay}
Replay or resumption of event-notifications from a prior event. This can, for example, help clients recover upon reconnection without refetching the representation.

1. {: #no-sync--representation}
Identification of resource representations, separate from event-notifications, within the [response stream](#representation-response). This is useful for a first fetch before a client starts receiving notifications or for periodic reconciliation during state synchronization.

1. {: #no-sync--merge-types}
The Conflict-free Replicated Data Types (CRDT) or Operational Transforms (OT)
strategy to be implemented by a client for synchronizing the representation using event-notifications.

### Endpoints {#out-of-scope--endpoints}

{: #no-endpoints--replication}
APIs built on top of existing messaging protocols (see, for example, WebSocket {{WS}} and WebSub {{WEBSUB}}) typically transfer event-notifications for multiple resources from a single endpoint. To replicate this functionality with {{&protocol}}, an application can mint an additional resource, which represents a collection of other resources ({{REST}}, <xref target="REST" section="Section 5.2.1.1" relative="rest_arch_style.htm#sec_5_2_1_1" sectionFormat="bare"/>), to serve as an endpoint for multi-resource notifications.

{: #no-endpoints--unspecified}
The {{&protocol}} Protocol leaves the design of endpoints to additional specifications, which can provide:

1. {: #no-endpoints--advertise-endpoint}
A mechanism for a server to advertise an endpoint, and the resources whose events the endpoint can report.

1. {: #no-endpoints--identify-resources}
A mechanism for a client to specify the resources from which it wants to receive event-notifications, for example by extending the {{<<data-model}}.

{: #no-endpoints--discouraged}
Subscribing to multiple resources with a single {{&protocol}} is, however, discouraged. It mirrors methods that encapsulate multiple requests within a single message, such as MGET or MHEAD, which were rejected during the design of HTTP/1.1 because they violate several REST constraints ({{REST}}, <xref target="REST" section="Section 6.3.3.1" relative="evaluation.htm#sec_6_3_3_1" sectionFormat="bare"/>). Where per-resource subscriptions are impractical, such as in limited environments or with legacy applications, endpoints can serve as an alternative.

## Limitations {#limitations}

{: #limitation--connection-limits}
Browsers cap the number of persistent HTTP/1.1 connections per host ({{RFC6202, Section 5.1}}), limiting the suitability of {{&protocol}} for web applications in the browser that require simultaneous event-notifications from multiple resources on a host reachable only over HTTP/1.1. This limitation is identical to that of other HTTP-based streaming protocols, such as Server-Sent Events ({{HTML}}, <xref target="HTML" section="Section 9.2" relative="#server-sent-events" sectionFormat="bare"/>). Implementations are strongly encouraged to adopt HTTP/2 (or later). HTTP/1.1 servers might consider setting up a reverse proxy over HTTP/2 (or later), deploying an alternative service with a different protocol configuration ({{RFC7838}}), or providing alternate hosts for resources. Implementations might alternatively consider using endpoints to provide event-notifications for multiple resources (see {{out-of-scope--endpoints}}). Clients on a browser requesting event-notifications over an HTTP/1.1 connection are advised to limit the number of persistent connections they open simultaneously to a given host, for example, by sharing a subscription across the frames, tabs, or windows of the same browser ({{RFC6202, Section 5.1}}).

## Comparison with Server-Sent Events {#sse-comparison}

{: #sse-defacto}
At the time of writing, Server-Sent Events (SSE) has emerged as the de facto mechanism for transferring event-notifications over HTTP.

{: #sse-standardization}
The HTML Living Standard standardizes Server-Sent Events ({{HTML}}, <xref target="HTML" section="Section 9.2" relative="#server-sent-events" sectionFormat="bare"/>) with the EventSource interface[^EventSource_Obsolescence] ({{HTML}}, <xref target="HTML" section="Section 9.2.2" relative="#the-eventsource-interface" sectionFormat="bare"/>) and the `text/event-stream` media type ({{HTML}}, <xref target="HTML" section="Section 17.7" relative="#text/event-stream" sectionFormat="bare"/>). This approach is fundamentally inconsistent with terminology defined in HTTP Semantics ({{HTTP, Section 3.2}}), transferring a sequence of asynchronous messages instead of a _representation_ "intended to reflect a past, current, or desired state of a given resource". Practically, the EventSource interface is extremely limited. For example, it does not even allow for custom HTTP header fields to be sent with requests. The response is only sent as `text/event-stream`, a text format in which any line break is a delimiter. Not just binary content but even multi-line text that requires line endings to be preserved must therefore be encoded, typically as Base 64 ({{RFC4648, Section 4}}), which results in an additional burden for both the sender and the recipient.

[^EventSource_Obsolescence]: As of October 2022, WHATWG does not intend to extend the EventSource feature, as [announced](https://github.com/whatwg/html/issues/8297#issuecomment-1291658863) by HTML Living Standard maintainer Anne van Kesteren, with reasons for the decision cited in a subsequent [comment](https://github.com/whatwg/html/issues/8297#issuecomment-1293054529).

{: #sse-non-standard}
On one hand, these deficiencies have led to a proliferation of non-standard implementations of Server-Sent Events[^hacks] that provide support for custom header fields, such as for sending credentials, or use the POST method to communicate additional configuration in a request body. On the other hand, they have forced developers to adopt alternative protocols such as WebSocket {{WS}}, despite the increased complexity.

[^hacks]: such as [this](https://www.npmjs.com/package/event-source-plus), [this](https://www.npmjs.com/package/@microsoft/fetch-event-source), [this](https://www.npmjs.com/package/fetch-event-stream), [this](https://www.npmjs.com/package/extended-eventsource), [this](https://www.npmjs.com/package/ngx-sse-client) and [this](https://www.npmjs.com/package/sse.js)

{: #benefits-over-sse}
{{&protocol}} takes a principled approach to event-notifications, as established in {{terminology}}. In particular, the definition of an event-notification as a "representation" of event(s) ({{notification}}) admits the use of arbitrary media types for event-notifications. Clients can use content negotiation as well as preconditions in a subscription request. Further, {{&protocol}} not only lets clients receive both the representation and notifications over the same protocol, viz. HTTP, but these can be encapsulated within a single HTTP response. Clients do not need to, say, authenticate multiple times, possibly with different mechanisms, to obtain data that is logically from the same resource. Clients also do not have to coordinate and synchronize multiple response streams carrying a representation and notifications from the same effective resource.
