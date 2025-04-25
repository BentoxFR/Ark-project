module UI
      # UI element showing the name of selected menu
    class NameMenuARK < SpriteStack
      # Name of the background file
      BACKGROUND = 'ARK_UI/Start_menu/Menu_background'
      # Coordinate of the spritestack
      COORDINATES = 0, 0
      
      # Create a new WinPocket
      # @param viewport [Viewport]
      def initialize(viewport)
        super(viewport, *COORDINATES)
        init_sprite
      end
  
      # Set the text to show
      # @param text [String] the text to show
      def text=(text)
        @text.text = text
      end
  
      private
  
      def init_sprite
        create_background
        @text = create_text
      end
  
      # Create the background sprite
      def create_background
        add_background(BACKGROUND).set_z(1)
      end
  
      # Create the text
      # @return [Text]
      def create_text
        text = add_text(88, 1, 144, 15, nil.to_s, 1, color: 10)
        text.z = 2
        return text
      end
    end
  end
  