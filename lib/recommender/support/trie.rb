# this class will be used to implement a trie
# a trie is a tree-like structure useful for efficient searching of large bodies of text.
# searching is accomplished in O(n) time for a given string, where n is the length of the string.
# this is accomplished at a tradeoff, construction of a trie takes more time.
# i think a trie will be better to use than Ruby's #include? method (Rabin-Karp) since there will be repeated queries.
# the trie will be constructed out of the readme's and the searches will be the keywords
class Recommender::Support::Trie
  attr_accessor :corpus, :trie_nodes

  CHARACTERS = 256

  # defaults
  ## matches characters that aren't 0-9a-ZA-Z or space
  REGEX = /[^[[:alnum:]] ]/

  # split on spaces
  SPLITTER = " "

  def initialize(readme_text)
    @corpus = readme_text
    @trie_nodes = Array.new(CHARACTERS)
  end

  def construct
    leave_alphanumeric_characters
    split_corpus.each { |word| add(word) }
  end

  def add(word)
    node = nil
    nodes = @trie_nodes
    word.each_char do |char|
      char_num = char.ord
      if nodes[char_num].nil?
        nodes[char_num] = Recommender::Support::TrieNode.new(char, CHARACTERS)
      end

      node = nodes[char_num]
      nodes = node.nodes
    end
  end

  def find(word)
    node = nil
    nodes = @trie_nodes
    word.each_char do |char|
      char_num = char.ord
      node = nodes[char_num]

      break if node.nil?
      nodes = node.nodes
    end

    !node.nil?
  end

  private
  def leave_alphanumeric_characters
    @corpus.gsub!(REGEX, "").upcase!
  end

  def split_corpus
    @corpus.split(SPLITTER)
  end
end
