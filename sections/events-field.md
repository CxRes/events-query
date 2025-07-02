# `Events` Header Field {#events-field}

{: #events-field-request}
The =Events= header field when used by a client in a request communicates preferences for the {{&protocol}} response. The =Events= header field is not meant for content negotiation.

{: #events-field-response}
The =Events= header field allows a server to communicate the properties of a response carrying event-notifications.

{: #events-field-stipulations}
=Events= is a Dictionary structured header field ({{HTTP-SF, Section 3.2}}). The order of keys is insignificant. Senders SHOULD NOT generate keys not registered with the HTTP Event Field Registry (An exception is made to allow for experimentation). Recipients MAY ignore keys that they are unaware of.

*[=Events=]: #events-field (((events (header field) ))) `Events`

## `duration` Property {#duration-property}

{: #duration-property-request}
The =duration= property when be used by a client in a request specifies the duration for which they prefer the response stream to remain open. A server is completely free to ignore this property.

{: #duration-property-response}
The =duration= property when used by a server in a response indicates the minimum duration for which a server intends to keep the response stream open. This property is merely advisory, and a server might still close the response stream before this duration.

{: #duration-property-stipulations}
The =duration= property is a key specified in the =Events= header field. It is of the type Integer ({{HTTP-SF, Section 3.3.1}}) with its value indicating duration in seconds. Only positive integer values are valid. A value of `0` indicates an indefinite duration. A sender MUST conform to these stipulations when generating the =duration= property. If the value of the =duration= property fails to conform to these stipulations, it MUST be ignored by the recipient.

*[=duration=]: #duration-property (((duration (property) ))) `duration`
