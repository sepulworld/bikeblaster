require 'ruboto/widget'
require 'ruboto/util/toast'

java_import 'android.media.MediaPlayer'
java_import 'android.media.AudioManager'
java_import 'android.net.Uri'
ruboto_import_widgets :Button, :LinearLayout, :TextView

class BikeblasterActivity
  def onCreate(bundle)
    super
    
    java_file = java.io.File.new('/mnt/sdcard/jruby/media/MissleLaunch.mp3')
    uri = Uri.fromFile(java_file)
    @player = MediaPlayer.create(self, uri)

    @listener = proc { AudioFocus.new
    context = getApplicationContext
    audio_manager = context.getSystemService(Context::AUDIO_SERVICE)

    audio_manager.requestAudioFocus(@listener, AudioManger::STREAM_MUSIC, AudioManager::AUDIOFOCUS_GAIN)
    @player.start }

  rescue Exception => e
    puts "#{ e } (#{ e.class } #{e.message} #{e.backtrace.inspect} )!"
      end
  
  def on_touch_event(event)
    @player.stop
    true
  end
    
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

class AudioFocus
  def onAudioFocusChange focusChange
    puts "On focus change #{focusChange}"
    nil
  end

  def toString
    self.class.to_s
  end
end
