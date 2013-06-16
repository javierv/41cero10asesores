# encoding: utf-8

require_relative '../../extras/gender.rb'

class String
  include Gender
end

describe Gender do
  context "palabras acabadas en 'a'" do
    it "devuelve femenino" do
      "mesa".gender.should == :female
    end
  end

  context "palabras acabadas en 'o'" do
    it "devuelve masculino" do
      "libro".gender.should == :male
    end
  end

  context "otras palabras" do
    it "devuelve masculino" do
      "sillón".gender.should == :male
    end
  end

  describe ".add_irregular_gender" do
    context "pasando una palabra conocida" do
      before(:each) { String.add_irregular_gender "calefacción", :female }

      it "devuelve el género definido" do
        "calefacción".gender.should == :female
      end

    end

    context "pasando varias palabras conocidas" do
      before(:each) do
        String.add_irregular_gender({"mano" => :female, "volga" => :male})
      end

      it "reconoce todas las palabras definidas" do
        "mano".gender.should == :female
        "volga".gender.should == :male
      end
    end
  end
end
