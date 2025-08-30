document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Find all section headers with class 'caption' (these are clickable section titles)
  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Restore saved open/closed state for this section
      const wasOpen = localStorage.getItem(sectionKey) === "true";
      if (wasOpen) {
        submenu.style.display = "block";
        caption.classList.add("open");
      } else {
        submenu.style.display = "none";
      }

      // Make the caption clickable
      caption.style.cursor = "pointer";

      caption.addEventListener("click", (e) => {
        e.preventDefault();
        const isVisible = submenu.style.display === "block";
        submenu.style.display = isVisible ? "none" : "block";
        caption.classList.toggle("open", !isVisible);
        // Save current state to localStorage
        localStorage.setItem(sectionKey, !isVisible);
      });
    }
  });
});
