import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "destination", "teamIds", "submit"]

  connect() {
    this.validate();
  }

  assign(event) {
    event.preventDefault();
    this.moveTeams(this.sourceTarget.querySelectorAll('input[type="checkbox"]'), this.destinationTarget);
  }

  remove(event) {
    event.preventDefault();
    this.moveTeams(this.destinationTarget.querySelectorAll('input[type="checkbox"]'), this.sourceTarget);
  }

  moveTeams(from, to) {
    from.forEach((source) => {
      if (source.checked) {
        to.appendChild(source.closest('li'));
        source.checked = false;
      }
    });
    this.updateTeamIds();
    this.validate();
  }

  updateTeamIds() {
    const teamIds = Array.from(this.destinationTarget.children).map((li) => {
      return li.dataset.id;
    });
    this.teamIdsTarget.value = teamIds.join(',');
  }

  validate() {
    if (this.destinationTarget.children.length === 8) {
      this.submitTarget.disabled = false;
    } else {
      this.submitTarget.disabled = true;
    }
  }
}
