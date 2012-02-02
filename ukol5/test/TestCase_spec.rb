require "rspec"
require_relative "../lib/TestCase"

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

  def define_stdin(vstup)
    input = StringIO.new
    input.string = vstup
    $stdin = input
    yield
  ensure
    $stdin = STDIN
  end

end

describe TestCase do

  it "by mel najit spravne reseni pro testovaci zadani" do
    vstup = "1\n-1 0\n0 1\n0 0\n"
    define_stdin(vstup) do
      sada = TestCase.new(0)
      sada.loadVstup
      out = capture_stdout do
        sada.findSolution
      end
      out.string.should == "1\n0 1\n\n"
    end

  end

  it "by mel najit spravne reseni pro 2. testovaci zadani" do
    vstup = "10\n-2 5\n-1 6\n-1 3\n0 4\n1 5\n2 6\n3 7\n7 8\n8 10\n8 9\n0 0\n"
    define_stdin(vstup) do
      sada = TestCase.new(0)
      sada.loadVstup
      out = capture_stdout do
        sada.findSolution
      end
      out.string.should == "4\n-2 5\n3 7\n7 8\n8 10\n\n"
    end

  end

  it "by mel zjistit, ze reseni neexistuje" do
    vstup = "1\n-1 0\n-5 -3\n2 5\n0 0\n"
    define_stdin(vstup) do
      sada = TestCase.new(0)
      sada.loadVstup
      out = capture_stdout do
        sada.findSolution
      end
      out.string.should == "0\n\n"
    end
  end
end