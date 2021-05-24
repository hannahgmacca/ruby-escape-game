require_relative 'app/start_menu'

def media_path(file)
  File.join(File.dirname(File.dirname(
 _FILE__)), 'media', file)
end

class GameWindow < Gosu::GameWindow
    def initialize(width=320, height=240, fullscreen=false)
        super
        self.caption = 'AirBnB Escape'
        @music = Gosu::Song.new(
        self, media_path('app/music.mp3'))
        @music.volume = 0.5
        @music.play(true)
        @start = StartMenu.new
        @start.menu
    end
end

window = GameWindow.new