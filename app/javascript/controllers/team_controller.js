import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "select", "players" ]

  connect() {
    this.loadPlayers()
  }

  loadPlayers() {
    const teamId = this.selectTarget.value
    fetch(`/teams/${teamId}.json`)
      .then(response => response.json())
      .then(players => {
        this.playersTarget.innerHTML = players.map(player => `<li>${player.name} - ${player.role}</li>`).join('')
      })
  }
}
