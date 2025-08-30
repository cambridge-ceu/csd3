document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Normalize URL: remove trailing slash for consistent comparison
  function normalizeUrl(url) {
    return url.replace(/\/$/, "");
  }

  const currentPath = normalizeUrl(window.location.pathname);

  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Check if any link in submenu matches currentPath exactly
      let activeLink = null;

      // Try exact match first
      activeLink = Array.from(submenu.querySelectorAll("a")).find((link) => {
        return normalizeUrl(link.getAttribute("href")) === currentPath;
      });

      // If no exact match, check if currentPath is the directory index for README.md
      if (!activeLink) {
        activeLink = Array.from(submenu.querySelectorAll("a")).find((link) => {
          const href = normalizeUrl(link.getAttribute("href"));
          // For example, if currentPath = "/Python" and href = "/Python/README"
          return (
            href.endsWith("/README") &&
            currentPath === href.replace(/\/README$/, "")
          );
        });
      }

      if (activeLink) {
        submenu.style.display = "block";
        caption.classList.add("open");
        localStorage.setItem(sectionKey, "true");
      } else {
        const wasOpen = localStorage.getItem(sectionKey) === "true";
        if (wasOpen) {
          submenu.style.display = "block";
          caption.classList.add("open");
        } else {
          submenu.style.display = "none";
          caption.classList.remove("open");
        }
      }

      caption.style.cursor = "pointer";
      caption.addEventListener("click", (e) => {
        e.preventDefault();

        const isOpen = submenu.style.display === "block";
        if (isOpen) {
          submenu.style.display = "none";
          caption.classList.remove("open");
          localStorage.setItem(sectionKey, "false");
        } else {
          submenu.style.display = "block";
          caption.classList.add("open");
          localStorage.setItem(sectionKey, "true");
        }
      });
    } else {
      caption.style.cursor = "pointer";
    }
  });
});
