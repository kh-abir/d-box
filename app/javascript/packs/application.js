// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require owl.carousel
//= require moment
//= require daterangepicker
//= require chosen-jquery
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("cocoon")
require("chartkick")
require("chart.js")
require("highcharts")

import 'popper.js'
import 'bootstrap'

import "@fortawesome/fontawesome-free/js/all";


$(function () {
    $("#category_select").change(function () {
        let id = $(this).val();
        $("#sub_category-select").empty();
        $('#sub_category-select')
            .append(`<option>Choose a subcategory</option>`);
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


    //Search panel
    $('#search').keyup(function () {
        let search_text = $(this).val();
        if (search_text == ""){
            $('#search_suggestions').hide();
        }
        else{
            $.ajax({
                url: '/search_suggestions',
                type: 'GET',
                dataType: 'json',
                data: {search_text: search_text},
                success: function (data) {
                    if (data['products'].length ==0 && data['sub_categories'].length == 0 && data['categories'].length == 0){
                        $('#search_suggestions').hide();
                    }
                    else {
                        $('#search_suggestions').show();
                        $('#search_suggestions_list').empty();

                        if (data['categories'].length != 0) {
                            $('#search_suggestions_list').append("<li>" + "Categories" + " <\li>");
                        }

                        for (let i = 0; i < data['categories'].length; i++) {
                            let id = data['categories'][i].id;
                            let name = data['categories'][i].title;
                            $('#search_suggestions_list').append("<li value='" + id + "'><a href='/search?search=" + name + "'>" + name + "<\a><\li>");
                        }

                        if (data['sub_categories'].length != 0) {
                            $('#search_suggestions_list').append("<li>" + "Subcategories" + " <\li>");
                        }

                        for (let i = 0; i < data['sub_categories'].length; i++) {
                            let id = data['sub_categories'][i].id;
                            let name = data['sub_categories'][i].title;
                            $('#search_suggestions_list').append("<li value='" + id + "'><a href='/search?search=" + name + "'>" + name + "<\a><\li>");
                        }

                        if (data['products'].length != 0) {
                            $('#search_suggestions_list').append("<li>" + "Products" + " <\li>");
                        }

                        for (let i = 0; i < data['products'].length; i++) {
                            let id = data['products'][i].id;
                            let name = data['products'][i].title;
                            $('#search_suggestions_list').append("<li value='" + id + "'><a href='/search?search=" + name + "'>" + name + "<\a><\li>");
                        }
                    }
                },
            });
        }
    });

    //Updating cart items on click
    $(document).on('click', 'table .cart_quantity', function () {
        let temp = parseInt($('.quantity_wrapper').attr('id'));
        if(!isNaN(temp)){
            $('.quantity_wrapper').remove();
            $('.edit_cart_quantity').append(`${temp}`);
            $('.edit_cart_quantity').removeClass().addClass('cart_quantity');
        }
        let id = $(this).attr('id');
        let stock = $(this).attr('stock');
        let value = parseInt($(this).text());
        $(this).removeClass('cart_quantity').addClass('edit_cart_quantity');
        $(this).html(
            `<div class="quantity_wrapper" id="${value}">
                <input min="1" max="${stock}" value='${value}' class="${id}_update_quantity form-control" type="number" name="ordered_item[quantity]"  />
                <button data='${id}' id="update_quantity" class="cart-update-btn" type="button"><i class="fas fa-check"></i></button>
                <button data='${id}' id="cancel" class="cart-cancel-btn" type="button"><i class="fas fa-times"></i></button>
             </div>`
        );
    });
    //cancel updating cart quantity
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
            alert(`Stock limited ! You can order max ${stock} items`);
            return false;
        }
        $.ajax({
            url: `ordered_items/${id}`,
            type: 'PATCH',
            dataType: 'json',
            data: {ordered_item: {quantity: updatedQuantity}},
            success: function (response) {
                let current_item = parseFloat($(input_field).attr('value'));
                let current_total_item = parseFloat($('.notification-badge').text());
                $('.quantity_wrapper').remove();
                $('.edit_cart_quantity').append(`${updatedQuantity}`);
                let subtotal = parseFloat($('.edit_cart_quantity').parent().find('.base_price').text()) * (updatedQuantity);
                $('.edit_cart_quantity').parent().find('.sub_total_price').text(subtotal.toFixed(1));
                $('.grand_total').html(`<strong class="dollars" style="margin-left: 25px;">${response}</strong>`);
                $('.notification-badge').text((current_total_item - current_item)+ updatedQuantity);
                $('#flash-message').show().html("<p class='alert alert-success'>Cart Updated</p>");
                $('#flash-message').fadeOut(2000);
                $('.edit_cart_quantity').removeClass().addClass('cart_quantity');
            }
        });
    });

    //checkout form stuffs
    $(document).on('click', '#payment_option_card', function () {
        $('.card-msg').fadeOut(500);
        $('.card_info').show();
    });
    $(document).on('click', '#payment_option_bkash', function () {
        $('.reveal').show();
    });
    $(document).on('click', '#payment_option_paypal', function () {
        $('.reveal').show();
    });

    // To print the invoice
    $(document).on('click','#print', function printContent(el){
        let restorepage = $('body').html();
        let printcontent = $('#' + el).clone();
        $('body').empty().html(printcontent);
        window.print();
        $('body').html(restorepage);
    });


    //Banner panel
    $('#banner_link_type').change(function () {
        let input = $(this).val();
        if(input === "" || input === "without link"){
            $(".subcategory-select").hide();
            $(".product-select").hide();
            $(".category-select").hide();
        }
        else if(input === "category") {
            $(".subcategory-select").hide();
            $(".product-select").hide();
            $(".category-select").show();
        }
        else if(input === "subcategory") {
            $(".category-select").hide();
            $(".product-select").hide();
            $(".subcategory-select").show();
        }
        else if(input === "product") {
            $(".category-select").hide();
            $(".subcategory-select").hide();
            $(".product-select").show();
        }
        else {
            $(".subcategory-select").hide();
            $(".product-select").hide();
            $(".category-select").hide();
        }

    });

    // $('.chosen-select').chosen();







});







