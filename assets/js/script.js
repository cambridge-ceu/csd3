document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.querySelector(".sidebar"); // Adjust this selector if needed
  if (!sidebar) return;

  // List your sidebar section titles exactly as they appear in the sidebar links
  const sections = ["systems", "Python", "R", "applications", "cardio"];

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
