document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const current = normalize(window.location.pathname);

  sidebar.querySelectorAll("a.caption").forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const href = normalize(caption.getAttribute("href") || "");

    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    let shouldOpen = false;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Check if submenu contains an active link
      const submenuLinks = submenu.querySelectorAll("a");
      const submenuHasActive = Array.from(submenuLinks).some(
        (link) => normalize(link.getAttribute("href") || "") === current
      );

      // Is the caption itself active (README.md)
      const isReadme = current === href;

      // Check if this section was previously opened
      const wasOpen = localStorage.getItem(sectionKey) === "true";

      shouldOpen = submenuHasActive || isReadme || wasOpen;

      submenu.style.display = shouldOpen ? "block" : "none";
      caption.classList.toggle("open", shouldOpen);

      caption.style.cursor = "pointer";

      // Handle click to toggle
      caption.addEventListener("click", (e) => {
        const isOpen = submenu.style.display === "block";
        submenu.style.display = isOpen ? "none" : "block";
        caption.classList.toggle("open", !isOpen);
        localStorage.setItem(sectionKey, String(!isOpen));
        // allow normal navigation to README if needed
      });
    }
  });

  function normalize(url) {
    return url.replace(/\/index\.html$/, "").replace(/\/$/, "");
  }
});
