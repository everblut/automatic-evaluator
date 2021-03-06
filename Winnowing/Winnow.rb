require 'winnow'

class Winnow
	def initialize(guarantee,noise)
	    @guarantee = guarantee || 15
	    @noise = noise || 9
	    @fingerprinter = Winnow::Fingerprinter.new(guarantee_threshold: guarantee
						           noise_threshold: noise)
	end
	def matcher_for(fingerprints)
	    @matches = Winnow::Matcher.find_matches(fingerprints[0],
						    fingerprints[1])	
	end
	
	def perform_matches(files)
	    @matches.each do |match|
		context_a = context_for(files[0],
					match.matches_from_a.first,
					15)
		context_b = context_for(files[1],
					match.matches_from_b.first,
					15)
	    end	
	    return context_a,context_b
	end
	def context_for(files,match,size)
	    first = match.index - size
	    last = match.index + size
	    return file[first .. last]
	end

