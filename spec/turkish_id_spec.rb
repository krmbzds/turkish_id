require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe TurkishId do
  it 'has a version number' do
    expect(TurkishId::VERSION).not_to be nil
  end

  it 'accepts integer input' do
    identity_number = TurkishId.new(10000000146)
    expect(identity_number.id_number).to eq([1, 0, 0, 0, 0, 0, 0, 0, 1, 4, 6])
  end

  it 'accepts string input' do
    identity_number = TurkishId.new('10000000146')
    expect(identity_number.id_number).to eq([1, 0, 0, 0, 0, 0, 0, 0, 1, 4, 6])
  end

  it 'generates checksum on initialization' do
    identity_number = TurkishId.new('10000000146')
    expect(identity_number.checksum).to eq([4, 6])
  end

  it 'validates a valid id number' do
    identity_number = TurkishId.new('10000000146')
    expect(identity_number.is_valid?).to eq(true)

    identity_number = TurkishId.new('98655172890')
    expect(identity_number.is_valid?).to eq(true)
  end

  it 'does not validate invalid id number' do
    identity_number = TurkishId.new('10001000146')
    expect(identity_number.is_valid?).to eq(false)
  end

  it 'does not validate id number that starts with zero' do
    identity_number = TurkishId.new('00100000146')
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

  it 'generates elder relatives' do
    identity_number = TurkishId.new(10000000146)
    expect(identity_number.elder_relative.first).to eq(10003000082)
  end

  it 'generates younger relatives' do
    identity_number = TurkishId.new(10003000082)
    expect(identity_number.younger_relative.first).to eq(10000000146)
  end

  it 'generates multiple elder relatives' do
    identity_number = TurkishId.new(10000000146)
    elder_relatives = identity_number.elder_relative.take(3)
    expect(elder_relatives).to eq([10003000082, 10005999902, 10008999848])
  end

  it 'generates multiple younger relatives' do
    identity_number = TurkishId.new(10008999848)
    elder_relatives = identity_number.younger_relative.take(3)
    expect(elder_relatives).to eq([10005999902, 10003000082, 10000000146])
  end
end
