require 'simplecov'
SimpleCov.start

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

  it 'generates checksum for partial id' do
    partial_id = '100000001'.digitize
    checksum = TurkishId.get_checksum(partial_id)
    expect(checksum).to eq([4, 6])
  end

  it 'appends checksum to partial id' do
    id = TurkishId.new('10000000146')
    id_core, result = id.core, '10000000146'.digitize
    expect(TurkishId.add_checksum(id_core)).to eq(result)
  end

  it 'generates elder relatives' do
    id = TurkishId.new('10000000146')
    result = ["10003000082", "10005999902"]
    expect(id.get_relatives 2).to eq(result)
  end

  it 'generates younger relatives' do
    id = TurkishId.new('10005999902')
    result = ["10003000082", "10000000146"]
    expect(id.get_relatives(2, 'down')).to eq(result)
  end

end
