require 'ruboto/widget'
require 'ruboto/util/toast'

java_import 'android.media.MediaPlayer'
java_import 'android.media.AudioManager'
java_import 'android.net.Uri'
ruboto_import_widgets :Button, :LinearLayout, :TextView

class BikeblasterActivity
  def onCreate(bundle)
    super
    
    
    set_title 'Bike Blaster!'

    self.content_view =
        linear_layout :orientation => :vertical do
          @text_view = text_view :text => 'Bike Laser', :id => 42, :width => :match_parent,
                                 :gravity => :center, :text_color => Java::android.graphics.Color::RED, :text_size => 48.0
          button :text => 'Bike Blaster Light Laser', :width => :match_parent, :id => 43, :on_click_listener => proc { fire_light_laser }
          button :text => 'Bike Blaster Heavy Laser', :width => :match_parent, :id => 43, :on_click_listener => proc { fire_heavy_laser }
          button :text => 'Bike Blaster Recharge', :width => :match_parent, :id => 44, :on_click_listener => proc { recharge }
	end
 
  rescue Exception
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private

  def fire_light_laser
    light_laser = $package.R::raw::lasershot2
    laser  = $package.R::raw::megalazer
    @player = MediaPlayer.create(self, light_laser)
    @player.start

    @text_view.text = 'Light Laser!'
    toast 'Firing light laser'
    rescue Exception => e
      puts "#{ e } (#{ e.class } #{e.message} #{e.backtrace.inspect} )!"
  end
  
  def fire_heavy_laser
    heavy_laser  = $package.R::raw::heavylaser2
    @player = MediaPlayer.create(self, heavy_laser)
    @player.start

    @text_view.text = 'Heavy Laser!'
    toast 'Firing heavy laser'
    rescue Exception => e
      puts "#{ e } (#{ e.class } #{e.message} #{e.backtrace.inspect} )!"
  end

  def recharge
    recharge = $package.R::raw::electronics011
    @player = MediaPlayer.create(self, recharge)
    @player.start

    @text_view.text = 'Recharged'
    toast 'Recharging...'
    rescue Exception => e
      puts "#{ e } (#{ e.class } #{e.message} #{e.backtrace.inspect} )!"
  end
    
end
