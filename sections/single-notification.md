# Single Notification {#single-notification}

{: #single-notification-description}
The simplest {{&protocol}} is to request a notification for the next event(s) on a resource. This, in effect, adds long polling capability ({{RFC6202, Section 2}}) to a resource.

## Request {#single-notification-request}

{: #single-notification-procedure}
To receive a single notification, a client makes a `QUERY` request ({{HTTP-QUERY, Section 3}}) using a realization of the subscription data model that MUST NOT include an interest in receiving a stream of event notifications.

{: #single-notification-request-conneg}
Since the content of the response is an event-notification, a client can negotiate its form with header fields in the usual manner.

~~~ http-message
{::include examples/single-notification/request.http}
~~~
{: sourcecode-name="single-notification-request-example.http" #single-notification-request-example title="Single Event Notification Request"}

## Response {#single-notification-response}

{: #single-notification-response-close}
When a single notification is requested, the server MUST close the connection immediately after sending the event-notification.

~~~ http-message
{::include examples/single-notification/response.http}
~~~
{: sourcecode-name="single-notification-response-example.http" #single-notification-response-example title="Single Event Notification Response"}

{{&zwsp}}

{:aside #no-hogging}
> **Implementation Advice**
>
> When a user navigates away from a website or an application using {{&protocol}}, user agents are strongly encouraged to properly close the response and release the connection.
