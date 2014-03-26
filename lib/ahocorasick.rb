
require 'ahocorasick/native'

module AhoCorasick
  
    class KeywordTree

        #
        # Loads the contents of file into the KeywordTree
        #
        #     k= AhoCorasick::KeywordTree.new
        #     k.from_file "dictionary.txt"
        #
        #
        def from_file file
            File.read(file).each { | string | self.add_string string }
            self
        end
    
        #
        # Only return the longest match at each position, e.g.
        # keywords 'database' and 'data' both matches 'database'
        # on position 3 in the text 'my database', but only the longest
        # match 'database' is returned.
        # 
        #     k= AhoCorasick::KeywordTree.new
        #     k.add_string 'database'
        #     k.add_string 'data'
        #     k.find_longest
        #
        def find_longest string
            find_all(string).group_by { |match| 
                match[:starts_at] 
            }.values.map{ |group| 
                group.max_by{ |match| 
                    match[:ends_at] 
                }
            }
        end
        
        alias_method :search_longest, :find_longest

        #
        # Only return the longest match at each position, e.g.
        # keywords 'database' and 'data' both matches 'database'
        # on position 3 in the text 'my database', but only the shortest 
        # match 'data' is returned.
        # 
        #     k= AhoCorasick::KeywordTree.new
        #     k.add_string 'database'
        #     k.add_string 'data'
        #     k.find_shortest
        #
        def find_shortest string
            find_all(string).group_by { |match| 
                match[:starts_at] 
            }.values.map{ |group| 
                group.min_by{ |match| 
                    match[:ends_at] 
                }
            }
        end
        
        alias_method :search_shortest, :find_shortest
        
        #
        # Creates a new KeywordTree and loads the dictionary from a file
        # 
        #    % cat dict0.txt
        #    foo
        #    bar
        #    base
        #     
        #    k= AhoCorasick::KeywordTree.from_file "dict0.txt"
        #    k.find_all("basement").size # => 1
        #
        def self.from_file filename
            self._from_file filename
        end
    end
end

