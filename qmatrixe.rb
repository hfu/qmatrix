require 'find'
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
  print ([" q\\z"] + (0..(r[0].size - 1)).map{|v| sprintf("%4d", v)}).join(' '), "\n"
  QMAX.times {|q|
    print ([q - 1] + r[q].map{|v| v.q}).map{|v| sprintf("%4d", v)}.join(' '), "\n"
  }
  $stdout.flush
end

def qmatrix(dir, maxzoom)
  r = Array.new(QMAX).map{Array.new(maxzoom + 1, 0)} # r[q + 1][z]
  c = 0
  Find.find(dir) {|path|
    next unless /(\d*)\/(\d*)\/(\d*)\.mvt$/.match path
    c += 1
    z = $1.to_i
    x = $2.to_i
    y = $3.to_i
    size = File.size(path)
    r[size.q + 1][z] += 1
    show(r, c) if c % 100000 == 0
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
