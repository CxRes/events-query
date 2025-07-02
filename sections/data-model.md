# Subscription Data Model {#data-model}

{: #data-model-description}
The abstract data model specifies the semantics of an {{&protocol}}.

{: #data-model-requirements}
A realization of the data model MUST allow a client to specify in a subscription request:

+ {: #data-model-requirement-representation}
interest in receiving a representation in a preferred form.

+ {: #data-model-requirement-notifications}
interest in receiving event-notifications in a preferred form.

{: #data-model-realization}
Implementations can choose an appropriate media-type to realize the subscription data model. Implementations are free to extend the data model to include additional data. A specific realization of the data model is outside the scope of this specification.

{: #data-model-example}
The following example shows the body of a subscription request wherein the `state` and `events` properties are used to specify request headers for representation and event-notifications respectively in a YAML like syntax.

~~~ yaml
state:
  Accept: text/html
events:
  Accept: example/event-response
~~~
{: sourcecode-name="data-model-example.yaml" #data-model-example-yaml title="Events Query Data Model in a YAML like syntax"}

*[data model]: #data-model
*[Data Model]: #data-model

*[+events+]: #data-model-property-events (((events (property) ))) `events`
*[+state+]: #data-model-property-state (((state (property) ))) `state`
