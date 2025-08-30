document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const currentPath = window.location.pathname.replace(/\/$/, ""); // trim trailing slash for consistency

  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Check for README.md or directory active link in submenu
      const links = Array.from(submenu.querySelectorAll("a"));
      const activeLink = links.find((link) => {
        const href = link.getAttribute("href").replace(/\/$/, "");
        return href === currentPath || href === currentPath + "/README.md";
      });

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
    }
  });
});
