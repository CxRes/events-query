# Design {#design}

{: #resource-as-source-of-truth}
{{&protocol}} is predicated on a resource itself being the most intuitive source for events on it. {{&protocol}} treats notifications as a response to a query for an event occurring on the resource. With HTTP allowing representations to provide a potentially unbounded stream of data, the {{&protocol}} Protocol is also able to communicate multiple events on the resource as a stream of notifications.

## Goals {#goals}

{: #goals-list}
To aid the development of real-time applications, it is imperative that the {{&protocol}} Protocol reduces the complexity of both servers and clients implementing event-notifications. With this in mind, the goals of the {{&protocol}} Protocol are:

1. {: #goal--http-only}
to provide reliable and in-order transfer of event-notifications using the Hypertext Transfer Protocol {{HTTP}}. Clients fetching resources over HTTP need not switch to another protocol for receiving event-notifications.

1. {: #goal--unified-source-of-truth}
to send updates directly from a resource of interest, obviating the need for additional resources to be specifically dedicated as notification endpoints. In contrast to existing approaches, this frees up the client from the burden of coordinating the response from the resource of interest with notifications from an endpoint.

1. {: #goal--unified-request}
to deliver the representation and notifications in response to a single request, minimizing round trips between clients and servers. It also eliminates the need to synchronize the delivery of the representation and notifications.

1. {: #goal--content-negotiation}
to enable the transfer of event-notifications using arbitrary formats that might be content-negotiated. This allows implementers to serve notifications that are more expressive, say, in comparison to existing HTTP-based messaging protocols such as Server-Sent Events {{SSE}}.

1. {: #goal--intermediation}
to specify transparent notification semantics that empowers intermediaries to scale event-notifications, improve reliability and reduce latency. Intermediaries shall also be able to proactively update caches in real-time.

## Constraints {#constraints}

{: #constraints-list}
To the extent feasible, the {{&protocol}}:

1. {: #constraint--reuse}
adheres to established practices and conventions. In particular, every attempt has been made to reuse existing protocols and specifications. Implementers shall be able to repurpose existing tools and libraries for implementing this specification.

1. {: #constraint--rest}
conforms to {{<<REST}}, best practices for {{<<RFC9205}} {{RFC9205}}, and {{<<RFC6202}} {{RFC6202}}. This specification can thus be used to extend the capabilities of any existing or future resource to additionally serve event-notifications over HTTP. This is to afford implementers the opportunity to scale notifications with their data and application.
<!--
  See my original comment on the solid/specification Gitter channel on 24 April 2020
  https://matrix.to/#/!PlIOdBsCTDRSCxsTGA:gitter.im/$VgCcuq2HbpLKJvxIw4witAUOsqcdhC98glgzqVI1WOY
-->

## Scope {#scope}

{: #in-scope}
The {{&protocol}} Protocol specifies:

1. {: #scope--discovery}
A mechanism to discover support for {{&protocol}} on a resource ({{discovery}}).

1. {: #scope--request}
A mechanism to request event-notifications from a resource (Sections {{<single-notification-request}} and {{<stream-request}}) along with the representation ({{representation-request}}).

1. {: #scope--query-data-model}
An abstract data model for requesting event-notifications ({{data-model}}).

1. {:noabbrev #scope--single-response-semantics}
Response semantics for a [single notification](#single-notification-response){:noabbrev}.

1. {:noabbrev #scope--streaming-response-semantics}
Response semantics for a stream carrying the [representation](#representation-response) (if requested) and [multiple event notifications](#stream-response){:noabbrev}.


{: #out-of-scope}
The {{&protocol}} Protocol does not specify:

1. {: #no-scope--specific-data-model}
A realization of the abstract data model used for requesting event-notifications.

1. {: #no-scope--specific-events}
The events for which a notification might be generated. This can be varied per resource.

1. {: #no-scope--notification-format}
The form or content of an event-notification. Implementations have the flexibility to generate event-notifications for the applications they wish to support on a resource.

1. {: #no-scope--stream-representation}
Specific representations for the response stream with multiple notifications.

## Limitations {#limitations}

{: #limitation--resource-specificity}
{{&protocol}} only allows notifications to be sent for events on a given resource. To transfer event-notifications originating from multiple resources in a single response, implementations will need to mint additional resources to serve as notification endpoints. This is no different from APIs built on top of existing messaging protocols (See, for example, WebSocket {{WS}} and WebSub {{WEBSUB}}).

{: #limitation--connection-limits}
Browsers cap the number of persistent HTTP/1.1 connections per host, limiting the suitability of {{&protocol}} for web applications in the browser that require simultaneous event-notifications from multiple resources on the same host. This limitation is identical to that of other HTTP-based streaming protocols, such as Server-Sent Events {{SSE}}. Implementations are strongly encouraged to adopt HTTP/2 (or later). HTTP/1.1 servers might consider setting up a reverse proxy over HTTP/2 (or later) or implement mitigation strategies, such as, maximizing the number of concurrent connections and providing alternate hosts for resources. Implementations might alternatively consider using endpoints to provide event-notifications for multiple resources as previously described. Clients on a browser requesting event-notifications over an HTTP/1.1 connection are advised to exercise caution when simultaneously opening multiple persistent connections to a given host.

## Comparison with Server-Sent Events

At the time of writing, Server-Sent Events (SSE) is the de facto mechanism for transferring event-notifications over HTTP, standardized through the EventSource API {{SSE}} as part of HTML Living Standard by the WHATWG.[^EventSource_Obsolecense]

[^EventSource_Obsolecense]: As of October 2022, HTML Living Standard maintainer Anne van Kesteren has [stated](https://github.com/whatwg/html/issues/8297#issuecomment-1291658863) that WHATWG does not intend to extend EventSource, with reasons for the decision cited in a subsequent [comment](https://github.com/whatwg/html/issues/8297#issuecomment-1291658863).

Server-Sent Events defines the `text/event-stream` media type to transmit event-notifications in response to a GET request. This approach is fundamentally inconsistent with terminology defined in HTTP Semantics ({{HTTP, Section 3.2}}), transferring a sequence of asynchronous messages instead of a representation "that is intended to reflect a past, current, or desired state of a given resource". Practically, the `text/event-stream` media type being limited to only textual content forces developers to opt for alternative protocols such as WebSockets {{WS}}, despite the increased complexity. The EventSource API does not even allow for headers to be sent with requests.

{{&protocol}} takes a principled approach to event-notifications, as established in {{terminology}}. In particular, the definition of an event-notification as a "representation" of event(s) ({{notification}}) admits the use of arbitrary media types for event-notifications. Clients can use content negotiation as well as preconditions in a subscription request. Further, {{&protocol}} not only lets clients receive both the representation and notifications over the same protocol, viz. HTTP, but these can be encapsulated within a single HTTP response. Clients do not need to, say, authenticate multiple times, possibly with different mechanisms, to obtain data from the same resource or co-ordinate and synchronize multiple response streams carrying a representation and notifications.
