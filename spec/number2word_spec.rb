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
    end

    context "Type String " do
      let(:number){ "-1" }
      it { expect{subject}.not_to raise_error }
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
    end

    context "More than one thousand" do
      let(:number){ "1,123" }
      it { expect{subject}.not_to raise_error }
    end

    context "More than one million" do
      let(:number){ "1,123,456" }
      it { expect{subject}.not_to raise_error }
    end

    context "More than one billion" do
      let(:number){ "1,123,456,789" }
      it { expect{subject}.not_to raise_error }
    end

    context "More than one trillion" do
      let(:number){ "1,123,456,789,012" }
      it { expect{subject}.not_to raise_error }
    end

    context "More than one centillion" do
      let(:number){ 7128895353753512801851213839122324656430517127764242492772122014363994162410568756562761573538649597748463505127063089169061629466715041366197187934797638009975342907981315112215903509554633328742826248199166160019498345725451164673477322579175931292781354746911215934169601043364358422156689012325474774 }
      it { expect{subject}.not_to raise_error }
    end

  end

end
