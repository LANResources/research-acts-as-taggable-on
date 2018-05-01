# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ResearchActsAsTaggableOn::DefaultParser do
  it '#parse should return empty array if empty array is passed' do
    parser = ResearchActsAsTaggableOn::DefaultParser.new([])
    expect(parser.parse).to be_empty
  end

  describe 'Multiple Delimiter' do
    before do
      @old_delimiter = ResearchActsAsTaggableOn.delimiter
    end

    after do
      ResearchActsAsTaggableOn.delimiter = @old_delimiter
    end

    it 'should separate tags by delimiters' do
      ResearchActsAsTaggableOn.delimiter = [',', ' ', '\|']
      parser = ResearchActsAsTaggableOn::DefaultParser.new('cool, data|I have')
      expect(parser.parse.to_s).to eq('cool, data, I, have')
    end

    it 'should escape quote' do
      ResearchActsAsTaggableOn.delimiter = [',', ' ', '\|']
      parser = ResearchActsAsTaggableOn::DefaultParser.new("'I have'|cool, data")
      expect(parser.parse.to_s).to eq('"I have", cool, data')

      parser = ResearchActsAsTaggableOn::DefaultParser.new('"I, have"|cool, data')
      expect(parser.parse.to_s).to eq('"I, have", cool, data')
    end

    it 'should work for utf8 delimiter and long delimiter' do
      ResearchActsAsTaggableOn.delimiter = ['，', '的', '可能是']
      parser = ResearchActsAsTaggableOn::DefaultParser.new('我的东西可能是不见了，还好有备份')
      expect(parser.parse.to_s).to eq('我， 东西， 不见了， 还好有备份')
    end

    it 'should work for multiple quoted tags' do
      ResearchActsAsTaggableOn.delimiter = [',']
      parser = ResearchActsAsTaggableOn::DefaultParser.new('"Ruby Monsters","eat Katzenzungen"')
      expect(parser.parse.to_s).to eq('Ruby Monsters, eat Katzenzungen')
    end
  end

end
