// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import ApplicationController from "./application_controller";
import RequestController from "./request_controller";
import FlatPickerController from './flatpickr_controller';
import ParticipantController from  './participant_controller';
import TemplateController from  './template_controller';
import PaymentController from "./payment_controller";
import KhasraBattankController from "./khasra_battank_controller"
import BlankFormController from "./blank_form_controller"
import { Autocomplete } from "stimulus-autocomplete";

application.register("application", ApplicationController);
application.register("request", RequestController);
application.register("flatpickr", FlatPickerController);
application.register("participant", ParticipantController);
application.register("template", TemplateController);
application.register("autocomplete", Autocomplete);
application.register("payment", PaymentController);
application.register("khbattank", KhasraBattankController);
application.register("blnk-frm", BlankFormController);