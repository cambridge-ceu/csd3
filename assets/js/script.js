document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const currentPath = window.location.pathname;

  // Select all section headers with class 'caption'
  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Check if the submenu contains an active link (including README.md)
      const activeLink = submenu.querySelector(`a[href="${currentPath}"]`);

      if (activeLink) {
        // If current page is inside this section, open it by default and save state
        submenu.style.display = "block";
        caption.classList.add("open");
        localStorage.setItem(sectionKey, "true");
      } else {
        // Otherwise, restore open/closed state from localStorage or collapse by default
        const wasOpen = localStorage.getItem(sectionKey) === "true";
        if (wasOpen) {
          submenu.style.display = "block";
          caption.classList.add("open");
        } else {
          submenu.style.display = "none";
          caption.classList.remove("open");
        }
      }

      // Make caption clickable to toggle submenu open/closed
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
      // For captions without submenu (like README.md-only sections),
      // you can add extra logic here if needed
      caption.style.cursor = "pointer";
    }
  });
});
