import { Controller } from "@hotwired/stimulus";
import tinymce from "tinymce";

// Uvezite osnovne resurse
import "tinymce/icons/default";
import "tinymce/themes/silver";
import "tinymce/models/dom";

// Opcionalno: dodatni alati
import "tinymce/plugins/lists";
import "tinymce/plugins/link";
import "tinymce/plugins/image";

export default class extends Controller {
  static targets = ["editor"];

  connect() {
    tinymce.init({
      target: this.editorTarget, // Povežite editor s target elementom
      plugins: ["lists", "link", "image"],
      toolbar: "undo redo | formatselect | bold italic | alignleft aligncenter alignright | bullist numlist outdent indent | link image",
      menubar: false,
      height: 300,
    });
  }

  disconnect() {
    if (tinymce.get(this.editorTarget.id)) {
      tinymce.get(this.editorTarget.id).remove();
    }
  }
}
