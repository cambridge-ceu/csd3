For enabling collapsible sidebar sections on Jekyll site with the jeky-rtd-theme:

---

## 1. `_layouts/default.liquid`

```liquid
---
layout: tasks/compress
---

{%- include rest/defaults.liquid -%}
{%- include common/rest/defaults.liquid -%}

<!DOCTYPE html>
<html lang="{{ lang }}" dir="{{ direction }}">
  <head>
    {%- include common/metadata.liquid -%}
    {%- include common/title.liquid -%}
    {%- include common/twitter_cards.liquid -%}
    {%- include common/opengraph.liquid -%}
    {%- include common/schema.liquid -%}
    {%- include common/links.liquid -%}
    {%- include rest/styles.liquid -%}
    {%- include common/script.liquid -%}
    {%- include extra/head.html -%}

    <!-- Custom styles -->
    <link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}">

    <style>
      .ceu-brand img {
        width: 250px;
        height: auto;
        margin-top: 20px;
      }
    </style>
  </head>

  <body class="container">
    {%- include templates/sidebar.liquid -%}
    {%- include templates/content.liquid -%}
    {%- include templates/addons.liquid -%}
    {%- include extra/body.html -%}

    <!-- Built-in Scripts -->
    {%- include rest/script.liquid -%}
    {%- include common/mermaid.liquid -%}
    {%- include common/mathjax.liquid -%}
    {%- include common/google_gtag.liquid -%}
    {%- include common/google_adsense.liquid -%}

    <!-- Custom JS -->
    <script src="{{ '/assets/js/script.js' | relative_url }}"></script>
  </body>
</html>
```

---

## 2. `assets/js/script.js`

```js
document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".sidebar"); // Adjust this selector if needed
  if (!sidebar) return;

  // List your sidebar section titles exactly as they appear in the sidebar links
  const sections = ["systems", "Python", "R", "applications", "cardio"];

  sections.forEach((section) => {
    const headerLink = Array.from(sidebar.querySelectorAll("a")).find(
      (a) => a.textContent.trim() === section
    );
    if (headerLink) {
      const parentLi = headerLink.closest("li");
      const subList = parentLi.querySelector("ul");
      if (subList) {
        subList.style.display = "none"; // Start collapsed
        headerLink.style.cursor = "pointer";
        headerLink.addEventListener("click", function (e) {
          e.preventDefault();
          subList.style.display =
            subList.style.display === "none" ? "" : "none";
        });
      }
    }
  });
});
```

---

## 3. `assets/css/style.css`

```css
.sidebar ul {
  margin-left: 1em;
}

.sidebar a {
  text-decoration: none;
}

.sidebar ul li a {
  display: block;
}

/* Optional: style for cursor on clickable headers */
.sidebar a {
  cursor: pointer;
}
```

---

### How to proceed:

1. Place the JS file in `assets/js/script.js`
2. Place the CSS file in `assets/css/style.css` (or compile your `.scss` to CSS here)
3. Confirm `_layouts/default.liquid` includes these files as above.
4. Run `jekyll build` or `make build` to regenerate.
5. Refresh your site, and you should see the sidebar sections collapsed initially, expandable on click.
