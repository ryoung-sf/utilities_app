import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import { get } from "@rails/request.js"

// Connects to data-controller="bills-count"
export default class extends Controller {
  connect() {
    createConsumer().subscriptions.create(
    { channel: "BillsChannel" },
    { received: (data) => this.renderLink(data) },
    );
  }

  renderLink(data) {
    let linkEl = document.getElementById("link")
    linkEl.classList.remove("font-semibold")
    linkEl.classList.add("bg-kellygreen", "border-seafoamgreen", "border-2", "font-bold")
    linkEl.innerHTML = `<a href="/">Click here to view your dashboard!</a>`;
  }
}