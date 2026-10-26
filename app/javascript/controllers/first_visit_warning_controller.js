import { Controller } from "@hotwired/stimulus"

let dismissedUntilReload = false

export default class extends Controller {
  connect() {
    if (document.documentElement.hasAttribute("data-turbo-preview") || dismissedUntilReload) return

    this.element.showModal()
    document.documentElement.classList.add("first-visit-warning-open")
  }

  disconnect() {
    this.beforeCache()
  }

  dismiss(event) {
    event?.preventDefault()
    dismissedUntilReload = true
    this.beforeCache()
  }

  beforeCache() {
    if (this.element.open) this.element.close()
    this.restorePage()
  }

  restorePage() {
    document.documentElement.classList.remove("first-visit-warning-open")
  }
}
