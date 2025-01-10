module Complement

  COMPLEMENTS = { 'G' => 'C', 'C' => 'G', 'T' => 'A', 'A' => 'U' }

  def self.of_dna(sequence)
    sequence.chars.map { |nucleotide| COMPLEMENTS[nucleotide] }.join
  end

end
