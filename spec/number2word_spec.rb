require 'spec_helper'
require 'number2word'
require File.expand_path("fixtures/sample_numbers.rb",File.dirname(__FILE__))

describe "Number2Word" do
  include Number2Word
  subject{ convert(number) }
  context "unexpected paramters passed" do
    context "without any parameters" do
      let(:number){ nil }
      it { expect{subject}.to raise_error("You need to pass a number") }
    end

    context "with multibyte string" do
      let(:number){ 'あ' }
      it { expect{subject}.to raise_error("You can only pass arabic numerals") }
    end

    context "with single byte string" do
      let(:number){ 'hoge' }
      it { expect{subject}.to raise_error("You can only pass arabic numerals") }
    end

    context "with string containing both string and number" do
      let(:number){ '10000円' }
      it { expect{subject}.to raise_error("You can only pass arabic numerals") }
    end

    context "with string containing commas" do
      let(:number){ '1,000,000' }
      it { expect{subject}.not_to raise_error }
    end

    context "with string containing whitespaces" do
      let(:number){ '1 000 000' }
      it { expect{subject}.not_to raise_error }
    end

  end

  context "Negative" do
    context "Type Fixnum " do
      let(:number){ -1 }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('negative one') }
    end

    context "Type String " do
      let(:number){ "-1" }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('negative one') }
    end

  end

  context "Zero" do
    let(:number){ 0 }
    it { expect{subject}.not_to raise_error }
    it { expect(subject).to eq("zero") }
  end

  context "Floating point" do
    let(:number){ 1000.11 }
    it { expect{subject}.not_to raise_error }
    it { expect(subject).to eq('one thousand point one one') }
  end

  (1..10).each do |num|
    context "Range 1-10: #{num}" do
      let(:number){ num }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq(SAMPLE_NUMBERS[num.to_s]) }
    end
  end

  (11..100).each do |num|
    context "Range 11-100: #{num}" do
      let(:number){ num }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq(SAMPLE_NUMBERS[num.to_s]) }
    end
  end

  context "Large number" do
    context "More than one thousand" do
      let(:number){ "1,123" }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('one thousand one hundred and twenty-three') }
    end

    context "More than one million" do
      let(:number){ "1,123,456" }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('one million one hundred and twenty-three thousand four hundred and fifty-six') }
    end

    context "More than one billion" do
      let(:number){ "1,123,456,789" }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('one billion one hundred and twenty-three million four hundred and fifty-six thousand seven hundred and eighty-nine') }
    end

    context "More than one trillion" do
      let(:number){ "1,123,456,789,012" }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('one trillion one hundred and twenty-three billion four hundred and fifty-six million seven hundred and eighty-nine thousand twelve') }
    end

    context "More than one centillion" do
      let(:number){ 7128895353753512801851213839122324656430517127764242492772122014363994162410568756562761573538649597748463505127063089169061629466715041366197187934797638009975342907981315112215903509554633328742826248199166160019498345725451164673477322579175931292781354746911215934169601043364358422156689012325474774 }
      it { expect{subject}.not_to raise_error }
      it { expect(subject).to eq('seven centillion one hundred and twenty-eight novemnonagintillion eight hundred and ninety-five octononagintillion three hundred and fifty-three septennonagintillion seven hundred and fifty-three sexnonagintillion five hundred and twelve quinnonagintillion eight hundred and one quattuornonagintillion eight hundred and fifty-one trenonagintillion two hundred and thirteen duononagintillion eight hundred and thirty-nine unnonagintillion one hundred and twenty-two nonagintillion three hundred and twenty-four novemoctogintillion six hundred and fifty-six octooctogintillion four hundred and thirty septoctogintillion five hundred and seventeen sexoctogintillion one hundred and twenty-seven quinoctogintillion seven hundred and sixty-four quattuoroctogintillion two hundred and forty-two treoctogintillion four hundred and ninety-two duooctogintillion seven hundred and seventy-two unoctogintillion one hundred and twenty-two octogintillion fourteen novemseptuagintillion three hundred and sixty-three octoseptuagintillion nine hundred and ninety-four septenseptuagintillion one hundred and sixty-two sexseptuagintillion four hundred and ten quinseptuagintillion five hundred and sixty-eight quattuorseptuagintillion seven hundred and fifty-six treseptuagintillion five hundred and sixty-two duoseptuagintillion seven hundred and sixty-one unseptuagintillion five hundred and seventy-three septuagintillion five hundred and thirty-eight novemsexagintillion six hundred and forty-nine octosexagintillion five hundred and ninety-seven septensexagintillion seven hundred and forty-eight sexsexagintillion four hundred and sixty-three quinsexagintillion five hundred and five quattuorsexagintillion one hundred and twenty-seven tresexagintillion sixty-three duosexagintillion eighty-nine unsexagintillion one hundred and sixty-nine sexagintillion sixty-one novemquinquagintillion six hundred and twenty-nine octoquinquagintillion four hundred and sixty-six septenquinquagintillion seven hundred and fifteen sexquinquagintillion forty-one quinquinquagintillion three hundred and sixty-six quattuorquinquagintillion one hundred and ninety-seven trequinquagintillion one hundred and eighty-seven duoquinquagintillion nine hundred and thirty-four unquinquagintillion seven hundred and ninety-seven quinquagintillion six hundred and thirty-eight novemquadragintillion nine octoquadragintillion nine hundred and seventy-five septenquadragintillion three hundred and forty-two sexquadragintillion nine hundred and seven quinquadragintillion nine hundred and eighty-one quattuorquadragintillion three hundred and fifteen trequadragintillion one hundred and twelve duoquadragintillion two hundred and fifteen unquadragintillion nine hundred and three quadragintillion five hundred and nine novemtrigintillion five hundred and fifty-four octotrigintillion six hundred and thirty-three septentrigintillion three hundred and twenty-eight sextrigintillion seven hundred and forty-two quintrigintillion eight hundred and twenty-six quattuortrigintillion two hundred and forty-eight tretrigintillion one hundred and ninety-nine duotrigintillion one hundred and sixty-six untrigintillion one hundred and sixty trigintillion nineteen novemvigintillion four hundred and ninety-eight octovigintillion three hundred and forty-five septenvigintillion seven hundred and twenty-five sexvigintillion four hundred and fifty-one quinvigintillion one hundred and sixty-four quattuorvigintillion six hundred and seventy-three trevigintillion four hundred and seventy-seven duovigintillion three hundred and twenty-two unvigintillion five hundred and seventy-nine vigintillion one hundred and seventy-five novemdecillion nine hundred and thirty-one octodecillion two hundred and ninety-two septendecillion seven hundred and eighty-one sexdecillion three hundred and fifty-four quindecillion seven hundred and forty-six quattuordecillion nine hundred and eleven tredecillion two hundred and fifteen duodecillion nine hundred and thirty-four undecillion one hundred and sixty-nine decillion six hundred and one nonillion forty-three octillion three hundred and sixty-four septillion three hundred and fifty-eight sextillion four hundred and twenty-two quintillion one hundred and fifty-six quadrillion six hundred and eighty-nine trillion twelve billion three hundred and twenty-five million four hundred and seventy-four thousand seven hundred and seventy-four') }
    end

  end

end
