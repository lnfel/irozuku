Template is copied from `$HOME/.rbenv/versions/3.3.4/lib/ruby/gems/3.3.0/gems/rdoc-6.12.0/lib/rdoc/generator/template/darkfish`.

- Added code blocks for `const.value` in `darkfish/class.rhtml`.
- Added padding-left to `main .method-detail` and used `--highlight-color` for `main .method-detail:target` border-color in `css/rdoc.css`. This adds more focus to the selected anchored section.
- Remove `visibility` of `¶` when hovering `main .method-heading`.
- `method-name` now prepends with `#` by default in `darkfish/class.rhtml`.
- Increased `main blockquote` border-size and padding.
- Reduced `main blockquote > p` line-height from 1.5 to 1.
- No longer displays `h1:hover span` to `h6:hover span`.
- Turn `#table-of-contents-navigation` into a flex container and set justify-content to space-evenly for a well-balanced space between the holy trinity of ruby documentation.
- Remove max-width on `main` (the immense negative space on the right is giving me chills) and set margin from `3em auto` to `3em 0`
- Increase horizontal padding of various elements.
- TODO: Make a new template instead of patching everything.
