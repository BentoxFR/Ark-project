module UI

    class GenericBase < SpriteStack

        private

        def create_button_background
            @button_background = add_sprite(0, 154, button_background_filename).set_z(500)
        end

        class ControlButton < SpriteStack
            # Array of button coordinates
            COORDINATES = [[3, 159], [83, 159], [163, 159], [243, 159]]
        end
    end
end

      