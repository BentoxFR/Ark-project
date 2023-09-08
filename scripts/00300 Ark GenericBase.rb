module UI

    class GenericBase < SpriteStack
=begin
        attr_reader :keys
        attr_reader :button_texts
        attr_reader :ctrl
        attr_reader :background

        def initialize(viewport, texts = [], keys = DEFAULT_KEYS, hide_background_and_button: false)
            super(viewport)
            @keys = keys
            create_graphics
            self.button_texts = texts
            if hide_background_and_button
              @button_background.visible = false
              @ctrl.each {|button| button.visible = false}
            end
        end
=end
        private
=begin
        def create_graphics
            create_background
            create_button_background
            create_control_button
        end
=end
        def create_button_background
            @button_background = add_sprite(0, 154, button_background_filename).set_z(500)
        end

        class ControlButton < SpriteStack
            # Array of button coordinates
            COORDINATES = [[3, 159], [83, 159], [163, 159], [243, 159]]
        end
    end
end

      