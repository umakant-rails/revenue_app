import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {

  connect(){
    document.addEventListener("autocomplete.change", this.autocomplete.bind(this));
  }

  getRecords(event){
    this.params = {};
    let targetName = event.target.name;
    let selected_value = event.target.value;
    let url = "/blank_forms/get_records"

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

  autocomplete(){
    let formId = event.detail.value;
    this.params = {};
    this.params.form_id = formId;
    this.getData('get', '/welcome/form/search', this.params)
  }

  searchForms(){
    var searchTerm = $("#search_term").val();
    if(searchTerm.length == 0){
      return;
    }
    this.params = {};
    this.params.search_term = searchTerm;
    this.getData('get', '/welcome/form/search', this.params);
  }

  selectImage(e){
    var classes = e.target.classList;

    if(classes.contains('fa-circle-xmark')){
      $("#imagefordomicile").val("");
      $("#imageSelectBlock").show();

      $("#image-cross-icon").hide();
      $("#imageAddBlock").hide();
      $("#imageAddBlock").html("")
    } else if(classes.contains('fa-circle-plus')){
      $("#imagefordomicile").click();
    }
  }

  addImage(e){
    var file = e.target.files[0];

    const fileReader = new FileReader();
    fileReader.readAsDataURL(file);

    if(file.type.indexOf("image/") == -1){
      alert("कृपया केवल इमेज/फोटो को ही सेलेक्ट करे |");
      return;
    }

    fileReader.addEventListener("load", function () {
      var imageStr = `<div class="image-holder">
        <img src="${this.result}" style="width:100%;height:100px"/>
      </div>`;
      $("#imageSelectBlock").hide();

      $("#image-cross-icon").show();
      $("#imageAddBlock").show();
      $("#imageAddBlock").html(imageStr)
    });
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