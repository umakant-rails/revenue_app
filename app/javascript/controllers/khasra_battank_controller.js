import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['battankSankhya', 'khasra', 'battankBlock', 'newkhasraListBlock', 
    'newkhasraFormBlock', 'crsfToken', 'newBattankForm', 'hissedar', 'newBattank', 
    'newBattankInput', 'submitBtn', 'allotedRakba', 'allotedKhasraBlock'];

  connect() {
    this.params = {}
  }
  
  createKhasraBattanksHtml(){
    var indx = event.target.dataset.indx;
    var battank_fields = "";

    var battank_sankhya = this.battankSankhyaTargets[indx].value;
    var id = this.khasraTargets[indx].dataset['id'];
    var khasra = this.khasraTargets[indx].value;
    var rakba = this.khasraTargets[indx].dataset['rakba'];

    if(battank_sankhya == '' || battank_sankhya == 1){
      this.addNewKhasraBattank()
    } else {
      for(var i=0; i<battank_sankhya; i++){
        battank_fields = battank_fields + `
          <div class="row mb-3 battank-fieldset">
            <div class="col-md-4">
              <input name="khasra_battank_attributes[${i}][khasra_id]" type="hidden" value="${id}" 
              class="form-control" />
              <input name="khasra" value="${khasra}" readonly=true class="form-control" />
            </div>
            <div class="col-md-4">
              <input name="khasra_battank_attributes[${i}][new_khasra]" value="${khasra}/${i+1}" class="form-control" />
            </div>
            <div class="col-md-4">
              <input name="khasra_battank_attributes[${i}][rakba]" value="" class="form-control"
               data-khbattank-target="newBattankInput" data-totalrakba="${rakba}" />
            </div>
          </div>  
        `;
      }
      this.battankSankhyaTargets[indx].value = '';
      this.battankBlockTarget.innerHTML = battank_fields;
      this.newkhasraListBlockTarget.style.display = 'none';
      this.newkhasraFormBlockTarget.style.display = 'block';
    }
  }

  resetKhasraBattanksHtml(){
    this.battankBlockTarget.innerHTML = '';
    this.newkhasraListBlockTarget.style.display = '';
    this.newkhasraFormBlockTarget.style.display = 'none';
  }

  addNewKhasraBattank(){
    var indx = event.target.dataset.indx;
    var khasra = this.khasraTargets[indx].value;
    var id = this.khasraTargets[indx].dataset['id'];
    var requestId = this.khasraTargets[indx].dataset['requestid'];
    var rakba = this.khasraTargets[indx].dataset['rakba']
    var csrfToken = this.crsfTokenTarget.value;

    var params = {
      authenticity_token: csrfToken,
      khasra_battank: {
        khasra_id: id,
        new_khasra: khasra,
        rakba: rakba
      }
    }
    var errorCallbackMethod = super.showErrorsByLayout;
    var successCallbackMethod = super.showErrorsByLayout;
    this.getData('POST', '/requests/'+requestId+'/khasra_battanks', params, 
      errorCallbackMethod , successCallbackMethod);    
  }

  submitForm(event){
    var rakbaArr = [];
    var total = 0;
    var newBattankFields = this.newBattankInputTargets;
    var totalRakba = parseFloat(this.newBattankInputTargets[0].dataset['totalrakba'])*10000;
    console.log(newBattankFields);
    for(var i=0; i<newBattankFields.length; i++){
      rakbaArr.push(parseFloat(newBattankFields[i].value) * 10000);
    }

    rakbaArr.forEach(function(vl){total += vl; });

    if(total != totalRakba){
      super.showErrorsByLayout(`कृपया सभी नए बटांक का रकबा मिलान करे | 
          सभी नए बटांक का कुल रकबा ${totalRakba/10000.0} हे. होना चाहिए,
          जबकि आपके द्वारा दर्ज किया गया कुल रकबा ${total/10000.0} हे. है |`);
      window.scrollTo(0, 0);

      var submitBtn = this.submitBtnTarget;
      setTimeout(function(){ submitBtn.disabled = false; }, 2000)
      event.preventDefault();
    }
  }

  calculateAllotedRakba(){
    let khasraElements = this.newBattankTargets.filter((x) => x.checked === true );
    var allotedRakba = 0;
    khasraElements.forEach(function(element){
      allotedRakba  += parseFloat(element.dataset['rakba']) * 10000;
    });
    this.allotedRakbaTarget.textContent = (allotedRakba/10000) + " हे." 
  }

  allotKhasraToNewHissedar(event){
    var params = {};
    let hissedarElements = this.hissedarTargets.filter((x) => x.checked === true );
    let khasraElements = this.newBattankTargets.filter((x) => x.checked === true );
    var csrfToken = this.crsfTokenTarget.value;
    var khasra_ids = khasraElements.map(function(element){ return element.dataset['id']});
    var hissedar_ids = hissedarElements.map(function(element){ return element.dataset['hissedarId']});
    var requestId = event.target.dataset['requestId'];

    var errorCallbackMethod = super.showErrorsByLayout;
    var successCallbackMethod = super.showErrorsByLayout;

    if(khasra_ids.length == 0){
      super.showErrorsByLayout("कृपया खसरा आवंटित करने के लिए पहले खसरा नंबर चुने |");
    } else if(hissedar_ids.length == 0){
      super.showErrorsByLayout("कृपया खसरा आवंटित करने के लिए पहले हिस्सेदार चुने |");
    } else {
      params = {
        authenticity_token: csrfToken,
        khasra_battank: {
          khasra_ids: khasra_ids,
          hissedar_ids: hissedar_ids
        }
      }
    }
    this.getData('POST', '/requests/'+requestId+'/khasra_battanks/add_participants' , params, 
      errorCallbackMethod , successCallbackMethod); 
  }

  removePraticipantFromNewBattanks(event){
    var newKhasraId = event.target.parentElement.dataset['id'];
    var requestId = event.target.parentElement.dataset['requestId'];
    var errorCallbackMethod = super.showErrorsByLayout;
    var successCallbackMethod = super.showErrorsByLayout;

    var csrfToken = this.crsfTokenTarget.value;
    var params = { authenticity_token: csrfToken }

    this.getData('POST', '/requests/'+requestId+'/khasra_battanks/' + newKhasraId + '/remove_participant' , params, 
      errorCallbackMethod , successCallbackMethod);
  }

  getData(requestType, url, params, errorCallback, successCallback){
    $.ajax({
      type: requestType,
      url: url,
      data: params,
      dataType: 'script',
      success: function(data){
      }, 
      error: function(error){
        var errors = JSON.parse(error.responseText);
        var errorKeys = Object.keys(errors);
        var errorArr = [];

        errorKeys.forEach(function (key) { 
          var value = errors[key];
          errorArr.push(key + " " + value);
        });
        errorCallback(errorArr.join("<br/>"));
      } 
    });
  }

}
