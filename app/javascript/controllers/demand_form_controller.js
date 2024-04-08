import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ['applicant', 'fatherName', 'address', 'timePeriod', 'khasra', 
    'divertedArea', 'ratePerSqMeter', 'divertedAmt', "interest", 'year', 'Charge', 'isCessApplied'];


  addNewYear(){
    let rowString = `<div class="row">
      <div class="col-md-5 mb-3">
        <label for="year" class="form-label">वर्ष</label>
        <input type="text" class="form-control" value="" data-dmd-frm-target="year" >
      </div>
      <div class="col-md-5 mb-3">
        <label for="shashti" class="form-label">शास्ति(व्याज%)</label>
        <input type="number" class="form-control" value="" data-dmd-frm-target="interest" min="0"> 
      </div>
      <div class="col-md-2 mb-3 mt-3">
        <br/>
        <i class="fa-solid fa-trash fnt-20 text-danger" data-action="click->dmd-frm#removeRow"></i>
      </div>
    </div>`;
    $("#yearBlock").append(rowString);
  }

  removeRow(e){
    e.target.parentElement.parentElement.remove();
  }

  calDiversionAmt(){
    var divertedArea = this.divertedAreaTarget.value;
    var ratePerSqMeter = this.ratePerSqMeterTarget.value;
    var divertedAmt = 0;
    if(divertedArea && ratePerSqMeter) {
      divertedAmt = divertedArea*ratePerSqMeter;
      this.divertedAmtTarget.value = divertedAmt;
    }
  }

  fillForm(){
    $(".applicant").text(this.applicantTarget.value);
    $(".applicant_father_name").text(this.fatherNameTarget.value);
    $(".applicant_address").text(this.addressTarget.value);
    $(".time_period").text(this.timePeriodTarget.value);
    $($("#data-row").find("td")[1]).text(this.khasraTarget.value);

    var divertedAmt = this.divertedAmtTarget.value;
    $(".custom-tbl tr:gt(2)").remove();
    var isCessApplied = this.isCessAppliedTarget.checked;

    if(divertedAmt){
      var yearArr = this.yearTargets;
      var interestArr = this.interestTargets;
      $($("#data-row").find("td")[1]).text(this.khasraTarget.value);
      $($("#data-row").find("td")[0]).css({height: '0px'})
      var totalAmtWithMess=0, totalAmt = 0, totalInterest=0;

      if(isCessApplied){
        $($("#data-row").find("td")[2]).text('कर + उपकर');
      } else {
        $($("#data-row").find("td")[2]).text('');
      }
      for(var i=0; i<yearArr.length; i++){
        var amtWithCess = parseInt(divertedAmt) + parseInt(divertedAmt/2);
        var interest = interestArr[i].value ? interestArr[i].value : 0;
        var interestAmt = parseInt((amtWithCess*interest)/100);

        totalAmtWithMess = totalAmtWithMess + amtWithCess;
        totalInterest = totalInterest + interestAmt;
        totalAmt = totalAmt + amtWithCess+interestAmt;

        if(isCessApplied){
          $(".custom-tbl").append(`<tr>
            <td>${yearArr[i].value}</td><td></td>
            <td>${divertedAmt} + ${divertedAmt/2} = ${amtWithCess}</td>
            <td>${interestAmt} (${interest}%)</td>
            <td></td><td>${amtWithCess+interestAmt}</td><td></td></tr>`
          )
        } else {
          $(".custom-tbl").append(`<tr>
            <td>${yearArr[i].value}</td><td></td>
            <td>${divertedAmt}</td>
            <td>${interestAmt} (${interest}%)</td>
            <td></td><td>${amtWithCess+interestAmt}</td><td></td></tr>`
          )
        }
      }

      $(".custom-tbl").append(`<tr>
        <td>योग</td><td></td>
        <td>${totalAmtWithMess}</td>
        <td>${totalInterest}</td>
        <td></td><td>${totalAmt}</td><td></td></tr>`
      )

    } else {
      alert('Please fill diversion Amount.')
    }
  }
}
