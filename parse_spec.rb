=begin
0 @I1@ INDI
1 NAME Jamis Gordon /Buck/
2 SURN Buck
2 GIVN Jamis Gordon
1 SEX M
<gedcom>
<indi id="@I1@">
<name>
    Jamis Gordon /Buck/
    <surn>Buck</surn> <givn>Jamis Gordon</givn>
</name> <sex>M</sex> ...
</indi>
... </gedcom>
=end

require 'rspec'
require_relative 'parse'

RSpec.describe Parse do
  let(:str){"<gedcom><indi id=11></indi></gedcom>"}
  let(:str2){"<gedcom><indi id=11><name>Jamis Gordon /Buck/</name></indi></gedcom>"}
  let(:str3){"<gedcom><indi id=11><name>Jamis Gordon /Buck/<surn>Buck</surn></name></indi></gedcom>"}
  let(:str4){"<gedcom><indi id=11><name>Jamis Gordon /Buck/<surn>Buck</surn><givn>Jamis Gordon</givn></name><sex>M</sex></indi></gedcom>"}
  it "create tag with id" do
     expect(Parse.parse("0 @11@ INDI")).to eq str
  end

  it "create name tag" do
     expect(Parse.parse("0 @11@ INDI\n1 NAME Jamis Gordon /Buck/")).to eq str2
  end

  it "creates surn tag" do
    expect(Parse.parse("0 @11@ INDI\n1 NAME Jamis Gordon /Buck/\n2 SURN Buck")).to eq str3
  end

  it "parses everything" do
    expect(Parse.parse("0 @11@ INDI\n1 NAME Jamis Gordon /Buck/\n2 SURN Buck\n2 GIVN Jamis Gordon\n1 SEX M")).to eq str4
  end

end
puts Parse.parse("0 @11@ INDI\n1 NAME Jamis Gordon /Buck/\n2 SURN Buck")