# Implementation Status {#implementation-status}

## Express Demo {#express-demo}

{: #express-demo-intro}
A toy server built in Express.js demonstrating the {{&protocol}} Protocol is available at [](https://github.com/CxRes/events-query-express-demo). This demo is powered by the following libraries:

+ {: #express-demo-lib--negotiate-events-field}
[Negotiate Events Field](https://github.com/CxRes/negotiate-events-field): To read the request =Events= header field ({{events-field}}) and negotiate the response =duration= ({{duration-property}}),

+ {: #express-demo-lib--nose}
[NOSE](https://github.com/CxRes/nose): To (((observation)))observe events on resources and generate notifications in a preferred format, and

+ {: #express-demo-lib--extended-response}
[Extended Response](https://github.com/CxRes/extended-response): To write the representation and event-notifications on the response stream for a given =duration= ({{duration-property}}).

{: #express-demo-license}
The demonstration and libraries are Free and Open Source Software, released under the Mozilla Public License, v. 2.0. Please contact the author for more information about these programs.

## CAMARA API Demo {#camara-api-demo}

A second, independent implementation by Jaime Jiménez that applies Events Query in an agent-ready mock for the [CAMARA (Global Telco API Alliance)](https://camaraproject.org) HTTP APIs is available at [](https://camara.jaime.win). The CAMARA sandbox uses Events Query to notify clients of SIM-swaps. An agent can observe changes to the SIM-swap state in-band as a JSON Sequence by sending a QUERY request to a resource, rather than setting up a separate Webhooks subscription.    
