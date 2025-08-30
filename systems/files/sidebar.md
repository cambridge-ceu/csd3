(with jekyll-rtd-theme) to have sidebar sections collapsed by default and toggle open/close on click **visible link texts**.

---

## 1. Update `_layouts/default.liquid`

Add the custom CSS and load your custom JS file.

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

      /* Sidebar collapsed submenu */
      .sidebar ul {
        margin-left: 1em;
      }
      .sidebar a {
        text-decoration: none;
      }
      .sidebar ul li a {
        display: block;
        cursor: pointer;
      }
      .sidebar ul li ul {
        display: none; /* collapsed by default */
      }
      .sidebar ul li.open > ul {
        display: block;
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

## 2. Create `assets/js/script.js`

Put this JavaScript that finds your sidebar sections by their visible link text, hides their sublists, and toggles them on click:

```js
document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Use the exact sidebar link text for your sections here:
  const sections = ["systems", "Python", "R", "applications", "cardio"];

  sections.forEach((section) => {
    // Find the sidebar link by matching the exact trimmed text content
    const headerLink = Array.from(sidebar.querySelectorAll("a")).find(
      (a) => a.textContent.trim().toLowerCase() === section.toLowerCase()
    );

    if (headerLink) {
      const parentLi = headerLink.closest("li");
      const subList = parentLi.querySelector("ul");

      if (subList) {
        // Initially collapsed (handled by CSS), but you can explicitly hide here if needed:
        subList.style.display = "none";

        // Add cursor style to header links via CSS above

        headerLink.addEventListener("click", function (e) {
          e.preventDefault();
          const isOpen = parentLi.classList.toggle("open");

          // Toggle display of submenu ul
          subList.style.display = isOpen ? "block" : "none";
        });
      }
    }
  });
});
```

---

## 3. Optional: `assets/css/style.css`

You can keep this minimal or empty if all styles are inlined in default.liquid. But if you want a separate CSS file, copy the styles there and include it in your layout as shown.

```css
.sidebar ul {
  margin-left: 1em;
}

.sidebar a {
  text-decoration: none;
}

.sidebar ul li a {
  display: block;
  cursor: pointer;
}

.sidebar ul li ul {
  display: none; /* collapsed by default */
}

.sidebar ul li.open > ul {
  display: block;
}
```

---

## Recap of what this does:

- Starts with all sidebar subsections collapsed (`display:none`).
- Clicking a section title toggles that section open or closed.
- It matches sidebar link text **case-insensitively** to your folder names or section labels.
- Minimal CSS to style cursor and indentation.

---

## What to check/do next

- Confirm exact sidebar link text in the page (use your browser’s dev tools).
- Update the `sections` array in `script.js` with those exact texts.
- Run `make build` or whatever you do to build your site.
- Clear cache or do a hard refresh in browser.

---
