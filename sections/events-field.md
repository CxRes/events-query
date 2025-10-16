# `Events` Header Field {#events-field}

{: #events-field-intro}
"=Events=" is a Dictionary structured header field ({{HTTP-SF, Section 3.2}}) to communicate the properties of a response stream to an {{&protocol}}.

{: #events-field-request}
In a request, the =Events= header field allows a client to indicate its preferences for the properties of the response stream carrying event-notifications. The =Events= header field is not meant for content negotiation.

{: #events-field-response}
In a response, the =Events= header field allows a server to specify the properties of a response stream carrying event-notifications.

{: #events-field-stipulations}
The order of keys in the =Events= header field is insignificant. Senders SHOULD NOT generate keys not registered with the HTTP Event Field Registry (with the exception made to allow experimentation). Recipients MAY ignore keys that they are unaware of.

*[=Events=]: #events-field (((events (header field) ))) `Events`

## `duration` Property {#duration-property}

{: #duration-property-intro}
The "=duration=" property is an Integer ({{HTTP-SF, Section 3.3.1}}) or Decimal ({{HTTP-SF, Section 3.3.2}}) valued Dictionary key specified on the =Events= header field to communicate the response duration in seconds.

{: #duration-property-request}
In a request, the =duration= property indicates the duration for which a client wants to receive event-notifications. A server MAY ignore this property.

{: #duration-property-response}
In a response, the =duration= property specifies the maximum duration for which a server intends to serve event-notifications. This property is merely advisory, and a server MAY close the response stream before this duration.

{: #duration-property-stipulations}
Only positive values are valid. A value of `0` indicates an indefinite duration. A sender MUST conform to these stipulations when generating the =duration= property. If the value of the =duration= property fails to conform to these stipulations, it MUST be ignored by the recipient.

*[=duration=]: #duration-property (((duration (property) ))) `duration`
