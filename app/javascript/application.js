// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from '@rails/ujs';
import $ from 'jquery';
window.$ = $;

import "bootstrap";
import "popper";
import "controllers";

Rails.start();