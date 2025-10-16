# Single Notification {#single-notification}

{: #single-notification-description}
The simplest {{&protocol}} is to request a notification for the next event(s) on a resource. This, in effect, adds long polling capability ({{RFC6202, Section 2}}) to a resource.

## Request {#single-notification-request}

{: #single-notification-request-content}
To be notified of the next event(s) on a resource using {{&protocol}}, a client can send an empty query. A server MUST consider a request with an empty query in an appropriate media type made using the `QUERY` method ({{HTTP-QUERY, Section 3}}) as a subscription request for a single event-notification.

{: #single-notification-request-conneg}
Since the content of the response is an event-notification, a client can negotiate its form in the usual manner with header fields.

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
