require_relative 'spec_helper'

describe 'Mongoid::TimeRange integration' do
  before { Timecop.freeze }


  describe 'create document without any attributes' do
    subject { Document.create }


    it 'sets from to current time and to to nil' do
      subject.range.from.to_i.must_equal Time.now.to_i
      subject.range.to.must_be_nil
    end
  end


  describe 'create document only with from attribute' do
    subject { Document.create(range: { from: Time.now.beginning_of_year }) }


    it 'sets from to given time and to to nil' do
      subject.range.from.to_i.must_equal Time.now.beginning_of_year.to_i
      subject.range.to.must_be_nil
    end
  end


  describe 'create document with both attributes' do
    subject { Document.create(range: { from: Time.now.beginning_of_year, to: Time.now.end_of_year }) }


    it 'sets from and to to given time' do
      subject.range.from.to_i.must_equal Time.now.beginning_of_year.to_i
      subject.range.to.to_i.must_equal Time.now.end_of_year.to_i
    end
  end


  after { Timecop.return }
end
