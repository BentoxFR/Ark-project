module GamePlay
    class Options

        MAX_BUTTON_SHOWN = 3

        private

        def create_viewport
            super
            rect = @viewport.rect
            x = rect.x + 160
            y = rect.y + 33
            @button_viewport = Viewport.create(x, y, 156, 118, 10_000)
        end
    end
end

module UI
    module Options
        class Description < SpriteStack

            def initialize(viewport)
                super(viewport, 0, 33)
                create_sprites
            end

        private

            def create_sprites
                add_background('options/Ark/description')
                @name = add_text(3, 4, 0, 13, :name, type: SymText, color: 10)
                @descr = add_text(3, 25, 151, 16, :description, type: SymMultilineText)
            end
        end
    end
end