document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Select all section headers with class 'caption'
  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Check if any submenu item is active (adjust selectors as needed)
      const activeItem = submenu.querySelector(
        "li.active, li.current, a.active, a.current"
      );

      if (activeItem) {
        // If active submenu item exists, show submenu by default and add 'open' class
        submenu.style.display = "block";
        caption.classList.add("open");
      } else {
        // Otherwise, hide submenu
        submenu.style.display = "none";
      }

      // Make caption clickable and toggle submenu visibility on click
      caption.style.cursor = "pointer";
      caption.addEventListener("click", (e) => {
        e.preventDefault();
        const isHidden = submenu.style.display === "none";
        submenu.style.display = isHidden ? "block" : "none";
        caption.classList.toggle("open", isHidden);
      });
    } else {
      // If no submenu, normal cursor
      caption.style.cursor = "default";
    }
  });
});
