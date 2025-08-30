document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const sections = [
    "THE SYSTEMS",
    "PYTHON PACKAGES",
    "R PACKAGES",
    "APPLICATIONS",
    "CARDIO",
  ];

  sections.forEach((section) => {
    const headerLink = Array.from(sidebar.querySelectorAll("a")).find(
      (a) => a.textContent.trim().toUpperCase() === section.toUpperCase()
    );

    if (headerLink) {
      const parentLi = headerLink.closest("li");
      if (!parentLi) return;

      const subList = parentLi.querySelector("ul");
      if (subList) {
        headerLink.style.cursor = "pointer";

        headerLink.addEventListener("click", function (e) {
          e.preventDefault();
          parentLi.classList.toggle("open");
        });
      }
    }
  });
});
