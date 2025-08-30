document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  // Use the exact sidebar link text for your sections here:
  const sections = ["systems", "Python", "R", "applications", "cardio"];

  sections.forEach((section) => {
    // Find the sidebar link by matching the exact trimmed text content
    const headerLink = Array.from(sidebar.querySelectorAll("a")).find(
      (a) => a.textContent.trim().toLowerCase() === section.toLowerCase()
    );

    if (headerLink) {
      const parentLi = headerLink.closest("li");
      const subList = parentLi.querySelector("ul");

      if (subList) {
        // Initially collapsed (handled by CSS), but you can explicitly hide here if needed:
        subList.style.display = "none";

        // Add cursor style to header links via CSS above

        headerLink.addEventListener("click", function (e) {
          e.preventDefault();
          const isOpen = parentLi.classList.toggle("open");

          // Toggle display of submenu ul
          subList.style.display = isOpen ? "block" : "none";
        });
      }
    }
  });
});
