document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Get current page URL path to detect active link
  const currentPath = window.location.pathname;

  // All section headers with submenu
  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Check if submenu contains an active link (including README.md)
      const activeLink = submenu.querySelector(`a[href="${currentPath}"]`);

      // If current page is inside this section, open it by default
      if (activeLink) {
        submenu.style.display = "block";
        caption.classList.add("open");
        localStorage.setItem(sectionKey, "true");
      } else {
        // Otherwise, restore from localStorage or collapse
        const wasOpen = localStorage.getItem(sectionKey) === "true";
        if (wasOpen) {
          submenu.style.display = "block";
          caption.classList.add("open");
        } else {
          submenu.style.display = "none";
          caption.classList.remove("open");
        }
      }

      // Make caption clickable to toggle submenu
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
