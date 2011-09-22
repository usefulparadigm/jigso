module ButtonHelper

  # from Rails 3.1 codebase (actionpack/lib/action_view/helpers/form_tag_helper.rb)
  # do not use this method on Rails 3.1 and above
  #
  def button_tag(content_or_options = nil, options = nil, &block)
    options = content_or_options if block_given? && content_or_options.is_a?(Hash)
    options ||= {}
    options.stringify_keys!

    if disable_with = options.delete("disable_with")
      options["data-disable-with"] = disable_with
    end

    if confirm = options.delete("confirm")
      options["data-confirm"] = confirm
    end

    options.reverse_merge! 'name' => 'button', 'type' => 'submit'

    content_tag :button, content_or_options || 'Button', options, &block
  end

  # // button link
  # // <button class="link" data-href="url">Click</button>
  # $('button.link').live('click', function() { window.location.href = $(this).data('href'); });
  #
  def button_link_to(title, href, options = nil)
    options ||= {}
    options.stringify_keys!
    button_tag title, :class => "link #{options['class']}", :type => 'button', :'data-href' => href
  end

end  