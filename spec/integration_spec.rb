require_relative 'spec_helper'

describe 'Mongoid::TimeRange integration' do
  before { Timecop.freeze }


  describe 'create document without any attributes' do
    subject { Document.create }


    it 'sets from to current time and to to nil' do
      subject.range.must_be_nil
    end


    describe 'when default is set to from: Time.now }' do
      subject { DocumentWithImplicitDefault.create }


      it 'sets from to current time and to to ni' do
        subject.range.must_equal from: Time.now, to: nil
      end
    end


    describe 'when default is set to ->{ Mongoid::TimeRange.new(from: Time.now) }' do
      subject { DocumentWithExplicitDefault.create }


      it 'sets from to current time and to to ni' do
        subject.range.must_equal from: Time.now, to: nil
      end
    end
  end


  describe 'create document only with from attribute' do
    subject { Document.create(range: { from: Time.now.beginning_of_year }) }


    it 'sets from to given time and to to nil' do
      subject.range.must_equal from: Time.now.beginning_of_year, to: nil
    end
  end


  describe 'create document with both attributes' do
    subject { Document.create(range: { from: Time.now.beginning_of_year, to: Time.now.end_of_year }) }


    it 'sets from and to to given time' do
      subject.range.must_equal from: Time.now.beginning_of_year, to: Time.now.end_of_year
    end
  end


  after { Timecop.return }
end
