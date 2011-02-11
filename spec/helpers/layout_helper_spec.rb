# encoding: utf-8

require 'spec_helper'

describe LayoutHelper do
  describe "#stylesheet" do
    context "adding a stylesheets" do
      before(:each) { helper.stylesheet 'application' }
        
      it 'adds a stylesheet to the list' do
        helper.stylesheets.should include('application')
      end

      it "doesn't add a javascript" do
        helper.javascripts.should_not include('application') 
      end
    end

    context "adding a javascript" do
      before(:each) { helper.javascript 'application' }

      it 'adds a javascript to the list' do
        helper.javascripts.should include('application')
      end

      it "doesn't add a stylesheet" do
        helper.stylesheets.should_not include('application')
      end
    end

    context "adding several stylesheets" do
      let(:stylesheets) { ['reset', 'layout', 'colors'] }
      before(:each) { helper.stylesheet *stylesheets }

      it 'adds all the stylesheets' do
        helper.stylesheets.should == stylesheets
      end

      it 'allows to add another stylesheet' do
        helper.stylesheet 'general'
        helper.stylesheets.should == stylesheets + ['general']
      end

      it "doesn't add the same stylesheet twice" do
        helper.stylesheet 'layout'
        helper.stylesheets.should_not == stylesheets + ['layout']
      end
    end

    context "adding several javascripts" do
      let(:javascripts) { ['jquery', 'rails', 'application'] }
      before(:each) { helper.javascript *javascripts }

      it 'adds all the javascripts' do
        helper.javascripts.should == javascripts
      end

      it 'allows to add another javascript' do
        helper.javascript 'jquery.ui'
        helper.javascripts.should == javascripts + ['jquery.ui']
      end

      it "doesn't add the same javascripts twice" do
        helper.javascript 'jquery'
        helper.javascripts.should_not == javascripts + ['jquery']
      end
    end
  end
end 
