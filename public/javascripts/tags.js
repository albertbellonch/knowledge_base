     var blank_label = "Please write a new tag name"
     $(document).ready(function() {
      var csrf_token = $('meta[name=csrf-token]').attr('content');
      var csrf_param = $('meta[name=csrf-param]').attr('content');
      $("#asset_name").focus();
      $("#new_tag_link").click(function() {
        $("#tag-form").fadeIn("slow");
        $("#tag_name").focus();
      });
      $("#tag-form").bind("keypress", function(e) { // Disable Submit on Enter key
        if (e.keyCode == 13) {
          return false;
        }
      });
      $(".tag").hover(function() {
        $(this).find(".delete-tag").show();
      });
      $(".tag").mouseleave(function() {
        $(this).find(".delete-tag").hide();
      })
      $("#tag_name").focusout(function() {
        if ($(this).val() == "") {
          $(this).val(blank_label);
          $(this).css("color", "#AAA");
        }
      });
      $("#tag_name").focus(function() {
        var tag_input = $(this);
        if ($(this).val() == blank_label) {
          $(this).val("");
          $(this).css("color", "#222");
        }
        $(this).keyup(function(e) {
          if (e.keyCode == 13) {
            var tag_name = tag_input.val();
           if (tag_name != ""){
              tag_input.val("");
              var data = "_method=post";
              data += "&tag[name]=" + encodeURIComponent(tag_name);
              if (csrf_param !== undefined && csrf_token !== undefined) {
                data += "&" + csrf_param + "=" + encodeURIComponent(csrf_token);
              }
              var options = {};
              options.type = "post";
              options.dataType = "text";
              options.data = data;
              options.url = "/tags";
              options.beforeSend = function(xhr){ xhr.setRequestHeader("Accept", "application/json"); }
              var ajaxRequest = jQuery.ajax(options);
              $("#tag-cloud").append($("<div class='tag'>" + tag_name + "</div>"));
              return true;
            }
          }
        });
      });
      $(".tag").live('click', function() {
        if ($(this).hasClass("clicked")) {
          $(this).removeClass("clicked");
        } else {
          $(this).addClass("clicked");
        }
      });
      $(".delete-tag > a").click(function() {
          var tag_to_destroy = $(this).attr("data_tag");
          if (confirm("¿Are you sure about deleting the tag? Bear in mind that it will be deleted in every fact.")) {
            var data = "_method=delete";
            data += "&tag[id]=" + encodeURIComponent(tag_to_destroy);
            if (csrf_param !== undefined && csrf_token !== undefined) {
              data += "&" + csrf_param + "=" + encodeURIComponent(csrf_token);
            }
            var options = {};
            options.type = "post";
            options.dataType = "text";
            options.data = data;
            options.url = "/tags/" + tag_to_destroy;
            options.beforeSend = function(xhr){ xhr.setRequestHeader("Accept", "application/json"); }
            var ajaxRequest = jQuery.ajax(options);
            $(this).parent().parent().fadeOut();
            return true;
        }
      });
      $("#post_button").click(function() {
        var tag_inputs = "";
        var i = 0;
        $(".clicked > .delete-tag > a").each(function() {
          tag_inputs += "<input id='fact_tag_ids_" + $(this).attr("data_tag");
          tag_inputs += "' name='fact[tag_ids][]' type='hidden' value='";
          tag_inputs += $(this).attr("data_tag");
          tag_inputs += "'>";
          i++;
        });
        if(i==0)
          tag_inputs = "<input name='fact[tag_ids][]' type='hidden' value=''>";
        $("#tag_inputs").html(tag_inputs);
        $("#fact_form").submit();
      });
    });
