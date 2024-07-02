function volume --wraps='wpctl set-volume @DEFAULT_AUDIO_SINK@' --description 'alias volume wpctl set-volume @DEFAULT_AUDIO_SINK@'
  wpctl set-volume @DEFAULT_AUDIO_SINK@ $argv
        
end
