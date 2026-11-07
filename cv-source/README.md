# CV source (public / blinded variant)

Builds `assets/pdf/CV_YatingZou.pdf`, the CV served from the website.

**This is the public variant: no phone number, no email address of any kind (not even
the UNC one), and no referee contact details** (the References section stays inside
`\begin{comment}`). The header links to the website, Google Scholar and GitHub instead.
Keep it in sync with your private CV, and re-check that nothing personal creeps back in.

## Build

```bash
export PATH="/Library/TeX/texbin:$PATH"
cd cv-source
latexmk -xelatex cv_faculty.tex
cp cv_faculty.pdf ../assets/pdf/CV_YatingZou.pdf
```

Then verify nothing personal got in. Check both the visible text and the link
annotations (a `mailto:` can hide behind link text). Plain `strings` on the PDF does
**not** work: the streams are compressed, so it finds nothing and always looks clean.

```bash
# Both lines must print no email address and no phone number.
pdftotext ../assets/pdf/CV_YatingZou.pdf - | grep -nE '@|[0-9]{3}[ .-][0-9]{3}[ .-][0-9]{4}'
qpdf --qdf --object-streams=disable ../assets/pdf/CV_YatingZou.pdf - | grep -ao '/URI *([^)]*)' | sort -u
```

## Notes

- **Bibliography is shared** with the website: `\addbibresource{../_bibliography/references_faculty.bib}`.
  One file feeds both the CV and the publications page, so they cannot drift.
- **Requires XeLaTeX** (`fontspec`/`mathspec`), plus `biber`.
- Local one-time setup on macOS:
  - `brew install --cask font-liberation` — the document sets `\setmainfont{Liberation Serif}`.
  - Copy the icon fonts where the OS can see them, since XeLaTeX resolves them by name:
    ```bash
    cp "$(kpsewhich FontAwesome.otf)"  ~/Library/Fonts/
    cp "$(kpsewhich academicons.ttf)" ~/Library/Fonts/
    ```
- Two fixes were needed relative to the original source, both marked with comments
  in the `.tex`: the icon packages must load _after_ the `fontspec`/`mathspec` block
  (otherwise "Option clash for package fontspec"), and `\MakeUppercase` is disabled
  for hyperref PDF strings.
- This directory is excluded from the Jekyll build; only the compiled PDF is published.
