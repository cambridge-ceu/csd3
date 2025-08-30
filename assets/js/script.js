document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const hasSubmenu = submenu && submenu.tagName.toLowerCase() === "ul";

    if (hasSubmenu) {
      // Check if any submenu item is active
      const activeItem = submenu.querySelector(
        "li.active, li.current, a.active, a.current"
      );

      if (activeItem) {
        // Show submenu if active item found
        submenu.style.display = "block";
        caption.classList.add("open");
      } else {
        submenu.style.display = "none";
      }

      // Toggle submenu on caption click
      caption.style.cursor = "pointer";
      caption.addEventListener("click", (e) => {
        e.preventDefault();
        const isHidden = submenu.style.display === "none";
        submenu.style.display = isHidden ? "block" : "none";
        caption.classList.toggle("open", isHidden);
      });
    } else {
      // No submenu — treat as normal link, cursor default
      caption.style.cursor = "pointer";

      // Optional: if you want to expand/collapse README content when clicking this caption,
      // you may implement that logic here if README content is hidden elsewhere.
      // For example, open the README content panel or navigate as usual.
      // If caption href points to README.md, no special toggle needed, just normal link.
    }
  });

  // Ensure sections remain open after clicking submenu links
  // For single-page app or dynamic loads, you might want to handle this differently
  // For static site reloads, the active class should persist on the server side rendering
});
