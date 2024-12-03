document.addEventListener("turbo:load", () => {
  const contactEmailsDiv = document.getElementById("contact-emails");
  const addEmailButton = document.getElementById("add-email");

  if (!contactEmailsDiv || !addEmailButton) return;

  // Dodavanje novog email polja
  addEmailButton.addEventListener("click", (e) => {
    e.preventDefault();

    const newId = new Date().getTime(); // Jedinstveni ID
    const template = `
      <div class="contact-email flex items-center space-x-4 mb-4">
        <input type="text" name="user[contact_emails_attributes][${newId}][email]" placeholder="Additional email" class="border-gray-300 focus:ring-2 focus:ring-green-500 rounded-md w-full" />
        <input type="hidden" name="user[contact_emails_attributes][${newId}][_destroy]" value="false" />
        <button type="button" class="remove-email bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600">Remove</button>
      </div>
    `;
    contactEmailsDiv.insertAdjacentHTML("beforeend", template);
  });

  // Uklanjanje email polja
  contactEmailsDiv.addEventListener("click", (e) => {
    if (e.target.classList.contains("remove-email")) {
      e.preventDefault();
      const emailField = e.target.closest(".contact-email");
      const destroyField = emailField.querySelector('input[type="hidden"]');

      if (destroyField) {
        destroyField.value = "true"; // Označi za brisanje
        emailField.style.display = "none"; // Sakrij polje
      } else {
        emailField.remove(); // Potpuno ukloni polje ako nije Rails managed
      }
    }
  });
});
