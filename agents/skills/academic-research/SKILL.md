---
name: academic-research
description: Rigorous academic literature research with prestige filters and hallucination-proof citations. Use when the user asks for state of the art, relevant papers, a literature review, or publication opportunities on a topic. Computer science focus, networking subarea included.
---

Goal: surface only high-prestige, real sources and never invent a reference.

## Prestige criteria (computer science)

1. Prefer top venues: CORE A*/A conferences and Q1 journals in the specific subarea; ACM, IEEE, Springer, Elsevier publishers.
2. arXiv preprints are allowed, but always check for a later official publication (same title/authors) and cite the published DOI when it exists. Never present a preprint as published.
3. Use Google Scholar to gauge impact (citations, venue, author reputation) and to find the area's survey or seminal paper.
4. For course-level master's work, also accept solid peer-reviewed sources at A/B level; still flag the venue tier.

## Anti-hallucination rules (hard)

- Verify every reference exists before including it (title, authors, year, venue, DOI/URL). If it cannot be verified, say so explicitly; never fill in from memory.
- Cite the specific claim or passage from the paper, not a paraphrase of the abstract alone.
- Separate "what the paper says" from "my synthesis or opinion".
- Record the search date; prefer the latest version of a paper.
- If no high-prestige source exists for the topic, say that clearly instead of lowering the bar to weak sites.

## Workflow

1. Run searches in parallel where possible (Google Scholar, arXiv, IEEE Xplore, ACM DL, publisher sites) using a background researcher subagent (async, low thinking) so the main session stays cheap.
2. State of the art X: find the most recent survey, the seminal paper, and 3-5 recent high-impact works; summarize each claim with its citation.
3. Publication opportunity: extract explicit gaps and limitations stated in recent surveys and list them with sources. Prefer gaps the user can turn into measurable improvements.
4. Deliver a lean synthesis with markdown links (DOI). Offer to save a dated .md note in the research folder instead of dumping raw content into chat.

## CS networking focus (when the topic is networking)

- Venues: ACM SIGCOMM, CoNEXT, USENIX NSDI/ATC, IEEE INFOCOM/ICNP, journals IEEE/ACM ToN and IEEE Communications Surveys & Tutorials.
- Prefer recent surveys for gap analysis; check if a proposed improvement was already tried (search prior work before suggesting).
