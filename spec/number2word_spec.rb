require 'spec_helper'
require 'number2word'

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
end
