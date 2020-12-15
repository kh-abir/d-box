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

    setTimeout(function () {
        $('#flash-message').fadeOut();
    },1000);

    $('#search').keyup(function () {
        let search_text = $(this).val();
        let letters = /^[A-Za-z]+$/;
        if (letters.test(search_text)){
            $.ajax({

                url: '/search_suggestions',
                type: 'GET',
                dataType: 'json',
                data: {search_text: search_text},
                success:function(data){
                    $('#search_suggestions').show();
                    $('#search_suggestions_list').empty();
                    for(let i = 0; i < data.length; i++){
                        let id = data[i].id;
                        let name = data[i].title;
                        $('#search_suggestions_list').append("<li value='" + id + "'><a href='/search?search=" + name + "'>" + name + "<\a><\li>");
                    }

                    $("#search_suggestions_list li").bind("click",function(){

                    });
                },
            });
        }
        else{
            $('#search_suggestions').hide();
        }
    });

    $(document).on('click', 'table .cart_quantity', function() {
        var x = $('td.cart_quantity #purchase-amount');
        if(x == null)
        {
            return false;
        }
        var id = $(this).attr('id');
        var value = parseInt($(this).text()) ;

       $(this).html(
       `
        <input data='${id}' min="1" max="10" value='${value}' style="width: 50%;" placeholder="Select amount" id="purchase-amount" type="number" name="ordered_item[quantity]">
       `
       )
    });

});







