require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'spec_helper'

describe TurkishId do
  it 'has a version number' do
    expect(TurkishId::VERSION).not_to be nil
  end

  it 'validates a valid id number' do
    identity_number = TurkishId.new('10000000146')
    expect(identity_number.is_valid?).to eq(true)
  end

  it 'does not validate invalid id number' do
    identity_number = TurkishId.new('10001000146')
    expect(identity_number.is_valid?).to eq(false)
  end

  it 'does not validate empty string' do
    identity_number = TurkishId.new('')
    expect(identity_number.is_valid?).to eq(false)
  end

  it 'does not validate nil input' do
    identity_number = TurkishId.new(nil)
    expect(identity_number.is_valid?).to eq(false)
  end

end
