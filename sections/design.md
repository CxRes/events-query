# Design {#design}

{: #resource-as-source-of-truth}
{{&protocol}} is predicated on a resource being the most intuitive source for notifying its events. {{&protocol}} treats notifications as a response to a query for an event occurring on the resource. With HTTP allowing representations to provide a potentially unbounded stream of data, the {{&protocol}} Protocol is also able to communicate multiple events on the resource as a stream of notifications.

{: #endpoints-not-needed}
Unlike other protocols, {{&protocol}} does not (usually) require additional resources to be specifically dedicated as endpoints for delivering event-notifications. By giving a resource the ability to send notifications when an event occurs, {{&protocol}} aims to reduce the complexity of both servers and clients implementing notifications, making it easier to develop real-time applications.

## Goals {#goals}

{: #goals-list}
The goals of the {{&protocol}} are:

1. {: #goal--http-only}
to use the Hypertext Transfer Protocol {{HTTP}} for reliable and in-order transfer of event-notifications. Clients fetching resources using HTTP need not required to switch to another protocol for receiving event-notifications.

1. {: #goal--unified-source-of-truth}
to provide updates directly from a resource of interest, obviating the need to create another endpoint for event-notifications. This eliminates the need to co-ordinate responses between a resource and the notification endpoint as is the case with existing approaches.

1. {: #goal--unified-request}
to allow clients to fetch representation and notifications in response to a single request, minimizing round-trips between clients and servers and eliminating the need to manage race conditions between responses.

1. {: #goal--negotiation}
to allow event-notifications to be communicated in any arbitrary format that might be negotiated. Implementers shall be able to provide more expressive notifications in comparison to existing HTTP based messaging protocols such as Server Sent Events {{SSE}}.

1. {: #goal--intermediation}
to specify transparent semantics that allow intermediaries to participate in scaling, improving reliability, and reducing latency of event-notifications as well as proactively update caches.

## Constraints {#constraints}

{: #constraints-list}
To the extent feasible, the {{&protocol}}:

1. {: #constraint--reuse}
adheres to established practices and conventions. In particular, every attempt has been made to reuse existing protocols and specifications. Implementers shall be able to repurpose existing tools and libraries for implementing this specification.

1. {: #constraint--rest}
conforms to {{<<REST}}, best practices for {{<<RFC9205}} {{RFC9205}}, and {{<<RFC6202}} {{RFC6202}}. This specification can, thus, be used to extend the capabilities of any existing HTTP resource to provide event-notifications. Implementers shall be able to scale notifications along with their data/applications.
<!--
  See my original comment on the solid/specification Gitter channel on 24 April 2020
  https://matrix.to/#/!PlIOdBsCTDRSCxsTGA:gitter.im/$VgCcuq2HbpLKJvxIw4witAUOsqcdhC98glgzqVI1WOY
-->

## Scope {#scope}

{: #in-scope}
The {{&protocol}} Protocol specifies:

1. {: #scope--discovery}
A mechanism to discover notification capabilities on a resource ({{discovery}}).

1. {: #scope--request}
A mechanism to request event-notifications from a resource (Sections {{<single-notification-request}} and {{<stream-request}}) along with the representation ({{representation-request}}).

1. {: #scope--query-data-model}
An abstract data model for the subscription ({{data-model}}).

1. {:noabbrev #scope--single-response-semantics}
Semantics for a response carrying a [single notification](#single-notification-response){:noabbrev}.

1. {:noabbrev #scope--streaming-response-semantics}
Semantics for the response streaming [multiple event notifications](#stream-response){:noabbrev} as well as the [representation](#representation-response), if requested.


{: #out-of-scope}
The {{&protocol}} Protocol does not specify:

1. {: #no-scope--specific-data-model}
A realization of the abstract data model used for requesting event-notifications. For the purposes of illustration, we shall use an imaginary `example/events-query` media-type for the request.

1. {: #no-scope--specific-events}
Specific events for which a notification is generated. !Events for which notifications are generated can vary per resource.

1. {: #no-scope--notification-format}
The form or content of an event-notification. Implementations have the flexibility to generate event-notifications for the applications they wish to support on a resource. We shall use a very simple YAML notification using an imaginary `example/event-notification` media-type for illustration.

1. {: #no-scope--stream-representation}
Specific representations for the response stream with multiple notifications. For the purpose of illustration, we shall use the `application/http` media-type ({{-HTTP1, Section 10.2}}) as the composite media-type for the response that includes a representation and/or multiple event-notifications.

## Limitations {#limitations}

{: #limitation--resource-specificity}
{{&protocol}} only allows notifications to be sent for events on a given resource. To send notifications for events on multiple resources in a single response, implementations will need to mint separate resources as notification endpoints. This is no different from APIs built on top of existing messaging protocols (See, for example, {{WS}} and {{WEBSUB}}).

{: #limitation--connection-limits}
Browsers cap the number of persistent HTTP/1.1 connections per host, limiting the suitability of {{&protocol}} for web applications in the browser that require simultaneous event-notifications from multiple resources on the same host. This limitation is identical to that of other HTTP streaming based protocols, such as Server-Sent Events {{SSE}}. Implementations are strongly encouraged to adopt HTTP/2 (or later). HTTP/1.1 servers might consider setting up a reverse proxy over HTTP/2 (or later) or implement mitigation strategies, such as to maximize the number of concurrent connections and to provide alternate hosts for resources. Implementations might alternatively consider using endpoints to provide event-notifications for multiple resources as previously described. Clients on a browser requesting event-notifications over an HTTP/1.1 connection are advised to exercise caution when opening multiple simultaneous persistent connections to any given host.
