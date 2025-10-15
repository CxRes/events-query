# Implementation Status {#implementation-status}

A toy server built in Express.js demonstrating the {{&protocol}} Protocol is available at [](https://github.com/CxRes/events-query-express-demo). This demo is powered by the following libraries:

- [Negotiate Events Field](https://github.com/CxRes/negotiate-events-field): To read the request =Events= header field ({{events-field}}) and negotiate the response =duration= ({{duration-property}}),
- [NOSE](https://github.com/CxRes/nose): To (((observation)))observe events on resources and generate notifications in a preferred format, and
- [Extended Response](https://github.com/CxRes/extended-response): To write the representation and event-notifications on the response stream for a given =duration= ({{duration-property}}).

The demonstration and libraries are Free and Open Source Software, released under the Mozilla Public License, v. 2.0. Please contact the author for more information about these programs.
