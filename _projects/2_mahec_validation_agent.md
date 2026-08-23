---
layout: page
title: LLM validation agent for health resource tracking
description: A tool-using agent that keeps North Carolina healthcare-location records current.
img:
importance: 2
category: research
related_publications: false
---

A provider-agnostic, tool-using LLM agent that validates healthcare-location records for MAHEC's
[FindMyCareWNC](https://findmycarewnc.org/) platform, which helps people in western North Carolina locate care.

**What it does**

- Automatically flags out-of-date entries in the existing resource directory.
- Detects new locations that are not yet tracked.
- Routes every proposed change through a human-in-the-loop review interface, which doubles as the
  performance-monitoring surface for the agent itself.

**Stack** — Python, LangChain, RAG, provider-agnostic LLM backend.

Developed with the [UNC Gillings Center for Artificial Intelligence and Public Health (CAIPH)](https://sph.unc.edu/caiph/)
and the [Mountain Area Health Education Center (MAHEC)](https://mahec.net/).
