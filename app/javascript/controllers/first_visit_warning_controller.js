import { Controller } from "@hotwired/stimulus"

const STORAGE_KEY = "polar:first-visit-warning:dismissed:v1"
let dismissedThisVisit = false

export default class extends Controller {
  connect() {
    if (document.documentElement.hasAttribute("data-turbo-preview") || this.dismissed()) return

    this.element.showModal()
    document.documentElement.classList.add("first-visit-warning-open")
  }

  disconnect() {
    this.beforeCache()
  }

  dismissed() {
    if (dismissedThisVisit) return true

    try {
      return window.localStorage.getItem(STORAGE_KEY) === "true"
    } catch {
      return false
    }
  }

  dismiss(event) {
    event?.preventDefault()
    dismissedThisVisit = true

    try {
      window.localStorage.setItem(STORAGE_KEY, "true")
    } catch {
      // Keep closing usable when the browser blocks persistent storage.
    }

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
