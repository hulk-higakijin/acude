import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { Modal, Dropdown } from "tailwindcss-stimulus-components"
application.register('modal', Modal)
application.register('dropdown', Dropdown)
