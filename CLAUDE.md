# CLAUDE.md

Guidance for Claude Code working in this repository.

## What this is

The personal academic website of **Yating Zou**, published at <https://yatingz205.github.io>.

It started from the [al-folio](https://github.com/alshedivat/al-folio) v1 Jekyll starter, but it is
**a personal site, not a contribution to the al-folio project**. The upstream starter's own rules
(its `AGENTS.md`, its test suite, its "the starter must never contain `_layouts`/`_sass`" contract)
do **not** apply here and have been removed. Local overrides are legal and in use.

## Three things that will waste your time if you don't know them

### 1. `baseurl` must stay empty

This is a **user site** (`username.github.io`), served from the domain root. `_config.yml` keeps
`baseurl:` present but blank, and `url: https://yatingz205.github.io`.

Build and serve with no baseurl flag:

```bash
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
bundle exec jekyll serve --livereload      # http://localhost:4000/
```

Any instruction you find (in old docs, in `docs/`, in blog posts about al-folio) to pass
`--baseurl /al-folio` is about the upstream demo site. Using it here breaks every link and asset.

### 2. `Gemfile` and `_config.yml` are two lists that must agree

A plugin gem must appear in **both** `group :al_folio_plugins` in the `Gemfile` **and** the
`plugins:` list in `_config.yml`. In only one, it is inert — no warning, no error, the feature just
silently does nothing. Adding _or_ removing a plugin means editing both files.

Repo/gem naming differs: repos use hyphens (`al-folio-core`), gem and plugin ids use underscores
(`al_folio_core`).

Currently active al-folio plugins, deliberately pruned to what the site uses:
`al_folio_core` (the theme), `al_folio_upgrade` (the CLI), `al_icons`, `al_search`, `al_img_tools`,
`al_math`. Everything else — CV rendering, distill, comments, analytics, cookies, charts, RTL,
newsletter, marimo, external posts, citations, email obfuscation, bootstrap-compat — has been
removed from both lists.

### 3. Features gate twice

A feature renders only when its gem is loaded **and** its `_config.yml` flag is on **and** the page
opts in via front matter. Otherwise the Liquid tag emits an empty string. When something "does
nothing", check the gem, then the flag, then the front matter, then the `third_party_libraries`
SRI entry — in that order.

## Local overrides

Several gem-owned files are shadowed locally. Overriding a gem file is supported: a same-path file
in this repo wins over the gem's copy.

| File                           | Why                                                                                   |
| ------------------------------ | ------------------------------------------------------------------------------------- |
| `_layouts/bib.liquid`          | minimal publication entries: plain text, bracketed `[paper]`/`[slides]` links         |
| `_layouts/about.liquid`        | photo + bio as a vertically centred flex row instead of a floated image               |
| `_includes/header.liquid`      | adds `nav_href` / `nav_new_tab` front matter so the cv tab opens the PDF in a new tab |
| `_includes/footer.liquid`      | renders nothing (the gem hardcodes a copyright line before `footer_text`)             |
| `assets/css/main.scss`         | adds `@use "pubs"` / `@use "socials"` to the gem's Sass entry point                   |
| `assets/_sass/_variables.scss` | accent color, magenta -> dark blue (`#00369f` light, `#7ea8e8` dark)                  |
| `assets/_sass/_themes.scss`    | **unmodified copy** -- see below                                                      |

`_themes.scss` looks pointless but is load-bearing. Sass resolves `@use` relative to the importing
file _first_, so the gem's own `_themes.scss` always reads the gem's `_variables.scss`, and an
accent override in a local `_variables.scss` alone does nothing. The local copy exists so its
`@use "variables"` resolves to the sibling local file. **Do not delete it** without verifying the
compiled accent color still changes.

### Sass lives in `assets/_sass`, not `_sass`

`_config.yml` sets `sass.sass_dir: assets/_sass`. This is deliberate and load-bearing:
`jekyll-cache-bust`'s `bust_css_cache` hashes the **hardcoded** path `assets/_sass`. With partials
in the default `_sass`, that glob matched nothing, `al_folio_core`'s fallback hashed the _gem's_
partials instead, and `main.css` kept the same `?v=` hash no matter what changed locally -- so
browsers served a stale stylesheet after every style edit. Check it still works:

```bash
grep -o 'main\.css?v=[0-9a-f]*' _site/publications/index.html   # must change when a partial does
```

**Consequence:** because `_variables.scss` and `_themes.scss` no longer sit at the upstream path,
`upgrade overrides audit` does not track them. After bumping `al_folio_core`, diff them by hand:

```bash
GEM=$(bundle show al_folio_core)
diff "$GEM/_sass/_themes.scss"    assets/_sass/_themes.scss
diff "$GEM/_sass/_variables.scss" assets/_sass/_variables.scss
```

`assets/_sass/_pubs.scss` and `assets/_sass/_socials.scss` are original files, not gem copies.

### Tracked overrides

The remaining overrides are registered in `.al-folio-overrides.yml`. After a gem upgrade:

```bash
bundle exec al-folio upgrade overrides audit
bundle exec al-folio upgrade overrides diff <path>
bundle exec al-folio upgrade overrides accept <path>
```

## Routing changes

| Change                                | Goes in                                                         |
| ------------------------------------- | --------------------------------------------------------------- |
| Bio, landing page                     | `_pages/about.md`                                               |
| A publication                         | `_bibliography/papers.bib`                                      |
| How publication entries look          | `_layouts/bib.liquid`; styles in `_pages/publications.md`       |
| A project                             | `_projects/*.md`                                                |
| The CV                                | replace `assets/pdf/CV_YatingZou.pdf` (the page just embeds it) |
| Colors                                | `assets/_sass/_variables.scss`                                  |
| Email / GitHub / Scholar links        | `_data/socials.yml`                                             |
| Site metadata, feature flags, plugins | `_config.yml` (plus `Gemfile` for plugins)                      |

Shared runtime behavior that would benefit every al-folio user belongs upstream in the owning gem
(see [BOUNDARIES.md](https://github.com/alshedivat/al-folio/blob/main/docs/BOUNDARIES.md)), not as another local override here.

## Adding links to a publication

Fields in `_bibliography/papers.bib` map to the bracketed tokens rendered by `_layouts/bib.liquid`:

| Field                     | Token                  | Note                                               |
| ------------------------- | ---------------------- | -------------------------------------------------- |
| `html` / `pdf` / `doi`    | `[paper]`              | first present wins; bare filename → `/assets/pdf/` |
| `arxiv`                   | `[arxiv]`              |                                                    |
| `slides`, `poster`        | `[slides]`, `[poster]` | bare filename → `/assets/pdf/`                     |
| `code`, `website`         | `[code]`, `[site]`     |                                                    |
| `abstract`, `bibtex_show` | `[abs]`, `[bib]`       | expand inline                                      |

Mark an entry `selected = {true}` to surface it on the landing page.

## Validation

```bash
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
bundle exec jekyll build           # must be clean; ~1.5s
npm run lint:prettier              # npm run format to fix
bundle exec al-folio upgrade audit
bundle exec al-folio upgrade overrides audit
```

Local Ruby is Homebrew `ruby@3.3` (matches CI). Ruby 4.x fails to build native extensions against
the installed Xcode Command Line Tools. ImageMagick must be on `PATH` for responsive images.

## Deployment

Pushing to `main` runs `.github/workflows/deploy.yml` — the only workflow kept — which builds with
`JEKYLL_ENV=production`, purges unused CSS, and force-pushes `_site/` to `gh-pages`. Pages serves
from that branch.

## Reference

The upstream al-folio manual lives at
<https://github.com/alshedivat/al-folio/tree/main/docs>. A copy may be present in
`docs/` on a local checkout, but it is **git-ignored and not part of this repo**, so do not
assume it exists. It describes the full starter, including features this site has removed, and
it assumes the `/al-folio` baseurl. Treat it as background, not as instructions for this repo.
