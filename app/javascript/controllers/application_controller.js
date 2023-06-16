import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {}

  printPage(){
    var restorePage = $('body').html();
    var printContent = $('.only-print').removeClass("page-a4").addClass("page").not(':hidden').clone();
    // var printContent = $('.only-print').not(':hidden').clone();
    $('body').empty().html(printContent);
    window.print();
    $('body').html(restorePage);
  }
  showErrorByElement(element, error) {
    element.parentElement.style.display = 'block';
    element.innerHTML = error;
  }

  showErrorsByLayout(msg){
    let element = $("#errorsAlert")[0];
    element.parentElement.style.display = 'block';
    element.innerHTML = msg;
  }

  showSuccessMsgByLayout(msg){
    alert('error layout')
    let element = $("#successAlert")[0];
    element.parentElement.style.display = 'block';
    element.innerHTML = msg;
  }
}
