require_relative 'spec_helper'

describe Mongoid::TimeRange do
  before { Timecop.freeze }
  let(:from) { Time.now.beginning_of_year }
  let(:to) { Time.now.end_of_year }
  subject { Mongoid::TimeRange.new(from, to) }


  describe :initialize do
    describe 'without any arguments' do
      subject { Mongoid::TimeRange.new }


      it 'sets from to Time.now' do
        subject.from.must_equal Time.now
      end


      it 'sets to to nil' do
        subject.to.must_be_nil
      end
    end


    describe 'with one argument' do
      subject { Mongoid::TimeRange.new(from) }


      it 'sets from to given value' do
        subject.from.must_equal from
      end


      it 'sets to to nil' do
        subject.to.must_be_nil
      end
    end


    describe 'with two arguments' do
      subject { Mongoid::TimeRange.new(from, to) }


      it 'sets from to given value' do
        subject.from.must_equal from
      end


      it 'sets to to given value' do
        subject.to.must_equal to
      end
    end
  end


  describe 'getters' do
    it 'responds to from' do
      subject.must_respond_to :from
    end


    it 'responds to to' do
      subject.must_respond_to :to
    end
  end


  describe 'setters' do
    it 'responds to from=' do
      subject.must_respond_to :from=
    end


    it 'responds to to=' do
      subject.must_respond_to :to=
    end
  end


  describe :mongoize do
    let(:value) { subject.mongoize }


    describe 'having both from and to' do
      it 'returns database friendly value' do
        value.must_equal from: from.mongoize, to: to.mongoize
      end
    end


    describe 'having only from value' do
      let(:to) { nil }


      it 'returns database friendly value' do
        value.must_equal from: from.mongoize, to: nil
      end
    end
  end


  describe 'self.mongoize' do
    describe 'giving a time range object' do
      let(:value) { Mongoid::TimeRange.mongoize(subject) }


      describe 'having both from and to' do
        it 'returns database friendly value' do
          value.must_equal from: from.mongoize, to: to.mongoize
        end
      end


      describe 'having only from value' do
        let(:to) { nil }


        it 'returns database friendly value' do
          value.must_equal from: from.mongoize, to: nil
        end
      end
    end


    describe 'giving a hash' do
      let(:value) { Mongoid::TimeRange.mongoize(from: from, to: to) }


      describe 'having both from and to' do
        it 'returns database friendly value' do
          value.must_equal from: from.mongoize, to: to.mongoize
        end
      end


      describe 'having only from value' do
        let(:to) { nil }


        it 'returns database friendly value' do
          value.must_equal from: from.mongoize, to: nil
        end
      end
    end
  end


  describe 'self.demongoize' do
    let(:value) { Mongoid::TimeRange.demongoize(from: from, to: to) }


    describe 'having both from and to' do
      it 'returns a TimeRange object' do
        value.must_equal Mongoid::TimeRange.new(from, to)
      end
    end


    describe 'having only from value' do
      let(:to) { nil }


      it 'returns database friendly value' do
        value.must_equal Mongoid::TimeRange.new(from)
      end
    end
  end


  describe :to_a do
    let(:value) { subject.to_a }


    it 'returns an array' do
      value.must_equal [from, to]
    end
  end


  after { Timecop.return }
end
