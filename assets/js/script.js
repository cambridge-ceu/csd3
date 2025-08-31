document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const current = normalize(window.location.pathname);

  sidebar.querySelectorAll("a.caption").forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const href = normalize(caption.getAttribute("href") || "");

    let isActive = false;

    if (current === href) {
      isActive = true;
    } else if (submenu && submenu.tagName.toLowerCase() === "ul") {
      isActive = Array.from(submenu.querySelectorAll("a")).some(
        (link) => normalize(link.getAttribute("href") || "") === current
      );
    }

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      submenu.style.display = isActive ? "block" : "none";
      caption.classList.toggle("open", isActive);
      caption.style.cursor = "pointer";

      caption.addEventListener("click", () => {
        const nowOpen = submenu.style.display === "none";
        submenu.style.display = nowOpen ? "block" : "none";
        caption.classList.toggle("open", nowOpen);
        // navigation still works through the href
      });
    }
  });

  // Helper function:
  function normalize(url) {
    return url.replace(/\/$/, "");
  }
});
