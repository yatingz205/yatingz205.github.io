# CV source (public / blinded variant)

Builds `assets/pdf/CV_YatingZou.pdf`, the CV served from the website.

**This is the public variant: the phone number and personal email are deliberately
removed.** The header links to the website, Google Scholar and GitHub instead. Keep it
in sync with your private CV, and re-check that nothing personal creeps back in.

## Build

```bash
export PATH="/Library/TeX/texbin:$PATH"
cd cv-source
latexmk -xelatex cv_postdoc.tex
cp cv_postdoc.pdf ../assets/pdf/CV_YatingZou.pdf
```

Then verify the blinding actually held — the raw byte scan also catches link
annotations, which plain text extraction misses:

```bash
# Should print 0. Keep the pattern in a local file rather than here, so this public
# repo does not spell out the very details being removed.
strings ../assets/pdf/CV_YatingZou.pdf | grep -cEf ~/.cv-blinding-patterns
```

## Notes

- **Bibliography is shared** with the website: `\addbibresource{../_bibliography/references_postdoc.bib}`.
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
