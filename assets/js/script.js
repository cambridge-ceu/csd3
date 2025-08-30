document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const hasSubmenu = submenu && submenu.tagName.toLowerCase() === "ul";

    // Check if current caption or submenu contains the active link
    const isActive =
      caption.classList.contains("active") ||
      (hasSubmenu && submenu.querySelector("a.active"));

    if (hasSubmenu) {
      // Show if active, hide otherwise
      submenu.style.display = isActive ? "block" : "none";
      if (isActive) caption.classList.add("open");

      // Add click handler
      caption.addEventListener("click", (e) => {
        // Always toggle the submenu
        const isHidden = submenu.style.display === "none";
        submenu.style.display = isHidden ? "block" : "none";
        caption.classList.toggle("open", isHidden);
        // Allow normal navigation to README.md
      });
    } else {
      // No submenu — no toggling needed, just allow navigation to README.md
      // No preventDefault needed
    }
  });

  // Keep submenu open when a submenu item is clicked
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
