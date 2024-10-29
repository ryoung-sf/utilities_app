import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  change(event) {
    let statement_date = event.target.selectedOptions[0].value
    console.log(statement_date)

    get(`/meters/dates?statement_date=${statement_date}`, {
        responseKind: "turbo-stream"
    })
  }
}
