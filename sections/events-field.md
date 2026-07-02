# `Events` Header Field {#events-field}

{: #events-field-intro}
"=Events=" is a Dictionary structured header field ({{HTTP-SF, Section 3.2}}) to communicate the properties of a response stream to an {{&protocol}}.

{: #events-field-request}
In a request, the =Events= header field allows a client to indicate its preferences for the properties of the response stream carrying event-notifications. The =Events= header field is not meant for content negotiation.

{: #events-field-response}
In a response, the =Events= header field allows a server to specify the properties of a response stream carrying event-notifications.

{: #events-field-stipulations}
The order of keys in the =Events= header field is insignificant. Senders SHOULD NOT generate keys not registered with the HTTP Events Field Registry (the exception is only for experimentation). Recipients MAY ignore keys that they are unaware of.

*[=Events=]: #events-field (((events (header field) ))) `Events`

## `duration` Property {#duration-property}

{: #duration-property-intro}
The "=duration=" property is an Integer ({{HTTP-SF, Section 3.3.1}}) or Decimal ({{HTTP-SF, Section 3.3.2}}) valued Dictionary key specified on the =Events= header field to communicate the response duration in seconds. Only non-negative values are valid.

{: #duration-property-request}
In a request, the =duration= property indicates the duration for which a client wants to receive event-notifications. A value of `0` indicates that the client does not have a preference for the response duration. A server MAY ignore this property.

{: #duration-property-response}
In a response, the =duration= property specifies the maximum duration for which a server intends to serve event-notifications. This property is merely advisory, and a server MAY end the response before this duration. 

{: #duration-property-response-authz}
A server SHOULD NOT set a response duration longer than the period for which an authorization is valid. This is to ensure that a server does not send notifications to clients after their authorization expires, while accommodating valid authorizations where the server is unable to determine the authorization period in advance. Once the request's authorization expires or is revoked, the server MUST NOT send any more notifications.

{: #duration-property-stipulations}
A sender MUST conform to these stipulations when generating the =duration= property. If the value of the =duration= property fails to conform to these stipulations, it MUST be ignored by the recipient.

*[=duration=]: #duration-property (((duration (property) ))) `duration`
