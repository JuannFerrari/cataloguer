import { Controller } from "stimulus";
import $ from "jquery";

require("select2/dist/css/select2");
require("select2-bootstrap-theme/dist/select2-bootstrap");

import Select2 from "select2";

export default class extends Controller {
  static values = { url: String }

  connect() {
    $(".content-search").select2({
      ajax: {
        url: this.urlValue,
        dataType: "json",
        delay: 300,
        data: function (params) {
          let query = {
            search: params.term,
          };
          return query;
        },
        processResults: function (data) {
          return {
            results: data,
          };
        },
      },
    });
  }
}
