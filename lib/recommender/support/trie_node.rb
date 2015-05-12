# a trie node represents the presence of a character
class Recommender::Support::TrieNode
  attr_reader :character
  attr_accessor :nodes

  def initialize(character, number)
    @character = character
    @nodes = Array.new(number)
  end
end
