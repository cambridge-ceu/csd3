document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Find all section headers (with class 'caption')
  const captions = sidebar.querySelectorAll("a.caption");

  captions.forEach((caption) => {
    let submenu = caption.nextElementSibling;

    // If submenu is missing or not <ul>, optionally create one (uncomment if needed)
    // if (!submenu || submenu.tagName.toLowerCase() !== "ul") {
    //   submenu = document.createElement("ul");
    //   caption.parentNode.insertBefore(submenu, caption.nextSibling);
    // }

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      // Hide submenu initially
      submenu.style.display = "none";

      // Make caption look clickable
      caption.style.cursor = "pointer";

      // Add click toggle behavior
      caption.addEventListener("click", (e) => {
        e.preventDefault();
        const isHidden = submenu.style.display === "none";
        submenu.style.display = isHidden ? "block" : "none";
        caption.classList.toggle("open", isHidden);
      });
    } else {
      // No submenu - disable pointer cursor (or style differently)
      caption.style.cursor = "default";
    }
  });
});
