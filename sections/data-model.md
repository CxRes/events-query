# Subscription Data Model {#data-model}

{: #data-model-description}
The abstract data model specifies the semantics of an {{&protocol}}.

{: #data-model-requirements}
A realization of the data model allows a client to express in a subscription request:

+ {: #data-model-requirement-notifications}
an interest in receiving a stream of event-notifications from a resource in a preferred form.

+ {: #data-model-requirement-representation}
an interest in receiving a representation of a resource (as would be sent in response to a GET request) in a preferred form.

{: #data-model-conditional}
A client MAY express interests conditional on the representations it is prepared to accept in response to the QUERY request.

{: #data-model-realization}
Implementations can choose appropriate media types to realize the subscription data model. Implementations are free to extend the data model to include additional data. A specific realization of the data model is beyond the scope of this specification (see {{out-of-scope--realizations}}).

{: #data-model-example}
The following example shows the body of a subscription request wherein the `state` and `events` properties use request header fields to express preferences for the representation and event-notifications respectively, in a YAML-like syntax.

~~~ yaml
state:
  Accept: text/html
events:
  Accept: example/event-notification
~~~
{: sourcecode-name="data-model-example.yaml" #data-model-example-yaml title="Events Query Data Model in a YAML-like syntax"}

{: #data-model-example-2}
The following modifies the previous example to express interests conditional on the `type` and `language` of the response.

~~~ yaml
- type: application/json-seq
  language: hi
  state:
    "@context": [https://schema.org, {"@language": hi}]
    "@type": Person
  events:
    "@context": [https://www.w3.org/ns/activitystreams, {"@language": hi}]
- type: application/json-seq
  state:
    "@context": https://schema.org
    "@type": Person
  events:
    "@context": https://www.w3.org/ns/activitystreams
- language: hi
  state:
    Accept: text/html
    Accept-Language: hi
  events:
    Accept: example/event-notification
    Accept-Language: hi
- state:
    Accept: text/html
  events:
    Accept: example/event-notification
~~~
{: sourcecode-name="data-model-example-2.yaml" #data-model-example-2-yaml title="Events Query Data Model with Conditional Interests"}

*[data model]: #data-model
*[Data Model]: #data-model

*[+events+]: #data-model-property-events (((events (property) ))) `events`
*[+state+]: #data-model-property-state (((state (property) ))) `state`
