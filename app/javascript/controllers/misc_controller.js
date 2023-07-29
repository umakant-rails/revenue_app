import { Controller } from "@hotwired/stimulus"

import ApplicationController from "./application_controller";

// Connects to data-controller="namantaran"
export default class extends ApplicationController {

  setPMKisanData(){
    var district = $("#district").val();
    var tehsil = $("#tehsil").val();
    var circle = $("#circle").val();
    var village = $("#village").find(':selected').text();
    var halka_name = $("#request_village_id").find(':selected').attr('halka_name');
    var halka_number = $("#request_village_id").find(':selected').attr('halka_number');
    $(".tehsil").addClass('filled-txt').text(tehsil);
    $(".halka_number").addClass('filled-txt').text(halka_number);
    $(".halka_name").addClass('filled-txt').text(halka_name);
    $(".village").addClass('filled-txt').text(village);
  }
}