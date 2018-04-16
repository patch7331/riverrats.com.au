class UpdatePlayerJob < ApplicationJob
  queue_as :default

  ###
  # Updates the given +player+ with the given stats.
  # @param [Player] player to update.
  # @param [Hash] changes A hash of all changes to this player.
  def perform (player, changes)
    player.score += changes[:score]
    player.games_played += changes[:plays]
    player.games_won += changes[:wins]
    player.save
  end

end