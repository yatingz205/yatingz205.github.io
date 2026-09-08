---
layout: page
title: SMART trial analysis pipeline
description: Estimation, inference, and interpretation for the BEST chronic low back pain trial.
img:
importance: 1
category: research
related_publications: false
---

A `targets`-orchestrated R pipeline for the **Biomarkers for Evaluating Spine Treatments (BEST)** trial
(registration ID [NCT05396014](https://clinicaltrials.gov/study/NCT05396014)), covering the full path from raw
trial data to an interpretable report.

**What it does**

- Estimates dynamic treatment regimes via Q-learning and super-learner ensembles.
- Performs CV-TMLE inference for the resulting regimes.
- Produces variable-importance summaries and interpretable models alongside the primary estimates.
- Renders a fully reproducible report, re-run end to end on any change to the upstream data or code.

**Stack** — R, `targets`, Quarto, `tidymodels`.

Developed with the [UNC Gillings Center for Artificial Intelligence and Public Health (CAIPH)](https://sph.unc.edu/caiph/)
and the UNC Collaborative Studies Coordinating Center (CSCC).
