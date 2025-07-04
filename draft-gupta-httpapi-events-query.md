---
title: "HTTP Events Query"
category: std

docname: draft-gupta-httpapi-events-query-latest
submissiontype: IETF
number:
date:
consensus: true
v: 3
area: "Web and Internet Transport"
workgroup: "Building Blocks for HTTP APIs"
keyword:
 - event
 - query
 - notification
venue:
  group: "Building Blocks for HTTP APIs"
  type: "Working Group"
  mail: "httpapi@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/httpapi/"
  github: "CxRes/events-query"
  latest: "https://CxRes.github.io/events-query/draft-gupta-httpapi-events-query.html"

author:
 -
    fullname: "Rahul Gupta"
    email: "cxres+ietf@protonmail.com"

autolink-iref-cleanup: true
entity:
  protocol: Events Query

normative:
  HTTP: RFC9110
  HTTP-SF: RFC9651
  HTTP-QUERY: I-D.ietf-httpbis-safe-method-w-body-10
  INCREMENTAL-HTTP-MESSAGES: I-D.ietf-httpbis-incremental-00
  RFC8126:
informative:
  DESIGN-FRAMEWORK: DOI.10.1145/267896.267920
  FETCH:
    target: https://fetch.spec.whatwg.org
    title: Fetch
    author:
      -
        ins: A. van Kesteren
        name: Anne van Kesteren
    seriesinfo:
      WHATWG: Living Standard
    date: Last Updated 28 May 2025
  HTTP-CACHING: RFC9111
  REST:
    target: https://roy.gbiv.com/pubs/dissertation/rest_arch_style.htm
    title: Representational State Transfer (REST)
    author:
      -
        ins: R. Fielding
        name: Roy Thomas Fielding
        org: University of California, Irvine
    date:
      month: September
      year: 2000
    refcontent: Chapter 5, Architectural Styles and the Design of Network-based Software Architectures
    seriesinfo:
      "Doctoral Dissertation": University of California, Irvine
    format:
      PDF: https://roy.gbiv.com/pubs/dissertation/fielding_dissertation.pdf#G16.1026811
  RFC3724:
  RFC3935:
  RFC6202:
  RFC7838:
  RFC8890:
  RFC9112:
    -: HTTP1
    display: HTTP/1.1
  RFC9205:
  SSE: W3C.eventsource
  WEBSUB: W3C.websub
  WS: W3C.websockets


--- abstract

Events Query is a minimal protocol built on top of HTTP that allows user agents to receive event-notifications directly from any resource of interest. The Events Query Protocol (EQP) is predicated on the idea that the most intuitive source for event-notifications is the resource itself.


--- middle

{::include-nested sections/introduction.md}

{::include sections/design.md}


<!-- Conformance Sections -->

{::include boilerplate/conformance.md}


<!-- Normative Sections -->

{::include sections/terminology.md}

{::include sections/events-field.md}

{::include sections/data-model.md}

{::include-nested sections/discovery.md}

{::include-nested sections/single-notification.md}

{::include-nested sections/stream.md}

{::include-nested sections/representation.md}


<!-- Considerations Sections -->

{::include considerations/security.md}

{::include considerations/iana.md}

{::include considerations/end-user.md}


--- back

{::include-nested appendix/example.md}

{::include-nested appendix/acknowledgments.md}
