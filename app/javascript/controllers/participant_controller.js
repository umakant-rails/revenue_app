import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['balee', 'gaurdian', 'isNabalig', 'relation', 'foutPerson', 'isApplicant', 'relationToDeceased'];

  connect() {
    this.params = {}
  }

  updateBaleeStatus(event){
    var isFaut = event.target.value;
    if(isFaut == 'true'){
      this.baleeTarget.disabled = true;
      this.isNabaligTarget.disabled = true;
      this.isNabaligTarget.value = false;
      this.baleeTarget.value = '';

      var relationToDeceased = this.relationTarget.value;

      if(relationToDeceased == 'पुत्री'){
        super.showErrorsByLayout("यदि वारसान पुत्री है और फौत हो चुकी है एवं उसके स्वयं के पुत्री/पुत्री/ वारसान है तो अभिभावक में उसके पति का नाम दर्ज करे");
        event.target.value = '';
        this.relationTarget.value = '';
        this.gaurdianTarget.value = '';
      }
      this.isApplicantTarget.disabled = true;
      this.isApplicantTarget.value = false;
    } else {
      this.isNabaligTarget.disabled = false;
      this.isApplicantTarget.disabled = false;
      this.isApplicantTarget.value = '';
    }
  }

  updateBaleeInput(event){
    var isNabalig = event.target.value;
    if(isNabalig == 'true'){
      this.baleeTarget.disabled = false;
    } else {
      this.baleeTarget.disabled = true;
      this.baleeTarget.value = '';
    }
  }

  updateRelation(event){
    var relation = event.target.value;
    var foutPerson = this.foutPersonTarget.value;

    if(foutPerson.length == 0){
      super.showErrorsByLayout("कृपया पहले फौत व्यक्ति को चुने |");
      event.target.value = '';
      return;
    }
    if(['पुत्र','पुत्री', 'पत्नी'].indexOf(relation) != -1) {
      this.relationTarget.value = relation;
    } else {
      this.relationTarget.value = "";
    }
  }

  feedGaurdian(event){
    var relation = event.target.value;
    if(['पति', 'अन्य'].indexOf(relation) == -1){
      let gaurdian = this.foutPersonTarget.options[this.foutPersonTarget.selectedIndex].dataset.gaurdian;
      this.gaurdianTarget.value = gaurdian;
    } else {
      this.gaurdianTarget.value = "";
    }
  }

  /* end js block - make ajax requext */
}
