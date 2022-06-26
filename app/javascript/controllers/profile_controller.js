import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "status", "output" ]
  selectCandidate() {
    this.outputTargets.forEach(e => { e.textContent = '受験生' })
  }

  selectProfessor() {
    this.outputTargets.forEach(e => { e.textContent = '教授' })
  }
}
