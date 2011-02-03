# encoding: utf-8

require 'spec_helper'

describe "Plurales españoles" do
  it "el plural de una palabra acabada en vocal se hace con una 's'" do
    'libro'.pluralize.should == 'libros'
    'libros'.singularize.should == 'libro'
  end

  it "el plural de una palabra que acaba en consonante es -es" do
    'autor'.pluralize.should == 'autores'
    'autores'.singularize.should == 'autor'
  end

  it "las palabras acabadas en 'z' hacen su plural en 'ces'" do
    'vez'.pluralize.should == 'veces'
    'veces'.singularize.should == 'vez'
  end

  it "las palabras agudas acabadas en 'n' ó 's' hacen el plural sin acento" do
    'balcón'.pluralize.should == 'balcones'
    'truhán'.pluralize.should == 'truhanes'
    'cordobés'.pluralize.should == 'cordobeses'
    'cojín'.pluralize.should == 'cojines'
    'trolebús'.pluralize.should == 'trolebuses'
    # 'balcones'.singularize.should == 'balcón' Peligros, ya que en la BD los nombres de tabla no tienen acentos  
  end

  it "las palabras acabadas en vocal débil con acento más consonante conservan el acento" do
    'raíz'.pluralize.should == 'raíces'
    'raíces'.singularize.should == 'raíz'

    'baúl'.pluralize.should == 'baúles'
    'baúles'.singularize.should == 'baúl'
  end

  #TODO: cacahuete => cacahuetes. Ver en qué consonantes pueden acabar las palabras españolas.

  it "las palabras acabadas en vocal cerrada con acento hace su plural en -es" do
    'manatí'.pluralize.should == 'manatíes'
    'manatíes'.singularize.should == 'manatí'

    'tabú'.pluralize.should == 'tabúes'
    'tabúes'.singularize.should == 'tabú'
  end

  it "las palabras agudas acabadas en vocal abierta hacen su plural en -s" do
    'sofá'.pluralize.should == 'sofás'
    'sofás'.singularize.should == 'sofá'

    'comité'.pluralize.should == 'comités'
    'comités'.singularize.should == 'comité'

    'plató'.pluralize.should == 'platós'
    'platós'.singularize.should == 'plató'
  end
end
