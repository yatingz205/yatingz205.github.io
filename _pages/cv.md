---
layout: page
permalink: /cv/
title: cv
description:
nav: true
nav_order: 4
# The navbar entry points straight at the PDF and opens it in a new tab
# (see the LOCAL ADDITION block in _includes/header.liquid).
# The page below is the fallback for anyone who lands on /cv/ directly.
nav_href: /assets/pdf/CV_YatingZou.pdf
nav_new_tab: true
---

<div class="cv-embed">
  <p class="cv-actions">
    <a href="{{ '/assets/pdf/CV_YatingZou.pdf' | relative_url }}" target="_blank" rel="noopener">[open in new tab]</a>
    <a href="{{ '/assets/pdf/CV_YatingZou.pdf' | relative_url }}" download>[download]</a>
  </p>

  <object data="{{ '/assets/pdf/CV_YatingZou.pdf' | relative_url }}" type="application/pdf" class="cv-object">
    <p>
      Your browser cannot display PDFs inline.
      <a href="{{ '/assets/pdf/CV_YatingZou.pdf' | relative_url }}" target="_blank" rel="noopener">Open my CV</a> instead.
    </p>
  </object>
</div>

<style>
  .cv-actions {
    margin-bottom: 0.75rem;
  }
  .cv-actions a {
    color: var(--global-theme-color);
    font-size: 0.9rem;
    margin-right: 0.6rem;
    text-decoration: none;
  }
  .cv-actions a:hover {
    text-decoration: underline;
  }
  .cv-object {
    width: 100%;
    height: 85vh;
    min-height: 600px;
    border: 1px solid var(--global-divider-color);
  }
  /* Mobile browsers generally refuse to render an inline PDF; show the links only. */
  @media (max-width: 768px) {
    .cv-object {
      display: none;
    }
  }
</style>
