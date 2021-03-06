# frozen_string_literal: true

# An achievement that is awarded to regional point winners
class BornLeader < Achievement
  def title
    I18n.t('achievement.born_leader.title')
  end

  def description
    I18n.t('achievement.born_leader.description')
  end

  def self.type
    :multi
  end
end
