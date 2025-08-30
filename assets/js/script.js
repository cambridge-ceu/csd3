document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Find all section headers (with class 'caption') that have a submenu <ul> next to them
  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    const submenu = caption.nextElementSibling;
    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Initially hide submenu
      submenu.style.display = "none";

      // Make caption look clickable
      caption.style.cursor = "pointer";

      // Add click toggle
      caption.addEventListener("click", (e) => {
        e.preventDefault();

        if (submenu.style.display === "none") {
          submenu.style.display = "block";
          caption.classList.add("open");
        } else {
          submenu.style.display = "none";
          caption.classList.remove("open");
        }
      });
    }
  });
});
