---
layout: page
permalink: /publications/
title: publications
description:
nav: true
nav_order: 2
---

<!--
  Two sections, split by the `keywords` field in _bibliography/references_postdoc.bib:
    methods section  -> keywords containing `methods` or `inprep`
    applied section  -> keywords containing `appPub`, `appSub` or `appPre` (matched on `app`)
  Entry markup: _layouts/bib.liquid. Styling: _sass/_pubs.scss.
-->

<nav class="pub-jump">
  <a href="#methods">methods</a>
  <a href="#applied">applied &amp; collaboration</a>
</nav>

<h2 id="methods" class="pub-section">methods</h2>

<div class="publications">
{% bibliography --query @*[keywords ~= methods|inprep] %}
</div>

<h2 id="applied" class="pub-section">applied &amp; collaboration</h2>

<div class="publications">
{% bibliography --query @*[keywords ~= app] %}
</div>
