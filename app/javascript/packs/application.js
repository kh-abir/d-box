// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require owl.carousel
//= require moment
//= require chosen-jquery
//= require country_select_search
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

// localStorage.setItem("ordered_items", {
//     "quantity": "1",
//     "product_variant_id": "6",
//     "price": "20763.0",
//     "details": "Incredible's variant_5",
//     "product_id": 1,
//     "in_stock": 81,
//     "purchase_price": "15568.5",
//     "featured": "yes"
// });
$(function () {

    function format_price(n, precision) {
        precision = precision || 2;
        return n.toLocaleString().split(".")[0]
            + "."
            + n.toFixed(precision).split(".")[1];
    }

    $("#category_select").change(function () {
        let id = $(this).val();
        $("#sub_category-select").empty();
        $('#sub_category-select')
            .append(`<option>Choose a subcategory</option>`);
        if (id == "") {
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
    }, 1000);

    //Search panel

    $('#search_products').keyup(function () {
        let search_text = $(this).val();
        if (search_text === "") {
            $('#products_search_suggestion').hide();
        } else {
            $.ajax({
                url: '/admin/products_search_suggestion',
                type: 'POST',
                dataType: 'json',
                data: {search_text: search_text},
                success: function (data) {
                    if (data['products'].length === 0) {
                        $('#products_search_suggestion').hide();
                    } else {
                        $('#products_search_suggestion').show();
                        $('#products_search_suggestion_list').empty();

                        for (let i = 0; i < data['products'].length; i++) {
                            var product_id = data['products'][i].id;
                            var title = data['products'][i].title;
                            $('#products_search_suggestion_list').append(`<li value="${product_id}"><a href="/admin/products/${product_id}">${title}</a></li>`);
                        }
                    }
                }
            });
        }
    });

    $('#search_variants').keyup(function () {
        let search_text = $(this).val();
        if (search_text === "") {
            $('#variants_search_suggestion').hide();
        } else {
            let product_id = $('#product_info').attr('product_id');
            $.ajax({
                url: '/admin/variants_search_suggestion',
                type: 'POST',
                dataType: 'json',
                data: {search_text: search_text, product_id: product_id},
                success: function (data) {
                    if (data['product_variants'].length === 0) {
                        $('#variants_search_suggestion').hide();
                    } else {
                        $('#variants_search_suggestion').show();
                        $('#variants_search_suggestion_list').empty();

                        for (let i = 0; i < data['product_variants'].length; i++) {
                            var product_variant_id = data['product_variants'][i].id;
                            var details = data['product_variants'][i].details;
                            $('#variants_search_suggestion_list').append(`<li value="${product_variant_id}"><a href="/admin/products/${product_id}/product_variants/${product_variant_id}">${details}</a></li>`);
                        }
                    }
                }
            });
        }
    });

    $('#search_orders').keyup(function () {
        let search_text = $(this).val();
        if (search_text === "") {
            $('#orders_search_suggestion').hide();
        } else {
            $.ajax({
                url: '/admin/orders_search_suggestion',
                type: 'POST',
                dataType: 'json',
                data: {search_text: search_text},
                success: function (data) {
                    if (data['orders'].length === 0) {
                        $('#orders_search_suggestion').hide();
                    } else {
                        $('#orders_search_suggestion').show();
                        $('#orders_search_suggestion_list').empty();

                        for (let i = 0; i < data['orders'].length; i++) {
                            var order_id = data['orders'][i]['order_id'];
                            var full_name = data['orders'][i]['name'];
                            $('#orders_search_suggestion_list').append(`<li value="${order_id}"><a href="/admin/orders/${order_id}">${full_name}</a></li>`);
                        }
                    }
                }
            });
        }
    });

    $('#search').keyup(function () {
        let search_text = $(this).val();
        if (search_text === "") {
            $('#search_suggestions').hide();
        } else {
            $.ajax({
                url: '/search_suggestions',
                type: 'GET',
                dataType: 'json',
                data: {search_text: search_text},
                success: function (data) {
                    if (data['products'].length === 0 && data['sub_categories'].length === 0 && data['categories'].length === 0) {
                        $('#search_suggestions').hide();
                    } else {
                        $('#search_suggestions').show();
                        $('#search_suggestions_list').empty();

                        if (data['categories'].length !== 0) {
                            $('#search_suggestions_list').append("<li>" + "Categories" + " </li>");
                        }

                        for (let i = 0; i < data['categories'].length; i++) {
                            let id = data['categories'][i].id;
                            let name = data['categories'][i].title;
                            $('#search_suggestions_list').append("<li value='" + id + "'><a href='/categories/" + id + "/products'>" + name + "</a></li>");
                        }

                        if (data['sub_categories'].length !== 0) {
                            $('#search_suggestions_list').append("<li>" + "Subcategories" + " </li>");
                        }

                        for (let i = 0; i < data['sub_categories'].length; i++) {
                            let id = data['sub_categories'][i].id;
                            let name = data['sub_categories'][i].title;
                            $('#search_suggestions_list').append("<li value='" + id + "'><a href='/sub_categories/" + id + "/products'>" + name + "</a></li>");
                        }

                        if (data['products'].length !== 0) {
                            $('#search_suggestions_list').append("<li>" + "Products" + " </li>");
                        }

                        for (let i = 0; i < data['products'].length; i++) {
                            let id = data['products'][i].id;
                            let name = data['products'][i].title;
                            $('#search_suggestions_list').append("<li value='" + id + "'><a href='/search?search=" + name + "'>" + name + "</a></li>");
                        }
                    }
                },
            });
        }
    });
    //coupon
    $(document).on('keyup', '#coupon', function (event) {
        if (event.keyCode === 13) $('.coupon_apply_button').click();
    });
    $(document).on('click', '.coupon_apply_button', function () {
        let code = $('#coupon').val();
        $.ajax({
            url: '/check_coupon',
            type: 'GET',
            dataType: 'json',
            data: {code: code},
            success: function (response) {
                if (response !== false) {
                    let amount = response.amount;
                    let grand_total = parseFloat($('.grand_total').attr('value'));
                    $('.grand_total').parent().children(':first-child').html(`<small>Coupon Discount (-)</small> <br>Total`);
                    $('.grand_total').html(
                        `<strong class="dollars coupon_amount">${format_price(amount / 100.0)}</strong><br>
                         <strong class="dollars">${format_price((grand_total - amount) / 100.0)}</strong>`
                    );
                    $('.coupon_apply_button').hide();
                    $('#coupon').prop('disabled', true);
                    $('#flash-message').show().html("<p class='alert alert-success'>Coupon Applied!</p>");
                    $('#flash-message').fadeOut(2000);
                } else {
                    $('#flash-message').show().html("<p class='alert alert-danger'>Invalid Coupon!</p>");
                    $('#flash-message').fadeOut(2000);
                }
            }
        });
    });
    $(document).on('click', '.coupon_remove_button', function () {
        $('#coupon').val(null);
        $('#coupon').prop('disabled', false);
        $('.coupon_apply_button').show();
        if (!$('.coupon_apply_button').length) {
            $('#coupon').next().prepend(`<button class="btn btn-info coupon_apply_button" type="button">Apply</button>`)
        }
        $.ajax({
            url: '/remove_coupon',
            type: 'DELETE'
        });
        $('.grand_total').parent().children(':first-child').text('Total');
        $('.grand_total').html(
            `<strong class="dollars">${format_price(parseFloat($('.grand_total').attr('value')) / 100.0)}</strong>`
        );

    });
    //Updating carts items on click
    $(document).on('click', 'table .cart_quantity', function () {
        if ($('.edit_cart_quantity').length) $('#cancel').click();

        let id = parseInt($(this).attr('id'));
        let stock = $(this).attr('stock');
        let value = parseInt($(this).text());
        $(this).html(
            `<div class="quantity_wrapper" id="${id}_quantity_wrapper">
                <input min="1" max="${stock}" value="${value}" class="${id}_update_quantity form-control" type="number" name="ordered_item[quantity]"  />
                <button data-id='${id}' id="update_quantity" class="cart-update-btn" type="button"><i class="fas fa-check"></i></button>
                <button data-id='${id}' id="cancel" class="cart-cancel-btn" type="button"><i class="fas fa-times"></i></button>
             </div>`
        );
        $(this).removeClass('cart_quantity').addClass('edit_cart_quantity');
    });
    $(document).on('click', '#update_quantity', function () {
        let id = parseInt($(this).attr('data-id'));
        let input_field = $(`.${id}_update_quantity`);
        let updatedQuantity = parseFloat($(input_field).val());
        let stock = parseInt($(input_field).attr('max'));
        if (updatedQuantity > stock) {
            alert(`Stock limited ! You can order max ${stock} items`);
            return false;
        }
        $.ajax({
            url: `update_cart`,
            type: 'PATCH',
            dataType: 'json',
            data: {ordered_item: {quantity: updatedQuantity, product_variant_id: id}},
            success: function (response) {
                let grand_total = parseFloat(response);
                let current_item = parseFloat($(input_field).attr('value'));
                let current_total_item = parseFloat($('.notification-badge').text());
                $('.quantity_wrapper').remove();
                $('.edit_cart_quantity').removeClass().addClass('cart_quantity').append(`${updatedQuantity}`);
                // $('.cart_quantity').append(`${updatedQuantity}`);
                let subtotal = parseFloat($(`#${id}_cart_price`).attr('value')) * updatedQuantity;
                $(`#${id}_sub_total_price`).text(format_price(subtotal / 100.0));

                if ($('.coupon_amount').text() === '') {
                    $('.grand_total').html(
                        `<strong class="dollars">${format_price((grand_total) / 100.0)}</strong>`
                    );
                } else {
                    let coupon_amount = parseFloat($('.coupon_amount').text()) * 100;
                    $('.grand_total').html(
                        `<strong class="dollars coupon_amount">${format_price(coupon_amount / 100.0)}</strong><br>
                         <strong class="dollars">${format_price((grand_total - coupon_amount) / 100.0)}</strong>`
                    );
                }
                $('.grand_total').attr('value', grand_total);
                $('.notification-badge').text((current_total_item - current_item) + updatedQuantity);
                $('#flash-message').show().html("<p class='alert alert-success'>Cart Updated</p>");
                $('#flash-message').fadeOut(2000);
            }
        });
    });
    //cancel updating carts quantity
    $(document).on('click', '#cancel', function () {
        let id = parseInt($(this).attr('data-id'));
        let input_field = $(`.${id}_update_quantity`);
        let current_item = parseFloat($(input_field).attr('value'));
        $('.quantity_wrapper').remove();
        $('.edit_cart_quantity').removeClass().addClass('cart_quantity').append(`${current_item}`);
    });

    // Stripe Checkout
    $(document).ready(function () {
        $('.checkoutbtn').on('click', function (event) {
            $('.checkoutbtn').prop('disabled', true);
            let invalid = false;
            if ($("#shipping_address_street").val() === "") {
                invalid = true;
            }
            if ($("#shipping_address_city").val() === "") {
                invalid = true;
            }
            if ($("#shipping_address_country").val() === "") {
                invalid = true;
            }
            if ($("#shipping_address_zip").val() === "") {
                invalid = true;
            }
            if (invalid) {
                $(".checkoutbtn").prop('disabled', false);
                alert('You must fill required fields!');
                return false;
            }
            event.preventDefault();
            let $button = $(this),
                $form = $button.parents('form');
            let opts = $.extend({}, $button.data(), {
                token: function (result) {
                    $form.append($('<input>').attr({type: 'hidden', name: 'stripeToken', value: result.id})).submit();
                }
            });
            StripeCheckout.open(opts);
        });
    });

    // Disable button
    // $(document).ready(function() {
    //     $(':input[type="submit"]').prop('disabled', true);
    //     $('input[type="text"]').keyup(function() {
    //         if($(this).val() != '') {
    //             $(':input[type="submit"]').prop('disabled', false);
    //         }
    //     });
    // });

    //Create Discount
    $(document).on('click', '.category_discount_btn', function () {
        $('.product_discount_btn').hide();
        $('.category_discount_btn').hide();
        $('.discount_head').append(' Category');
        $('.select_category').show();
    });
    $(document).on('click', '.product_discount_btn', function () {
        $('.product_discount_btn').hide();
        $('.category_discount_btn').hide();
        $('.discount_head').append(' Product');
        $('.select_product').show();
    });
    // To print the invoice
    $(document).on('click', '#print', function printContent(el) {
        let restorepage = $('body').html();
        let printcontent = $('#' + el).clone();
        $('body').empty().html(printcontent);
        window.print();
        $('body').html(restorepage);
    });
    //Banner panel
    $(document).on('click', '.category_banner_btn', function () {
        $('.category_banner_btn').hide();
        $('.sub_category_banner_btn').hide();
        $('.product_banner_btn').hide();
        $('.without_link_banner_btn').hide();
        $('.discount_head').append(' Category');
        $('.select_banner_for_category').show();
    });
    $(document).on('click', '.sub_category_banner_btn', function () {
        $('.category_banner_btn').hide();
        $('.sub_category_banner_btn').hide();
        $('.product_banner_btn').hide();
        $('.without_link_banner_btn').hide();
        $('.discount_head').append(' Subcategory');
        $('.select_banner_for_sub_category').show();
    });
    $(document).on('click', '.product_banner_btn', function () {
        $('.category_banner_btn').hide();
        $('.sub_category_banner_btn').hide();
        $('.product_banner_btn').hide();
        $('.without_link_banner_btn').hide();
        $('.discount_head').append(' Product');
        $('.select_banner_for_product').show();
    });
    $(document).on('click', '.without_link_banner_btn', function () {
        $('.category_banner_btn').hide();
        $('.sub_category_banner_btn').hide();
        $('.product_banner_btn').hide();
        $('.without_link_banner_btn').hide();
        $('.discount_head').append(' Without Link');
        $('.select_banner_for_without_link').show();
    });

    $(document).on('click', '#revenue_search_btn', function () {
        let start_date = $('#revenue-start-date').val();
        let end_date = $('#revenue-end-date').val();
        $.ajax({
            url: "admin_panels/reports",
            type: "POST",
            dataType: "json",
            data: {start_date: start_date, end_date: end_date},
            success: function (data) {
                $('.revenue_by_custom_date').show();
                $('.revenue').text(format_price(parseFloat(data)));
            }
        });
    });
    // Product back in stock notification
    $('#myCheck').on('change', function () {
        let productId = $(this).attr('product-id');
        if ($(this).is(':checked')) {
            $.ajax({
                url: '/save_user_to_notify',
                type: 'POST',
                dataType: 'json',
                data: {productId: productId},
                success: function (response) {
                    if (response) {
                        $('#flash-message').show().html(
                            "<p class='alert alert-success'>You will be notified when the product comes back in stock!</p>"
                        );
                        $('#flash-message').fadeOut(2000);
                    } else {
                        alert('You need to Sign in to get notified!');

                        if ($("#myCheck").is(':checked')) {
                            $("#myCheck").prop('checked', false);
                        }
                    }
                }
            })
        } else {
            $.ajax({
                url: '/delete_user_notification',
                type: 'DELETE',
                dataType: 'json',
                data: {productId: productId}
            })
        }
    });
    //Order Status
    $(document).on('click', '.order_status', function () {
        $('.update_status').hide();
        let id = $(this).attr('id');
        $('.my-cancel-btn').hide();
        $('#update_status_cancel_' + id).show();
        $('#update_status_' + id).show();
    });
    $(document).on('click', '.update_status_cancel', function () {
        $('.update_status').hide();
        let id = $(this).attr('id');
        $('.my-cancel-btn').hide();
        $('#update_status_' + id).hide();
    });

});







