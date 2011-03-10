# encoding: utf-8

require 'spec_helper'

describe Gender do
  it "devuelve femenino para palabras acabadas en 'a'" do
    "mesa".gender.should == :female
  end

  it "devuelve masculino para palabras acabadas en 'o'" do
    "libro".gender.should == :male
  end

  it "devuelve masculino para otros" do
    "sillón".gender.should == :male
  end

  it "en palabras conocidas devuelve el género definido" do
    String.add_irregular_gender "calefacción", :female
    "calefacción".gender.should == :female
  end

  it "acepta un hash con varias palabras para añadir género" do
    String.add_irregular_gender({"mano" => :female, "volga" => :male})
    "mano".gender.should == :female
    "volga".gender.should == :male
  end
end
