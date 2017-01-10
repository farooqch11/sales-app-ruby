$(document).ready(function(){

	$(document).on("keypress", '.item_search_input', function(){
	  $('.item_search').click();
	});

	$(document).on("change", '.item_category_search_input', function(){
	  $('.item_search').click();
	});

	$(document).on("keypress", '.customer_search_input', function(){
	  $('.customer_search').click();
	});

	$(document).on("change", "#sale_comments_comments", function(){
		$('.sale_comments').click();
	});


	$(document).on("change", "#line_item_price", function(){
		$.ajax({
      type: "POST",
      url: '/sales/override_price', //sumbits it to the given url of the form
      data: {override_price: { price: $(this).val(), item_id: $(this).parent().parent().find('.item_id').val()} ,id: $('#search_sale_id').val() },
      dataType: "script",
      success: function() {
      	console.log('price updated');
      }
    });
  	// alert('price');
	});

	$(document).on("change", "#sale_discount", function(){
		$.ajax({
      type: "POST",
      url: '/sales/sale_discount', //sumbits it to the given url of the form
      data: {discount: $(this).val(), id: $('#search_sale_id').val()},
      dataType: "script",
      success: function() {
      	console.log('sale discounted');
      }
    });
  	// alert('price');
	});


	// Jquery form validations
	$(".form_custom_item").validate({
		rules: {
			"custom_item[name]": {required: true },
			"custom_item[price]": {required: true, number: true},
			"custom_item[stock_amount]": {required: true, number: true}
		}
	});

	$(".edit_sale").validate({
		rules: {
			"line_item[price]": {required: true, number: true }
		}
	});

	$("#new_item").validate({
		rules: {
			"item[sku]": {required: true },
			"item[name]": {required: true },
			"item[price]": {required: true, number: true },
			"item[stock_amount]": {required: true, number: true },
			"item[cost_price]": {required: true, number: true }
		}
	});

	$("#new_user").validate({
		rules: {
			"user[email]": {required: true, email: true },
			"user[username]": {required: true },
			"user[password]": {required: true }
		}
	});

	$("#new_customer").validate({
		rules: {
			"customer[first_name]": {required: true },
			"customer[last_name]": {required: true },
			"customer[email_address]": {email: true }
		}
	});

	$("#create_custom_customer").validate({
		rules: {
			"custom_customer[first_name]": {required: true },
			"custom_customer[last_name]": {required: true },
			"custom_customer[email_address]": {email: true }
		}
	});

    // Empty full cart
    $('#empty-cart').click(function(){
        $.ajax({
            type: "POST",
            url: '/sales/empty_cart', //sumbits it to the given url of the form
            data: { id: $('#search_sale_id').val()},
            dataType: "script",
            success: function() {
                console.log('empty_cart');
            }
        });
    });

    $('.cash').click(function(){
        $('#payments_payment_type').val('cash');
    });


    $('.card').click(function(){
        $('#payments_payment_type').val('credit_card');
    });

    $('.cash_card').click(function(){
        $('#payments_payment_type').val('cash_and_card');
    });
    $('.payment_term').click(function(){
        $('#payments_payment_type').val('payment_term');
    });

	// creates a line item for a sale
	var input = $('#search_item_name')[0];
	var sale_id = $('#search_sale_id')[0];
	  Awesomplete.$.bind(input, {
		  "awesomplete-selectcomplete": function(evt) {
              alert(input);
		   $.ajax({
		      type: "GET",
		      url: '/sales/create_line_item', //sumbits it to the given url of the form
		      data: { item_id: parseInt(input.value.split(".|")[0]), quantity: 1, id:  $('#search_sale_id').val() },
		      dataType: "script",
		      success: function() {
		      	// prepare the search box for the new entry
		      	input.value = "";
		      	 console.log('line item created');
		      }
		    });
		  }
        });

});
