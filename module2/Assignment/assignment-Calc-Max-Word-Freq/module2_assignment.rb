class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    self.content = content
    self.line_number = line_number
    self.calculate_word_frequency
  end

  def highest_wf_count= (new_highest_wf_count)
    @highest_wf_count = new_highest_wf_count
  end

  def highest_wf_words= (new_highest_wf_words)
    @highest_wf_words = new_highest_wf_words
  end

  def content= (new_content)
    @content = new_content
  end

  def line_number= (new_line_number)
    @line_number = new_line_number
  end
  
  def calculate_word_frequency()
    word_frequecy = Hash.new(0)
    content.split.each do |word|
      word_frequecy[word.downcase] += 1
    end
    @highest_wf_count = word_frequecy.max_by{|k,v| v}[1]
    @highest_wf_words = word_frequecy.select {|k,v| v === @highest_wf_count}.keys

  end  
end

class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    self.analyzers = Array.new
  end

  def analyzers= (new_analyzers)
    @analyzers = new_analyzers
  end

  def highest_count_across_lines= (new_highest_count_across_lines)
    @highest_count_across_lines = new_highest_count_across_lines
  end

  def highest_count_words_across_lines= (new_highest_count_words_across_lines)
    @highest_count_words_across_lines = new_highest_count_words_across_lines
  end

  def analyze_file()
    @analyzers = Array.new 
    if File.exist? 'test.txt'
      File.foreach( 'test.txt' ).with_index do |line, line_num|
        @analyzers.push(LineAnalyzer.new(line.chomp, line_num+1))
      end
    end
  end

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 
      analyzers
        .sort_by{ |e| e.highest_wf_count }
        .reverse
        .first
        .highest_wf_count
    @highest_count_words_across_lines = 
      analyzers
        .select{ |a| a.highest_wf_count === highest_count_across_lines}
  end

  def print_highest_word_frequency_across_lines()
    print "The following words have the highest word frequency per line:" 

    highest_count_words_across_lines.each do |analyzer| 
      print "\n#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})" 
    end

    #print highest_count_across_lines
    #print highest_count_words_across_lines
  end


 end
