# Introduction {#introduction}

{: #intro-http-traditional-use}
HTTP was originally designed as a stateless, request/response protocol for transferring hypermedia documents on the web ({{HTTP, Section 1.2}}). This design was adequate for web pages that were mostly static and written by hand.

{: #intro-real-time-needs}
But web applications have evolved over time to provide increasingly dynamic and interactive experiences, requiring near-instantaneous updates. HTTP does not automatically inform clients of changes to a resource. Developers have employed various techniques, such as Comet {{COMET}} and Server-Sent Events {{SSE}} to work around this constraint, but these can be suboptimal for many applications.

{: #intro-alternate-protocols}
For this reason, web programmers often prefer implementing custom messaging systems over alternate protocols such as WebSocket {{WS}} and WebSub {{WEBSUB}}. Not only does this approach require additional layers of code, involving multiple Web APIs and/or userland libraries such as [socket.io](https://socket.io/), it demands extra coordination effort to synchronize representation and notifications across multiple protocols. The dual-protocol approach thus compounds the development and maintenance overhead. Furthermore, deployment at scale is challenging with the notifications traffic now opaque to network intermediaries.

{: #intro-events-query}
{{&protocol}} is a minimal protocol built on top of the Hypertext Transfer Protocol {{HTTP}} that allows applications to request event-notifications directly from a resource of interest using the `QUERY` method ({{HTTP-QUERY, Section 3}}).

{: #intro-convenience}
The objective of this specification is to make the request and receipt of event-notifications extremely convenient for consumers. {{&protocol}} allows programmers to incorporate real-time functionality in their web applications without the need to switch to another protocol. Further, {{&protocol}} can deliver representation and notifications from a resource in a single response, obviating any need for coordination and saving on unnecessary round trips.

{: #intro-fetch-example keepWithNext="true"}
With the help of a suitable composite media type parser, {{&protocol}} responses can be consumed with just a few lines of code, as illustrated in the JavaScript example below:

~~~ javascript
const response = await fetch("http://example.com/foo", {
  method: "QUERY",
  headers: {
    Accept: "application/http",
    "Content-Type": "example/events-query"
  },
  body: JSON.stringify({
    state: { Accept: "text/plain" },
    events: { Accept: "example/event-notification" }
  })
});

// split the response into an iterable of representation and notifications
const splitResponse = splitHTTPResponseStream(response);

// read the representation
const {done, value: representation} = await splitResponse.next();
if (!done) {
  // do something with the representation
}

// iterate over notifications
for await (const notification of splitResponse) {
  // do something with a notification
}
~~~
{: #events-query-fetch-example sourcecode-name="events-query-fetch-example.js" title="Events Query fetch example"}

{: #intro-conneg}
Unlike other event-notification mechanisms, {{&protocol}} supports content negotiation for notifications, just like representations. Thus, the {{&protocol}} Protocol preserves the flexibility of interaction afforded by HTTP and extends it to event-notifications.

{: #intro-sync}
When combined with suitable data synchronization technologies like Conflict Free Replicated Data Types (CRDT) or Operational Transforms (OT), event-notifications can be used to create "live" representations. This can immensely simplify the task of programming multi-author distributed real-time applications.
