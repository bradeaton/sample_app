# Override Rails handling of confirmation

# BAE - This is some coffee script I got from: https://gist.github.com/1862479
#		I've modified it slightly to put the confirm: message in the title and allow the user to supply
#		a dialog_message attribute to be displayed in the body of the dialog.

$.rails.allowAction = (element) ->
  # The message is something like "Are you sure?"
  dialog_title = element.data('confirm')
  message = element.attr('dialog_message')
  # If there's no dialog_title, there's no data-confirm attribute, 
  # which means there's nothing to confirm
  return true unless dialog_title
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
    # We don't necessarily want the same styling as the original link/button.
    .removeAttr('class')
    # We don't want to pop up another confirmation (recursion)
    .removeAttr('data-confirm')
    # We want a button
    .addClass('btn').addClass('btn-danger')
    # We want it to sound confirmy
    .html("Yes, I'm positively certain.")

  # Create the modal box with the message
  modal_html = """
               <div class="modal" id="myModal">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <h3>#{dialog_title}</h3>
                 </div>
                 <div class="modal-body">
                   <p>#{message}</p>
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Cancel</a>
                 </div>
               </div>
               """
  $modal_html = $(modal_html)
  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  # Pop it up
  $modal_html.modal()
  # Prevent the original link from working
  return false