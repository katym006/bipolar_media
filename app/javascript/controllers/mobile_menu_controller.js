import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "toggle"]

  connect() {
    this.mobileViewport = window.matchMedia("(max-width: 760px)")
    this.handleViewportChange = () => {
      if (!this.mobileViewport.matches) this.close()
    }
    this.mobileViewport.addEventListener("change", this.handleViewportChange)
  }

  disconnect() {
    this.close()
    this.mobileViewport.removeEventListener("change", this.handleViewportChange)
  }

  open() {
    if (!this.mobileViewport.matches || this.dialogTarget.open) return

    this.dialogTarget.showModal()
    this.toggleTarget.setAttribute("aria-expanded", "true")
    document.documentElement.classList.add("mobile-menu-open")
  }

  close(event) {
    if (event?.type === "cancel") event.preventDefault()
    if (this.dialogTarget.open) this.dialogTarget.close()
    this.restore()
  }

  restore() {
    this.toggleTarget.setAttribute("aria-expanded", "false")
    document.documentElement.classList.remove("mobile-menu-open")
  }
}
