# Example {#example}

{: #example-description}
The following example illustrates a complete request and response for representation and notifications using {{&protocol}}. Chunks have been omitted for clarity.

## Request {#example-request-representation-and-notifications}

~~~ http-message
{::include examples/stream/state-request.http}
~~~
{: sourcecode-name="notifications-stream-request-with-representation.http" #notifications-stream-request-with-representation-example title="Request for Representation and Notifications"}

## Response {#example-response-representation-and-notifications}

~~~ http-message
{::include examples/stream/response-headers.http}

{::include examples/stream/representation.http.txt}

{::include examples/notifications/update.http.txt}

{::include examples/notifications/delete.http.txt}
~~~
{: sourcecode-name="notifications-stream-response-with-representation.http" #notifications-stream-response-with-representation-example title="Response Stream with Representation and Notifications"}
