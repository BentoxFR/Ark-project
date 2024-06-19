# Fixe les images -- XHTMLBoy (http://funkywork.blogspot.com) Adapté par Grim pour RMXP

    # Adapté à SDK par Eurons avec l'aide de Yuri, Leikt et yyyyj
    # Possibilité de mettre les image en dessous du joueur avec le suffixe "under_ev", merci à Metaiko pour cet ajout
    # Pour permettre à une image de rester fixée sur la carte, il faut que son nom commence par FIX- ou alors utiliser la fonction "fixed_pictures(id1, id2, id3 etc.)"
    # qui permet de fixer une (ou plusieurs) images sur la carte.
    # Par défaut, les images sont supprimée a chaque téléportation sauf si vous utilisez
    # la commande "add_stayed_pictures(id1, id2 etc.)" qui permet aux images de rester
    # malgré la téléportation. (il existe aussi remove_stayed_pictures qui annule l'effet stay des images)
 
    #==============================================================================
    # ** Game_Map
    #------------------------------------------------------------------------------
    #  This class handles maps. It includes scrolling and passage determination
    # functions. The instance of this class is referenced by $game_map.
    #==============================================================================
    
    class Game_Map
 
      #--------------------------------------------------------------------------
      # * Alias
      #--------------------------------------------------------------------------
      alias fix_setup setup
      alias fix_initialize initialize
      #--------------------------------------------------------------------------
      # * Public Instance Variables
      #--------------------------------------------------------------------------
      attr_accessor :fix_pictures
      attr_accessor :stay_pictures
 
 
      #--------------------------------------------------------------------------
      # * Object Initialization
      #--------------------------------------------------------------------------
      def initialize
        fix_initialize
        @stay_pictures = []
        @screen = $game_screen
      end
 
      #--------------------------------------------------------------------------
      # * Setup
      #--------------------------------------------------------------------------
      def setup(map_id)
        fix_setup(map_id)
		    @stay_pictures ||= []
        (10 ..7).each do |id|
          if $game_screen.pictures[id]
            $game_screen.pictures[id].erase unless stayed?(id)
          end
        end
        @fix_pictures = []
      end
 
      #--------------------------------------------------------------------------
      # * Set fixed pictures
      #--------------------------------------------------------------------------
      def set_fixed_pictures(ids)
        @fix_pictures = ids
      end
 
      #--------------------------------------------------------------------------
      # * add stay pictures
      #--------------------------------------------------------------------------
      def add_stay_pictures(ids)
        @stay_pictures += ids
        @stay_pictures.uniq!
      end
 
      #--------------------------------------------------------------------------
      # * remove stay pictures
      #--------------------------------------------------------------------------
      def remove_stay_pictures(ids)
        ids.each do |id|
          @stay_pictures.delete(id)
        end
      end
 
      #--------------------------------------------------------------------------
      # * 's fixed
      #--------------------------------------------------------------------------
      def fixed?(id)
        @fix_pictures.include?(id)
      end
 
      #--------------------------------------------------------------------------
      # * 's stayed
      #--------------------------------------------------------------------------
      def stayed?(id)
        @stay_pictures.include?(id)
      end
 
    end
 
    #==============================================================================
    # ** Sprite_Picture
    #------------------------------------------------------------------------------
    # This sprite is used to display pictures. It observes an instance of the
    # Game_Picture class and automatically changes sprite states.
    #==============================================================================
 
    class Sprite_Picture
 
      #--------------------------------------------------------------------------
      # * alias
      #--------------------------------------------------------------------------
      alias fix_initialize initialize
      alias fix_update_position update
 
      #--------------------------------------------------------------------------
      # * Public Instance Variables
      #--------------------------------------------------------------------------
      attr_accessor :anchor
 
      #--------------------------------------------------------------------------
      # * Object Initialization
      #    picture : Game_Picture
      #--------------------------------------------------------------------------
      def initialize(viewport, picture)
        fix_initialize(viewport, picture)
        @anchor = (@picture.name =~ /^fix/i) != nil
      end
 
      #--------------------------------------------------------------------------
      # * Update Position
      #--------------------------------------------------------------------------
      def update
        fix_update_position
      @anchor = (@picture.name =~ /^fix/i) != nil || $game_map.fixed?(@picture.number)
        if @anchor
          new_x =  @picture.x - ($game_map.display_x / 8)
          new_y =  @picture.y - ($game_map.display_y / 8)
          self.x, self.y = new_x, new_y
        else
          self.x = @picture.x
          self.y = @picture.y
          self.z = @picture.number
        end
      end
 
    end
 
    #==============================================================================
    # ** Game_Interpreter
    #------------------------------------------------------------------------------
    #  An interpreter for executing event commands. This class is used within the
    # Game_Map, Game_Troop, and Game_Event classes.
    #==============================================================================
 
    class Interpreter
 
      #--------------------------------------------------------------------------
      # * define fixed pictures
      #--------------------------------------------------------------------------
      def fixed_pictures(*ids)
        $game_map.set_fixed_pictures(ids)
      end
 
      #--------------------------------------------------------------------------
      # * define stayed pictures
      #--------------------------------------------------------------------------
      def add_stayed_pictures(*ids)
        $game_map.add_stay_pictures(ids)
      end
 
      #--------------------------------------------------------------------------
      # * remove stayed pictures
      #--------------------------------------------------------------------------
      def remove_stayed_pictures(*ids)
        $game_map.remove_stay_pictures(ids)
      end
 
    end


    
    class Spriteset_Map

      def refresh_picture_viewport(id)
        img = $game_screen.pictures[id]
        @picture_sprites[id - 1]&.dispose
        @picture_sprites[id - 1] = Sprite_Picture.new(img&.name =~ /under_ev$/i ? @viewport1 : @viewport2, img)
      end

    end

    class Game_Picture
      alias fix_show show
      def show(name, origin, x, y, zoom_x, zoom_y, opacity, blend_type)
        previous_under_ev = $game_screen.pictures[@number].name =~ /under_ev$/i
        actual_under_ev = name =~ /under_ev$/i
        change_vp = previous_under_ev.class != actual_under_ev.class
        fix_show(name, origin, x, y, zoom_x, zoom_y, opacity, blend_type)
        $scene.spriteset.refresh_picture_viewport(@number) if $scene.is_a?(Scene_Map) && change_vp
      end
    end