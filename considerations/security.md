# Security Considerations {#security-considerations}

{: #derived-security-considerations}
{{&protocol}} is subject to the security considerations of the HTTP `QUERY` method ({{HTTP-QUERY, Section 2}}) and more generally HTTP Semantics. Considerations relevant to the use of HTTP `QUERY` method are discussed in {{Section 4 of HTTP-QUERY}}. HTTP Semantics and its use for transferring information over the Internet are discussed in {{Section 17 of HTTP}}.

{: #security-considerations-ddos}
When serving event-notifications, servers are required to keep the response stream open for an extended period of time. Since the effort required to request notifications is tiny compared to the time, memory, and bandwidth consumed attempting to serve the notifications, servers implementing {{&protocol}} have increased susceptibility to Denial-of-Service attacks. Servers ought to ignore, coalesce, or reject egregious subscription requests, such as repeated requests from the same origin within a short interval of time.
