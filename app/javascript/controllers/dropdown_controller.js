import { Controller } from "@hotwired/stimulus"
import { leave, toggle } from "el-transition"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "button"]

  toggle() {
    toggle(this.menuTarget)
    console.log("hide")
  }

  hide(event) {
    const buttonClicked = this.buttonTarget.contains(event.target)

    if (!buttonClicked) {
      leave(this.menuTarget)
    }
  }
}
