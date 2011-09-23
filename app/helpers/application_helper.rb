module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  
  # Outputs all flash messages as an unordered list
  # Returns the HTML as a string or true if flash is empty
  # credit: https://github.com/brightbox/flashing-rails/blob/master/lib/flashing_rails.rb
  def flash_messages( opts = {} )
    return "" if flash.empty?
    
    css_id = opts[:id] || "flash"
    css_class = opts[:class] || nil

    generate_flash_list = lambda do |key, message|
      if message.is_a?(Array)
        message.map {|msg| generate_flash_list[key, msg] }.join("\n")
      else
        "\t" + content_tag("li", message, :class => key)
      end
    end

    msgs = flash.map do |key, message|
      generate_flash_list[key, message]
    end.unshift("") << "" # Force a newline before/after items

    content_tag("ul", msgs.join("\n"), :id => css_id)
  end

  # http://codefastdieyoung.com/2011/03/css-js-organization-best-practice/
  def body_classes
    [controller.controller_name].join
  end

  # using https://github.com/kpumuk/meta-tags
  def page_title(title)
    title(@page_title = title)
  end

  # def page_title(title)
  #   content_tag :h2, title(title), :class => 'title'
  # end

  def first_image(html)
    html =~ /\<img.*?src="(.*?)"/ ? $1 : "/images/no_image_thumb.png"
  end

  def render_timeline(events)
    events.map do |event|
      render("timeline_events/new_entry", :event => event)
    end.join
  end
  

end
