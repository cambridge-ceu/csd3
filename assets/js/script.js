document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const current = normalize(window.location.pathname);

  sidebar.querySelectorAll("a.caption").forEach((caption) => {
    const submenu = caption.nextElementSibling;
    if (!submenu || submenu.tagName.toLowerCase() !== "ul") return;

    const href = normalize(caption.getAttribute("href") || "");
    const sectionKey = `sidebar-section-${caption.textContent.trim()}`;

    // Determine whether this section should open by default
    const submenuLinks = submenu.querySelectorAll("a");
    const submenuHasActive = Array.from(submenuLinks).some(
      (link) => normalize(link.getAttribute("href") || "") === current
    );

    const isReadme = current === href;
    const userToggled = localStorage.getItem(sectionKey);

    // Default open if current page is in section and user hasn't toggled
    let shouldOpen = submenuHasActive || isReadme;

    if (userToggled !== null) {
      // Use stored toggle preference instead of default
      shouldOpen = userToggled === "true";
    }

    submenu.style.display = shouldOpen ? "block" : "none";
    caption.classList.toggle("open", shouldOpen);
    caption.style.cursor = "pointer";

    // Toggle on click
    caption.addEventListener("click", (e) => {
      const isOpen = submenu.style.display === "block";
      submenu.style.display = isOpen ? "none" : "block";
      caption.classList.toggle("open", !isOpen);
      localStorage.setItem(sectionKey, String(!isOpen));
    });
  });

  function normalize(url) {
    return url.replace(/\/index\.html$/, "").replace(/\/$/, "");
  }
});
