module UI
    # Button that is shown in the main menu
    class ArkMenuButton < SpriteStack
    # Name of the background file
    BACKGROUND = 'ARK_UI/Start_menu/Menu_background'
    # Coordinate of the button on screen
    COORDINATES_ICON = 137, 16
    # Coordinate of the spritestack
    COORDINATES = 0, 0
    # Offset between each button
    OFFSET_COORDINATE = [0, 24]
    # Offset between selected position and unselected position
    SELECT_POSITION_OFFSET = [-6, 0]
    
    # @return [Boolean] selected
    attr_reader :selected

    # Create a new PSDKMenuButton
    # @param viewport [Viewport]
    # @param real_index [Integer] real index of the button in the menu
    # @param positional_index [Integer] index used to position the button on screen
    def initialize(viewport, real_index, positional_index)
      super(viewport, *coordinates(positional_index))
      @index = real_index
      @selected = false
      create_sprites
    end

    # Update the button animation
    def update
      @animation&.update
    end

    private

    # Compute the button x, y coordinate on the screen based on index
    # @param index [Integer]
    # @return [Array<Integer>]
    def coordinates(index)
      x = BASIC_COORDINATE.first + index * OFFSET_COORDINATE.first
      y = BASIC_COORDINATE.last + index * OFFSET_COORDINATE.last
      return x, y
    end

    def create_sprites
      create_background
      create_icon
      create_text
    end

    def create_background
      add_background(BACKGROUND).set_z(1)
    end

    def create_icon
      # @type [SpriteSheet]
      @icon = add_sprite(133, 16, 'Active_icons', 3, 1, type: SpriteSheet)
      @icon.select(0, icon_index)
      @icon.set_origin(@icon.width / 2, @icon.height / 2)
      @icon.set_position(@icon.x + @icon.ox, @icon.y + @icon.oy)
    end

    def icon_index
      @index
    end

    def create_text
      add_text(96, 0, 128, 16, text.sub(PFM::Text::TRNAME[0], $trainer.name), 2)
    end

    # Get the text based on the index
    # @return [Integer]
    def text
      case @index
      when 0 then return text_get(14, 1) # Dex
      when 1 then return text_get(14, 2) # BAG
      when 2 then return text_get(14, 0) # PARTY
      when 3 then return text_get(14, 5) # Options
      when 4 then return text_get(14, 4) # Save
      else
        return ext_text(9000, 26) # Quit
      end
    end
  end
end
