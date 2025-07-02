# Introduction {#introduction}

{: #intro-http-traditional-use}
HTTP was originally designed for transferring static documents within a single request and response. HTTP does not automatically inform clients of changes to a document. This design was adequate for web pages that were mostly static and written by hand.

{: #intro-real-time-needs}
But web-applications today are dynamic, requiring instantaneous updates from sources. The many workarounds developed over the years to provide real-time updates for resources using HTTP have proven to be inadequate. Web programmers instead resort to implementing custom messaging systems over alternate protocols such as WebSockets {{WS}}, which requires additional layers of code, typically involving non-standard JavaScript frameworks to provide event-notifications. It also requires additional work to coordinate a representation and notifications that are served on different protocols.

{: #intro-events-query}
{{&protocol}} is a minimal protocol built on top of {{HTTP}} that allows applications to request event-notifications directly from a resource of interest using the `QUERY` method ({{HTTP-QUERY, Section 3}}).

{: #intro-convinience}
The objective of this specification is to make the request and receipt of event-notifications extremely convenient for consumers. Programmers implementing {{&protocol}} shall no longer be forced to switch to another protocol to incorporate real-time functionality in their web applications. Not only that, web-applications shall receive a representation and notifications in a single response, obviating any need for co-ordination and saving on unnecessary roundtrips.

{: #intro-fetch-example keepWithNext="true"}
With the help of a suitable composite media-type parser, {{&protocol}} responses can be consumed with just a few lines of code, as illustrated in the JavaScript example below:

~~~ javascript
const response = fetch("http://example.com/foo", {
  method: "QUERY",
  headers: {
    "Content-Type": "application/json",
    Accept: "application/http"
  },
  body: JSON.stringify({
    state: { Accept: "text/plain" },
    events: { Accept: "example/event-request" }
  })
});

const splitResponse = splitHTTPResponseStream(response);
// splits the response into an iterable of representation and notifications

const {done, value: representation} = await splitResponse.next();
if (!done) {
  // do something with the representation
  // API identical to fetch Response
}

for await (const notification of splitResponse) {
  // do something with a notification
  // API identical to fetch Response
}
~~~
{: #events-query-fetch-example sourcecode-name="events-query-fetch-example.js" title="Events Query fetch example"}

{: #intro-conneg}
Unlike other HTTP based event-notification mechanisms, {{&protocol}} supports content negotiation for notifications, just like representations. Thus, the {{&protocol}} Protocol preserves the flexibility of interaction afforded by HTTP and extends it to event-notifications.

{: #intro-sync}
When combined with suitable data synchronization mechanisms like Conflict Free Replicated Data Types (CRDT) or Operational Transforms (OT), event-notifications can be used create representations that are "live" for user agents. This has the potential to immensely simplify the task of programming multi-author distributed real-time applications.
