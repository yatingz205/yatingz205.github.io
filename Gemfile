source 'https://rubygems.org'

gem 'jekyll'

# Core plugins that directly affect site building
group :jekyll_plugins do
    gem 'jekyll-3rd-party-libraries'
    gem 'jekyll-cache-bust'
    gem 'jekyll-feed'
    gem 'jekyll-imagemagick'
    gem 'jekyll-link-attributes'
    gem 'jekyll-minifier'
    gem 'jekyll-scholar'
    gem 'jekyll-sitemap'
    gem 'jekyll-socials'
    gem 'jekyll-terser', :git => "https://github.com/RobertoJBeltran/jekyll-terser.git"
    gem 'jekyll-toc'
    gem 'jemoji'
end

# Gems for development or external data fetching (outside :jekyll_plugins)
group :other_plugins do
    gem 'css_parser'
    gem 'observer'       # used by jekyll-scholar
end

# Gems for al-folio plugins.
# NOTE: this list and the `plugins:` list in _config.yml must agree. A gem in
# only one of them is inert -- with no error message. See CLAUDE.md.
group :al_folio_plugins do
    gem 'al_folio_core', '= 1.0.15'      # the theme itself: layouts, includes, Sass
    gem 'al_folio_upgrade', '= 1.0.3'    # `bundle exec al-folio upgrade ...` CLI
    gem 'al_icons', '= 1.0.0'            # Font Awesome / Academicons for social links
    gem 'al_img_tools', '= 1.0.3'        # medium-zoom on images
    gem 'al_math', '= 1.0.2'             # MathJax
end
