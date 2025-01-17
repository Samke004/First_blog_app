/*
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import tinymce_controller from "./tinymce_controller"
eagerLoadControllersFrom("controllers", application)

*/

// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

// Automatski učitava sve kontrolere
eagerLoadControllersFrom("controllers", application);

// Ručno registriraj tinymce_controller (nije automatski učitan)
import TinymceController from "./tinymce_controller";
application.register("tinymce", TinymceController);
