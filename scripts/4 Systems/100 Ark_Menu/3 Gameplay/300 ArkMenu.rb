module GamePlay
  class MonMenu < BaseCleanUpdate::FrameBalanced
    def initialize
      super
      @index = 0  # Pour les icônes dynamiques
      @max_index = 3  # Nombre d'icônes fixes/dynamiques
    end
    
    def create_graphics
      # Sera appelé automatiquement
    end
    
    def update_inputs
      # Gestion flèches gauche/droite
    end
    
    def update_graphics
      # Animations
    end
  end
end