# Security Considerations {#security-conideration}

{: #derived-security-considerations}
{{&protocol}} is subject to the security considerations of the HTTP `QUERY` method ({{HTTP-QUERY, Section 2}}) and more generally HTTP Semantics. Considerations relevant to the use of HTTP `QUERY` method are discussed in {{Section 4 of HTTP-QUERY}} and HTTP Semantics and its use for transferring information over the Internet are discussed in {{Section 17 of HTTP}}.

{: #security-considerations-ddos}
When serving a stream of event-notifications, resources are required to keep the response stream open for an extended period of time, making them more susceptible to Denial-of-Service attacks because the effort required to request notifications from the same resource is tiny compared to the time, memory, and bandwidth consumed by attempting to serve the notifications. Servers ought to ignore, coalesce, or reject egregious event-notification request, such as repeated notification requests to a resource from the same origin.
