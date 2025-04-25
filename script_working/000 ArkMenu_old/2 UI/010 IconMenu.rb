module UI
  class IconMenuARK < SpriteStack
    # Coordinate of the button on screen
    COORDINATES_ICON = 137, 16

    # @return [Boolean] selected
    attr_reader :selected

    # Create a new ARKMenuButton
    # @param viewport [Viewport]
    # @param real_index [Integer] real index of the button in the menu
    # @param positional_index [Integer] index used to position the button on screen
    def initialize (viewport, real_index, positionnal_index)
      super(viewport, *coordinates(positional_index))
      @index = real_index
      @selected = false
      create_graphic
    end

    # Set the selected state
    # @param value [Boolean]
    def selected=(value)
      return if value == @selected

      if value
        @icon.select(1, icon_index)
      else
        @icon.select(0, icon_index)
      end
      @selected = value
    end

    private

    def create_graphic
      create_icon
      create_text
    end

    def create_icon
      # @type [SpriteSheet]
      @icon = add_sprite()
      @icon.select(0, icon_index)
    end

    # Get the icon index
    # @return [Integer]
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