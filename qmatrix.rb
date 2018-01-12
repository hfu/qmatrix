QMAX = 26

class Fixnum
  def q
    0.step{|i|
      return i - 1 if self >> i == 0
    }
  end
end

def show(r, c)
  print "** count #{c} ***\n"
  QMAX.times {|q|
    print ([q] + r[q]).map{|v| sprintf("%4d", v)}.join(' '), "\n"
  }
end

def qmatrix(dir, maxzoom)
  r = Array.new(QMAX).map{Array.new(maxzoom, 0)} # r[q][z]
  c = 0
  0.upto(maxzoom) {|z|
    (2 ** z).times {|x|
      (2 ** z).times {|y|
	c += 1
        path = "#{dir}/#{z}/#{x}/#{y}.mvt"
	size = File.exist?(path) ? File.size(path) : 0
	r[size.q][z] += 1
	show(r, c) if c % 1000 == 0
      }
    }
  }
  show(r, c)
end

if ARGV.size != 2
  print <<-EOS
ruby qmatrix.rb {dir} {maxzoom}
  EOS
else
  qmatrix(ARGV[0], ARGV[1].to_i)
end
