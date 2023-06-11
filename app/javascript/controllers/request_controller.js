import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {
  static targets = ['paymentstatus', 'paymentNotDone', 'district', 'tehsil', 'circle', 'village', 
    'page', 'gaurdian', 'totalShareSold', 'isShareHolder', 'isApplicant', 'requestType', 'requestTitle'];

  connect() {
    this.params = {}
  }

  checkVillageStatus(){
    var villageName = this.villageTarget.options[this.villageTarget.selectedIndex].text;
    var requestType = event.target.options[event.target.selectedIndex].text;

    if(villageName.length == 0){
      super.showErrorsByLayout("कृपया पहले ग्राम चुने |");
      event.target.value = '';
    } else {
      var requestTitle = villageName + " का " + requestType + " हेतु आवेदन";
      this.requestTitleTarget.value = requestTitle;
    }
  }
  updateRequestTitle(){
    var applicant = event.target.value;
    var requestType = this.requestTypeTarget.options[this.requestTypeTarget.selectedIndex].text;
    var requestTitle = applicant + " का " + requestType + " आवेदन";

    this.requestTitleTarget.value = requestTitle;
 } 
  getRecords(event){
    this.params = {};
    let targetName = event.target.name;
    let selected_value = event.target.value;
    let url = "/requests/get_records"

    if(selected_value == ''){
      return ;
    }

    this.params.selected_field = targetName;
    this.params.selected_value = selected_value;

    if(targetName == 'district'){
      this.getData('get', url, this.params);
    } else if (targetName == 'tehsil'){
      this.getData('get', url, this.params);
    } else if (targetName == 'circle'){
      this.getData('get', url, this.params);
    }
    
  }

  showPage(event){
    var pageName = event.target.dataset.pagename;
    var list_elements = event.target.parentElement.children;
    var paymentStatus = this.paymentstatusTarget.dataset.vl;

    for(var list of list_elements){
      if(list == event.target){
        list.classList.add('active');
      } else {
        list.classList.remove('active');
      }
    }

    // if(paymentStatus != 'true'){
    //   this.paymentNotDoneTarget.style.display ='block';
    // }
    
    for(var page of this.pageTargets){
      if(page.dataset['name'] == pageName){
        page.style.display ='block';
      } else {
        page.style.display ='none';
      }
    }
  }
  
  updateAnavedakFields(event){
    var participantType = event.target.value;
    if(participantType == 2 || participantType == 3){
      this.totalShareSoldTarget.disabled = false;
      this.isShareHolderTarget.disabled = false;
      this.isApplicantTarget.disabled = true;
    } else {
      this.totalShareSoldTarget.disabled = true;
      this.isShareHolderTarget.disabled = true;
      this.isApplicantTarget.disabled = false;
    }
  }

  /* start js block - make ajax requext */
  getData(requestType, url, params){
    $(".spinner").css('display', 'block');
    $.ajax({
      type: requestType,
      url: url,
      data: params,
      dataType: 'script',
      success: function(data){
      }
    });
  }
/* end js block - make ajax requext */
}
