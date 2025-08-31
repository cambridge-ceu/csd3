document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.querySelector(".sidebar");
  if (!sidebar) return;

  const normalize = (url) => url.replace(/\/$/, "");
  const current = normalize(window.location.pathname);

  sidebar.querySelectorAll("a.caption").forEach((caption) => {
    const submenu = caption.nextElementSibling;
    const sectionKey =
      "sidebar-" +
      normalize(caption.getAttribute("href") || "").replace(/\//g, "_");

    if (submenu && submenu.tagName.toLowerCase() === "ul") {
      const links = Array.from(submenu.querySelectorAll("a"));
      const activeLink = links.find((link) => {
        const href = normalize(link.getAttribute("href"));
        return (
          href === current ||
          href === current + "/README" ||
          (href.endsWith("/README") &&
            current === href.replace(/\/README$/, ""))
        );
      });

      if (activeLink) {
        submenu.style.display = "block";
        caption.classList.add("open");
        localStorage.setItem(sectionKey, "true");
      } else if (localStorage.getItem(sectionKey) === "true") {
        submenu.style.display = "block";
        caption.classList.add("open");
      }

      caption.style.cursor = "pointer";
      caption.addEventListener("click", (e) => {
        e.preventDefault();
        const isOpen = submenu.style.display === "block";
        submenu.style.display = isOpen ? "none" : "block";
        caption.classList.toggle("open", !isOpen);
        localStorage.setItem(sectionKey, !isOpen);
      });
    }
  });
});
