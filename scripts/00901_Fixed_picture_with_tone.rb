class Game_Screen
  FIX_PICTURE_ID = 48
  # start a tone change process
  # @param tone [Tone] the new tone
  # @param duration [Integer] the time it takes in frame
  def start_tone_change(tone, duration)
    @tone_target = tone.clone
    @tone_duration = duration
    if @tone_duration == 0
      @tone = @tone_target.clone
    end
    tone_rgb = [tone.red, tone.green, tone.blue]
    fp_img = $game_screen.pictures[FIX_PICTURE_ID]
    if tone_rgb == [-255, -255, -255]
      fp_img.move(duration, fp_img.origin, fp_img.x, fp_img.y, fp_img.zoom_x, fp_img.zoom_y, 0, fp_img.blend_type) 
    elsif fp_img.opacity != 255
      fp_img.move(duration, fp_img.origin, fp_img.x, fp_img.y, fp_img.zoom_x, fp_img.zoom_y, 255, fp_img.blend_type)
    end
  end
end