require "rspec"
require "tempfile"
require_relative "../lib/Decipher"

require 'stringio'

module Kernel

  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end

end



describe "decipher" do

  it "by mel vratit tentyz text pri nulovem posunu" do
    out = capture_stdout do
      file = Tempfile.new("sifra")
      file.write "abcd\ndef aa\n"
      file.close

      decipher(0, file.path)
      file.unlink
    end
    out.string.should == "abcd\ndef aa\n"

  end

  it "by mel vratit tentyz text pri posunu 94" do
    out = capture_stdout do
      file = Tempfile.new("sifra")
      file.write "abcd\ndef aa\n"
      file.close

      decipher(94, file.path)
      file.unlink
    end
    out.string.should == "abcd\ndef aa\n"

  end

  it "by mel umet posunout text vpred" do
    out = capture_stdout do
      file = Tempfile.new("sifra")
      file.write "abcd\ndef aa\n"
      file.close

      decipher(1, file.path)
      file.unlink
    end
    out.string.should == "bcde\nefg!bb\n"

  end

  it "by mel umet posunout text vzad" do
    out = capture_stdout do
      file = Tempfile.new("sifra")
      file.write "abcd\ndef aa\n"
      file.close

      decipher(-1, file.path)
      file.unlink
    end
    out.string.should == "`abc\ncde}``\n"

  end


end
