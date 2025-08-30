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
      (a) => a.textContent.trim() === section
    );

    if (headerLink) {
      const parentLi = headerLink.closest("li");
      const subList = parentLi.querySelector("ul");

      if (subList) {
        subList.style.display = "none";
        headerLink.style.cursor = "pointer";

        headerLink.addEventListener("click", function (e) {
          e.preventDefault();
          const isOpen = parentLi.classList.toggle("open");
          subList.style.display = isOpen ? "block" : "none";
        });
      }
    }
  });
});
