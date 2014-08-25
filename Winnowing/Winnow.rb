require 'winnow'

DEFAULT_G = 15
DEFAULT_N = 9
DEFAULT_arch1 = "examples/alumno1/ejercicio.c"
DEFAULT_arch2 = "examples/alumno2/ejercicio.c"
USAGE = "Usage : Winnow [file 1] [file 2] [opt guarantee] [opt noise]" 
def main
	return USAGE if ARGV.nil? 
	filename1 = ARGV[0].nil? ? DEFAULT_arch1 : ARGV[0]
	filename2 = ARGV[1].nil? ? DEFAULT_arch2 : ARGV[1]
	doc1 = File.new(filename1)
	doc2 = File.new(filename2)
	guarantee =  ARGV[2].nil? ? DEFAULT_G : ARGV[2].to_i
	noise = ARGV[3].nil? ? DEFAULT_N : ARGV[3].to_i
	wn = Winnow::Fingerprinter.new(guarantee_threshold: guarantee, noise_threshold: noise, preprocessor: Winnow::Preprocessors::SourceCode.new('c'))
	performMatch(wn,{ source: filename1, content: doc1 },{source: filename2, content: doc2})
end

def performMatch(wn,doc1,doc2)
	str1 = doc1[:content].read
	str2 = doc2[:content].read
	fp1 = wn.fingerprints(str1, source: doc1[:source])
	fp2 = wn.fingerprints(str2, source: doc2[:source])
	matches = Winnow::Matcher.find_matches(fp1,fp2)
	matches.each do |match|
		mA = match.matches_from_a.first
		mB = match.matches_from_b.first
		contextA = str1[mA.index - 20 .. mA.index + 20]
		contextB = str2[mB.index - 20 .. mB.index + 20]
		puts " > Match en #{mA.source} : #{contextA.inspect}"
		puts " > Match en #{mB.source} : #{contextB.inspect}"
		print "\n"
	end
	puts "Cantidad de coincidencias: #{matches.size}"
end

main