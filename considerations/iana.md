# IANA Considerations {#iana-considerations}

{: #change-controller}
The change controller for the following registrations is: "IETF (iesg@ietf.org) - Internet Engineering Task Force".

## HTTP Field Registration {#field-registration}

{: #field-registration-instruction}
IANA is requested to add the following entry in the "[Hypertext Transfer Protocol (HTTP) Field Name Registry](https://www.iana.org/assignments/http-fields/)" (See {{Section 16.1.1 of HTTP}}):

| Header Field Names  | Status     | Structured-Type  | Reference         |
|-
| =Events=            | Permanent  | Dictionary       | {{events-field}}  |
{: title="List of HTTP Field Name registrations" #field-registration-list}

## The HTTP Events Field Registry {#events-field-registry}

{: #registry-registration-instruction}
IANA is requested to create a new registry, "HTTP Events Field Registry", under the [Hypertext Transfer Protocol (HTTP) Parameters](https://www.iana.org/assignments/http-parameters/) registry to register properties for use in the =Events= header field. New registrations will use the Specification Required policy ({{RFC8126, Section 4.6}}).

### Template {#events-field-registry-template}

{: #events-field-registry-template-required-list}
The registration of an =Events= property MUST include the following fields:

+ {: #events-field-registry-template--property-name}
Property Name: A Dictionary ({{HTTP-SF, Section 3.2}}) key to be used in the =Events= header field.
+ {: #events-field-registry-template--structured-type}
Structured Type: The Structured Data Type ({{HTTP-SF, Section 3.3}}) of the value associated with the key, according to requirements in {{Section 3.2 of HTTP-SF}}.
+ {: #events-field-registry-template--refrence}
Reference: A pointer to the specification text.

{: #events-field-registry-template-optional-list}
The registration MAY also include the following fields:

+ {: #events-field-registry-template--optional-parameters}
Optional Parameters: An enumeration of optional parameters and the Structured Data Type ({{Section 3.3 of HTTP-SF}}) of value associated with the parameter, according to requirements in {{Section 3.1.2 of HTTP-SF}}
+ {: #events-field-registry-template--comments}
Comments: Additional information to be included in the template.

### Initial Registry Contents {#events-field-registry-initial-content}

{: #events-field-registry-initial-content-instruction}
The initial contents of the HTTP Events Field Registry are:

| Property Name  | Structured-Type  | Reference             |
|-
| =duration=     | Integer Item     | {{duration-property}} |
{: title="List of HTTP Events Field property name registrations" #events-property-registration-list}
