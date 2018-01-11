class Fixnum
  def q
    0.step{|i|
      return i - 1 if self >> i == 0
    }
  end
end

def qmatrix(dir, maxzoom)
  0.upto(maxzoom) {|z|
    (2 ** z).times {|x|
      (2 ** z).times {|y|
        path = "#{dir}/#{z}/#{x}/#{y}.mvt"
	size = File.exist?(path) ? File.size(path) : 0
	print "#{path} #{size.q}\n"
      }
    }
  }
end

if ARGV.size != 2
  print <<-EOS
ruby qmatrix.rb {dir} {maxzoom}
  EOS
else
  qmatrix(ARGV[0], ARGV[1].to_i)
end
