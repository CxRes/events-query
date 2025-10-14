# Terminology and Core Concepts {#terminology}

## Event {#event}

{: #event-defn}
An event is the instantaneous effect of the (normal or abnormal) termination of the invocation of an operation on an object of interest {{DESIGN-FRAMEWORK}}. The entity invoking an operation is termed the **(((!invoker)))invoker**{:noabbrev}.

{: #events-in-HTTP}
In the specific context of HTTP, the object of interest is data scoped to some resource. When the operation is an HTTP method, the invoker is a user agent. However, an operation need not be limited to an HTTP method, it might just as easily have been invoked using another mechanism or protocol. !Events are then an extension of resource state (See {{HTTP, Section 3.2}}) in the temporal dimension.

## Observation {#observation}

{: #observation-defn}
An event is considered observable, if an entity outside the invoker and object of interest can detect its occurrence {{DESIGN-FRAMEWORK}}. This entity is the **(((!observer)))observer**{:noabbrev}.

{: #observer-in-HTTP}
It follows from the HTTP uniform interface that the observer is always a server. The events that are observed, the mechanism of observation, and information recorded from the event are implementation details for the server.

{: #observation-roles}
That an origin server has to assume the role of an observer in order to generate event-notifications is obvious. An intermediary, while not observing the data scoped to a resource directly, still has the possibility to serve as an observer. An intermediary can observe events transmitted by an origin server or another intermediary, whether using {{&protocol}} or another mechanism, to generate event-notifications for outbound consumers.

## Event Notification {#notification}

{: #notification-defn}
An event-notification, or notification, is information transmitted by an observer upon an event or contiguous events on a resource.

{: #notification-in-HTTP}
{{&protocol}} extends "information hiding" behind the HTTP uniform interface to the temporal dimension by defining communication with respect to a transferable notification of the resource event(s), rather than transferring the event(s) themselves.

{: #notification-characteristics}
A target resource might be capable of generating multiple notifications for the same event(s) that a subscriber can select from using content negotiation. Hypertext notifications can not only provide information about the resource events but also processing instructions that help guide the recipient's future actions, for example, the possibility to determine the current representation from a previous representation.

## Subscription {#subscription}

{: #subscription-defn}
A subscription is an expression of interest to receive event-notifications sent to an observer. The requesting entity is a **(((!subscriber)))subscriber**{:noabbrev}.

{: #subscriber-in-HTTP}
Due to the request/response semantics of HTTP, the subscriber coincides with the recipient of event-notifications ({{DESIGN-FRAMEWORK}} uses the term _requester_ or _broker_ to identify a requesting entity, with the _broker_ and _recipient_ together forming the subscriber; for this specification, the distinction is not necessary).

{: #subscription-conneg}
The subscription in the form of a query affords the user agent the opportunity to engage in content negotiation for preferred form of event-notifications (as well as the representation, if simultaneously requested).

*[event]: #event (((event))) event
*[Event]: #event (((event))) Event
*[events]: #event (((event))) events
*[!Events]: #event (((event))) Events

*[invoker]:
*[Invoker]: (((invoker)))

*[observer]:
*[Observer]: (((observer)))

*[observation]: #observation
*[Observation]: #observation (((observation)))

*[Event-Notification]: #notification (((notification))) (((event notification))) Event Notification
*[event-notification]: #notification (((notification))) (((event notification))) event notification
*[Event-Notifications]: #notification (((notification))) (((event notification))) Event Notifications
*[event-notifications]: #notification (((notification))) (((event notification))) event notifications

*[Notification]: #notification (((event notification))) (((notification))) Notification
*[notification]: #notification (((event notification))) (((notification))) notification
*[Notifications]: #notification (((event notification))) (((notification))) Notifications
*[notifications]: #notification (((event notification))) (((notification))) notifications

*[subscriber]:
*[Subscriber]: (((subscriber)))

*[subscription]: #subscription
*[Subscription]: #subscription (((subscription)))
