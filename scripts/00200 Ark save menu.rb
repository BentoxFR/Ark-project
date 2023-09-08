module UI
    
    class SaveSign < SpriteStack

    attr_accessor :save_index
    attr_accessor :visual_index

    SAVE_INDEX_MESSAGE = '#%d'

    private

    def show_new_game
        @swap_sprites.each { |sp| sp.visible = false }
        @background.load('load/box_new', :interface)
        @cursor.load('load/cursor_corrupted_new', :interface)
        @new_corrupted_text.text = ext_text(9000, 0)
      end
  
      def show_corrupted
        @swap_sprites.each { |sp| sp.visible = false }
        @background.load('load/box_corrupted', :interface)
        @cursor.load('load/cursor_corrupted_new', :interface)
        @new_corrupted_text.text = corrupted_message
      end
  
      def show_data(value)
        @swap_sprites.each { |sp| sp.visible = true }
        @background.load('load/Ark/box_main', :interface)
        @cursor.load('load/Ark/cursor_main', :interface)
        @save_text.text = format(save_index_message, @save_index)
        @new_corrupted_text.visible = false
        show_save_data(value)
      end

      def show_save_data(value)
        @player_sprite.load(value.game_player.character_name, :character)
        @player_sprite.set_origin(@player_sprite.width / 2, @player_sprite.height)
        $game_actors = value.game_actors
        $game_variables = value.game_variables
        @location_text.text = PFM::Text.parse_string_for_messages(value.env.current_zone_name)
        @player_name.text = value.trainer.name
        @badge_value&.text = value.trainer.badge_counter.to_s
        @pokedex_value&.text = value.pokedex.creature_seen.to_s
        @time_value&.text = value.trainer.play_time_text
        @pokemon_sprites.each_with_index do |sprite, index|
          sprite.data = value.actors[index]
        end
      ensure
        $game_actors = PFM.game_state&.game_actors
        $game_variables = PFM.game_state&.game_variables
      end
  
      def create_sprites
        @swap_sprites = []
        create_background
        create_cursor
        create_player_sprite
        create_player_name
        create_save_text
        create_save_info_text
        create_pokemon_sprites
      end
  
      def create_background
        @background = add_sprite(0, 0, NO_INITIAL_IMAGE)
      end
  
      def create_cursor
        @cursor = add_sprite(-4, -4, NO_INITIAL_IMAGE, 1, 2, type: SpriteSheet)
      end
  
      def create_player_sprite
        @player_sprite = add_sprite(44, 62-16, NO_INITIAL_IMAGE, 4, 4, type: SpriteSheet)
        @swap_sprites << @player_sprite
      end
  
      def create_player_name
        @player_name = add_text(45, 63-16, 0, 16, '', 1, color: player_name_color)
        @swap_sprites << @player_name
      end
  
      def create_save_text
        @save_text = add_text(-102, 3, 226, 16, '', 1, color: 26)
        @new_corrupted_text = add_text(0, 4, 226, 16, '', 1, color: 10)
        @swap_sprites << @save_text
      end
  
      def create_save_info_text
        @location_text = add_text(91, 19-16, 0, 16, '', color: location_color)
        @swap_sprites << @location_text
        @badge_text = add_text(91, 35-16, 0, 16, text_get(25, 1), color: info_color)
        @swap_sprites << @badge_text
        @badge_value = add_text(216, 35-16, 0, 16, '', 2, color: info_color)
        @swap_sprites << @badge_value
        @pokedex_text = add_text(91, 51-16, 0, 16, text_get(25, 3), color: info_color)
        @swap_sprites << @pokedex_text
        @pokedex_value = add_text(216, 51-16, 0, 16, '', 2, color: info_color)
        @swap_sprites << @pokedex_value
        @time_text = add_text(91, 67-16, 0, 16, text_get(25, 5), color: info_color)
        @swap_sprites << @time_text
        @time_value = add_text(216, 67-16, 0, 16, '', 2, color: info_color)
        @swap_sprites << @time_value
      end
  
      def create_pokemon_sprites
        @pokemon_sprites = Array.new(6) { |i| add_sprite(24 + i * 35, 99, NO_INITIAL_IMAGE, type: PokemonIconSprite) }
        @swap_sprites.concat(@pokemon_sprites)
      end
  
      def player_name_color
        9
      end
  
      def location_color
        0
      end
  
      def info_color
        26
      end
  
      def corrupted_message
        CORRUPTED_MESSAGE
      end
  
      def save_index_message
        SAVE_INDEX_MESSAGE
      end
  
      def base_x
        47
      end
  
      def base_y
        36
      end
  
      def spacing_x
        240
      end
  
      def spacing_y
        0
      end
    end
  end
  