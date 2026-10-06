(function () {
  "use strict";

  var yearEls = document.querySelectorAll("[data-current-year]");
  yearEls.forEach(function (el) { el.textContent = String(new Date().getFullYear()); });

  var revealEls = document.querySelectorAll(".reveal");
  if (!("IntersectionObserver" in window) || window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    revealEls.forEach(function (el) { el.classList.add("is-visible"); });
    return;
  }

  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (!entry.isIntersecting) return;
      entry.target.classList.add("is-visible");
      observer.unobserve(entry.target);
    });
  }, { threshold: 0.12, rootMargin: "0px 0px -40px 0px" });

  revealEls.forEach(function (el) { observer.observe(el); });

  document.querySelectorAll('a[href^="#"]').forEach(function (link) {
    link.addEventListener("click", function (event) {
      var id = link.getAttribute("href");
      if (!id || id === "#") return;
      var target = document.querySelector(id);
      if (!target) return;
      event.preventDefault();
      target.scrollIntoView({ behavior: "smooth", block: "start" });
      history.replaceState(null, "", id);
    });
  });
})();
/* 首页 V2：讲解 / 练习 / 自测 切换 */
(function () {
  "use strict";
  var buttons = Array.prototype.slice.call(document.querySelectorAll("[data-tab]"));
  var panels = Array.prototype.slice.call(document.querySelectorAll("[data-panel]"));
  if (!buttons.length || !panels.length) return;

  buttons.forEach(function (button) {
    button.addEventListener("click", function () {
      var target = button.getAttribute("data-tab");
      buttons.forEach(function (item) {
        var active = item === button;
        item.classList.toggle("is-active", active);
        item.setAttribute("aria-selected", active ? "true" : "false");
      });
      panels.forEach(function (panel) {
        panel.classList.toggle("is-active", panel.getAttribute("data-panel") === target);
      });
    });
  });
})();
