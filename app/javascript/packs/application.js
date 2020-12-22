// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require owl.carousel
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
            url: `/admin/categories/${id}/get_subcategories`,
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
    $('.viewSwitch').click(function () {
        let href = $(this).attr('href');
        $periodHolders.hide();
        $(href).show();
    });

    setTimeout(function () {
        $('#flash-message').fadeOut();
    },1500);

    $('#search').keyup(function () {
        let search_text = $(this).val();
        let letters = /^[A-Za-z]+$/;
        if (letters.test(search_text)) {
            $.ajax({

                url: '/search_suggestions',
                type: 'GET',
                dataType: 'json',
                data: {search_text: search_text},
                success: function (data) {
                    $('#search_suggestions').show();
                    $('#search_suggestions_list').empty();
                    for (let i = 0; i < data.length; i++) {
                        let id = data[i].id;
                        let name = data[i].title;
                        $('#search_suggestions_list').append("<li value='" + id + "'><a href='/search?search=" + name + "'>" + name + "<\a><\li>");
                    }

                    $("#search_suggestions_list li").bind("click", function () {

                    });
                },
            });
        } else {
            $('#search_suggestions').hide();
        }
    });

    $(document).on('click', 'table .cart_quantity', function () {
        let id = $(this).attr('id');
        let stock = $(this).attr('stock');
        let value = parseInt($(this).text());
        $(this).removeClass('cart_quantity').addClass('edit_cart_quantity');
        $(this).html(
            `<div class="quantity_wrapper">
                <input min="1" max="${stock}" value='${value}' class="${id}_update_quantity form-control" type="number" name="ordered_item[quantity]"  />
                <button data='${id}' id="update_quantity" class="btn btn-secondary" type="button">Update</button>
                <button data='${id}' id="cancel" class="btn btn-danger" type="button">Cancel</button>
             </div>`
        );
    });

    $(document).on('click','#cancel', function () {
        let id = parseInt($(this).attr('data'));
        let input_field = $(`.${id}_update_quantity`);
        let current_item = parseFloat($(input_field).attr('value'));
        $('.quantity_wrapper').remove();
        $('.edit_cart_quantity').append(`${current_item}`);
        $('.edit_cart_quantity').removeClass().addClass('cart_quantity');
    });

    $(document).on('click', '#update_quantity', function () {
        let id = parseInt($(this).attr('data'));
        let input_field = $(`.${id}_update_quantity`);
        let updatedQuantity = parseFloat($(input_field).val());
        let stock = parseInt($(input_field).attr('max'));
        if (updatedQuantity > stock) {
            alert(`Stock limited ! You can order max ${stock} products`);
            return false;
        }
        $.ajax({
            url: `ordered_items/${id}`,
            type: 'PATCH',
            dataType: 'json',
            data: {ordered_item: {quantity: updatedQuantity}},
            success: function (response) {
                let current_item = parseFloat($(input_field).attr('value'));
                let current_total_item = parseFloat($('.badge').text());
                $('.quantity_wrapper').remove();
                $('.edit_cart_quantity').append(`${updatedQuantity}`);
                let subtotal = parseFloat($('.edit_cart_quantity').parent().find('.base_price').text()) * (updatedQuantity);
                $('.edit_cart_quantity').parent().find('.sub_total_price').text(subtotal);
                $('.grand_total').html(`<strong>${response}</strong>`);
                $('.badge').text((current_total_item - current_item)+ updatedQuantity);
                $('#flash-message').show().html("<p class='alert alert-success'>Cart Updated</p>");
                $('#flash-message').fadeOut(2000);
                $('.edit_cart_quantity').removeClass().addClass('cart_quantity');
            }
        });



    });
});







