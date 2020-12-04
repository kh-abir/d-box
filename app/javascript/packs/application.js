// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("cocoon")
require("chartkick")
require("chart.js")
require("highcharts")

import 'popper.js'
import 'bootstrap'
import './subcategories'
import "@fortawesome/fontawesome-free/js/all";


$(function () {
    $("#category_select").change(function () {
        let id = $(this).val();
        $("#sub_category-select").empty();
        $('#sub_category-select')
            .append(`<option>Choose a subcategory</option>`)
        if(id == ""){
            $("#sub_category-select").prop("disabled", true);
            return false;
        }
        $.ajax({
            url: `/categories/${id}/get_subcategories`,
            error: function () {
            },
            dataType: 'json',
            success: function (subCategories) {
                $("#sub_category-select").prop("disabled", false);
                subCategories.forEach(function (subCategory) {
                    $('#sub_category-select')
                        .append(`<option value=${subCategory.id}>${subCategory.title}</option>`)
                });
            },
            type: 'GET'
        });
    });




    //Admin panel
    let $periodHolders = $('#day, #week, #month, #year').hide();
    $('#day').show();
    $('.viewSwitch').click(function() {
        let href = $(this).attr('href');
        $periodHolders.hide();
        $(href).show();
    });

});









