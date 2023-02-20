import lightbox from "lightbox2/dist/js/lightbox-plus-jquery"

document.addEventListener("turbo:load", function () {
  lightbox.init();
});

window.addEventListener("popstate", function ( event ) {
  location.reload(true);
});
