require 'ruboto/widget'
require 'ruboto/util/toast'

ruboto_import_widgets :Button, :LinearLayout, :TextView

class BikeblasterActivity
  def onCreate(bundle)
    super
    set_title 'Bike Blaster!'

    self.content_view =
        linear_layout :orientation => :vertical do
          @text_view = text_view :text => 'Missle Ready', :id => 42, :width => :match_parent,
                                 :gravity => :center, :text_size => 48.0
          button :text => 'Bike Blaster Fire', :width => :match_parent, :id => 43, :on_click_listener => proc { fire }
          button :text => 'Bike Blaster Reload', :width => :match_parent, :id => 44, :on_click_listener => proc { reload }
	end
  rescue Exception
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private

  def fire
    @text_view.text = 'BOOM!'
    toast 'Missle launched'
  end

  def reload
    @text_view.text = 'Missle Reloaded'
    toast 'Reloading...'
  end
    
end
