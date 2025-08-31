document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const currentPath = window.location.pathname;

  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const hasSubmenu = submenu && submenu.tagName.toLowerCase() === "ul";

    const captionHref = caption.getAttribute("href");

    const isActive =
      caption.classList.contains("active") ||
      (captionHref && currentPath === captionHref) ||
      (hasSubmenu && submenu.querySelector(`a[href="${currentPath}"]`));

    if (hasSubmenu) {
      // Keep open if active
      submenu.style.display = isActive ? "block" : "none";
      if (isActive) caption.classList.add("open");

      caption.style.cursor = "pointer";

      // Toggle submenu on click (without preventing navigation)
      caption.addEventListener("click", (e) => {
        // Do not preventDefault — allow navigation to README.md
        const isHidden = submenu.style.display === "none";
        submenu.style.display = isHidden ? "block" : "none";
        caption.classList.toggle("open", isHidden);
      });
    }
  });

  // Keep submenu open when any submenu link is clicked
  const submenuLinks = sidebar.querySelectorAll("ul li a");
  submenuLinks.forEach((link) => {
    link.addEventListener("click", () => {
      const parentSubmenu = link.closest("ul");
      if (parentSubmenu) {
        parentSubmenu.style.display = "block";
        const parentCaption = parentSubmenu.previousElementSibling;
        if (parentCaption && parentCaption.classList.contains("caption")) {
          parentCaption.classList.add("open");
        }
      }
    });
  });
});
