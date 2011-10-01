class UserPreference

  DEFAULT_OPTIONS = {

    # default options for prefs
    :notify_when_sombody_touch_me => true,
    :publish_activity_on_add_item => false
  }

  DEFAULT_OPTIONS.keys.each { |key| attr_accessor key }

  def initialize(options={})
    DEFAULT_OPTIONS.each do |key, value| 
      instance_variable_set("@#{key}".to_sym, options[key] || value)
    end  
  end

end