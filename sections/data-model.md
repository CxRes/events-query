# Subscription Data Model {#data-model}

{: #data-model-description}
The abstract data model specifies the semantics of an {{&protocol}}.

{: #data-model-requirements}
A realization of the data model allows a client to specify in a subscription request:

+ {: #data-model-requirement-notifications}
an interest in receiving a stream of event-notifications from a resource in a preferred form.

+ {: #data-model-requirement-representation}
an interest in receiving a representation of a resource (that would be sent in response to a GET request) in a preferred form.

{: #data-model-specificity}
A client MAY specify an interest specific to the representation it is prepared to accept in response to the QUERY request.

{: #data-model-realization}
Implementations can choose appropriate media types to realize the subscription data model. Implementations are free to extend the data model to include additional data. A specific realization of the data model is beyond the scope of this specification (see {{out-of-scope--realizations}}).

{: #data-model-example}
The following example shows the body of a subscription request wherein the `state` and `events` properties are used to specify request headers for representation and event-notifications respectively in a YAML-like syntax.

~~~ yaml
state:
  Accept: text/html
events:
  Accept: example/event-notification
~~~
{: sourcecode-name="data-model-example.yaml" #data-model-example-yaml title="Events Query Data Model in a YAML-like syntax"}

{: #data-model-example-2}
The following modifies the previous example to express an interest in receiving representation and notifications as linked data when the response media type is JSON sequence ([RFC7464]).

~~~ yaml
application/json-seq:
  state:
    "@context": application/ld+json
  events:
    "@context": application/activity+json
"*/*":    
  state:
    Accept: text/html
  events:
    Accept: example/event-notification
~~~
{: sourcecode-name="data-model-example-2.yaml" #data-model-example-2-yaml title="Events Query Data Model with Representation Specific Interest"}

*[data model]: #data-model
*[Data Model]: #data-model

*[+events+]: #data-model-property-events (((events (property) ))) `events`
*[+state+]: #data-model-property-state (((state (property) ))) `state`
