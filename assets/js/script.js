document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".sidebar"); // Adjust to your actual sidebar container
  if (!sidebar) return;

  const sections = [
    "THE SYSTEM",
    "Python packages",
    "R packages",
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
        subList.style.display = "none"; // Start collapsed
        headerLink.style.cursor = "pointer";
        headerLink.addEventListener("click", function (e) {
          e.preventDefault();
          subList.style.display =
            subList.style.display === "none" ? "" : "none";
        });
      }
    }
  });
});
