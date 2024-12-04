import { Controller } from "@hotwired/stimulus";
import tinymce from "tinymce/tinymce";
import "tinymce/themes/silver";
import "tinymce/icons/default";
import "tinymce/plugins/lists";
import "tinymce/plugins/textcolor";
import "tinymce/plugins/colorpicker";
import "tinymce/plugins/fullscreen";

export default class extends Controller {
  connect() {
    tinymce.init({
      target: this.element,
      menubar: false,
      plugins: "lists textcolor colorpicker fullscreen",
      toolbar:
        "undo redo | bold italic | forecolor backcolor | fontsize | alignleft aligncenter alignright | bullist numlist",
      toolbar_mode: "floating",
      contextmenu: false,
      setup: (editor) => {
        editor.on("change", () => {
          this.element.value = editor.getContent();
        });
      },
    });
  }

  disconnect() {
    if (tinymce.get(this.element.id)) {
      tinymce.get(this.element.id).remove();
    }
  }
}
