import { Controller } from "@hotwired/stimulus";
import "/vendor/tinymce/tinymce.min.js"; // Učitaj TinyMCE globalno

export default class extends Controller {
  connect() {
    if (!this.element.dataset.tinymceInitialized) {
      this.element.dataset.tinymceInitialized = true;

      globalThis.tinymce.init({
        selector: "textarea[data-controller='tinymce']", // Cilja textarea
        plugins: "link lists table code",
        toolbar: "undo redo | bold italic | alignleft aligncenter alignright | bullist numlist | link table | code",
        menubar: false,
        branding: false,
        height: 300,

        // ✅ Ispravi putanje do TinyMCE fajlova
        base_url: "/vendor/tinymce", // Postavlja baznu URL putanju
        suffix: ".min", // Dodaje `.min.js` na krajeve fajlova
      });
    }
  }

  disconnect() {
    globalThis.tinymce.remove();
  }
}
