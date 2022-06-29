import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { Modal, Dropdown, Toggle } from "tailwindcss-stimulus-components"
application.register('modal', Modal)
application.register('dropdown', Dropdown)
application.register('toggle', Toggle)
